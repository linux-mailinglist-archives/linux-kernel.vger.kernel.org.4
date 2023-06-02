Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6171F940
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjFBEUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjFBEUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D6CE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C00F564C17
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A69BC433EF;
        Fri,  2 Jun 2023 04:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685679645;
        bh=Pe0QdSQELFT4UssZ7PzgR16P5m3tS2P0+wxp1GZ38R8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LowUN665zQHa0uvTb3FnPncpJmTOU6V2ezCMk2A4eHRfj+xwdSDVcHJs4RdFlpstW
         zW3i/m8g7NW8lAW9X3/pjRFZ5jvXN2qa8OSBxZvXmoWoRJw3+8TRANQ3xS2EqdRI6G
         L07LXvfPQZsAb6LuqM0HiliMdKF4y3H91+NyH5SlFkozs7p4OZuDlRGs4H1brxJmvG
         VZ32nd0UfpnzlyFdYqrLLJiX+t9MYpAO+lGLsBVWMfsGU1qC6L0gob7FBrQ8EgnKj7
         kNccbpYblBEcC2jhymk1mzJ9+SZ/RPV5NBQngac++E/466iVqdsGurLMrvvir2Cue4
         p5HuUQAOL7BFQ==
Date:   Thu, 1 Jun 2023 21:20:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Bug in short splice to socket?
Message-ID: <20230601212043.720f85c2@kernel.org>
In-Reply-To: <909595.1685639680@warthog.procyon.org.uk>
References: <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
        <20230524153311.3625329-1-dhowells@redhat.com>
        <20230524153311.3625329-10-dhowells@redhat.com>
        <20230526180844.73745d78@kernel.org>
        <499791.1685485603@warthog.procyon.org.uk>
        <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
        <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com>
        <832277.1685630048@warthog.procyon.org.uk>
        <909595.1685639680@warthog.procyon.org.uk>
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

On Thu, 01 Jun 2023 18:14:40 +0100 David Howells wrote:
> The answer then might be to make TLS handle a zero-length send()

IDK. Eric added MSG_SENDPAGE_NOTLAST 11 years ago, to work around 
this exact problem. Your refactoring happens to break it and what
you're saying sounds to me more or less like "MSG_SENDPAGE_NOTLAST 
is unnecessary, it's user's fault".

A bit unconvincing. Maybe Eric would chime in, I'm not too familiar
with the deadly mess of the unchecked sendmsg()/sendpage() flags.
