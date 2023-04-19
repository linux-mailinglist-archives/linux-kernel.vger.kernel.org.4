Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C518C6E856E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjDSW6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjDSW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8C593C2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2471214cdd3so208314a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945044; x=1684537044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4z5GDt+xM87DteGPLwbziaQRjegx46K8N8SblpggcI=;
        b=lc6v/s63EfbX00zVBBvJow9kK2OWQHb1m041wnlXgjL4xvvZO/7aM1krXhOpZ+8FaO
         S7q+1SLxn3DdIZc+V5hfAlV4WjCb55HFzJDRyln3Irp6M3XCvR3EpDqv602NSOH5HNEg
         AHLZ0H0gG03A78NxoByf2kyaW6GKVrkQRI+dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945044; x=1684537044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4z5GDt+xM87DteGPLwbziaQRjegx46K8N8SblpggcI=;
        b=BE9zcwiiWAQtOhZ6jSg/WDkZU2fjvnb0AFinJ9VD9mF+y9CLaVM8BDks0LpO+XO7v0
         4iX2RklTcZSG+UtWe8mQQlC4kZXpKDyt8zJea3u1ExAup8HZ7iw+M5kAjkaVrCZqpQwx
         hneZ0l/wH0wiHljkM3CyKGUGVTr0scvaNM9Y3d9df7NnyfFIk0dpqh30EytXSvDeVQMA
         iCqTpMtDEoiP9izibFAzRut7lgDdMrLKJX9GbNOUcQQnFqKdfooh4tZXHLF+wrDqca4l
         upTupft+2SQUsuUur4qfQAfPV/GTf+wcUDIVT6wP0yw3iVmMnZ8+ysc10jRrFccieQ/q
         zxbA==
X-Gm-Message-State: AAQBX9fL2GHC7aDqgyNGurvb0NQMABh5u/Cc9c1u4hem26Rrl7AcGq4l
        WbRrnqZJlyU/RPMvcE5VxumkRA==
X-Google-Smtp-Source: AKy350aIOHfPbowBDglSQr5Ur+c9Q9vdVJvKvaRSc+zSrfA52Pfz++ZHTr6h2HiJKmK6NXRBfzJ5NQ==
X-Received: by 2002:a17:90a:5a82:b0:23f:83de:7e4a with SMTP id n2-20020a17090a5a8200b0023f83de7e4amr4268789pji.7.1681945044116;
        Wed, 19 Apr 2023 15:57:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/10] arm64: ipi_nmi: Fallback to a regular IPI if NMI isn't enabled
Date:   Wed, 19 Apr 2023 15:56:04 -0700
Message-ID: <20230419155341.v8.10.Ic3659997d6243139d0522fc3afcdfd88d7a5f030@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ipi_nmi implementation relies on the arm64 pseudo-NMI
support. This needs to be enabled in both the kernel config with
CONFIG_ARM64_PSEUDO_NMI and on the kernel command line with
"irqchip.gicv3_pseudo_nmi=1".

Let's add a fallback of using a regular IPI if the NMI isn't
enabled. The fallback mechanism of using a regular IPI matches what
arm32 does all the time since there is no NMI there.

The reason for doing this is to make the trigger_all_cpu_backtrace()
class of functions work. While those functions all return a bool
indicating that the caller should try a fallback upon failure, an
inspection of the callers shows that nearly nobody implements a
fallback. It's better to at least provide something here.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I dunno what people think of this patch. If it's great, we could
actually drop some of the patches out of this series since some of
them are to account for the fact that we might not be able to register
an "ipi_nmi". If it's awful, it could simply be dropped.

Changes in v8:
- "Fallback to a regular IPI if NMI isn't enabled" new for v8

 arch/arm64/kernel/ipi_nmi.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index 2adaaf1519e5..02868752845c 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -16,6 +16,7 @@
 
 static struct irq_desc *ipi_nmi_desc __read_mostly;
 static int ipi_nmi_id __read_mostly;
+static bool is_nmi;
 
 bool arm64_supports_nmi(void)
 {
@@ -62,8 +63,12 @@ void dynamic_ipi_setup(void)
 	if (!ipi_nmi_desc)
 		return;
 
-	if (!prepare_percpu_nmi(ipi_nmi_id))
-		enable_percpu_nmi(ipi_nmi_id, IRQ_TYPE_NONE);
+	if (is_nmi) {
+		if (!prepare_percpu_nmi(ipi_nmi_id))
+			enable_percpu_nmi(ipi_nmi_id, IRQ_TYPE_NONE);
+	} else {
+		enable_percpu_irq(ipi_nmi_id, IRQ_TYPE_NONE);
+	}
 }
 
 void dynamic_ipi_teardown(void)
@@ -71,14 +76,28 @@ void dynamic_ipi_teardown(void)
 	if (!ipi_nmi_desc)
 		return;
 
-	disable_percpu_nmi(ipi_nmi_id);
-	teardown_percpu_nmi(ipi_nmi_id);
+	if (is_nmi) {
+		disable_percpu_nmi(ipi_nmi_id);
+		teardown_percpu_nmi(ipi_nmi_id);
+	} else {
+		disable_percpu_irq(ipi_nmi_id);
+	}
 }
 
 void __init set_smp_dynamic_ipi(int ipi)
 {
+	int err;
+
 	if (!request_percpu_nmi(ipi, ipi_nmi_handler, "IPI", &cpu_number)) {
-		ipi_nmi_desc = irq_to_desc(ipi);
-		ipi_nmi_id = ipi;
+		is_nmi = true;
+	} else {
+		err = request_percpu_irq(ipi, ipi_nmi_handler, "IPI", &cpu_number);
+		if (WARN_ON(err))
+			return;
+
+		irq_set_status_flags(ipi, IRQ_HIDDEN);
 	}
+
+	ipi_nmi_desc = irq_to_desc(ipi);
+	ipi_nmi_id = ipi;
 }
-- 
2.40.0.634.g4ca3ef3211-goog

