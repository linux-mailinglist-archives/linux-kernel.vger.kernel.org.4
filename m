Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC86D731E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjFOQph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjFOQo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:44:57 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE7030FA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:35 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f8d2bfec9bso22127965e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847474; x=1689439474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7eq1USby5ztEf/7JC2Lke/melezYmsYGTiWNlQ9QdE=;
        b=IV6LxR5o3aMYTfUtYytMr644MIV6Oiajfl225yCbT6QpDlJ4T+ohDQrmkDuIAkaSJ9
         W9zACqMgQpXStIhSHZoUCLNPFszhOcFqzUMKIaAtAUfe4C1ImyeazH5XOgv8CpFoUW7y
         NqUazOoJliX5PyvjE6BS3LBvnScaocmURFhqXFbtaVAu/9JeZ1gpnCm5WCIH/R2KGSXO
         +vuM4TabZLT6Ae5bh1wXr6CrxvcqYzA7TZyiuRGYRbVKkob8rllzzuUPSNoHtOKxo0U/
         jtSZq9FhUF+Yrhh4JAFU1WnHjagbInW11r7UvPF9HmR+Q+p0HinUazCY3MAei7y2v9fi
         P8Bw==
X-Gm-Message-State: AC+VfDzQgbNSB8iIBKhR/clsLUsbq+4vzkSQqIj3RC74GuhfMoUul8lj
        rzXX56ZEEEZQqmZvzkdlDc4=
X-Google-Smtp-Source: ACHHUZ5vMzpzcEwea8p6zmZXyM0paKmFlSUyMnQ4eN2gvbq1e5scVMSPYhTePZDDNsVHDD4QsZ9Bkw==
X-Received: by 2002:a1c:ed06:0:b0:3f7:f584:5796 with SMTP id l6-20020a1ced06000000b003f7f5845796mr15079346wmh.2.1686847473943;
        Thu, 15 Jun 2023 09:44:33 -0700 (PDT)
Received: from localhost (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c314400b003f1978bbcd6sm4683036wmo.3.2023.06.15.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:44:33 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     pawan.kumar.gupta@linux.intel.com, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     leit@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/speculation: Disable mitigations if CONFIG says so
Date:   Thu, 15 Jun 2023 09:44:16 -0700
Message-Id: <20230615164417.3588162-6-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615164417.3588162-1-leitao@debian.org>
References: <20230615164417.3588162-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way to disable certain mitigations(MDS, TAA, MMIO) today.
They are enabled even when the kernel has
CONFIG_SPECULATION_MITIGATIONS=n.

Create a function that says if the speculative mitigations are enabled
or not. They should use CONFIG_SPECULATION_MITIGATIONS as one source of
information.

Just enable MDS, TAA, MMIO mitigations if speculative mitigations are
enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/cpu/bugs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 182af64387d0..703649a29181 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -87,6 +87,12 @@ void update_spec_ctrl_cond(u64 val)
 		wrmsrl(MSR_IA32_SPEC_CTRL, val);
 }
 
+static inline bool cpu_speculative_mitigations_off(void)
+{
+	return cpu_mitigations_off() ||
+		!IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS);
+}
+
 noinstr u64 spec_ctrl_current(void)
 {
 	return this_cpu_read(x86_spec_ctrl_current);
@@ -278,7 +284,7 @@ static const char * const mds_strings[] = {
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_speculative_mitigations_off()) {
 		mds_mitigation = MDS_MITIGATION_OFF;
 		return;
 	}
@@ -352,7 +358,7 @@ static void __init taa_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off()) {
+	if (cpu_speculative_mitigations_off()) {
 		taa_mitigation = TAA_MITIGATION_OFF;
 		return;
 	}
@@ -443,7 +449,7 @@ static void __init mmio_select_mitigation(void)
 
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
 	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
-	     cpu_mitigations_off()) {
+	     cpu_speculative_mitigations_off()) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
 	}
@@ -516,7 +522,7 @@ early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 
 static void __init md_clear_update_mitigation(void)
 {
-	if (cpu_mitigations_off())
+	if (cpu_speculative_mitigations_off())
 		return;
 
 	if (!static_key_enabled(&mds_user_clear))
-- 
2.34.1

