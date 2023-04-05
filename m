Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2E6D72B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 05:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbjDEDfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 23:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDEDf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 23:35:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311093C3F;
        Tue,  4 Apr 2023 20:35:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3353Z3IG017329;
        Tue, 4 Apr 2023 22:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680665703;
        bh=DV4jgkhSH/8JsasYkUzg03N4e1jfAh5IuAJx+n9i4Hg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=zSdtN4yHV/M3mw8JcqykdpdiEVQqv8xtlcweabc0fvWR6rJ8qCkZmzEYSOLpCUteG
         FWZ9p2LT/TX6JxBmgBuVf+n2pncS8zcSkv72OB92DcYHnb8grYYdWZ9TVh+qhDcVM4
         c2MczjsLSb2uaSU+mPgMpNqFhX/gUci2W2gThdC4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3353Z3cu029333
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Apr 2023 22:35:03 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 4
 Apr 2023 22:35:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 4 Apr 2023 22:35:03 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3353Z1oZ022632;
        Tue, 4 Apr 2023 22:35:01 -0500
Message-ID: <eea63f29-54ce-ef82-62c6-92193558908f@ti.com>
Date:   Wed, 5 Apr 2023 09:05:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] mmc: sdhci_am654: Add support for PM suspend/resume
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230331101619.4117312-1-vigneshr@ti.com>
 <CAPDyKFqQZgmd_ydbjKJ+5-Dte9i2=DqWwZNgVHi2MnH+q7pZ1g@mail.gmail.com>
 <9029896f-d6fb-e341-9544-1104ecfa9f8a@ti.com>
 <CAPDyKFpXfRqx4WLuiU6m=rgM9A=21KfDTuEb5TboaOC+w_hMwg@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <CAPDyKFpXfRqx4WLuiU6m=rgM9A=21KfDTuEb5TboaOC+w_hMwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/23 17:24, Ulf Hansson wrote:
> On Mon, 3 Apr 2023 at 19:42, Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>> Hi,
>>
>> On 31/03/23 20:01, Ulf Hansson wrote:
>>> On Fri, 31 Mar 2023 at 12:17, Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>>>
>>>> From: Aswath Govindraju <a-govindraju@ti.com>
>>>>
>>>> Add support for suspend/resume and pm_runtime resume/suspend.
>>>>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>> ---
>>>>
>>>> Since RFC v2:
>>>> Address all comments around sdhci_am654_remove()
>>>> Set autosuspend_delay to -1 as SDHCI will host rootfs via SD/eMMC and
>>>> autosuspend can cause long latency for user interactive applications
>>>
>>> I am curious about the "long" latency. Do you have some data that you
>>> can share for how long it takes to runtime-resume the device?
>>>
>>
>> As part of wider teting, I discovered that on certain boards (J721e EVM
>> for example), there is a latency of ~500ms for controller to start up
>> (HW limitation around card detect debounce timer [0]). This results in
>> momentary (but noticeable) lag when playing a video for example.
> 
> Ohh, that kind of sucks. There is no way to workaround that I guess?

Unfortunately no,

> 
>>
>>
>> [0[
>> https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/sdhci_am654.c#L361
>>
>>
>>> Using -1 as the default value for the autosuspend_delay seems fine to
>>> me, but did you consider using a longer timeout than the common 100ms?
>>> Could that perhaps be a better default option?
>>
>> Its more of the startup delay than how long controller should remain
>> active. So tuning autosuspend_delay does not seem to help.
>>
>>>
>>> Of course, in the end this is a choice of performance in favor of
>>> wasting energy.
>>
>> Yes, this is choice of opt-in vs opt-out. Users can tune the delay via
>> sysfs as needed.
>>
>> I am setting it to -1 to avoid regressing any userspace apps (vs
>> enabling autosuspend and then asking impacted users to set to -1)
> 
> Alright, makes sense!
> 
>>
>> One solution is to use -1 on platforms where latency is significant
>> based on compatible / SoC detection?
> 
> That's a good idea! It seems a pity to make all SoCs suffer, if there
> is only a subset that has this problem. Although, let's consider that
> as an improvement that can be done on top of $subject patch.

Sure, will follow up with a patch to reduce autosuspend_delay on
platforms w/o above issue.

> 
> So, applied for next, thanks!

Great, thanks!

-- 
Regards
Vignesh
