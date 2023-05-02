Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E91D6F474E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjEBPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjEBPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:34:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C620ACC;
        Tue,  2 May 2023 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n5nFvQDtT19Y0IoYC+k9c19j4Y4eOBPBF0zE19fkJiE=; b=j9YwVa8JmZCz14lLJDjeYIiIY0
        QJTITifAv7TXUfitdIzFN4XbgPG6K8fHI2NUxa/1LItOW3qP1VRHtsHHrbnt/PKf+iwtdEYIi8wMP
        IF52nY8VUeX3b4Fb96p0H9raiLuWo13WnCpm1JAqXUJRcQ7qFKy2CNMLjaXUlCNnYhhhhbXXhfPZs
        C6L/dQCeqwUN/qBDOM9/EaDdY1tVMVRRX25cnE9Ug446nMtfx5yP5OguNmwBjALdHvvG8USeR2F+D
        kMiIdN55xUuwwSO3XbUcZ8hIsstBjrrocOLp9HiqdYkNAQmDTWor0poYSMfEhGbxBbGBWBC+iYDFa
        N7ujUV+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pts1J-008QZd-0G; Tue, 02 May 2023 15:34:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D7153002BF;
        Tue,  2 May 2023 17:34:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0482724827D27; Tue,  2 May 2023 17:34:22 +0200 (CEST)
Date:   Tue, 2 May 2023 17:34:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v3 1/3] perf/core: Rework forwarding of {task|cpu}-clock
 events
Message-ID: <20230502153422.GE1597538@hirez.programming.kicks-ass.net>
References: <20230425142205.762-1-ravi.bangoria@amd.com>
 <20230425142205.762-2-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425142205.762-2-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 07:52:03PM +0530, Ravi Bangoria wrote:
> Currently, PERF_TYPE_SOFTWARE is treated specially since task-clock and
> cpu-clock events are interfaced through it but internally gets forwarded
> to their own pmus.
> 
> Rework this by overwriting event->attr.type in perf_swevent_init() which
> will cause perf_init_event() to retry with updated type and event will
> automatically get forwarded to right pmu. With the change, SW pmu no
> longer needs to be treated specially and can be included in 'pmu_idr'
> list.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  include/linux/perf_event.h | 11 ++++++
>  kernel/events/core.c       | 69 ++++++++++++++++++++------------------
>  2 files changed, 47 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..40647d707fb3 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -322,6 +322,9 @@ struct pmu {
>  	/* number of address filters this PMU can do */
>  	unsigned int			nr_addr_filters;
>  
> +	/* Skip creating pmu device and sysfs interface. */
> +	bool				skip_sysfs_dev;
> +
>  	/*
>  	 * Fully disable/enable this PMU, can be used to protect from the PMI
>  	 * as well as for lazy/batch writing of the MSRs.

Does this make sense?

---
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -295,6 +295,8 @@ struct perf_event_pmu_context;
 
 struct perf_output_handle;
 
+#define PMU_NULL_DEV	((void *)(~0))
+
 /**
  * struct pmu - generic performance monitoring unit
  */
@@ -322,9 +324,6 @@ struct pmu {
 	/* number of address filters this PMU can do */
 	unsigned int			nr_addr_filters;
 
-	/* Skip creating pmu device and sysfs interface. */
-	bool				skip_sysfs_dev;
-
 	/*
 	 * Fully disable/enable this PMU, can be used to protect from the PMI
 	 * as well as for lazy/batch writing of the MSRs.
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11113,7 +11113,7 @@ static struct pmu perf_cpu_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
 	.capabilities	= PERF_PMU_CAP_NO_NMI,
-	.skip_sysfs_dev	= true,
+	.dev		= PMU_NULL_DEV,
 
 	.event_init	= cpu_clock_event_init,
 	.add		= cpu_clock_event_add,
@@ -11195,7 +11195,7 @@ static struct pmu perf_task_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
 	.capabilities	= PERF_PMU_CAP_NO_NMI,
-	.skip_sysfs_dev	= true,
+	.dev		= PMU_NULL_DEV,
 
 	.event_init	= task_clock_event_init,
 	.add		= task_clock_event_add,
@@ -11442,7 +11442,7 @@ int perf_pmu_register(struct pmu *pmu, c
 	type = ret;
 	pmu->type = type;
 
-	if (pmu_bus_running && !pmu->skip_sysfs_dev) {
+	if (pmu_bus_running && !pmu->dev) {
 		ret = pmu_dev_alloc(pmu);
 		if (ret)
 			goto free_idr;
@@ -11524,7 +11524,7 @@ void perf_pmu_unregister(struct pmu *pmu
 
 	free_percpu(pmu->pmu_disable_count);
 	idr_remove(&pmu_idr, pmu->type);
-	if (pmu_bus_running) {
+	if (pmu_bus_running && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
 		device_del(pmu->dev);
@@ -13687,7 +13687,7 @@ static int __init perf_event_sysfs_init(
 		goto unlock;
 
 	list_for_each_entry(pmu, &pmus, entry) {
-		if (pmu->skip_sysfs_dev)
+		if (pmu->dev)
 			continue;
 
 		ret = pmu_dev_alloc(pmu);
