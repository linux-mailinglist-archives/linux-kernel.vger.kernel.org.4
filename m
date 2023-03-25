Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D856C8AA4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 04:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCYDXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 23:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCYDXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 23:23:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FFC1498F;
        Fri, 24 Mar 2023 20:23:49 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pk48j5wpfz17Ngh;
        Sat, 25 Mar 2023 11:20:37 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 11:23:47 +0800
Message-ID: <a189829b-2ae4-8a62-1d0d-43c50217ce84@huawei.com>
Date:   Sat, 25 Mar 2023 11:23:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/5]scsi:scsi_debug: Add error injection for single device
Content-Language: en-US
To:     <dgilbert@interlog.com>, John Garry <john.g.garry@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <louhongxiang@huawei.com>
References: <20230323115601.178494-1-haowenchao2@huawei.com>
 <b5f8240e-f46a-b83b-ed16-66c2d8c5571f@oracle.com>
 <c9d213e2-5ab4-0db2-f87a-247519debbbb@huawei.com>
 <750a4b24-6122-6faa-fed4-25e3167ea376@oracle.com>
 <fd810b7f-5520-1054-735f-8434a237c6e4@interlog.com>
 <164655df-0db3-0ec5-fb84-ff52204577e9@huawei.com>
 <5763743e-1923-d06e-04b7-19dfa0e8e2f4@interlog.com>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <5763743e-1923-d06e-04b7-19dfa0e8e2f4@interlog.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/25 1:31, Douglas Gilbert wrote:
