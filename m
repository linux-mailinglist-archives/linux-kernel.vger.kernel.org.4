Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04236C6947
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCWNNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCWNN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:13:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6D2103;
        Thu, 23 Mar 2023 06:13:25 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pj5Ky3rK5zbcKw;
        Thu, 23 Mar 2023 21:10:14 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 21:13:22 +0800
Message-ID: <c9d213e2-5ab4-0db2-f87a-247519debbbb@huawei.com>
Date:   Thu, 23 Mar 2023 21:13:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/5]scsi:scsi_debug: Add error injection for single device
To:     John Garry <john.g.garry@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <louhongxiang@huawei.com>
References: <20230323115601.178494-1-haowenchao2@huawei.com>
 <b5f8240e-f46a-b83b-ed16-66c2d8c5571f@oracle.com>
Content-Language: en-US
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <b5f8240e-f46a-b83b-ed16-66c2d8c5571f@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/23 20:40, John Garry wrote:
> On 23/03/2023 11:55, Wenchao Hao wrote:
>> The original error injection mechanism was based on scsi_host which
>> could not inject fault for a single SCSI device.
>>
>> This patchset provides the ability to inject errors for a single
>> SCSI device. Now we supports inject timeout errors, queuecommand
>> errors, and hostbyte, driverbyte, statusbyte, and sense data for
>> specific SCSI Command.
> 
> There is already a basic mechanism to generate errors - like timeouts - on "nth" command. Can you say why you want this new interface? What special scenarios are you trying to test/validate (which could not be achieved based on the current mechanism)?
>

I am testing a new error handle policy which is based on single scsi_device
without set host to RECOVERY. So I need a method to generate errors for
single SCSI devices.

While we can not generate errors for single device with current mechanism
because it is designed for host-wide error generation.
  
> With this series we would have 2x methods to inject errors, which is less than ideal, and they seem to possibly conflict as well, e.g. I set timeout for nth command via current interface and then use the new interface to set timeout for some other cadence. What behavior to expect ...?

I did not take this issue in consideration. I now assume the users would
not use these 2 methods at same time.

What's more, I don not know where to write the usage of this newly added
interface, maybe we can explain these in doc?

> 
> I'm not saying that I am a huge fan of the current inject mechanism, but at the very least you need to provide more justification for this series.
>>>
>> The first patch add an sysfs interface to add and inquiry single
>> device's error injection info; the second patch defined how to remove
>> an injection which has been added. The following 3 patches use the
>> injection info and generate the related error type.
>>
>> Wenchao Hao (5):
>>    scsi:scsi_debug: Add sysfs interface to manage scsi devices' error
>>      injection
>>    scsi:scsi_debug: Define grammar to remove added error injection
>>    scsi:scsi_debug: timeout command if the error is injected
>>    scsi:scsi_debug: Return failed value if the error is injected
>>    scsi:scsi_debug: set command's result and sense data if the error is
>>      injected
>>
>>   drivers/scsi/scsi_debug.c | 296 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 296 insertions(+)
>>
> 
> 

