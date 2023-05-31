Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787D0717272
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjEaAch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjEaAcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F33D121
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C21363517
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D875C433D2;
        Wed, 31 May 2023 00:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685493134;
        bh=R71oU/0C7O8aZ1Fo65yDpnqy1TpGhfrRouAYxvAjdW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OUzgd5vhGClmDKAEtoIbqwLsQS0UPyIv9zBCQ5Ph80pA8CbxCAJoXLCUZjfxEsmj7
         PgTvwepq7y4uuHCcIpViRQhnOV+J8SuU5K1zrY+2j54yrHw/X8REBwzUBj8eqGRrM6
         pEHx97BTFBdADQPYE82kZ5igqX4LDL7AzYZELUfpd5lNNlBZtEgaatqMi9I5EZYHC1
         tDUVfAVWLMfSBDb9LfdAr9FmihzxuO+r5Kwl7Pnsd1ZWBjjh98avBnsP7Lqm43iFTS
         bjvK9giC87TxwLMoTpme192nFucxCXdbfUIxehZ0GyPv7hkeqtIfftVQFWK5Do8Izr
         oz0lrJhs7RgQw==
Date:   Tue, 30 May 2023 17:32:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug in short splice to socket?
Message-ID: <20230530173212.5fec9fc3@kernel.org>
In-Reply-To: <499791.1685485603@warthog.procyon.org.uk>
References: <20230526180844.73745d78@kernel.org>
        <20230524153311.3625329-1-dhowells@redhat.com>
        <20230524153311.3625329-10-dhowells@redhat.com>
        <499791.1685485603@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 23:26:43 +0100 David Howells wrote:
> Interesting.  Now that you've pointed me at it, I've tried running it.  Mostly
> it passes, but I'm having some problems with the multi_chunk_sendfile tests
> that time out.  I think that splice_direct_to_actor() has a bug.  The problem
> is this bit of code:
> 
> 		/*
> 		 * If more data is pending, set SPLICE_F_MORE
> 		 * If this is the last data and SPLICE_F_MORE was not set
> 		 * initially, clears it.
> 		 */
> 		if (read_len < len)
> 			sd->flags |= SPLICE_F_MORE;
> 		else if (!more)
> 			sd->flags &= ~SPLICE_F_MORE;
> 
> When used with sendfile(), it sets SPLICE_F_MORE (which causes MSG_MORE to be
> passed to the network protocol) if we haven't yet read everything that the
> user requested and clears it if we fulfilled what the user requested.
> 
> This has the weird effect that MSG_MORE gets kind of inverted.  It's never
> seen by the actor if we can read the entire request into the pipe - except if
> we hit the EOF first.  If we hit the EOF before we fulfil the entire request,
> we get a short read and SPLICE_F_MORE and thus MSG_MORE *is* set.  The
> upstream TLS code ignores it - but I'm changing this with my patches as
> sendmsg() then uses it to mark the EOR.
> 
> I think we probably need to fix this in some way to check the size of source
> file - which may not be a regular file:-/  With the attached change, all tests
> pass; without it, a bunch of tests fail with timeouts.

Yeah.. it's one of those 'known warts' which we worked around in TLS
because I don't know enough about VFS to confidently fix it in fs/.
Proper fix would be pretty nice to have.

The original-original report of the problem is here, FWIW:
https://lore.kernel.org/netdev/1591392508-14592-1-git-send-email-pooja.trivedi@stackpath.com/

And my somewhat hacky fix was d452d48b9f8.
