Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDCC6A96A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCCLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCCLq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:46:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E780B5C107
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:46:56 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FA7A1EC0657;
        Fri,  3 Mar 2023 12:46:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677844015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=qiGBt7B0mRCjrofKoblCFZs0an8sawnlWbGRochINd4=;
        b=JUrmvvkQfN6eTb+URvjCH1wJuAixCLZW6rj/dqloq0QPIevBnC/3sQ0mOi6oU0SXOhw4Lf
        i9hAh3jXVnI9rQDFsd0YvtUeAHNB5rqDA2z81uSQmCI99zU2EawNHrpDXILLI9cJ3HkD9j
        h3Gv0ugfXhNsiCYfcir1Uj2zsjHEMYA=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode: Do not taint when late loading on AMD
Date:   Fri,  3 Mar 2023 12:46:49 +0100
Message-Id: <20230303114649.18552-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Describe why the concurrency issues which late loading poses are not
affecting AMD hardware, after discussing it with hw folks. Thus, do not
taint when late loading on it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/x86/microcode.rst      | 10 ++++++++++
 arch/x86/kernel/cpu/microcode/core.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index b627c6f36bcf..15b52e2b181d 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -208,6 +208,16 @@ Basically there is no way to declare a new microcode update suitable
 for late-loading. This is another one of the problems that caused late
 loading to be not enabled by default.
 
+AMD
+---
+
+Late loading on AMD does not have the concurrency issues described
+above: when loading is attempted on T0, the T1 is quiesced and does not
+execute instructions. Therefore, even if a higher priority interrupt or
+a fault happens, the whole core will see it either before the microcode
+patch has been applied or after. In either case, T0 and T1 will have the
+same microcode revision and nothing intermediate.
+
 Builtin microcode
 =================
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7a329e561354..779f70547fb7 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -498,7 +498,8 @@ static ssize_t reload_store(struct device *dev,
 	if (ret == 0)
 		ret = size;
 
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 
 	return ret;
 }
-- 
2.35.1

