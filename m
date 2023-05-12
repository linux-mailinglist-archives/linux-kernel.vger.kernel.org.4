Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F86700857
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbjELMrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjELMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:47:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2E711D82
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vdTxcgWO1By0iF6Z2i/LtR0GY0S19282UkV3RoglxSU=; b=J7tfRUcTFK/19zRMwE1+/3cQHP
        1xlkCSvFVYR26IwUsXfpPKGHpgXJMnPRD6uqgHNudHlZYDk1dAI5ZsPchNBRTDADgW9T3Vu+DIJ+H
        cr1QFLjxzel+Y4Q6C5PtEm5pP8NobNBXX5r6XFRjviH+02Em4Bmt40yVoK6IddQdhE/VYcoybaTb4
        t373NN+aH4EPi/c4aE21CYG5+HkVwkxMe7Wfr6MeHIdqasuampx8CnjCxoQFFrXcl5fGgOXSf90Hh
        KajsaafsgVDWOHXjRGyGDJ2F46rSrTemzZ153QLlf5Gr2aGZT6/Aet4IkIAoUZEBwthywJQQanbDV
        umtsBXRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSAn-00993y-0E;
        Fri, 12 May 2023 12:47:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FB35300451;
        Fri, 12 May 2023 14:46:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5049A2C8B6A87; Fri, 12 May 2023 14:46:59 +0200 (CEST)
Date:   Fri, 12 May 2023 14:46:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] watchdog: Prefer use "ref-cycles" for NMI watchdog
Message-ID: <20230512124659.GY4253@hirez.programming.kicks-ass.net>
References: <20230509221700.859865-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509221700.859865-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 03:17:00PM -0700, Song Liu wrote:
> NMI watchdog permanently consumes one hardware counters per CPU on the
> system. For systems that use many hardware counters, this causes more
> aggressive time multiplexing of perf events.
> 
> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
> used. Try use "ref-cycles" for the watchdog. If the CPU supports it, so
> that one more hardware counter is available to the user. If the CPU doesn't
> support "ref-cycles", fall back to "cycles".
> 
> The downside of this change is that users of "ref-cycles" need to disable
> nmi_watchdog.

Urgh..

how about something like so instead; then you can use whatever event you
like...

---
 include/linux/nmi.h   |  2 ++
 kernel/watchdog.c     | 45 ++++++++++++++++++++++++++++++++++++---------
 kernel/watchdog_hld.c |  4 ++--
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 048c0b9aa623..8b6307837346 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -19,6 +19,8 @@ bool is_hardlockup(void);
 
 extern int watchdog_user_enabled;
 extern int nmi_watchdog_user_enabled;
+extern int nmi_watchdog_type;
+extern u64 nmi_watchdog_config;
 extern int soft_watchdog_user_enabled;
 extern int watchdog_thresh;
 extern unsigned long watchdog_enabled;
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e61f21e7e33..b3c09e0f96a3 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -40,6 +40,8 @@ static DEFINE_MUTEX(watchdog_mutex);
 unsigned long __read_mostly watchdog_enabled;
 int __read_mostly watchdog_user_enabled = 1;
 int __read_mostly nmi_watchdog_user_enabled = NMI_WATCHDOG_DEFAULT;
+int __ro_after_init nmi_watchdog_type = PERF_TYPE_HARDWARE;
+u64 __ro_after_init nmi_watchdog_config = PERF_COUNT_HW_CPU_CYCLES;
 int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
 static int __read_mostly nmi_watchdog_available;
@@ -73,15 +75,40 @@ void __init hardlockup_detector_disable(void)
 
 static int __init hardlockup_panic_setup(char *str)
 {
-	if (!strncmp(str, "panic", 5))
-		hardlockup_panic = 1;
-	else if (!strncmp(str, "nopanic", 7))
-		hardlockup_panic = 0;
-	else if (!strncmp(str, "0", 1))
-		nmi_watchdog_user_enabled = 0;
-	else if (!strncmp(str, "1", 1))
-		nmi_watchdog_user_enabled = 1;
-	return 1;
+	int ret = 1;
+
+	if (!str)
+		return -EINVAL;
+
+	while (str) {
+		char *next = strchr(str, ',');
+		if (next) {
+			*next = 0;
+			next++;
+		}
+
+		if (!strcmp(str, "panic"))
+			hardlockup_panic = 1;
+		else if (!strcmp(str, "nopanic"))
+			hardlockup_panic = 0;
+		else if (!strcmp(str, "0"))
+			nmi_watchdog_user_enabled = 0;
+		else if (!strcmp(str, "1"))
+			nmi_watchdog_user_enabled = 1;
+		else if (str[0] == 'r') {
+			str++;
+			ret = kstrtou64(str, 16, &nmi_watchdog_config);
+			if (ret)
+				break;
+			nmi_watchdog_type = PERF_TYPE_RAW;
+			nmi_watchdog_user_enabled = 1;
+		}
+
+		str = next;
+	}
+
+	return ret;
+
 }
 __setup("nmi_watchdog=", hardlockup_panic_setup);
 
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..27bc15f9a92a 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -99,8 +99,6 @@ static inline bool watchdog_check_timestamp(void)
 #endif
 
 static struct perf_event_attr wd_hw_attr = {
-	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
 	.size		= sizeof(struct perf_event_attr),
 	.pinned		= 1,
 	.disabled	= 1,
@@ -170,6 +168,8 @@ static int hardlockup_detector_event_create(void)
 	struct perf_event *evt;
 
 	wd_attr = &wd_hw_attr;
+	wd_attr->type = nmi_watchdog_type;
+	wd_attr->config = nmi_watchdog_config;
 	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
 
 	/* Try to register using hardware perf events */
