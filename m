Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ADA6E0A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDMJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDMJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:24:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A50901B;
        Thu, 13 Apr 2023 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681377835; x=1712913835;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SPDp3hg45JekinIXS1tAfq4DH77ftTaYczfJGUAIIzw=;
  b=GGLHM96VIl2MVWrCT7Z1sLJugF4xCSe/0VbQLkjQijYnWejcPvhxfTqO
   AKo7eVTjTp6wD2l3Qn0Y6NmclUIjya6nirUiEKsOxAEiQ6saUqoM3x/13
   lqx1YpNd4c0fMZrVovT7EO1+oPN2xP6Uzz/aFQeDIaEZhwWUlN2eyaKLj
   XcxPflRCh0QLck3zizJbH0ZdmmhJ0XeTySSQP+vI1l4w6psgkhucZ+7e8
   83E8WDcpF2g0TLPcLZs3TYD+ShO/duoMEDLL/H401W3ITgd+nyBUiVHgH
   U9PtpnQXjRwDjGiz4iFm/1ffvsC4WAZ4yxIEWmJAtsCk8bnNVJLnhnWDC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="344130961"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="344130961"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 02:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="682887647"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="682887647"
Received: from pkudryav-mobl1.ger.corp.intel.com ([10.252.45.220])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 02:23:51 -0700
Date:   Thu, 13 Apr 2023 12:23:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
cc:     Box David E <david.e.box@intel.com>, jstultz@google.com,
        pavel@ucw.cz, svenva@chromium.org,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Shyam-sundar.S-k@amd.com, rrangel@chromium.org,
        Jain Rajat <rajatja@google.com>, hdegoede@redhat.com,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
In-Reply-To: <20230412194917.7164-5-mario.limonciello@amd.com>
Message-ID: <5d904d5a-d25e-7d6d-57e4-ca451bcead57@linux.intel.com>
References: <20230412194917.7164-1-mario.limonciello@amd.com> <20230412194917.7164-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023, Mario Limonciello wrote:

> intel_pmc_core displays a warning when the module parameter
> `warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
> state.
> 
> Report this to the standard kernel reporting infrastructure so that
> userspace software can query after the suspend cycle is done.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7->v8:
>  * Report max sleep as well
> ---
>  drivers/platform/x86/intel/pmc/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 925c5d676a43..f9677104353d 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1153,6 +1153,7 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	pmc_core_do_dmi_quirks(pmcdev);
>  
>  	pmc_core_dbgfs_register(pmcdev);
> +	pm_report_max_hw_sleep(((1UL << 32) - 1) * pmc_core_adjust_slp_s0_step(pmcdev, 1));

Technically this is FIELD_MAX(SLP_S0_RES_COUNTER_MASK) * pmc_core_adjust...? 
Where the define is:
#define SLP_S0_RES_COUNTER_MASK	GENMASK(31, 0)

>  
>  	device_initialized = true;
>  	dev_info(&pdev->dev, " initialized\n");
> @@ -1214,6 +1215,8 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
>  	if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
>  		return false;
>  
> +	pm_report_hw_sleep_time((u32)(s0ix_counter - pmcdev->s0ix_counter));
> +
>  	if (s0ix_counter == pmcdev->s0ix_counter)
>  		return true;
>  
> 

-- 
 i.

