Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B167D169
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjAZQ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjAZQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:26:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E2071659;
        Thu, 26 Jan 2023 08:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674750321; x=1706286321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vQ5Xq73A77dcWgvpi3junj6Bi2A1oCr2o7H27eKOWOQ=;
  b=Dos9LDbJJAJWVBAuxEsqIAE/UTLCxaf0teAPFdehrq7/uyLDmvpyetUp
   T0XmGyejuTrvChUuPl8gM0PTmB3tZkUiNYmRi6h0Zqp/nqKlcTYQSozhE
   IVkkB2BvveIoq8tHKNXPm+FtaAvRunuF9o0G/7sKaGFwRSIHwcJYhLkvC
   9/xCp/ohqE1ClwICbBz6Tp0YMF09oNkEsAxpHCPRypPfqQQaj64ki/T+i
   m5Qp5Zh0U7SGj7x+SfLs6at+j4Wztpav7qwt/UIp13c9Yp6Sn4H/OvhsX
   0IJRO7K5L9eH8xoQsJgXfuiz21rjLtjHOrFRjSwMRTdMCKr72NetNzfi7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354154664"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="354154664"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612855067"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="612855067"
Received: from nmani1-mobl2.amr.corp.intel.com (HELO [10.209.167.178]) ([10.209.167.178])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:36 -0800
Message-ID: <1013f667-c11f-25a2-ab2b-87b9368ad456@linux.intel.com>
Date:   Thu, 26 Jan 2023 09:50:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 12/22] sound: usb: card: Introduce USB SND platform
 op callbacks
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-13-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230126031424.14582-13-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> +int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
> +{
> +	if (platform_ops)
> +		return -EEXIST;
> +
> +	platform_ops = ops;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_register_platform_ops);
> +
> +int snd_usb_unregister_platform_ops(void)
> +{
> +	platform_ops = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);

I find this super-racy.

If the this function is called just before ...

>  
>  /*
>   * disconnect streams
> @@ -910,6 +928,10 @@ static int usb_audio_probe(struct usb_interface *intf,
>  	usb_set_intfdata(intf, chip);
>  	atomic_dec(&chip->active);
>  	mutex_unlock(&register_mutex);
> +
> +	if (platform_ops->connect_cb)
> +		platform_ops->connect_cb(intf, chip);
> +

... this, then you have a risk of using a dandling pointer.

You also didn't test that the platform_ops != NULL, so there's a risk of
dereferencing a NULL pointer.

Not so good, eh?

It's a classic (I've had the same sort of issues with SoundWire), when
you export ops from one driver than can be removed, then additional
protection is needed when using those callbacks.


