Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD070E35D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbjEWRCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjEWRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAE9C2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A96634C5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB37C433D2;
        Tue, 23 May 2023 17:01:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jAEDfDfm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1684861293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAAodiyGWsaT6Idtby9CZIckSp/ylQBdaFt1VWfkThI=;
        b=jAEDfDfmf8BHdnZsb8HAiQ2DXBfHNn0zo6txVrJOmcDe8gAWG+0XwNg/Bdh1NQ9pL4HM/9
        VBC8cgXnMBgQoduzDaAtNUrQMAt9z6ZDOM3EclU+O5iy9lpm5jclnUtbBdp69bi4yCs3PY
        CGzKmA6kh/JJlTdI9Nzy40hrMT/0oHw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 276351ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 23 May 2023 17:01:33 +0000 (UTC)
Date:   Tue, 23 May 2023 19:01:31 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in
 enqueue_timer
Message-ID: <ZGzxa18w-v8Dsy5D@zx2c4.com>
References: <000000000000c0b11d05fa917fe3@google.com>
 <ZGzfzEs-vJcZAySI@zx2c4.com>
 <20230523090512.19ca60b6@kernel.org>
 <CANn89iLVSiO1o1C-P30_3i19Ci8W1jQk9mr-_OMsQ4tS8Nq2dg@mail.gmail.com>
 <20230523094108.0c624d47@kernel.org>
 <CAHmME9obRJPrjiJE95JZug0r6NUwrwwWib+=LO4jiQf-y2m+Vg@mail.gmail.com>
 <20230523094736.3a9f6f8c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523094736.3a9f6f8c@kernel.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 09:47:36AM -0700, Jakub Kicinski wrote:
> On Tue, 23 May 2023 18:42:53 +0200 Jason A. Donenfeld wrote:
> > > It should, no idea why it isn't. Looking thru the code now I don't see
> > > any obvious gaps where timer object is on a list but not active :S
> > > There's no way to get a vmcore from syzbot, right? :)
> > >
> > > Also I thought the shutdown leads to a warning when someone tries to
> > > schedule the dead timer but in fact add_timer() just exits cleanly.
> > > So the shutdown won't help us find the culprit :(  
> > 
> > Worth noting that it could also be caused by adding to a dead timer
> > anywhere in priv_data of another netdev, not just the sole timer_list
> > in net_device.
> 
> Oh, I thought you zero'ed in on the watchdog based on offsets.
> Still, object debug should track all timers in the slab and complain
> on the free path.

No, I mentioned watchdog because it's the only timer_list in struct
net_device.

Offset analysis is an interesting idea though. Look at this:

> The buggy address belongs to the object at ffff88801ecc0000
>  which belongs to the cache kmalloc-cg-8k of size 8192
> The buggy address is located 5376 bytes inside of
>  freed 8192-byte region [ffff88801ecc0000, ffff88801ecc2000)

IDA says that for syzkaller's vmlinux, net_device has a size of 0xc80
and wg_device has a size of 0x880. 0xc80+0x880=5376. Coincidence that
the address offset is just after what wg uses?

Hm.

Jason
