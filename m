Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5C72EEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjFMWIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFMWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8DD10E6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBD7363B71
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E4BC433CB;
        Tue, 13 Jun 2023 22:08:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9CBc-000EDc-0c;
        Tue, 13 Jun 2023 18:08:24 -0400
Message-ID: <20230613220824.008781599@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 13 Jun 2023 18:07:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        William White <chwhite@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [for-next][PATCH 04/11] rtla: Automatically move rtla to a house-keeping cpu
References: <20230613220750.330146797@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

When the user sets -c <cpu-list> try to move rtla out of the <cpu-list>,
even without an -H option. This is useful to avoid having rtla
interfering with the workload.

This works by removing <cpu-list> from rtla's current affinity.

If rtla fails to move itself away it is not that of a problem as this
is an automatic measure.

Link: https://lkml.kernel.org/r/c54304d90c777310fb85a3e658d1449173759aab.1686066600.git.bristot@kernel.org

Cc: William White <chwhite@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_hist.c  |  9 +++++
 tools/tracing/rtla/src/osnoise_top.c   |  9 +++++
 tools/tracing/rtla/src/timerlat_hist.c |  9 +++++
 tools/tracing/rtla/src/timerlat_top.c  |  9 +++++
 tools/tracing/rtla/src/utils.c         | 50 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/utils.h         |  1 +
 6 files changed, 87 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index b616a72d5c0a..dfbcb5ca7ecb 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -753,6 +753,15 @@ osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_hist_params
 			err_msg("Failed to set rtla to the house keeping CPUs\n");
 			goto out_err;
 		}
+	} else if (params->cpus) {
+		/*
+		 * Even if the user do not set a house-keeping CPU, try to
+		 * move rtla to a CPU set different to the one where the user
+		 * set the workload to run.
+		 *
+		 * No need to check results as this is an automatic attempt.
+		 */
+		auto_house_keeping(&params->monitored_cpus);
 	}
 
 	return 0;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 0e2f3b216d34..0833537bb2eb 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -582,6 +582,15 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
 			err_msg("Failed to set rtla to the house keeping CPUs\n");
 			goto out_err;
 		}
+	} else if (params->cpus) {
+		/*
+		 * Even if the user do not set a house-keeping CPU, try to
+		 * move rtla to a CPU set different to the one where the user
+		 * set the workload to run.
+		 *
+		 * No need to check results as this is an automatic attempt.
+		 */
+		auto_house_keeping(&params->monitored_cpus);
 	}
 
 	return 0;
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 00287e96f22e..1675d54cae81 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -776,6 +776,15 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 			err_msg("Failed to set rtla to the house keeping CPUs\n");
 			goto out_err;
 		}
+	} else if (params->cpus) {
+		/*
+		 * Even if the user do not set a house-keeping CPU, try to
+		 * move rtla to a CPU set different to the one where the user
+		 * set the workload to run.
+		 *
+		 * No need to check results as this is an automatic attempt.
+		 */
+		auto_house_keeping(&params->monitored_cpus);
 	}
 
 	return 0;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 920f2f6ef842..f0c6d9735e2a 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -619,6 +619,15 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 			err_msg("Failed to set rtla to the house keeping CPUs\n");
 			goto out_err;
 		}
+	} else if (params->cpus) {
+		/*
+		 * Even if the user do not set a house-keeping CPU, try to
+		 * move rtla to a CPU set different to the one where the user
+		 * set the workload to run.
+		 *
+		 * No need to check results as this is an automatic attempt.
+		 */
+		auto_house_keeping(&params->monitored_cpus);
 	}
 
 	return 0;
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 8f9ad8f01e0f..3e25f0277fb9 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -709,3 +709,53 @@ int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
 	close(cg_fd);
 	return 0;
 }
+
+/**
+ * auto_house_keeping - Automatically move rtla out of measurement threads
+ *
+ * Try to move rtla away from the tracer, if possible.
+ *
+ * Returns 1 on success, 0 otherwise.
+ */
+int auto_house_keeping(cpu_set_t *monitored_cpus)
+{
+	cpu_set_t rtla_cpus, house_keeping_cpus;
+	int retval;
+
+	/* first get the CPUs in which rtla can actually run. */
+	retval = sched_getaffinity(getpid(), sizeof(rtla_cpus), &rtla_cpus);
+	if (retval == -1) {
+		debug_msg("Could not get rtla affinity, rtla might run with the threads!\n");
+		return 0;
+	}
+
+	/* then check if the existing setup is already good. */
+	CPU_AND(&house_keeping_cpus, &rtla_cpus, monitored_cpus);
+	if (!CPU_COUNT(&house_keeping_cpus)) {
+		debug_msg("rtla and the monitored CPUs do not share CPUs.");
+		debug_msg("Skipping auto house-keeping\n");
+		return 1;
+	}
+
+	/* remove the intersection */
+	CPU_XOR(&house_keeping_cpus, &rtla_cpus, monitored_cpus);
+
+	/* get only those that rtla can run */
+	CPU_AND(&house_keeping_cpus, &house_keeping_cpus, &rtla_cpus);
+
+	/* is there any cpu left? */
+	if (!CPU_COUNT(&house_keeping_cpus)) {
+		debug_msg("Could not find any CPU for auto house-keeping\n");
+		return 0;
+	}
+
+	retval = sched_setaffinity(getpid(), sizeof(house_keeping_cpus), &house_keeping_cpus);
+	if (retval == -1) {
+		debug_msg("Could not set affinity for auto house-keeping\n");
+		return 0;
+	}
+
+	debug_msg("rtla automatically moved to an auto house-keeping cpu set\n");
+
+	return 1;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 9ab2f0d7bc1c..dec59163cfbc 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -60,6 +60,7 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set);
 int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
 int set_cpu_dma_latency(int32_t latency);
+int auto_house_keeping(cpu_set_t *monitored_cpus);
 
 #define ns_to_usf(x) (((double)x/1000))
 #define ns_to_per(total, part) ((part * 100) / (double)total)
-- 
2.39.2
