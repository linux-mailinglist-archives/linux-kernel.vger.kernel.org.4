Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6B6D2ED4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjDAHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 03:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDAHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 03:10:05 -0400
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Apr 2023 00:10:03 PDT
Received: from nimbus1.mmprivatehosting.com (nimbus1.mmprivatehosting.com [54.208.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77941D855
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 00:10:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTP id 6C1CC60034
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 07:03:13 +0000 (UTC)
X-Virus-Scanned: amavis at mmprivatehosting.com
Received: from dave.mielke.cc (unknown [174.116.27.113])
        (Authenticated sender: relay@dave.mielke.cc)
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTPA
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 07:03:12 +0000 (UTC)
Received: from beta.private.mielke.cc (beta.private.mielke.cc [192.168.0.2])
        by dave.mielke.cc (Postfix) with ESMTPS id 3B6FB491
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 03:03:11 -0400 (EDT)
Received: from beta.private.mielke.cc (localhost [127.0.0.1])
        by beta.private.mielke.cc (8.17.1/8.15.2) with ESMTPS id 33173A0U005027
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 1 Apr 2023 03:03:10 -0400
Received: (from dave@localhost)
        by beta.private.mielke.cc (8.17.1/8.17.1/Submit) id 33173ARt005026
        for linux-kernel@vger.kernel.org; Sat, 1 Apr 2023 03:03:10 -0400
Date:   Sat, 1 Apr 2023 02:25:22 -0400
From:   Dave Mielke <Dave@mielke.cc>
To:     Linux Kernel Mailing List 
        <linux-kernel%40vger.kernel.org@beta.private.mielke.cc>
Cc:     Samuel Thibault <Samuel.Thibault@ens-lyon.org>
Subject: The regrettable demise of the TIOCSTI ioctl.
Message-ID: <ZCfOUSZ87LaBVjq7@beta.private.mielke.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that, starting in the 6.2 kernel (I think), there's a move underway to get rid of the TIOCSTI ioctl. The fact that the kernel configuration information says "provides no meaningful real-world utility any more" shows that the kernel developers seem to be unaware of an important subset of their users who absolutely depend on TIOCSTI.

By removing TIOCSTI, you have broken several users' *ability* to work at all with their current hardware!

The users I'm referring to are those who rely on their ability to work productively with braille devices. They use BRLTTY (see brltty.app). Most braille devices, these days, have braille keyboards. BRLTTY interprets what its users type on those braille keyboards, and uses TIOCSTI to inject those characters. Since I'm unaware of any adequate replacement for TIOCSTI, I'm asking (begging?) that this ioctl please be NOT removed.

Even disablign it isn't good because a blind user who relies on his/her braille keyboard won't be able to fix the problem by logging in and issuing the needed sysctl command (try imagining how you'd do that without your keyboard). We could distribute a brltty.conf sysctl.d file, but that isn't a great idea either given that, in
the end, it'd end up being run on all systems since BRLTTY is generally distributed.

Please understand that it simply isn't true at all that TIOCSTI has no practical use these days. It most certainly does!

Thanks for at least hearing me out.

-- 
I believe the Bible to be the very Word of God: http://Mielke.cc/bible/
Dave Mielke            | 2213 Fox Crescent | WebHome: http://Mielke.cc/
EMail: Dave@Mielke.cc  | Ottawa, Ontario   | Twitter: @Dave_Mielke
Phone: +1 613 726 0014 | Canada  K2A 1H7   |
