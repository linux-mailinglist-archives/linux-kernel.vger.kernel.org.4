Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EDC6F5642
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjECKew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjECKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:34:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92249E4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6FaGQ2ho/mL27ZDcomoYO4ruGRPLaAIjg/kH+MPkWv0=; b=liqPxYORVqohj7987yEA1SDtcZ
        MFF4UEj7quOd0s4QW480c4KVkAW7RuVSwTtnVHIB6f+e3UGy3hrj62YvXpnDCGr1cen6Oxc8B+KtJ
        0I6FrkXIIToSot7HC97iewi0zE7H7SynRh3CdZ8FHgXz+9lE2//DmdSetfEmdT+KGiz23kbCzEfYj
        yFr6h60t7Tlt1kuQ6I+fm3rpmp3PLcbXVItTLKlMeDZbRgaXP4odofBnOg7Gd1GeGjl78UikslqzA
        85cOFsBamfRIT0BX1Obgt1XYtLL7PAhDKGD1o2spdpNl9KnBpz6TZE0i3/5n+iqkdfhFZBka35yGO
        6U8K07Mg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57500)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pu9oj-0003D8-Pd; Wed, 03 May 2023 11:34:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pu9of-0001hp-CA; Wed, 03 May 2023 11:34:33 +0100
Date:   Wed, 3 May 2023 11:34:33 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com>,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, surenb@google.com,
        syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org,
        vschneid@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in psi_task_switch
Message-ID: <ZFI4ue1uzd0Il9yM@shell.armlinux.org.uk>
References: <000000000000281ae805faa4844e@google.com>
 <CACT4Y+Z+N9P6H8ZmF=TGfrC26r1LhHW7OT__UWKTh5VJOWnjEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z+N9P6H8ZmF=TGfrC26r1LhHW7OT__UWKTh5VJOWnjEg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 08:37:15AM +0200, Dmitry Vyukov wrote:
> On Mon, 1 May 2023 at 18:43, syzbot
> <syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1113550c280000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4cc65ccad523b604
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0827f43974813b74e6db
> > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com
> 
> +arm mailing list
> 
> Kernel started falling apart on arm during boot in various strange ways.

Are these all the same hardware platform? If so, please check the
hardware with a known working kernel. These look like spurious failts
caused possibly the hardware platform failing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
