Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924016AAE52
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 06:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCEFjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 00:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCEFjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 00:39:49 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C074CDF3;
        Sat,  4 Mar 2023 21:39:48 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q189so3689177pga.9;
        Sat, 04 Mar 2023 21:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677994788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aF4awQjRw6Sz8u+8//U9ovq/pyiLmh3hGvC3x/vOYJQ=;
        b=gyU4DPmORyLU6mT6oqiFWLuzdbnUKXyiijoxiDJQBshJZS0yHu+mLpMxRjr1JvIXr2
         pGZbZb+m+jIUUCvDC4Sy3jEtc0FYm/of5k/sBay45UotVhvDe3fDm8gKMEKlzHm5PP10
         1JJ5Vl/6DjZt7vusbIG4DCUhQpX0AU93YJGcPfKRnEC8Ef3TU2tCJc9nhsNO9d41bFlG
         /xKin2e75LglhwwZxdq6BusHz5FgofkaEWKqklQAjBfW12DqE7JnvFj1skGOjzq0Ea2S
         2P6yzymlJAgcAMTCAm8N2vTVhixxrE8JncmNDpWt43PyA2w7QyCPxNQ7izEkakIhVk5B
         GrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677994788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF4awQjRw6Sz8u+8//U9ovq/pyiLmh3hGvC3x/vOYJQ=;
        b=gd1kKCfeEYd/OV7thXm7YA2+8lqsXsolN2+7gpk1lXnibryVZ7YS3S+hfDc18zSqU4
         Qu0CLxFam6hAVHm1V8Lqs2hzhJJF54255TjNz9+7oWFufNAa7S/jCC/Cmc6r0BD2VLxD
         6rrwMIO4/KPKYQxA61U8m2/FLxARazyDBw01Na8VxZwBW5R6D/7U2Qd4jSbL6xALP7f4
         eHXWFSsqKiflgYJtZd2tTAHXTIycblcz31dLpdmyzCq/kmapCZmpSNXTD44Z8e+gTevc
         38o9/PciCLSwS2GbdKUgTOfRRhNYK2ui0TKGp+AqWKtc0Nt4qBSwFXkd+4p4gNNAHv9Q
         StPg==
X-Gm-Message-State: AO0yUKXmCBdWUFJ9vKpzAu6rzfMbGyuwJqepKbH1RgcxZhiS4fOhekip
        flTv7AzZTTByazTt5LUgO8w=
X-Google-Smtp-Source: AK7set+jKTqo3dkOqSmOvreWP2ak+GnwM1RU4t38QsU2omuNiYiQda3bLr3FX4LLB4z+SWAgjUHmsQ==
X-Received: by 2002:a62:1dd4:0:b0:5d6:138f:5596 with SMTP id d203-20020a621dd4000000b005d6138f5596mr7369497pfd.14.1677994787926;
        Sat, 04 Mar 2023 21:39:47 -0800 (PST)
Received: from mbhardwaj.nvidia.com ([203.200.25.7])
        by smtp.googlemail.com with ESMTPSA id u4-20020aa78484000000b00575d1ba0ecfsm3994983pfn.133.2023.03.04.21.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 21:39:47 -0800 (PST)
From:   Manish Bhardwaj <bhardwajmanish18@gmail.com>
Cc:     Manish Bhardwaj <bhardwajmanish18@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: introduced stub APIs for exported APIs
Date:   Sun,  5 Mar 2023 11:09:34 +0530
Message-Id: <20230305053934.9948-1-bhardwajmanish18@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
index d5628a7b5eaa..f3361f6f348e 100644
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
+extern void perf_pmu_unregister(struct pmu *pmu)					{ }
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
-- 
2.39.2

