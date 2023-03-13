Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA26B7FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCMRt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCMRts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:49:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84D17203A;
        Mon, 13 Mar 2023 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678729784; x=1710265784;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=k1jfQWwUrLRiIUyKxmnw1YYQ/KfXv2xO0bIFnvUL4Dk=;
  b=nn3k8sWsiIVvipHtNAGG5N1VWkXxoQ35Ns+YEJ5ymnD3Wwu7Ru9xdHVl
   /+gwbBP243SyOJQCXgu2AxuNcAI9XydFffRugChvJO+64w3Lxdn2tNkRW
   8x3CdtyvKpZIpLBeaAUIJSZ0Zq9tl2wQOYoFJOun+YyN6+zY7UX1IDoqI
   M+BT1c7DFSo4+KrW9KzHTrgQkWekrnVNFiiPZdBdWT+/YnLo99HMzQzSO
   u/L7lxuqGMK8RyNJR7LkPFRD0Qd+cfYjQQh71V1nFsCrXv3ngmCMA//8S
   Dtp+CPP/h5DesKZqh7rBdY7yQbzrXOYKmgoz2bLENzB5kn2LJFSQTsVrF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321069344"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="321069344"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:49:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="852860027"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="852860027"
Received: from jlewis8x-mobl.amr.corp.intel.com (HELO [10.255.34.75]) ([10.255.34.75])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:49:10 -0700
Message-ID: <6fbd4471-9f72-c87c-3803-90f7224abce0@linux.intel.com>
Date:   Mon, 13 Mar 2023 09:46:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 1/2] ASoC: max98363: add soundwire amplifier driver
Content-Language: en-US
To:     =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, krzysztof.kozlowski@linaro.org,
        rf@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        herve.codina@bootlin.com, wangweidong.a@awinic.com,
        james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com
References: <20230311011409.210014-1-ryan.lee.analog@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230311011409.210014-1-ryan.lee.analog@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +	ret = sdw_stream_add_slave(max98363->slave, &stream_config,
> +				   &port_config, 1, stream);
> +	if (ret) {
> +		dev_err(dai->dev, "Unable to configure port\n");
> +		return ret;
> +	}
> +
> +	if (params_channels(params) > 16) {
> +		dev_err(component->dev, "Unsupported channels %d\n",
> +			params_channels(params));
> +		return -EINVAL;
> +	}

Do you actually support more than 8 channels?

The data port DPnPrepareCtl and DPn_ChannelEn registers expose 8
channels max. It's always possible to 'cheat' by packing two channels in
the same sample, but that would require custom signaling between manager
and peripheral that isn't present.

Could it be a left-over from a TDM implementation?

The rest of the patch looks fine.