> On 2023-03-23 23:42, haowenchao (C) wrote:
>> On 2023/3/24 1:24, Douglas Gilbert wrote:
>>> On 2023-03-23 12:25, John Garry wrote:
>>>> On 23/03/2023 13:13, haowenchao (C) wrote:
>>>>> On 2023/3/23 20:40, John Garry wrote:
>>>>>> On 23/03/2023 11:55, Wenchao Hao wrote:
>>>>>>> The original error injection mechanism was based on scsi_host which
>>>>>>> could not inject fault for a single SCSI device.
>>>>>>>
>>>>>>> This patchset provides the ability to inject errors for a single
>>>>>>> SCSI device. Now we supports inject timeout errors, queuecommand
>>>>>>> errors, and hostbyte, driverbyte, statusbyte, and sense data for
>>>>>>> specific SCSI Command.
>>>>>>
>>>>>> There is already a basic mechanism to generate errors - like timeouts - on "nth" command. Can you say why you want this new interface? What special scenarios are you trying to test/validate (which could not be achieved based on the current mechanism)?
>>>>>>
>>>>>
>>>>> I am testing a new error handle policy which is based on single scsi_device
>>>>> without set host to RECOVERY. So I need a method to generate errors for
>>>>> single SCSI devices.
>>>>>
>>>>> While we can not generate errors for single device with current mechanism
>>>>> because it is designed for host-wide error generation.
>>>>>
>>>>>> With this series we would have 2x methods to inject errors, which is less than ideal, and they seem to possibly conflict as well, e.g. I set timeout for nth command via current interface and then use the new interface to set timeout for some other cadence. What behavior to expect ...?
>>>>>
>>>>> I did not take this issue in consideration. I now assume the users would
>>>>> not use these 2 methods at same time.
>>>>>
>>>>> What's more, I don not know where to write the usage of this newly added
>>>>> interface, maybe we can explain these in doc?
>>>>
>>>> sysfs entries are described in Documentation/ABI, but please don't add elaborate programming interfaces in sysfs files (like in these patches) - a sysfs file should be just for reading or writing a single value
>>>
>>> Hi,
>>> Maybe this link might help for scsi_debug documentation:
>>>      https://doug-gilbert.github.io/scsi_debug.html
>>>
>>> And rather than sysfs for complicated, per (pseudo_ device
>>> settings, perhaps we could think about a SCSI mechanism like
>>> the "Unit Attention" mode page [0x0] which is vendor specific
>>> and used by Seagate and WDC for this sort of thing.
>>> A framework is already in the scsi_debug driver to change
>>> some mode page settings:
>>>
>>> # sdparm /dev/sg0
>>>      /dev/sg0: Linux     scsi_debug        0191
>>> Read write error recovery mode page:
>>>    AWRE          1  [cha: n, def:  1]
>>>    ARRE          1  [cha: n, def:  1]
>>>    PER           0  [cha: n, def:  0]
>>> Caching (SBC) mode page:
>>>    WCE           1  [cha: y, def:  1]
>>>    RCD           0  [cha: n, def:  0]
>>> Control mode page:
>>>    SWP           0  [cha: n, def:  0]
>>> Informational exceptions control mode page:
>>>    EWASC         0  [cha: n, def:  0]
>>>    DEXCPT        1  [cha: n, def:  1]
>>>    MRIE          0  [cha: y, def:  0]
>>>
>>> As can be seen WCE and MRIE are changeable, so
>>>
>>> # sdparm --clear=WCE /dev/sg0
>>> # sdparm --get=WCE /dev/sg0
>>>      /dev/sg0: Linux     scsi_debug        0191
>>> WCE           0  [cha: y, def:  1]
>>>
>>>
>>> Doug Gilbert
>>>
>>>
>>
>> Do you mean define scsi_debug's own format of mode page0(Vendor specific)
>> which contains these error injection info, and set/get these parameters
>> via sdparm?
>> If so, do we need to modify the sdparm code for these changes?
> 
> Not a problem.
> 
>> I want to add more injections in scsi_debug to test the SCSI middle layer,
>> for example, control return SUCCESS in scsi_debug_abort() or
>> scsi_debug_device_reset().
>>
>> These injections are more oriented to developers to trigger and observe
>> the error handler of SCSI middle layer.
>>
>> We can extend other error injections conveniently via my interface,
>> for example, add a new error code to add a new injection to control the
>> return value of scsi_debug_abort().
>>
>> If it's not recommended to add this interface in sysfs, what about proc? Like
>> /proc/scsi/scsi, we can write "scsi remove-single-device h:c:t:l" to manage
>> device.
> 
> In the past, procfs has been used for this sort of thing
> but the powers that be want to phase that usage out.
> 
> debugfs, even though it is usually mounted under sysfs at
> /sys/kernel/debug , does not seem to have the "one value
> per variable" restriction. So debugfs or configfs
> ( /sys/kernel/config ) might be better candidates.
> See 'df -ahT' .
> 

Define scsi_debug's own format of mode page0 seems too complex and we have to
change the sdparm code. In order to make a better scalability, I prefer to add
these interface via debugfs. Actually, I design the format of the "error interface"
described in patch1 by referring to interfaces of ftrace.

The new interfaces based on debugfs would look like following:
/sys/kernel/debug/scsi_debug
	|
	+-- 0:0:0:1
	|	|
	|	\-- error
	|
	\-- 0:0:0:2
		|
		\-- error

>>>>>> I'm not saying that I am a huge fan of the current inject mechanism, but at the very least you need to provide more justification for this series.
>>>>>>>>
>>>>>>> The first patch add an sysfs interface to add and inquiry single
>>>>>>> device's error injection info; the second patch defined how to remove
>>>>>>> an injection which has been added. The following 3 patches use the
>>>>>>> injection info and generate the related error type.
>>>>>>>
>>>>>>> Wenchao Hao (5):
>>>>>>>    scsi:scsi_debug: Add sysfs interface to manage scsi devices' error
>>>>>>>      injection
>>>>>>>    scsi:scsi_debug: Define grammar to remove added error injection
>>>>>>>    scsi:scsi_debug: timeout command if the error is injected
>>>>>>>    scsi:scsi_debug: Return failed value if the error is injected
>>>>>>>    scsi:scsi_debug: set command's result and sense data if the error is
>>>>>>>      injected
>>>>>>>
>>>>>>>   drivers/scsi/scsi_debug.c | 296 ++++++++++++++++++++++++++++++++++++++
>>>>>>>   1 file changed, 296 insertions(+)
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 
> 

