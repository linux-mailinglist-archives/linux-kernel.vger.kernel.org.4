Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012786E8567
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjDSW5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjDSW5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D8C5BBF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51f597c97c5so255686a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945037; x=1684537037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g22FS7H3jiae+Nq35iKba9yRyiXUFZk5tjGcb2Ngrro=;
        b=I12V15zv0C6apw691aW9levIxgdcSXiKj994KdL77DgbZjGB9+wGZjupAC8Yjj+94l
         I2rEcmLlXEU/axqyDoo0R6CwAxucD+HcDQl0ePN+qZMHOnthxCTrHLDkn/xVoMejl+qb
         Me8n3aplq6CQK1d9jjQseR8w1Z4mM8oCUhL24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945037; x=1684537037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g22FS7H3jiae+Nq35iKba9yRyiXUFZk5tjGcb2Ngrro=;
        b=bikN8eQhgErI3YNKPBKgsQovWlJNtLZ2Ayv2tIllZ9o/OudANLYFQ64ihy6fyNNKHV
         2orvd5om/NjWedwi8UrUELY2F1QVPLDagfiFUZgTBbay5rWjmU//hNn7JZ/adyEbHwNJ
         /m02BOxdARJX8hLtuR6Fz/m2NGmZ9+h3jHMZ2mAdA9kO4jF1MDgmDQvGuXlJSWfxMJ5P
         qfk9fQNC/YmLpde+BhGv9oOTK2+5yGoMtuI2HP8aLOVOkHWEFK63NqkImBi5QYeE7Xpc
         KST1rpJTdbxpykxopH1XNUj+ODSqwyGZBob1jNIzPrc+emlx+nYRgp+waix0KeodBDWV
         OKcA==
X-Gm-Message-State: AAQBX9cNy4e4+MvsKDAEEcCkfaTO5s+mkP1Y6MvZfp14JI5UxL8nfqML
        nJxsCu/gEsDvmSFa6m3Y8Mu7+w==
X-Google-Smtp-Source: AKy350ZwQMfndFrterU/j3ICOpzairok4fxxMIEh8n95ls1l91IwUIv+MTPvdfsHLoUmgY2boXCeJA==
X-Received: by 2002:a17:90a:6707:b0:247:6619:61de with SMTP id n7-20020a17090a670700b00247661961demr4179810pjj.46.1681945037310;
        Wed, 19 Apr 2023 15:57:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:16 -0700 (PDT)
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
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/10] kgdb: Expose default CPUs roundup fallback mechanism
Date:   Wed, 19 Apr 2023 15:56:01 -0700
Message-ID: <20230419155341.v8.7.I21d92f8974c8e4001a5982fea6c98da1bed33ef5@changeid>
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

From: Sumit Garg <sumit.garg@linaro.org>

Add a new API kgdb_smp_call_nmi_hook() to expose default CPUs roundup
mechanism to a particular archichecture as a runtime fallback if it
detects to not support NMI roundup.

Currently such an architecture example is arm64 supporting pseudo NMIs
feature which is only available on platforms which have support for GICv3
or later version.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 include/linux/kgdb.h      | 12 ++++++++++++
 kernel/debug/debug_core.c |  8 +++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 258cdde8d356..87713bd390f3 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -199,6 +199,18 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
 
 extern void kgdb_call_nmi_hook(void *ignored);
 
+/**
+ *	kgdb_smp_call_nmi_hook - Provide default fallback mechanism to
+ *				 round-up CPUs
+ *
+ *	If you're using the default implementation of kgdb_roundup_cpus()
+ *	this function will be called.  And if an arch detects at runtime to
+ *	not support NMI based roundup then it can fallback to default
+ *	mechanism using this API.
+ */
+
+extern void kgdb_smp_call_nmi_hook(void);
+
 /**
  *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
  *
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index d5e9ccde3ab8..14d40a7d6a4b 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -238,7 +238,7 @@ NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
 static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd) =
 	CSD_INIT(kgdb_call_nmi_hook, NULL);
 
-void __weak kgdb_roundup_cpus(void)
+void kgdb_smp_call_nmi_hook(void)
 {
 	call_single_data_t *csd;
 	int this_cpu = raw_smp_processor_id();
@@ -269,6 +269,12 @@ void __weak kgdb_roundup_cpus(void)
 			kgdb_info[cpu].rounding_up = false;
 	}
 }
+NOKPROBE_SYMBOL(kgdb_smp_call_nmi_hook);
+
+void __weak kgdb_roundup_cpus(void)
+{
+	kgdb_smp_call_nmi_hook();
+}
 NOKPROBE_SYMBOL(kgdb_roundup_cpus);
 
 #endif
-- 
2.40.0.634.g4ca3ef3211-goog

