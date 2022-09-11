Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013135B4CBB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiIKIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIKIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:47:49 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8A3206E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:48 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 16400 invoked from network); 11 Sep 2022 10:47:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886066; bh=vIU+pYyiZqffoa9XSPfAbtCZ4n9Cipl0lCAjnwdsgs8=;
          h=From:To:Cc:Subject;
          b=XtMTJNOrLLmaoh3u2S2l7mRmcRrnh5zBe0eSqTo5/WHeqIHKaObBg919BI9cLHoGa
           glzUVoAwI0Kw2DvP1DE7JOimXvu/pVhL204lME2zxqeJYfYEZBJeXWr45F9qLW7a8E
           XYR9MWDHuAWDaf1MYUCwl31t7vMai6n2AQU6ZYvk=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:46 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 03/10] x86/Kconfig: always enable ARCH_SPARSEMEM_ENABLE
Date:   Sun, 11 Sep 2022 10:47:04 +0200
Message-Id: <20220911084711.13694-4-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 8cba2fd5504c7f8c4ec837be5678c50e
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [oeME]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that (X86_64 || X86_32) is always true on x86.

This logical OR directive was introduced in
commit 6ea3038648da ("arch/x86: remove depends on CONFIG_EXPERIMENTAL")
probably by a trivial mistake.

Fixes: 6ea3038648da ("arch/x86: remove depends on CONFIG_EXPERIMENTAL")
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 28133b5d3f12..70bf4df73fa2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1625,7 +1625,6 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
 
-- 
2.25.1

