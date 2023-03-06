Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10D36AC8D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCFQ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCFQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:57:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF4F13BDBC;
        Mon,  6 Mar 2023 08:57:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9B0FFEC;
        Mon,  6 Mar 2023 08:57:13 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.47.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F6B33F67D;
        Mon,  6 Mar 2023 08:56:28 -0800 (PST)
Date:   Mon, 6 Mar 2023 16:56:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Manish Bhardwaj <bhardwajmanish18@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: introduced stub APIs for exported APIs
Message-ID: <ZAYbNawi+hYnZw/h@FVFF77S0Q05N>
References: <20230305053934.9948-1-bhardwajmanish18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305053934.9948-1-bhardwajmanish18@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 11:09:34AM +0530, Manish Bhardwaj wrote:
> Introduced stub APIs for exported APIs so that we can build
> independent module without any error if CONFIG_PERF_EVENT
> feature is disabled in kernel.
> 
> drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.c:

This file and folders do not exist in mainline (looking at v6.3-rc1), and I'd
expect this driver to live under drivers/perf/ unless it's tied to some other
component, which the naming implies it is not.

There is no point bulding a PMU driver when CONFIG_PERF_EVENT=n, since it
cannot register with perf and so the code will bloat the kernel for no reason.

The better option is to fix the Kconfig for the driver to depend upon
CONFIG_PERF_EVENT=y so that it cannot be built in this case.

Thanks,
Mark.

> In function _scf_pmu_device_probe_:
> drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.c:596:    8:
> error: implicit declaration of function _perf_pmu_register_
> [-Werror=implicit-function-declaration]
>   err = perf_pmu_register(&uncore_pmu->pmu, uncore_pmu->pmu.name,
> 531       |        ^~~~~~~~~~~~~~~~~
> drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.c: In
> function _scf_pmu_device_remove_:
> drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.c:611:    2:
> error: implicit declaration of function _perf_pmu_unregister_; did you
> mean _device_unregister_? [-Werror=implicit-function-declaration]
>   611 |  perf_pmu_unregister(&uncore_pmu->pmu);
>       |  ^~~~~~~~~~~~~~~~~~~
>       |  device_unregister
> cc1: some warnings being treated as errors
> scripts/Makefile.build:297: recipe for target
> 'drivers/platform/tegra/uncore_pmu/tegra23x_perf_uncore.o' failed
> make[7]: *** [drivers/platform/tegra/
> uncore_pmu/tegra23x_perf_uncore.o] Error 1
> 
> Signed-off-by: Manish Bhardwaj <bhardwajmanish18@gmail.com>
> ---
>  include/linux/perf_event.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..f3361f6f348e 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1679,6 +1679,42 @@ extern int perf_event_account_interrupt(struct perf_event *event);
>  extern int perf_event_period(struct perf_event *event, u64 value);
>  extern u64 perf_event_pause(struct perf_event *event, bool reset);
>  #else /* !CONFIG_PERF_EVENTS: */
> +static void perf_event_addr_filters_sync(struct perf_event *event)		{ }
> +static u64 perf_event_read_value(struct perf_event *event,
> +				 u64 *enabled, u64 *running)
> +{
> +	return 0;
> +}
> +static void perf_event_update_userpage(struct perf_event *event)			{ }
> +static void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)	{ }
> +static void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)	{ }
> +static void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)		{ }
> +static void perf_tp_event(u16 event_type, u64 count, void *record,
> +			  int entry_size, struct pt_regs *regs,
> +			  struct hlist_head *head, int rctx,
> +			  struct task_struct *task)
> +{
> +}
> +static int perf_pmu_register(struct pmu *pmu, const char *name, int type)
> +{
> +	return -1;
> +}
> +extern void perf_pmu_unregister(struct pmu *pmu)					{ }
> +static struct perf_event *
> +perf_event_create_kernel_counter(struct perf_event_attr *attr,
> +				int cpu,
> +				struct task_struct *task,
> +				perf_overflow_handler_t callback,
> +				void *context)
> +{
> +	return NULL;
> +}
> +static void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)		{ }
> +static ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
> +			      char *page)
> +{
> +	return -1;
> +}
>  static inline void *
>  perf_aux_output_begin(struct perf_output_handle *handle,
>  		      struct perf_event *event)				{ return NULL; }
> -- 
> 2.39.2
> 
