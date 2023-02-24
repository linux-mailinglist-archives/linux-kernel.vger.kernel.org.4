Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F846A1CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBXNUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXNUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:20:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFC6629E;
        Fri, 24 Feb 2023 05:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677244852; x=1708780852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7ODUv3D8xf81slIDQs9GhkgTjA9Y9Xu/c56SdK+cH1A=;
  b=ikYK1b4s8SzlLNIWH96wKrMykydjc6qKyw45W2sqV4ca68RqUPQSeX91
   1GGACTBfmfVgZV2E2LPHUmn2NJTVc6jZVyPhyDjArWuY9ndK7zBXSZhre
   SVRP+IutSpFr1vMKWqJ+An8OgZWah5n6tv0QcEEVgwek0KPvVlxB19ZzE
   1PLiGQN2Mmq8BV/fSj2Hy87OrDGILTcoPM2jf+bHIZlceWLexl/DmOtOj
   f4sINztiVAHTBZV+EIelZbbURk/+9h0zk/AcEghc7lSErnDLZ/ccr8b6x
   2dmQqxlGIOU21Qp6/SCkv5WVmQgPz2XGK19iSvf+5T6crbKb8KrVEEZnx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="333477525"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="333477525"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 05:20:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="741671090"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="741671090"
Received: from nderuite-mobl1.ger.corp.intel.com (HELO [10.251.215.190]) ([10.251.215.190])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 05:20:48 -0800
Message-ID: <f258311c-cbb3-7d5b-7f7f-2034809aad57@linux.intel.com>
Date:   Fri, 24 Feb 2023 15:21:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Replace fake flexible
 arrays with flexible-array member
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Y/gyIg1qZduhigPi@work>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <Y/gyIg1qZduhigPi@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2023 05:42, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members, instead.
> 
> Use the DECLARE_FLEX_ARRAY() helper macro to transform zero-length
> arrays in unions with flexible-array members.
> 
> Address the following warnings found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> sound/soc/sof/ipc4-control.c:176:77: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:78:29: warning: array subscript 0 is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:80:33: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:95:53: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:96:53: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:93:53: warning: array subscript 0 is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:140:58: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:141:29: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:142:29: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-topology.c:1475:36: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-topology.c:1476:36: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/258
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  sound/soc/sof/ipc4-topology.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
> index 72529179ac22..8507171a6e4d 100644
> --- a/sound/soc/sof/ipc4-topology.h
> +++ b/sound/soc/sof/ipc4-topology.h
> @@ -266,8 +266,8 @@ struct sof_ipc4_control_data {
>  	int index;
>  
>  	union {
> -		struct sof_ipc4_ctrl_value_chan chanv[0];
> -		struct sof_abi_hdr data[0];
> +		DECLARE_FLEX_ARRAY(struct sof_ipc4_ctrl_value_chan, chanv);
> +		DECLARE_FLEX_ARRAY(struct sof_abi_hdr, data);
>  	};
>  };
>  

-- 
Péter
