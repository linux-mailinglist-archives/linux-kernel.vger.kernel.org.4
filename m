Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181696BD6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCPRMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCPRM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:12:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04EB3D3095
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:12:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FFEE2F4;
        Thu, 16 Mar 2023 10:12:52 -0700 (PDT)
Received: from [10.57.54.186] (unknown [10.57.54.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 825443F885;
        Thu, 16 Mar 2023 10:12:07 -0700 (PDT)
Message-ID: <c468a656-036f-df45-0c5e-034a73ed727a@arm.com>
Date:   Thu, 16 Mar 2023 17:12:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/9] coresight: Dynamically add connections
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-6-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230310160610.742382-6-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 16:06, James Clark wrote:
> Add a function for adding connections dynamically. This also removes
> the 1:1 mapping between port number and the index into the connections
> array. The only place this mapping was used was in the warning for
> duplicate output ports, which has been replaced by a search. Other
> uses of the port number already use the port member variable.
> 
> Being able to dynamically add connections will allow other devices like
> CTI to re-use the connection mechanism despite not having explicit
> connections described in the DT.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   .../hwtracing/coresight/coresight-platform.c  | 77 ++++++++++++++-----
>   include/linux/coresight.h                     |  7 +-
>   2 files changed, 64 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index c77238cdf448..16553f7dde12 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -27,8 +27,9 @@ static int coresight_alloc_conns(struct device *dev,
>   				 struct coresight_platform_data *pdata)
>   {
>   	if (pdata->nr_outconns) {
> -		pdata->out_conns = devm_kcalloc(dev, pdata->nr_outconns,
> -					    sizeof(*pdata->out_conns), GFP_KERNEL);
> +		pdata->out_conns = devm_krealloc_array(
> +			dev, pdata->out_conns, pdata->nr_outconns,

super minor nit:
		pdata->out_conns = devm_krealloc_array(dev,

		
> +			sizeof(*pdata->out_conns), GFP_KERNEL | __GFP_ZERO);
>   		if (!pdata->out_conns)
>   			return -ENOMEM;
>   	}
> @@ -36,6 +37,48 @@ static int coresight_alloc_conns(struct device *dev,
>   	return 0;
>   }
>   
> +/*
> + * Add a connection in the first free slot, or realloc
> + * if there is no space. @conn's contents is copied into the new slot.
> + *
> + * If the output port is already assigned on this device, return -EINVAL
> + */
> +int coresight_add_conn(struct device *dev,
> +		       struct coresight_platform_data *pdata,
> +		       const struct coresight_connection *conn)
> +{
> +	int ret;
> +	struct coresight_connection *free_conn = NULL;
> +	struct coresight_connection *i;
> +
> +	/*
> +	 * Search for a free slot, and while looking for one, warn
> +	 * on any existing duplicate output port.
> +	 */
> +	for (i = pdata->out_conns; i < pdata->out_conns + pdata->nr_outconns;
> +	     ++i) {

minor nit: I see why you have gone against using "i" as index into
the array. But I think having that as the index is still better
readable.

	for (i = 0; i < pdata->nr_outconns; i++) {
		struct coresight_connection *c = &pdata->out_conns[i];

> +		if (i->remote_fwnode && conn->port != -1 &&
> +		    i->port == conn->port) {
> +			dev_warn(dev, "Duplicate output port %d\n", i->port);
> +			return -EINVAL;
> +		}
> +		if (!i->remote_fwnode && !free_conn)
> +			free_conn = i;
> +	}
> +
> +	if (!free_conn) {

and:
	/* No free slots */
	if (i == pdata->nr_outconns) {

> +		pdata->nr_outconns++;
> +		ret = coresight_alloc_conns(dev, pdata);
> +		if (ret)
> +			return ret;
> +		free_conn = &pdata->out_conns[pdata->nr_outconns - 1];
> +	}
> +

and:
	pdata->out_conns[i] = *conn;


Otherwise looks good to me.

Suzuki


