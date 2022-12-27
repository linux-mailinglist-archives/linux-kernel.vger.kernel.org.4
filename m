Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B356656FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 21:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiL0UzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 15:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiL0Uyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 15:54:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C321615A11;
        Tue, 27 Dec 2022 12:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672173668; x=1703709668;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ne94dgkkzGg53jyZDGuBXcIDhwnjy96fv/eeDJXON+4=;
  b=M5w5O+YzbQlouT+7V+zqOsJUS7LvFktyGaT+Mq3Q+TWicrO+LTszOn4p
   ECs78AP9ceDMiJ6vgyzFWVeJ+G79NjtyfS+96yfzSNHTB5i+qDnFSMqb5
   U9bVdeFZz21MV05eT5Lr/xW85wbf/+1xw740L23erTsx/7AWxiaifQ9Mz
   j9RMTeXnYiw25Bmeo9M7ogFh5uXr6Ppj0COQitezLpWArLH4gAc8DAy81
   hD2GJxAe1TWCMOocfyx+gOs4HMxoLBTRo339Mr4aPartQIYABlZvO3cTL
   f/8d3Ws5pAhpM4uNe1u5F0QKNUOglQ31sFNqlf4Hbbp5lUTrghGVwOtJ5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="321990502"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="321990502"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 12:40:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="630780123"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="630780123"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 12:40:51 -0800
Message-ID: <24821308109ba20d845e11caf32bede92fec5d8e.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Pratyush Yadav <ptyadav@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Date:   Tue, 27 Dec 2022 12:40:51 -0800
In-Reply-To: <12138067.O9o76ZdvQC@kreacher>
References: <12138067.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-27 at 20:51 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When _PPC returns 0, it means that the CPU frequency is not limited
> by
> the platform firmware, so make acpi_processor_get_platform_limit()
> update the frequency QoS request used by it to "no limit" in that
> case
> and avoid updating the QoS request when the _PPC return value has not
> changed.
> 
> This addresses a problem with limiting CPU frequency artificially on
> some systems after CPU offline/online to the frequency that
> corresponds
> to the first entry in the _PSS return package.
> 
> While at it, move the _PPC return value check against the state count
> earlier to avoid setting performance_platform_limit to an invalid
> value.
> 
> Reported-by: Pratyush Yadav <ptyadav@amazon.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/processor_perflib.c |   27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/processor_perflib.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/processor_perflib.c
> +++ linux-pm/drivers/acpi/processor_perflib.c
> @@ -53,6 +53,8 @@ static int acpi_processor_get_platform_l
>  {
>         acpi_status status = 0;
>         unsigned long long ppc = 0;
> +       s32 qos_value;
> +       int index;
>         int ret;
>  
>         if (!pr)
> @@ -72,17 +74,30 @@ static int acpi_processor_get_platform_l
>                 }
>         }
>  
> +       index = ppc;
> +
> +       if (pr->performance_platform_limit == index ||
> +           ppc >= pr->performance->state_count)
> +               return 0;

Do we need to re initialize pr->performance_platform_limit to 0 in
acpi_processor_unregister_performance()?

If PPC was 1 before the offline and after online the above check will
cause it to return as the pr->performance_platform_limit is not
changed. Not sure if the PM QOS state is preserved after offline and
online. This is stored in a per CPU variable, not in dynamically
allocated memory which will be reallocated during online again.


Thanks,
Srinivas

> +
>         pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr-
> >id,
> -                      (int)ppc, ppc ? "" : "not");
> +                index, index ? "is" : "is not");
>  
> -       pr->performance_platform_limit = (int)ppc;
> +       pr->performance_platform_limit = index;
>  
> -       if (ppc >= pr->performance->state_count ||
> -           unlikely(!freq_qos_request_active(&pr->perflib_req)))
> +       if (unlikely(!freq_qos_request_active(&pr->perflib_req)))
>                 return 0;
>  
> -       ret = freq_qos_update_request(&pr->perflib_req,
> -                       pr->performance->states[ppc].core_frequency *
> 1000);
> +       /*
> +        * If _PPC returns 0, it means that all of the available
> states can be
> +        * used ("no limit").
> +        */
> +       if (index == 0)
> +               qos_value = FREQ_QOS_MAX_DEFAULT_VALUE;
> +       else
> +               qos_value = pr->performance-
> >states[index].core_frequency * 1000;
> +
> +       ret = freq_qos_update_request(&pr->perflib_req, qos_value);
>         if (ret < 0) {
>                 pr_warn("Failed to update perflib freq constraint:
> CPU%d (%d)\n",
>                         pr->id, ret);
> 
> 
> 


