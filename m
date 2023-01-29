Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD067FD31
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjA2GzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2GzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:55:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A346A1F4B2;
        Sat, 28 Jan 2023 22:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674975308; x=1706511308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pLizHV3VOzyjL1m4zB1zP1MXn3GWDVvQuhcDoXLvhNk=;
  b=SVUAKmSL2rDzA2xPZTxPI45khwI5Nu7u6CmvmfgC/8JYDbew8oK3n3xU
   vmjrK73KKq1Wh6MxeAMmOu1nkE4X/2w9gNNg0SpYUZ25A2NQebhydv0tO
   VLBKXK5htQYZazxbNUBShhqP1AWBoKNK8tlUSt+/M/kqv3BKmsHmPvKBu
   W+sn5d1NrPj4rMlroa/RCswQ1Zstfh/484Cg983HWY6exD+g0rEahsoid
   PTe8YaYAgL+2Y4HVbOH2C8+K/BTOHx+R+u3wlCR4WwT9uMTXId+qGorRc
   pSiS9B0HnC4WiP3EiRhL/uF4k5e/dA5I2zVg6Xkm5kYpMXihsH92X9Dxp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="327385518"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="327385518"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 22:55:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="806297526"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="806297526"
Received: from zhoufuro-mobl.ccr.corp.intel.com (HELO [10.254.211.56]) ([10.254.211.56])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 22:55:02 -0800
Message-ID: <7c1d80b6-5db3-9955-0a67-908455bd77fa@linux.intel.com>
Date:   Sun, 29 Jan 2023 14:54:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH v2 07/22] ASoC: Add SOC USB APIs for adding an USB
 backend
To:     Greg KH <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
        broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-8-quic_wcheng@quicinc.com> <Y9UiiMbJFjkzyEol@kroah.com>
Content-Language: en-US
From:   Zhou Furong <furong.zhou@linux.intel.com>
In-Reply-To: <Y9UiiMbJFjkzyEol@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> +void *snd_soc_usb_get_priv_data(struct device *usbdev)
>> +{
>> +	struct snd_soc_usb *ctx;
>> +
>> +	if (!usbdev)
>> +		return NULL;
> 
> How could usbdev ever be NULL?
The method is exported to public, valid check should be reasonable
as someone may call it by mistake

> 
>> +
>> +	ctx = snd_soc_find_usb_ctx(usbdev);
>> +
>> +	return ctx ? ctx->priv_data : NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_get_priv_data);
>> +

