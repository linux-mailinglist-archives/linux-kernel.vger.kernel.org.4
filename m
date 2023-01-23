Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9AE6780F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjAWQIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjAWQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:08:18 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F22685C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:08:13 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NAQc7K009195;
        Mon, 23 Jan 2023 10:08:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=RVfnSLhOLaLfi6M49TyAlTRurkbQvUP+PVV+XGSoDRE=;
 b=kwUSzGDeCSgdyrC2Kit4hlxhJzOlOKmnEo76AQWldAMoDGU/Du3wyCSva8I1P9uBhcGs
 s8hFflMa6AGQaBfFQamH8BrpBqfQYDeh/3ktufUd2nwNd2TLZwrkWx79bZyip1H6u7/Q
 jb3FHxUJxqYx3WGvDld8fjc0gmrkT2mKzLPdMXkShnuDKr6a19j0lpzAx7wTrdT6FM0T
 2QuqLMc/ipdKRhJ+toGDJrQ7UxP1frFTqS3mBbrH1qkvhAr21YOnn07HAhlK+YL8chVw
 kThXLsyKUcDVDDQQQCxn/+ctHmj3sa0yE9rJjv9TZVP7p7Dg+FpWtX5mpNsh9UfaqsMJ CA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n8eb5u9vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 10:08:05 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 23 Jan
 2023 10:08:02 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Mon, 23 Jan 2023 10:08:02 -0600
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BA4D12C5;
        Mon, 23 Jan 2023 16:08:02 +0000 (UTC)
Message-ID: <05a00da2-2ff8-b234-3959-b451849b8cdb@opensource.cirrus.com>
Date:   Mon, 23 Jan 2023 16:08:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
        <sanyog.r.kale@intel.com>, <yung-chuan.liao@linux.intel.com>
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
 <c05a6791-96a7-2b10-d353-eb7b316aefc8@linux.intel.com>
 <20230120095941.GL36097@ediswmail.ad.cirrus.com>
 <881088ad-95d7-2462-20d2-72a6a9d3ba68@linux.intel.com>
 <20230123145353.GX36097@ediswmail.ad.cirrus.com>
 <034245f8-50b7-e801-7961-58c77dbc00b1@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <034245f8-50b7-e801-7961-58c77dbc00b1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -kOyOzxdZwUdkUX4DCf-htTy87Jm2znY
X-Proofpoint-ORIG-GUID: -kOyOzxdZwUdkUX4DCf-htTy87Jm2znY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 15:50, Pierre-Louis Bossart wrote:
> 
> 
> On 1/23/23 08:53, Charles Keepax wrote:
>> On Fri, Jan 20, 2023 at 10:20:50AM -0600, Pierre-Louis Bossart wrote:
>>> On 1/20/23 03:59, Charles Keepax wrote:
>>>> On Thu, Jan 19, 2023 at 11:12:04AM -0600, Pierre-Louis Bossart wrote:
>>>>> There should be an explanation and something checking that both are not
>>>>> used concurrently.
>>>>
>>>> I will try to expand the explanation a litte, but I dont see any
>>>> reason to block calling both handlers, no ill effects would come
>>>> for a driver having both and it is useful if any soundwire
>>>> specific steps are needed that arn't on other control buses.
>>>
>>> I think it's problematic if the peripheral tries to wake-up the manager
>>> from clock-stop with both an in-band wake (i.e. drive the data line
>>> high) and a separate GPIO-based interrupt. It's asking for trouble IMHO.
>>> We spent hours in the MIPI team to make sure there were no races between
>>> the manager-initiated restarts and peripheral-initiated restarts, adding
>>> a 3rd mechanism in the mix gives me a migraine already.
>>
>> Apologies but I am struggling see why this has any bearing on
>> the case of a device that does both an in-band and out-of-band
>> wake. The code we are adding in this patch will only be called in the
>> in-band case. handle_nested_irq doesn't do any hardware magic or
>> schedule any threads, it just calls a function that was provided
>> when the client called request_threaded_irq. The only guarantee
>> of atomicity you have on the interrupt_callback is sdw_dev_lock
>> and that is being held across both calls after the patch.
>>
>> Could you be a little more specific on what you mean by this
>> represents a 3rd mechanism, to me this isn't a new mechanism just
>> an extra callback? Say for example this patch added an
>> interrupt_callback_early to sdw_slave_ops that is called just
>> before interrupt_callback.
> 
> Well, the main concern is exiting the clock-stop. That is handled by the
> manager and could be done
> a) as the result of the framework deciding that something needs to be
> done (typically as a result of user/applications starting a stream)
> b) by the device with an in-band wake in case of e.g. jack detection or
> acoustic events detected
> c) same as b) but with a separate out-of-band interrupt.
> 
> I'd like to make sure b) and c) are mutually-exclusive options, and that
> the device will not throw BOTH an in-band wake and an external interrupt.

Why would it be a problem if the device did (b) and (c)?
(c) is completely invisible to the SoundWire core and not something
that it has to handle. The handler for an out-of-band interrupt must
call pm_runtime_get_sync() or pm_runtime_resume_and_get() and that
would wake its own driver and the host controller.
