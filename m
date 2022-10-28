Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446B66117F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJ1QsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ1Qr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:47:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5461EEA3F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QKytlREYiTLpgxfFh35rP21mKKtH4zCnPdMR02CiPB4=; b=tUYLUTBO4ITtmpwmX0vst1lWZZ
        DVnidmNbD/Q7dg/D0oMx6J93/GV4M4yHYoR8tkpq7920ihF9F+AkLTW5rjFNS9hWIJIt0zPwRzfWJ
        ufzAIXuYC6yl7KKuRcbvKLwSIW3F9p/cYgZl47J4oYVDBp5pFnr61O+9o6Ap7kxIVrjhHH2TF+rVa
        t0PTvqd37R1IF3iH4iWuFiptMNoT7phGxK81N6M1dmUp5Hujz+k8q+9lxX5lfLBBfDLHtVuGDmAML
        gm2Guc6v0yrxAtCMba0DDGai43H5vWv6isL/87B3MwJfJBr4zwuxDPh+czo2GVRqa6DDwxmWyT+Z/
        LAX4cMqg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55688 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ooSWP-00006W-OE; Fri, 28 Oct 2022 17:47:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1ooSWP-000FDy-5t; Fri, 28 Oct 2022 17:47:53 +0100
In-Reply-To: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] ARM: findbit: document ARMv5 bit offset calculation
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 Oct 2022 17:47:53 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the ARMv5 bit offset calculation code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/lib/findbit.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 7fd3600db8ef..4c584bc4704b 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -172,10 +172,10 @@ ENDPROC(_find_next_bit_be)
 .L_found:
 #if __LINUX_ARM_ARCH__ >= 5
 		rsb	r0, r3, #0
-		and	r3, r3, r0
-		clz	r3, r3
-		rsb	r3, r3, #31
-		add	r0, r2, r3
+		and	r3, r3, r0		@ mask out lowest bit set
+		clz	r3, r3			@ count high zero bits
+		rsb	r3, r3, #31		@ offset of first set bit
+		add	r0, r2, r3		@ add offset of first set bit
 #else
 		tst	r3, #0x0f
 		addeq	r2, r2, #4
-- 
2.30.2

