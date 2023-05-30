Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1E0715C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjE3Kme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjE3Km1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:42:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04AFC106;
        Tue, 30 May 2023 03:42:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E5DAB6;
        Tue, 30 May 2023 03:43:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9252C3F67D;
        Tue, 30 May 2023 03:42:20 -0700 (PDT)
Message-ID: <77033400-94ba-85c4-77b6-f29a90843fce@arm.com>
Date:   Tue, 30 May 2023 12:42:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 15/17] Documentation: EM: Add a runtime modifiable EM
 design description
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-16-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230512095743.3393563-16-lukasz.luba@arm.com>
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
> Document the new runtime modifiable EM design and how it can be used.
> Change the last section layout and allow to provide another example
> how to use this new API in a driver code.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/power/energy-model.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
> index e97c7f18d8bd..64c2462dc9a6 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -89,6 +89,26 @@ due to the workload instruction mix and data set is not modeled.
>  Also static power which can change during runtime due to variation of SOC
>  temperature is not modeled in EM.
>  
> +2.2 Runtime modifiable EM
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +To better reflect power variation due to static power (leakage) the EM
> +supports runtime modifications of the power values. The mechanism relies on
> +RCU to free the modifiable EM perf_state table memory. Its user, the task
> +scheduler, also uses RCU to access this memory. The EM framework is
> +responsible for allocating the new memory for the modifiable EM perf_state
> +table. The old memory is freed automatically using RCU callback mechanism.
> +This design decision is made based on task scheduler using that data and
> +to prevent wrong usage of kernel modules if they would be responsible for the
> +memory management.
> +The drivers which want to modify the EM values are protected from concurrent
> +access using a mutex. Therefore, the drivers must use sleeping context when
> +they want to modify the EM. The runtime modifiable EM might also be used for
> +better reflecting real workload scenarios, e.g. when they pop-up on the screen
> +and will run for longer period, such as: games, video recoding or playing,
> +video calls, etc. It is up to the platform engineers to experiment and choose
> +the right approach for their device.

IMHO, there are a lot of design aspects missing here.

E.g.

Why 2 tables, modifiable (a) and default (b)?

Why does only EAS use (a)?

(a) and (b) being the same performance state table until first call to
modify (a) ()

> +
>  
>  3. Core APIs
>  ------------

