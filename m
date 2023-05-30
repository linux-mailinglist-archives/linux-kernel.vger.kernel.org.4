Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D419D715BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjE3Kdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjE3Kdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:33:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A02BE125;
        Tue, 30 May 2023 03:33:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C71AB6;
        Tue, 30 May 2023 03:34:12 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 244CE3F67D;
        Tue, 30 May 2023 03:33:25 -0700 (PDT)
Message-ID: <0968c915-0344-b08f-7117-5b1ff6b126fd@arm.com>
Date:   Tue, 30 May 2023 12:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/17] Documentation: EM: Add a new section about the
 design
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-15-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230512095743.3393563-15-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 11:57, Lukasz Luba wrote:
> Add a new section 'Design' which covers the information about Energy
> Model. It contains the design decisions, describes models and how they
> reflect the reality. Add description of the basic const. EM. Change the
> other section IDs.

I would vote for coalescing the 4 doc patches into 1.

> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/power/energy-model.rst | 36 +++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
> index ef341be2882b..e97c7f18d8bd 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -72,16 +72,34 @@ required to have the same micro-architecture. CPUs in different performance
>  domains can have different micro-architectures.
>  
>  
> -2. Core APIs
> +2. Design
> +-----------------
> +
> +2.1 Basic EM
> +^^^^^^^^^^^^

Can we make sure that people get the relation between 'basic' and
'default' easier?

It should be obvious that `pd->default_table->state` refers to this
`basic (const.) EM. Using the same identifier always helps in this
situation.

> +
> +The basic EM is built around const. power information for each performance
> +state. This model can be derived based on power measurements of the device
> +e.g. CPU while running some benchmark. The benchmark might be integer heavy
> +or floating point computation with a data set fitting into the CPU cache or
> +registers. Bare in mind that this model might not be covering all possible
> +workloads running on CPUs. Thus, please run a few different benchmarks and
> +verify with some real workloads your power model values. The power variation
> +due to the workload instruction mix and data set is not modeled.
> +Also static power which can change during runtime due to variation of SOC
> +temperature is not modeled in EM.
> +
> +
> +3. Core APIs
>  ------------
>  
> -2.1 Config options
> +3.1 Config options
>  ^^^^^^^^^^^^^^^^^^
>  
>  CONFIG_ENERGY_MODEL must be enabled to use the EM framework.
>  
>  
> -2.2 Registration of performance domains
> +3.2 Registration of performance domains
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
>  Registration of 'advanced' EM
> @@ -110,8 +128,8 @@ The last argument 'microwatts' is important to set with correct value. Kernel
>  subsystems which use EM might rely on this flag to check if all EM devices use
>  the same scale. If there are different scales, these subsystems might decide
>  to return warning/error, stop working or panic.
> -See Section 3. for an example of driver implementing this
> -callback, or Section 2.4 for further documentation on this API
> +See Section 4. for an example of driver implementing this
> +callback, or Section 3.4 for further documentation on this API
>  
>  Registration of EM using DT
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -156,7 +174,7 @@ The EM which is registered using this method might not reflect correctly the
>  physics of a real device, e.g. when static power (leakage) is important.
>  
>  
> -2.3 Accessing performance domains
> +3.3 Accessing performance domains
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
>  There are two API functions which provide the access to the energy model:
> @@ -175,10 +193,10 @@ CPUfreq governor is in use in case of CPU device. Currently this calculation is
>  not provided for other type of devices.
>  
>  More details about the above APIs can be found in ``<linux/energy_model.h>``
> -or in Section 2.4
> +or in Section 3.4
>  
>  
> -2.4 Description details of this API
> +3.4 Description details of this API
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  .. kernel-doc:: include/linux/energy_model.h
>     :internal:
> @@ -187,7 +205,7 @@ or in Section 2.4
>     :export:
>  
>  
> -3. Example driver
> +4. Example driver
>  -----------------
>  
>  The CPUFreq framework supports dedicated callback for registering

