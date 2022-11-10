Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0456240A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKJLDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:02:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB8E62CE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668078178; x=1699614178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QsXzk5C5epnb6EBB5ywup9HpoGDQrTmRBHEVnEeC6VY=;
  b=kAsk9GluEnWd1Vuc1i+CluJG2u1CQiRZ3amH13QcMATn/OEmzLrFeJFT
   nxB97kW7jxmObLjr+gciEFKeOftGd0929toQEvzoTGo65rUj2qKHTdbXT
   X/foZbGtxyyYY+0K0IFhuKPCaMWwJhTkxNBPET4Vyuum2KJLZcmptZCxe
   XPGgjJKBFMU8hjhgoRfmZW7+AxXYFekUg005ZQotti1jtSm0PhBD8+PzI
   iGEf/5aEb73yI6zBLKkxkYUmJle0oI6hDZKS6yOY/Nie4MOMqLoZo0eki
   9/ZDvY6zor/ZXq65ML320zHN3U7MzfaWNGYgQLtx6IGDy8s31etgFvyb6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309995481"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="309995481"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 03:02:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="726347003"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="726347003"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.190]) ([10.99.249.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 03:02:56 -0800
Message-ID: <8039aad2-3d6f-153f-bf23-892c3804b0fa@linux.intel.com>
Date:   Thu, 10 Nov 2022 12:02:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Asoc: core: fix wrong size kzalloc for rtd's components
 member
Content-Language: en-US
To:     lishqchn <lishqchn@qq.com>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <tencent_59850BB028662B6F2D49D7F3624AB84CCF05@qq.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <tencent_59850BB028662B6F2D49D7F3624AB84CCF05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2022 5:24 AM, lishqchn wrote:
> The actual space for struct snd_soc_component has been allocated by
> snd_soc_register_component, here rtd's components are pointers to
> components, I replace the base size from *component to component.
> 
> Signed-off-by: lishqchn <lishqchn@qq.com>
> ---
>   sound/soc/soc-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index a6d6d10cd471..d21e0284b2aa 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -459,7 +459,7 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
>   	 */
>   	rtd = devm_kzalloc(dev,
>   			   sizeof(*rtd) +
> -			   sizeof(*component) * (dai_link->num_cpus +
> +			   sizeof(component) * (dai_link->num_cpus +
>   						 dai_link->num_codecs +
>   						 dai_link->num_platforms),
>   			   GFP_KERNEL);

Can't struct_size macro be used instead, it is meant to be used when 
calculating size of structs containing flexible arrays at the end?

