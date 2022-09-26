Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B85E9B66
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiIZIAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiIZH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:59:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D85DFF1;
        Mon, 26 Sep 2022 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664179027; x=1695715027;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=91OQkbf/d555l82Oyt8s1+1wuCP9eUN+PBdU79ijhAY=;
  b=MbhgQgAwHhaDgEq/t3EqDG+10ce337DhYneR0IjtafnBYKk/b4p6M62c
   0mJs6pQVeYCE0CMQMAdJluy72SmNEfrSZS5sJuSqtZEAeyxkTgfUIE76C
   DZXAHfMXe7nFCD2dO4YwWUeTST0ODbLyD2INDOdntJEhggnLUbeI38GAh
   rnQ2RP/p558oF56tUGHgtiwXWlz9uWtg74p24niTXhFZaleP/D02zw6OV
   LGDRQd3LAvdp6NeWN783jv5ts+MWlet1L+omJG3g1+8f5g9bQw9Hls37s
   9pZI2ML6pW/q0ozh4uv4Pq4ch8dyft3/l9+NjahJybAIRQyNq3I+DcHNU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="288105572"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="288105572"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 00:57:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="683435575"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="683435575"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2022 00:56:54 -0700
Message-ID: <8271d551-4034-71fe-5be4-e08e28b6dd6b@linux.intel.com>
Date:   Mon, 26 Sep 2022 10:58:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
To:     liulongfang <liulongfang@huawei.com>, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        yisen.zhuang@huawei.com
References: <20220915011134.58400-1-liulongfang@huawei.com>
 <6b5a45f1-caf3-4259-77da-e36788f5b8a9@linux.intel.com>
 <2648444c-2f2a-4d9b-8545-6677663adcf0@huawei.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: print warning when HCE was set
In-Reply-To: <2648444c-2f2a-4d9b-8545-6677663adcf0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.9.2022 5.35, liulongfang wrote:
> On 2022/9/22 21:01, Mathias Nyman Wrote:
>> Hi
>>
>> On 15.9.2022 4.11, Longfang Liu wrote:
>>> When HCE(Host Controller Error) is set, it means that the xhci hardware
>>> controller has an error at this time, but the current xhci driver
>>> software does not log this event.
>>>
>>> By adding an HCE event detection in the xhci interrupt processing
>>> interface, a warning log is output to the system, which is convenient
>>> for system device status tracking.
>>>
>>
>> xHC should cease all activity when it sets HCE, and is probably not
>> generating interrupts anymore.
>>
>> Would probably be more useful to check for HCE at timeouts than in the
>> interrupt handler.
>>
> 
> Which function of the driver code is this timeout in?

xhci_handle_command_timeout() will usually trigger at some point,

> 
>> If this is something seen on actual hardware then it makes sense to add it.
>>
> 
> This HCE error is sure to report an interrupt on the chip we are using.

Ok, then makes sense to add this patch.

Thanks
-Mathias

