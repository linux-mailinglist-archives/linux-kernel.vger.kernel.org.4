Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497D05FE9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJNHyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJNHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:54:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB402E9FE;
        Fri, 14 Oct 2022 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665734089; x=1697270089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IyNUXND8RFegm37PH1Kc2TacekLBXzHLk6N6Q3vmS2U=;
  b=GDF8NvsE0VJ9DsWW5IElF6+h3en3W2miGAngTsHDZmr5IydPhVomUya1
   24e5kuZuLqSKh5kM4AXEXGbKYaiHTQU5S6bkQWc3Ux0piraQqo/VexkpQ
   rM1sq/N1VBceLNs9Y0e3xgmX/FBN02X7DAt4XL3cpS6DbTZqchV8iAC0B
   6yiPPHa03vfecnz9AHcWP0GkWDEEl2GK078PIshGijXYwLntnrGPlOH+D
   PMbCBaYVAjw83k6b1pCMrLi6lhoF6l17L0oop4aBaKt25X0+Il/FjKlrb
   z6NDGajUEZaX1zA8g+Kyrc0TFb88XmJ5EOPpAiRsSO3iNmzxaWdSPjIxP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="285038169"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="285038169"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 00:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="752835130"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="752835130"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 14 Oct 2022 00:54:40 -0700
Message-ID: <7163ea05-7ea5-998b-932a-25ffd36ed296@intel.com>
Date:   Fri, 14 Oct 2022 10:56:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] xhci: print warning when HCE was set
Content-Language: en-US
To:     liulongfang <liulongfang@huawei.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        yisen.zhuang@huawei.com
References: <20220915011134.58400-1-liulongfang@huawei.com>
 <6b5a45f1-caf3-4259-77da-e36788f5b8a9@linux.intel.com>
 <2648444c-2f2a-4d9b-8545-6677663adcf0@huawei.com>
 <8271d551-4034-71fe-5be4-e08e28b6dd6b@linux.intel.com>
 <19ab61d6-c2a2-42be-2bb6-500636868703@huawei.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <19ab61d6-c2a2-42be-2bb6-500636868703@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.2022 6.12, liulongfang wrote:
> On 2022/9/26 15:58, Mathias Nyman wrote:
>> On 24.9.2022 5.35, liulongfang wrote:
>>> On 2022/9/22 21:01, Mathias Nyman Wrote:
>>>> Hi
>>>>
>>>> On 15.9.2022 4.11, Longfang Liu wrote:
>>>>> When HCE(Host Controller Error) is set, it means that the xhci hardware
>>>>> controller has an error at this time, but the current xhci driver
>>>>> software does not log this event.
>>>>>
>>>>> By adding an HCE event detection in the xhci interrupt processing
>>>>> interface, a warning log is output to the system, which is convenient
>>>>> for system device status tracking.
>>>>>
>>>>
>>>> xHC should cease all activity when it sets HCE, and is probably not
>>>> generating interrupts anymore.
>>>>
>>>> Would probably be more useful to check for HCE at timeouts than in the
>>>> interrupt handler.
>>>>
>>>
>>> Which function of the driver code is this timeout in?
>>
>> xhci_handle_command_timeout() will usually trigger at some point,
>>
> 
> Because this HCE error is reported in the form of an interrupt signal, it is more
> concise to put it in xhci_irq() than in xhci_handle_command_timeout().
> 

Patch was added to queue after you reported your xHC hardware triggers interrupts when HCE is set.
I'll send it forward after 6.1-rc1

xHCI specification still indicate HCE might not trigger interrupts:
  
Section 4.24.1 -Internal Errors
...
"Software should implement an algorithm for checking the HCE flag if the xHC is
not responding."

Thanks
-Mathias
