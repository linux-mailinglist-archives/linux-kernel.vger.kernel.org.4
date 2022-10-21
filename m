Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421026083AD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 04:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJVCkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 22:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJVCkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 22:40:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6062A19C204;
        Fri, 21 Oct 2022 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666406447; x=1697942447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kF/xdr28uQrpRA72AFf0G6ObdUEgtJJsF4mCHOi/eWk=;
  b=bm+0eJXIdIOogKgl1DP6gRrPiHi5dUFOZhUuh4tTwqzYpzoPTDbmoiWU
   L8QlbV6mUp3cSH8gMT9/XjowH65RVzoeduG8MmnUNJWBrpERMBAKPb+z9
   JRUWKjNVOOXUFMlmxC8M1WGMacV9JL8zuTeaRE9UJh1T0C6VlDgAd5KzW
   i1vbHyw2PWVu6uaemBDyq77LrH/ZbdWMeF7Bq4rN9yIp2+uaEL4FcCASO
   9WjBne1+SXuO43zGZbwQGRheQBBmEkfYx2SZXvIR2d22gJU0fphEkd4lz
   5IHLSh6H+hPhIHoOCna7xIpEE1toIqe57SpK0HrhWmCdJ/tsqZ5a1ExTN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="393461693"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="393461693"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 19:40:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773273982"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="773273982"
Received: from kerendel-mobl1.amr.corp.intel.com (HELO [10.212.96.240]) ([10.212.96.240])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 19:40:46 -0700
Message-ID: <5528f5e7-86fe-f53e-d8db-db91cdd25adb@linux.intel.com>
Date:   Fri, 21 Oct 2022 12:13:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v2 5/9] ASoC: qdsp6: audioreach: simplify module_list sz
 calculation
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        tiwai@suse.com, lgirdwood@gmail.com, bgoswami@quicinc.com,
        linux-kernel@vger.kernel.org
References: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
 <20221021165207.13220-6-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221021165207.13220-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/22 11:52, Srinivas Kandagatla wrote:
> Simplify module_list size calcuation by doing inside modules loop.

typo: calculation.

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/audioreach.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index 0015ec89d90b..87a3fd1f8107 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.c
> +++ b/sound/soc/qcom/qdsp6/audioreach.c
> @@ -430,7 +430,6 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
>  	struct audioreach_sub_graph *sgs;
>  	struct apm_mod_list_obj *mlobj;
>  	struct list_head *sg_list;
> -	int num_modules_per_list;
>  	int num_connections = 0;
>  	int num_containers = 0;
>  	int num_sub_graphs = 0;
> @@ -451,6 +450,9 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
>  		list_for_each_entry(container, &sgs->container_list, node) {
>  			num_containers++;
>  			num_modules += container->num_modules;
> +			ml_sz = ml_sz + sizeof(struct apm_module_list_params) +
> +				APM_MOD_LIST_OBJ_PSIZE(mlobj, container->num_modules);
> +
>  			list_for_each_entry(module, &container->modules_list, node) {
>  				if (module->src_mod_inst_id)
>  					num_connections++;
> @@ -459,11 +461,11 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
>  	}
>  
>  	num_modules_list = num_containers;
> -	num_modules_per_list = num_modules/num_containers;
>  	sg_sz = APM_SUB_GRAPH_PSIZE(sg_params, num_sub_graphs);
>  	cont_sz = APM_CONTAINER_PSIZE(cont_params, num_containers);
> -	ml_sz =	ALIGN(sizeof(struct apm_module_list_params) +
> -		num_modules_list * APM_MOD_LIST_OBJ_PSIZE(mlobj,  num_modules_per_list), 8);
> +
> +	ml_sz = ALIGN(ml_sz, 8);
> +
>  	mp_sz = APM_MOD_PROP_PSIZE(mprop, num_modules);
>  	mc_sz =	APM_MOD_CONN_PSIZE(mcon, num_connections);
>  
