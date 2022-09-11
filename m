Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9815B4CB6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIKIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIKIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:47:48 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177C3206E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:47 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 12976 invoked from network); 11 Sep 2022 10:47:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886064; bh=LG1nA/NbcwJ6Bmnos7szIV25H+uEv8jBm87oL1DXQ20=;
          h=From:To:Cc:Subject;
          b=bDFTJ9H7RIPdNrmWKFKmg8lEjO5k554CvwJ1y2D13E+i1MbCOGEOLo3mGMFiv62g7
           6Q6Oe3xeuERZFwMnI1Zd8WbdFTZtqzfOwadOsg7DszfJlpP6lXBAlwXoSgRYm+FnEX
           y63HRx7d/aITpiawwtsdNfRE6o/4Ef+aNqnW8oiA=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:44 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 02/10] x86/apic: fix panic message when x2APIC is not supported
Date:   Sun, 11 Sep 2022 10:47:03 +0200
Message-Id: <20220911084711.13694-3-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: b23c894c89c5d3368c5a99d8a5418887
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [cdMU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct course of action is to enable x2APIC support in the kernel,
not to disable it in the BIOS (which may be impossible).
x2APIC has performance and functionality benefits, so it is best to use
it if it is available on the platform.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Yinghai Lu <yinghai@kernel.org>
---
v2: add a newline at the end of the text

 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6d303d1d276c..206a2693a27a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1902,7 +1902,7 @@ static int __init validate_x2apic(void)
 	/*
 	 * Checkme: Can we simply turn off x2apic here instead of panic?
 	 */
-	panic("BIOS has enabled x2apic but kernel doesn't support x2apic, please disable x2apic in BIOS.\n");
+	panic("Kernel does not support x2APIC, please recompile with CONFIG_X86_X2APIC or disable x2APIC in BIOS.\n");
 }
 early_initcall(validate_x2apic);
 
-- 
2.25.1

