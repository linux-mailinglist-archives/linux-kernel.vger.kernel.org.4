Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79E715A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjE3Jcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjE3JcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:32:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25450135;
        Tue, 30 May 2023 02:31:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34EF02F4;
        Tue, 30 May 2023 02:32:23 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01563F663;
        Tue, 30 May 2023 02:31:35 -0700 (PDT)
Message-ID: <70e630b8-e577-a148-0179-61aedf910c09@arm.com>
Date:   Tue, 30 May 2023 11:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 06/17] PM: EM: Add update_power() callback for runtime
 modifications
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-7-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230512095743.3393563-7-lukasz.luba@arm.com>
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
> The Energy Model (EM) is going to support runtime modifications. This
> new callback would be used in the upcoming EM changes. The drivers
> or frameworks which want to modify the EM have to implement the
> update_power() callback and provide it via EM API
> em_dev_update_perf_domain(). The callback is then used by the EM
> framework to get new power values for each frequency in existing EM.

Do we have any numbers or feedback that the chosen design (i.e. update
per performance state through update_power()) is performant enough for
the anticipated use case on real devices?

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 8069f526c9d8..cc2bf607191e 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -158,6 +158,26 @@ struct em_data_callback {
>  	 */
>  	int (*get_cost)(struct device *dev, unsigned long freq,
>  			unsigned long *cost);
> +
> +	/**
> +	 * update_power() - Provide new power at the given performance state of
> +	 *		a device
> +	 * @dev		: Device for which we do this operation (can be a CPU)
> +	 * @freq	: Frequency at the performance state in kHz
> +	 * @power	: New power value at the performance state
> +	 *		(modified)
> +	 * @priv	: Pointer to private data useful for tracking context
> +	 *		during run-time modifications of EM.
> +	 *
> +	 * The update_power() is used by run-time modifiable EM. It aims to
> +	 * provide updated power value for a given frequency, which is stored
> +	 * in the performance state. The power value provided by this callback
> +	 * should fit in the [0, EM_MAX_POWER] range.
> +	 *
> +	 * Return 0 on success, or appropriate error value in case of failure.
> +	 */
> +	int (*update_power)(struct device *dev, unsigned long freq,
> +			    unsigned long *power, void *priv);
>  };
>  #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
>  #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb)	\
> @@ -165,6 +185,7 @@ struct em_data_callback {
>  	  .get_cost = _cost_cb }
>  #define EM_DATA_CB(_active_power_cb)			\
>  		EM_ADV_DATA_CB(_active_power_cb, NULL)
> +#define EM_UPDATE_CB(_update_power_cb) { .update_power = &_update_power_cb }
>  
>  struct em_perf_domain *em_cpu_get(int cpu);
>  struct em_perf_domain *em_pd_get(struct device *dev);

