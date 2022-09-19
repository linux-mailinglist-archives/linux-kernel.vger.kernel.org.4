Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86925BD0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiISPYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiISPX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:23:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B139BAB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:23:13 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oaIc3-0001M2-Dm; Mon, 19 Sep 2022 17:23:11 +0200
Message-ID: <b5271342-c804-70c1-9a81-d94efa59b203@leemhuis.info>
Date:   Mon, 19 Sep 2022 17:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [REGRESSION 5.19.x] AMD HD-audio devices missing on 5.19
 #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     regressions@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
References: <874jy4cqok.wl-tiwai@suse.de>
 <c6ea56f5-05be-c9bb-4eda-a3c4a081326f@leemhuis.info>
In-Reply-To: <c6ea56f5-05be-c9bb-4eda-a3c4a081326f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663600993;48343573;
X-HE-SMSGID: 1oaIc3-0001M2-Dm
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

On 24.08.22 09:13, Thorsten Leemhuis wrote:

> On 22.08.22 16:12, Takashi Iwai wrote:
>>
>> we've received regression reports about the missing HD-audio devices
>> on AMD platforms, and this turned out to be caused by the commit
>> 512881eacfa72c2136b27b9934b7b27504a9efc2
>>     bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management
>>
>> The details are found in openSUSE bugzilla:
>>   https://bugzilla.suse.com/show_bug.cgi?id=1202492
>>
>> The problem seems to be that HD-audio (both onboard analog and HDMI)
>> PCI devices are assigned to the same IOMMU group as AMD graphics PCI
>> device, and once after the AMDGPU is initialized beforehand, those
>> audio devices can't be probed since iommu_device_use_default_domain()
>> returns -EBUSY.
>>
>> I'm not sure whether it's specific to PCI bus due to the assignment
>> logic of those IOMMU groups, or it's about the handling of the active
>> domain assignment.  In anyway, disabling IOMMU works around the
>> problem, and passing driver_managed_dma flag to the HD-audio driver
>> was also confirmed to work around it, too.
>>
>> The problem persists with 6.0-rc1 kernel.
>>
>> If you have / can give any fix patch or debug patch, let me know; I'll
>> build test kernels and ask the reporters.
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot introduced 512881eacfa72c2136b27b99 ^
> https://bugzilla.suse.com/show_bug.cgi?id=1202492
> #regzbot title AMD HD-audio devices missing on 5.19
> #regzbot ignore-activity

#regzbot fixed-by: 2380f1e8195ef612deea
