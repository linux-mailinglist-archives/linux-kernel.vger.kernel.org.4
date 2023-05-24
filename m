Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4CD70FAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjEXPmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbjEXPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76078E70
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACEB261927
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60B2C433D2;
        Wed, 24 May 2023 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684942777;
        bh=9Hl32z8O29zupLewPwrp8TBa3k0iI9CyhI88kKC9mx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LeXRm7BtiZTlebT681eMU23sdH7H3sx167YpHnt5zUzTXsy44X1JAfbDnIrBJ03rn
         19Xpt0L3QVP5WH7cZyizBHJJIS/nDyh3pgzmRvR5iSIKpowHGWtlhTYYz6jWduPvsx
         /kU8JlHTQXC5B/QbvoP6Dbw73YwFfbqMaUVmUmX8oem0zwojl2enIcZFazIW3vXYca
         jgbWY4A0mTTsmC9CtMNsO2ctPty55mAQu6OLhG2RABV1LavDUqbFCXCZBzrnvKl53U
         gtEgxaLeayUCj1TrpE8ckP9p8gmbT5XElDKW2lo/J8KhX4cmJDWMv+UGx92Lrisixv
         93vgt0zerCxmQ==
Date:   Wed, 24 May 2023 08:39:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in
 enqueue_timer
Message-ID: <20230524083935.7108f17f@kernel.org>
In-Reply-To: <20230524083341.0cd435f7@kernel.org>
References: <000000000000c0b11d05fa917fe3@google.com>
        <ZGzfzEs-vJcZAySI@zx2c4.com>
        <20230523090512.19ca60b6@kernel.org>
        <CANn89iLVSiO1o1C-P30_3i19Ci8W1jQk9mr-_OMsQ4tS8Nq2dg@mail.gmail.com>
        <20230523094108.0c624d47@kernel.org>
        <CAHmME9obRJPrjiJE95JZug0r6NUwrwwWib+=LO4jiQf-y2m+Vg@mail.gmail.com>
        <20230523094736.3a9f6f8c@kernel.org>
        <ZGzxa18w-v8Dsy5D@zx2c4.com>
        <CANn89iLrP7-NbE1yU_okruVKqbuUc3gxPABq4-vQ4SKrUhEdtA@mail.gmail.com>
        <CANn89iKEjb-g1ed2M+VS5avSs=M0gNgH9QWXtOQRM_uDTMCwPw@mail.gmail.com>
        <CACT4Y+YcNt8rvJRK+XhCZa1Ocw9epHg1oSGc28mntjY3HWZp1g@mail.gmail.com>
        <20230524083341.0cd435f7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 08:33:41 -0700 Jakub Kicinski wrote:
> On Wed, 24 May 2023 10:24:31 +0200 Dmitry Vyukov wrote:
> > FWIW There are more report examples on the dashboard.
> > There are some that don't mention wireguard nor usbnet, e.g.:
> > https://syzkaller.appspot.com/text?tag=CrashReport&x=17dd2446280000
> > So that's probably red herring. But they all seem to mention alloc_netdev_mqs.  
> 
> While we have you, let me ask about the possibility of having vmcore
> access - I think it'd be very useful to solve this mystery. 
> With a bit of luck the timer still has the function set.

I take that back.

Memory state around the buggy address:
 ffff88801ecc1400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801ecc1480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801ecc1500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb  
                   ^
 ffff88801ecc1580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801ecc1600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
