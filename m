Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488BB73A975
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFVU2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjFVU2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C1B1FF0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E0C0618E2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BA5C433C0;
        Thu, 22 Jun 2023 20:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687465716;
        bh=y/yWd5uVMRCaLK5FhZxHraUGBdV/mEzDKca+3yl4kns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WxMN7ynzoeDIgKp9qigd+U7A+dKCvNZNhyw9863fmtMX3FKqJWn+0zNnaxc0UMlYo
         pg5eLKEaUwtXcJ846Q6rTVD058OFrAkHSmXXIY/MNsZe7wZL6ivWyl2ySsoPT9Qrs9
         aLBR6Ev6OzLVxLEn/6tLTRGJwuoZq+dbZlkp8MSvpfXXAEAtVn5FV5LXc8rhnwQo/k
         IC+sfBPVYRsCJ8bJJEmFrUo4j8cAFOSk9Y3IFdxDok1bUE1kDnAekvwAnlBgAqxyQu
         RvfVhnW7aIfE3tyGlGf6R3lJKP7Zfo48Sgw1UFO4Ma9VUlFJ5ZQSqdFE5I9t4IxrE9
         O7BtuG0QmHmqA==
Date:   Thu, 22 Jun 2023 13:28:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
Message-ID: <20230622132835.3c4e38ea@kernel.org>
In-Reply-To: <1952674.1687462843@warthog.procyon.org.uk>
References: <20230622111234.23aadd87@kernel.org>
        <20230620145338.1300897-1-dhowells@redhat.com>
        <20230620145338.1300897-2-dhowells@redhat.com>
        <1952674.1687462843@warthog.procyon.org.uk>
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

On Thu, 22 Jun 2023 20:40:43 +0100 David Howells wrote:
> > How did that happen? I thought MSG_SPLICE_PAGES comes from former
> > sendpage users and sendpage can't operate on slab pages.  
> 
> Some of my patches, take the siw one for example, now aggregate all the bits
> that make up a message into a single sendmsg() call, including any protocol
> header and trailer in the same bio_vec[] as the payload where before it would
> have to do, say, sendmsg+sendpage+sendpage+...+sendpage+sendmsg.

Maybe it's just me but I'd prefer to keep the clear rule that splice
operates on pages not slab objects. SIW is the software / fake
implementation of RDMA, right? You couldn't have picked a less
important user :(

Paolo indicated that he'll take a look tomorrow, we'll see what he
thinks.

> I'm trying to make it so that I make the minimum number of sendmsg calls
> (ie. 1 where possible) and the loop that processes the data is inside of that.

The in-kernel users can be fixed to not use slab, and user space can't
feed us slab objects.

> This offers the opportunity, at least in the future, to append slab data to an
> already-existing private fragment in the skbuff.

Maybe we can get Eric to comment. The ability to identify "frag type"
seems cool indeed, but I haven't thought about using it to attach
slab objects.

> > The locking is to local_bh_disable(). Does the milliont^w new frag
> > allocator have any additional benefits?  
> 
> It is shareable because it does locking.  Multiple sockets of multiple
> protocols can share the pages it has reserved.  It drops the lock around calls
> to the page allocator so that GFP_KERNEL/GFP_NOFS can be used with it.
> 
> Without this, the page fragment allocator would need to be per-socket, I
> think, or be done further up the stack where the higher level drivers would
> have to have a fragment bucket per whatever unit they use to deal with the
> lack of locking.

There's also the per task frag which can be used under normal conditions
(sk_use_task_frag).

> Doing it here makes cleanup simpler since I just transfer my ref on the
> fragment to the skbuff frag list and it will automatically be cleaned up with
> the skbuff.
> 
> Willy suggested that I just allocate a page for each thing I want to copy, but
> I would rather not do that for, say, an 8-byte bit of protocol data.

TBH my intuition would also be get a full page and let the callers who
care about performance fix themselves. Assuming we want to let slab
objects in in the first place.
