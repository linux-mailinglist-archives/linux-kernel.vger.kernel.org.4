Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B215E658CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiL2M6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2M6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:58:39 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38E613DE9;
        Thu, 29 Dec 2022 04:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1672318719; x=1703854719;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=fPipVc4z0gWEOJMhi7+Lql0b+KIlINn8rsi5K72nNU4=;
  b=ivk5BPlqnEWddg5acAzcTnHH1K+W/6wzAZPtFSgdy3psZmNR5SCs/8pg
   1ruuq/VqT2Wan9d5wwFYOS3L8W7atHstEFewZxLvHi9/ub5XTzjVUMEBy
   DdpLtXGqKBFdVj4IYUZqKcPkbuPW60a3bT/7DxDIWUCogufMdF6d44go+
   Y=;
X-IronPort-AV: E=Sophos;i="5.96,284,1665446400"; 
   d="scan'208";a="166123243"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 12:58:37 +0000
Received: from EX13MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id 6032441886;
        Thu, 29 Dec 2022 12:58:36 +0000 (UTC)
Received: from EX19D024UWB003.ant.amazon.com (10.13.138.126) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 29 Dec 2022 12:58:35 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D024UWB003.ant.amazon.com (10.13.138.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.20; Thu, 29 Dec 2022 12:58:35 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.42 via Frontend Transport; Thu, 29 Dec 2022 12:58:35 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id C228220D25; Thu, 29 Dec 2022 13:58:33 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
References: <12138067.O9o76ZdvQC@kreacher> <12124970.O9o76ZdvQC@kreacher>
Date:   Thu, 29 Dec 2022 13:58:33 +0100
In-Reply-To: <12124970.O9o76ZdvQC@kreacher> (Rafael J. Wysocki's message of
        "Wed, 28 Dec 2022 22:21:49 +0100")
Message-ID: <mafs0sfgybc3q.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, Dec 28 2022, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> When _PPC returns 0, it means that the CPU frequency is not limited by
> the platform firmware, so make acpi_processor_get_platform_limit()
> update the frequency QoS request used by it to "no limit" in that case.
>
> This addresses a problem with limiting CPU frequency artificially on
> some systems after CPU offline/online to the frequency that corresponds
> to the first entry in the _PSS return package.
>
> Reported-by: Pratyush Yadav <ptyadav@amazon.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2:
>    * Move some changes into a separate patch
>    * Update the changelog accordingly
>
> ---
>  drivers/acpi/processor_perflib.c |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/acpi/processor_perflib.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/processor_perflib.c
> +++ linux-pm/drivers/acpi/processor_perflib.c
> @@ -53,6 +53,8 @@ static int acpi_processor_get_platform_l
>  {
>         acpi_status status = 0;
>         unsigned long long ppc = 0;
> +       s32 qos_value;
> +       int index;
>         int ret;
>
>         if (!pr)
> @@ -72,17 +74,27 @@ static int acpi_processor_get_platform_l
>                 }
>         }
>
> +       index = ppc;
> +
>         pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
> -                      (int)ppc, ppc ? "" : "not");
> +                index, index ? "is" : "is not");
>
> -       pr->performance_platform_limit = (int)ppc;
> +       pr->performance_platform_limit = index;
>
>         if (ppc >= pr->performance->state_count ||
>             unlikely(!freq_qos_request_active(&pr->perflib_req)))
>                 return 0;
>
> -       ret = freq_qos_update_request(&pr->perflib_req,
> -                       pr->performance->states[ppc].core_frequency * 1000);
> +       /*
> +        * If _PPC returns 0, it means that all of the available states can be
> +        * used ("no limit").
> +        */
> +       if (index == 0)
> +               qos_value = FREQ_QOS_MAX_DEFAULT_VALUE;

One small thing I noticed: in acpi_processor_ppc_init() "no limit" value
is set to INT_MAX and here it is set to FREQ_QOS_MAX_DEFAULT_VALUE. Both
should evaluate to the same value but I think it would be nice if the
same thing is used in both places. Perhaps you can fix that up when
applying?

Other than this,

Reviewed-by: Pratyush Yadav <ptyadav@amazon.de>
Tested-by: Pratyush Yadav <ptyadav@amazon.de>

Thanks for working on this.

> +       else
> +               qos_value = pr->performance->states[index].core_frequency * 1000;
> +
> +       ret = freq_qos_update_request(&pr->perflib_req, qos_value);
>         if (ret < 0) {
>                 pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
>                         pr->id, ret);
>
>
>

-- 
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



