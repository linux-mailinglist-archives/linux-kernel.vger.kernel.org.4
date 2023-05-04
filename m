Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B2D6F6C77
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjEDM4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjEDM4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:56:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CAB59FD;
        Thu,  4 May 2023 05:56:18 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QBtxk3G1xzpSvY;
        Thu,  4 May 2023 20:52:10 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 20:56:13 +0800
Message-ID: <0423d1a9-e707-c94d-9a35-8c4304aa4b35@huawei.com>
Date:   Thu, 4 May 2023 20:56:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/6] scsi:scsi_debug: Add error injection for single
 device
Content-Language: en-US
To:     <dgilbert@interlog.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <louhongxiang@huawei.com>
References: <20230428013320.347050-1-haowenchao2@huawei.com>
 <585941de-3e17-d5aa-311b-17773c6fbf1f@interlog.com>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <585941de-3e17-d5aa-311b-17773c6fbf1f@interlog.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/3 7:52, Douglas Gilbert wrote:
> On 2023-04-27 21:33, Wenchao Hao wrote:
>> The original error injection mechanism was based on scsi_host which
>> could not inject fault for a single SCSI device.
>>
>> This patchset provides the ability to inject errors for a single
>> SCSI device. Now we supports inject timeout errors, queuecommand
>> errors, and hostbyte, driverbyte, statusbyte, and sense data for
>> specific SCSI Command.
>>
>> The first two patch add an debugfs interface to add and inquiry single
>> device's error injection info; the third patch defined how to remove
>> an injection which has been added. The following 3 patches use the
>> injection info and generate the related error type.
>>
>> V2:
>>    - Using debugfs rather than sysfs attribute interface to manage error
>>
>> Wenchao Hao (6):
>>    scsi:scsi_debug: create scsi_debug directory in the debugfs filesystem
>>    scsi:scsi_debug: Add interface to manage single device's error inject
>>    scsi:scsi_debug: Define grammar to remove added error injection
>>    scsi:scsi_debug: timeout command if the error is injected
>>    scsi:scsi_debug: Return failed value if the error is injected
>>    scsi:scsi_debug: set command's result and sense data if the error is
>>      injected
>>
>>   drivers/scsi/scsi_debug.c | 318 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 318 insertions(+)
> 
> Been playing around with this patchset and it seems to work as expected. Took me
> a while to work my way through interface description at the beginning of
>    [PATCH v2 2/6] scsi:scsi_debug: Add interface to manage single device's error inject
> 
> so I cut and paste it into my scsi_debug.html page and did some work on it, see:
>     https://doug-gilbert.github.io/scsi_debug.html
> 
> There is a new chapter titled: Per device error injection
> Kept the ASCII art so it could be ported back to [PATCH v2 2/6]'s description
> if Wenchao is agreeable.
> 

Thank you a lot, I would update the patch's description in next version.

> So for the whole series:
>    Acked-by: Douglas Gilbert <dgilbert@interlog.com>
> 
> 
> One suggestion for later work: perhaps the Command opcode field could be
> expanded to: x8[,x16] so optionally a Service Action (in hex) could be
> given (e.g. '9e,10' for the READ CAPACITY (16) command).
> 
> Doug Gilbert
> 
> 

Would you help me to check if my understanding is correct:

Define Command opcode as x16, split this 16bit as two parts, one for actually
SCSI Command opcode,, another one for Service Action. If so, it would make this
interface complex to use. I want to make it easy and we do not need to calculate
data.

I think there are other methods to support specify a Service Action:

method1. Redefine the General rule format and append Service Action to SCSI
    command opcode as following:

   +--------+------+-------------------------------------------------------+
   | Column | Type | Description                                           |
   +--------+------+-------------------------------------------------------+
   |   1    |  u8  | Error code                                            |
   |        |      |  0: timeout SCSI command                              |
   |        |      |  1: fail queuecommand, make queuecommand return       |
   |        |      |     given value                                       |
   |        |      |  2: fail command, finish command with SCSI status,    |
   |        |      |     sense key and ASC/ASCQ values                     |
   +--------+------+-------------------------------------------------------+
   |   2    |  s32 | Error count                                           |
   |        |      |  0: this rule will be ignored                         |
   |        |      |  positive: the rule will always take effect           |
   |        |      |  negative: the rule takes effect n times where -n is  |
   |        |      |            the value given. Ignored after n times     |
   +--------+------+-------------------------------------------------------+
   |   3    |  x8  | SCSI command opcode, 0xff for all commands            |
   +--------+------+-------------------------------------------------------+
   |   4    |  x8  | specify a Service Action, 0xff for all commands       |
   +--------+------+-------------------------------------------------------+
   |  ...   |  xxx | Error type specific fields                            |
   +--------+------+-------------------------------------------------------+

method2. define new Error code for commands which need a Service Action,
    for example: define Error code 3 as the following format to timeout a
    command commands which need a Service Action:

   +--------+------+-------------------------------------------------------+
   | Column | Type | Description                                           |
   +--------+------+-------------------------------------------------------+
   |   1    |  u8  | Fix to 3                                              |
   +--------+------+-------------------------------------------------------+
   |   2    |  s32 | Error count                                           |
   |        |      |  0: this rule will be ignored                         |
   |        |      |  positive: the rule will always take effect           |
   |        |      |  negative: the rule takes effect n times where -n is  |
   |        |      |            the value given. Ignored after n times     |
   +--------+------+-------------------------------------------------------+
   |   3    |  x8  | SCSI command opcode, 0xff for all commands            |
   +--------+------+-------------------------------------------------------+
   |   4    |  x8  | specify a Service Action, 0xff for all commands       |
   +--------+------+-------------------------------------------------------+

   We can inject timeout error for the READ CAPACITY (16) command with following:
   echo "3 -10 0x9e 0x10" > ${error}
