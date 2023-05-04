Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B6A6F664C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjEDHuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:50:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEDD10B;
        Thu,  4 May 2023 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683186620; x=1714722620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JdwCvt2/E2LmVXmxFe5M50QoohDkM7PADSNEK66ibw0=;
  b=iaimr5C5HSvEnvUddVLzyMeISgR9n3Djfj76B2cchobogC5dBXcSTabW
   cxNEoVAWEwcMvVFfWhi4XrYmTeWCwP+U4lEfdM80IOBGVWKrxjlPxrfKv
   qJQYfWJ5zHVYK7eY8jXcOXBOV1Ghk1gBNi32UuR2ck1HQuJ5CAGkANeOK
   FaM7z6WFL6IJVmBa0BcL3uCCP5giE8yIf+TGfD3FR3eCeiaJ2Z6ejLaF3
   /pAd+EkCpNr5vJNRjqlBNbFBTVYt0+0ZzoEP5+B7mEsE94yAb2n8zcjgj
   VcWCphtZ/wYCWI2uj3fVb5OmQp6XKIwDe+4oy0KhLZ4e/2D7DDrIGXG6c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="376924586"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="376924586"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 00:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="1026826787"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="1026826787"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2023 00:50:17 -0700
Message-ID: <fe7dd886-99b1-bcce-2c3d-fe8aa2bbff6d@linux.intel.com>
Date:   Thu, 4 May 2023 10:51:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v2] xhci-pci: Only run d3cold avoidance quirk for s2idle
Content-Language: en-US
To:     "Limonciello, Mario" <mlimonci@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Donghun Yoon <donghun.yoon@lge.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424214859.3109-1-mario.limonciello@amd.com>
 <8c4f85c1-32db-a84c-f77c-6e2aa556d2f4@linux.intel.com>
 <ac090da4-6cec-8c5a-22ac-36e130cb201a@amd.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <ac090da4-6cec-8c5a-22ac-36e130cb201a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.5.2023 16.59, Limonciello, Mario wrote:
> 
> On 5/3/2023 8:14 AM, Mathias Nyman wrote:
>> On 25.4.2023 0.48, Mario Limonciello wrote:
>>> Donghun reports that a notebook that has an AMD Ryzen 5700U but supports
>>> S3 has problems with USB after resuming from suspend. The issue was
>>> bisected down to commit d1658268e439 ("usb: pci-quirks: disable D3cold on
>>> xhci suspend for s2idle on AMD Renoir").
>>>
>>> As this issue only happens on S3, narrow the broken D3cold quirk to only
>>> run in s2idle.
>>>
>>> Fixes: d1658268e439 ("usb: pci-quirks: disable D3cold on xhci suspend for s2idle on AMD Renoir")
>>> Reported-and-tested-by: Donghun Yoon <donghun.yoon@lge.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v1->v2:
>>>   * Guard against CONFIG_SUSPEND not being set
>>
>> Thanks,
>> Checkpatch complains that it wants a link to the issue after a "Reported-by:" tag.
>>
>> Is there any public report of this?
>>
>> Thanks
>> Mathias
>>
>>
> It was reported privately to me by Donghun, and they confirmed from private testing
> that this change helps the issue.
> 
> I noticed that message from checkpatch too before I sent this up, but I figured it's better
> to give Donghun attribution rather than drop the tag.
> 

Agree, thanks for the info

Mathias
  

