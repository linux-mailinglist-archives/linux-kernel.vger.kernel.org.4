Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE56AAEC6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 10:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCEJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 04:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCEJ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 04:28:20 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323B67A8E;
        Sun,  5 Mar 2023 01:28:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kb15so6921833pjb.1;
        Sun, 05 Mar 2023 01:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678008498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjyKHW/kawAuwuQfrAWVGuzBmTM7GYJlp82gYhymMcs=;
        b=jABWayejwtGhcItoAt3G7bLw466a5H5PPhNAyj/17NYmQeniElDScMW8f1oclGzhpq
         3Hzgt26m3KUuGZWox+tg6RcyyCaPKyacXGxZf8NgsxnUzuZu/X3NNEV3JM37QDoPwLHu
         Ryx0zCRZAcKCxUk3HP6/9wHIqV4ykjyQtanrdEEagsY6O9KKyxCrCVcuuymCgqWGdA34
         lAqApg1ezaVz27wA0yLKRAn6uRWYaObKPKe7f7h3c9Im7CTisAAUvpPPdfG5xCVvIEEx
         7xnInnHAXuiI+XX1RS3x2X9f8qYTij/IsZ+4TqTWBjtzO98OexFsQ0fCtrYaTqPLGdTh
         P0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678008498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjyKHW/kawAuwuQfrAWVGuzBmTM7GYJlp82gYhymMcs=;
        b=V4yAbiI5KXXMgIBfnOraFWFJOqsVan7FK49peXfYU2UPYZckX6s2Xgo6ZHigExSqaN
         z1KDR6+gysr1vGxvoCE0dWNc8FQ/+WZ3xFxUes4fam6smoDDrR1V74dsHNJ82J3tWzDd
         B7AGy+OJC4O83+D6aJ0Cf++cRW+Wd7RuUNlMY7edAuga/UO+mZ/jEoE+DTeIRVhZOT2d
         CWn9lbExPiJ75rAlFirm20mNGPVajTP7cLGzTORGtch4jc0pCElG5/+Iqq838zTV4OM/
         909kt3GVry9PUrg1iTM81dOy5t174dK3pObiQJQn2bYC4YW4iXPjXMHD9gr4+t2j5Ypw
         M6Uw==
X-Gm-Message-State: AO0yUKVd+fFVMlMBxqrp7tyeYBkvyrItJ2LDxMX5DG6lqZDEzJz8ZWfa
        5r9vc0dr23kxRHGNlKQFVanbWqDgx9HYSQ==
X-Google-Smtp-Source: AK7set++UyKWGrsZ10B0LNEUIUmCxHzBKAElgojOCieONFfl9ObfJihWWVgmFzngmwJQU1V35v7Yeg==
X-Received: by 2002:a17:902:f693:b0:19d:e11:32de with SMTP id l19-20020a170902f69300b0019d0e1132demr9442026plg.34.1678008498536;
        Sun, 05 Mar 2023 01:28:18 -0800 (PST)
Received: from mbhardwaj.nvidia.com ([203.200.25.7])
        by smtp.googlemail.com with ESMTPSA id w22-20020a1709029a9600b001991f3d85acsm4418019plp.299.2023.03.05.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 01:28:18 -0800 (PST)
From:   Manish Bhardwaj <bhardwajmanish18@gmail.com>
To:     bhardwajmanish18@gmail.com
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Subject: [PATCH] perf/core: introduced stub APIs for exported APIs
Date:   Sun,  5 Mar 2023 14:57:59 +0530
Message-Id: <20230305092759.10754-1-bhardwajmanish18@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305053934.9948-1-bhardwajmanish18@gmail.com>
References: <20230305053934.9948-1-bhardwajmanish18@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduced stub APIs for exported APIs so that we can build
independent module without any error if CONFIG_PERF_EVENT
feature is disabled in kernel.

drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.c:
In function _scf_pmu_device_probe_:
drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.c:596:    8:
error: implicit declaration of function _perf_pmu_register_
[-Werror=implicit-function-declaration]
  err = perf_pmu_register(&uncore_pmu->pmu, uncore_pmu->pmu.name,
531       |        ^~~~~~~~~~~~~~~~~
drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.c: In
function _scf_pmu_device_remove_:
drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.c:611:    2:
error: implicit declaration of function _perf_pmu_unregister_; did you
mean _device_unregister_? [-Werror=implicit-function-declaration]
  611 |  perf_pmu_unregister(&uncore_pmu->pmu);
      |  ^~~~~~~~~~~~~~~~~~~
      |  device_unregister
cc1: some warnings being treated as errors
scripts/Makefile.build:297: recipe for target
'drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.o' failed
make[7]: *** [drivers/platform/tegra/
uncore_pmu/tegra23x_perf_uncore.o] Error 1

Signed-off-by: Manish Bhardwaj <bhardwajmanish18@gmail.com>
---
 include/linux/perf_event.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..96259320aff1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1679,6 +1679,42 @@ extern int perf_event_account_interrupt(struct perf_event *event);
 extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
 #else /* !CONFIG_PERF_EVENTS: */
+static void perf_event_addr_filters_sync(struct perf_event *event)		{ }
+static u64 perf_event_read_value(struct perf_event *event,
+				 u64 *enabled, u64 *running)
+{
+	return 0;
+}
+static void perf_event_update_userpage(struct perf_event *event)			{ }
+static void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)	{ }
+static void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)	{ }
+static void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)		{ }
+static void perf_tp_event(u16 event_type, u64 count, void *record,
+			  int entry_size, struct pt_regs *regs,
+			  struct hlist_head *head, int rctx,
+			  struct task_struct *task)
+{
+}
+static int perf_pmu_register(struct pmu *pmu, const char *name, int type)
+{
+	return -1;
+}
+static void perf_pmu_unregister(struct pmu *pmu)					{ }
+static struct perf_event *
+perf_event_create_kernel_counter(struct perf_event_attr *attr,
+				int cpu,
+				struct task_struct *task,
+				perf_overflow_handler_t callback,
+				void *context)
+{
+	return NULL;
+}
+static void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)		{ }
+static ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
+			      char *page)
+{
+	return -1;
+}
 static inline void *
 perf_aux_output_begin(struct perf_output_handle *handle,
 		      struct perf_event *event)				{ return NULL; }

base-commit: b01fe98d34f3bed944a93bd8119fed80c856fad8
-- 
2.39.2

