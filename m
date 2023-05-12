Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260C17004F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbjELKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbjELKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:12:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D003F3ABF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683886298; x=1715422298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lBNvZ/IXG6dHmWrwcxyPKxgwf2Ta/coLnCCGhcyQKdA=;
  b=gvoIgw9oxQ/RiyQdDFTy2Dup2DsgdQdtFgup02YrtgpU7tLKAnaCI+OZ
   OEvHNcTDRk2o0TE7OVUOd16lIwlF52ODlqG1TbEHsIUks/t7Yybr0pjbm
   FmycqhxOxx5+7cgFsAIRrU96OgnGK8Wwoa3+MDD788g17Zyk9gszNOBT6
   h60DR2435lOCth+EG1331bTBKYTP5p31ftvvZtfdnEzzUYWy9KYTlhO2m
   JIQCdcu+UGnbRlCFAbTD4izQJ0/aUeKIAXComt42GpMD2P4wnheHZGHTZ
   Uuv51LZ2z9zB5hDXB0mIquiiiKNZenuRKeOTF6uEC6U4Uut9nPKe0BDl7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="416386117"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="416386117"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="824308963"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="824308963"
Received: from nhanph1x-mobl.amr.corp.intel.com (HELO [10.249.38.84]) ([10.249.38.84])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:11:34 -0700
Message-ID: <947a2a5d-5a63-6437-bfc3-a5c4841152c2@linux.intel.com>
Date:   Fri, 12 May 2023 13:12:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH] ASoC: SOF: topology: Fix missing error code in
 sof_route_load()
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        pierre-louis.bossart@linux.intel.com
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230512025410.52832-1-jiapeng.chong@linux.alibaba.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230512025410.52832-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2023 05:54, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'err'.
>
> sound/soc/sof/topology.c:2060 sof_route_load() warn: missing error
code 'ret'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Robots don't necessarily understand code...
The cases which this is aiming to fix are the cases when we ignore
things, not failing.

Would it be possible to check the code and understand it before sending
a patch?

Nack.

> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4935
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  sound/soc/sof/topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index d3d536b0a8f5..3ca3a72f1805 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -2045,7 +2045,6 @@ static int sof_route_load(struct
snd_soc_component *scomp, int index,
>  	if (!source_swidget) {
>  		dev_err(scomp->dev, "error: source %s not found\n",
>  			route->source);
> -		ret = -EINVAL;
>  		goto err;
>  	}
>
> @@ -2064,7 +2063,6 @@ static int sof_route_load(struct
snd_soc_component *scomp, int index,
>  	if (!sink_swidget) {
>  		dev_err(scomp->dev, "error: sink %s not found\n",
>  			route->sink);
> -		ret = -EINVAL;
>  		goto err;
>  	}
>
> @@ -2087,6 +2085,8 @@ static int sof_route_load(struct
snd_soc_component *scomp, int index,
>  	return 0;
>  err:
>  	kfree(sroute);
> +	ret = -EINVAL;
> +
>  	return ret;
>  }
>
-- 
Péter
