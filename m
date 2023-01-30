Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C3C68077E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjA3IfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjA3IfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:35:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0DCEB49;
        Mon, 30 Jan 2023 00:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675067708; x=1706603708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GBIpIc+A10cwgQqoTcUX1briJX8R+8iaF6VJFNW2w1o=;
  b=T/OJu6kX+SXVgkQqHw+pvbCzV2htYmlwGEZ0pBVmcLg7V++UtM6D6GCa
   430DNxXrjGjzdo26Tc/KHKT3JHSBpMd1E2wZYPTz7rHeiOzYwhb6TzLW0
   Mps6wJM965w44qehlaqg8YDIwOVBT09n9wnnAzydpzqNDKJKqqS3JIJCv
   K1HuFFYLBVhmV0uNpVQMqYkxRDJSI217IbQ3O74wiURknyqUZ+TrhmKKk
   gpRhzclSSVck7RbtN3Yt2z3CVZ3WpFN5fjN5tq/2AqidC/6DZYRNcJFoS
   AeAvRItLQ+gib4MTWWX9L7rkBUpmw9rOTQsN9Y89DzXdeZiyeUgSEDO4M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="327521040"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="327521040"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 00:35:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="772405473"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="772405473"
Received: from zhoufuro-mobl.ccr.corp.intel.com (HELO [10.249.170.163]) ([10.249.170.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 00:35:01 -0800
Message-ID: <7f461661-2dcf-056d-f78a-93c409388f29@linux.intel.com>
Date:   Mon, 30 Jan 2023 16:34:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 07/22] ASoC: Add SOC USB APIs for adding an USB
 backend
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
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
 <7c1d80b6-5db3-9955-0a67-908455bd77fa@linux.intel.com>
 <Y9YbumlV9qh+k68h@kroah.com>
Content-Language: en-US
From:   Zhou Furong <furong.zhou@linux.intel.com>
In-Reply-To: <Y9YbumlV9qh+k68h@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/29 15:09, Greg KH wrote:
> On Sun, Jan 29, 2023 at 02:54:43PM +0800, Zhou Furong wrote:
>>
>>
>>>> +void *snd_soc_usb_get_priv_data(struct device *usbdev)
>>>> +{
>>>> +	struct snd_soc_usb *ctx;
>>>> +
>>>> +	if (!usbdev)
>>>> +		return NULL;
>>>
>>> How could usbdev ever be NULL?
>> The method is exported to public, valid check should be reasonable
>> as someone may call it by mistake
> 
> We do not protect the kernel from itself like this, no need to check
> things that should never happen.  If the caller gets it wrong, their
> code will break :)
> 
> thanks,
> 
> greg k-h

Thank you Greg!

This has been confused me for long time when I found Linux kernel don't 
check input even for public method.

