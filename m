Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5373E121
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFZNya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFZNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:54:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE222BB;
        Mon, 26 Jun 2023 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687787665; x=1719323665;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=UIOhw/+18cUbQ6mrRiXB9WS5HrjLqAxhhP6EGQM4t/0=;
  b=B1h1kmJM7mtQsUoPrVIWe3JlwjJtj5TWQjXTbG0LM3nxB/bSQr2jxlmc
   nLK8pO1TJTG/VhFOHKgbdhhC/PM0tmRRcs+KC7e2j6a51tMHfZcxKgrOo
   2RKM3LVpJrf8ALEVMT9DGy6HCjvHtLNwlyrGB4nRt51Gp9ajezeab9wnG
   C7GdCpxrqywkd0NyjnjVWdE6YG+Qo9BNDi1HpZjNZ4U65jiH395pEqcch
   OiDE4tVczNfLR0fRoW9p47rS41roSgzWw8kzh/O6Oyr6Jt2Qt5kl6QhmV
   U4Xk8BKnzOROSvaW4bLcDnod3msEOTgjsdtplcXRIC6c/FgZrxaXyBdFu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="424942329"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="424942329"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 06:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="962761705"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="962761705"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2023 06:54:19 -0700
Message-ID: <da468fe6-709c-b6e6-159d-10f76d296307@linux.intel.com>
Date:   Mon, 26 Jun 2023 16:55:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-2-quic_wcheng@quicinc.com>
 <a45ff335-0563-85c7-3b31-d6ca23a54a3f@linux.intel.com>
 <ed0397eb-da17-fbee-647e-f3a2a57577fe@quicinc.com>
 <9f30e9f9-280e-b381-fecc-2a032c1117af@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3 01/28] xhci: Add support to allocate several
 interrupters
In-Reply-To: <9f30e9f9-280e-b381-fecc-2a032c1117af@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.6.2023 1.37, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 3/13/2023 1:32 PM, Wesley Cheng wrote:
>> Hi Mathias,
>>
>> On 3/10/2023 7:07 AM, Mathias Nyman wrote:
>>> On 9.3.2023 1.57, Wesley Cheng wrote:
>>>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>>
>>>> Introduce xHCI APIs to allow for clients to allocate and free
>>>> interrupters.  This allocates an array of interrupters, which is based on
>>>> the max_interrupters parameter.  The primary interrupter is set as the
>>>> first entry in the array, and secondary interrupters following after.
>>>>
>>>
>>> I'm thinking about changing this offloading xHCI API
>>> xhci should be aware and keep track of which devices and endpoints that
>>> are offloaded to avoid device getting offloaded twice, avoid xhci driver
>>> from queuing anything itself for these, and act properly if the offloaded
>>> device or entire host is removed.
>>>
>>> So first thing audio side would need to do do is register/create an
>>> offload entry for the device using the API:
>>>
>>> struct xhci_sideband *xhci_sideband_register(struct usb_device *udev)
>>>
>>> (xHCI specs calls offload sideband)
>>> Then endpoints and interrupters can be added and removed from this
>>> offload entry
>>>
>>> I have some early thoughts written as non-compiling code in:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git feature_interrupters
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters
>>>
>>> Let me know what you think about this.
>>>
>>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>
>>> My Signed-off-by tag is being misused here.
>>>
>>> I wrote a chunk of the code in this patch as PoC that I shared in a separate topic branch.
>>> It was incomplete and not intended for upstream yet. (lacked locking, several fixme parts, etc..)
>>> The rest of the code in this patch is completely new to me.
>>>
>>
>> Sorry about this.  I cherry picked the change directly from your branch, so it carried your signed off tag with it.  Will make to include them properly next time.
>>
> 
> I'm about ready to submit the next revision for this set of changes, and I was wondering how we should handle the changes you made on:
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters
> 
> I did make some modifications to some of the interrupter fixme tags you had, and also updated the xhci-sideband APIs with the proper logic.  I don't believe it is correct for me to submit a set of patches authored by you without your signed off tag. (checkpatch throws an error saying the author did not sign off on the change)
> 

Note that the first patch "xhci: split allocate interrupter into separate alloacte and add parts"
is already in usb-next on its way to 6.5

Maybe Co-developed-by would work in this case, with a small explanation at the end of the commit message.
Something like:

Locking, DMA something and feataure x added by Wesley Cheng to
complete original concept code by Mathias

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

Thanks
-Mathias

