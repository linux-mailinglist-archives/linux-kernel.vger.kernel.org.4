Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD5873A7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjFVSMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVSMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4781FE9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A33EA618C7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 18:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC78C433C0;
        Thu, 22 Jun 2023 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687457556;
        bh=3voyAzfGrtM2hCUsVSFe/G6QJ7KTcAlIITK7RFZZfKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BeSVipOHf6K1iDWyC9PfTd5evoVvNx6BLxGjYl9ESPwCk6pcXDSthl6bbPTZnnL0b
         VXv0qbINbaiSoX/p+9wOB896WJXAjUn8YjSSpqD7wptnWW4RfiwEb5f6wp3SNt7P57
         GZlotEkMT8/H74L2psL/S4TBDtoZo2rWPhj03RNDdNqSQP07K82JPXcrPJ+4xJEhNj
         L/WzvggSLLJXoez5lQ2dWdBCNHdGqCGcGsgq09v9QdJl+LwAU5fLNj6ssJ90V8E8fp
         VUbbxcWTSXfIk2s9GrHrW5NF7vtjQg0d4iD5LEByGfwOpFh8RaOUY+eObFoJMezyHa
         RzHjobdhmUiRg==
Date:   Thu, 22 Jun 2023 11:12:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
Message-ID: <20230622111234.23aadd87@kernel.org>
In-Reply-To: <20230620145338.1300897-2-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
        <20230620145338.1300897-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 15:53:20 +0100 David Howells wrote:
> If sendmsg() is passed MSG_SPLICE_PAGES and is given a buffer that contains
> some data that's resident in the slab, copy it rather than returning EIO.

How did that happen? I thought MSG_SPLICE_PAGES comes from former
sendpage users and sendpage can't operate on slab pages.

> This can be made use of by a number of drivers in the kernel, including:
> iwarp, ceph/rds, dlm, nvme, ocfs2, drdb.  It could also be used by iscsi,
> rxrpc, sunrpc, cifs and probably others.
> 
> skb_splice_from_iter() is given it's own fragment allocator as
> page_frag_alloc_align() can't be used because it does no locking to prevent
> parallel callers from racing.

The locking is to local_bh_disable(). Does the milliont^w new frag
allocator have any additional benefits?

>  alloc_skb_frag() uses a separate folio for
> each cpu and locks to the cpu whilst allocating, reenabling cpu migration
> around folio allocation.
