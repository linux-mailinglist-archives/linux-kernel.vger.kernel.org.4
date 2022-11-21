Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663E96325C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKUO1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiKUO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:27:05 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD516AFE5F;
        Mon, 21 Nov 2022 06:26:58 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG8kG3ph6zqSMM;
        Mon, 21 Nov 2022 22:23:02 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 22:26:55 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 22:26:55 +0800
Message-ID: <731f2c97-fb3c-f2a1-22b5-059b3c3afe33@huawei.com>
Date:   Mon, 21 Nov 2022 22:26:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 0/5] scsi:scsi_debug:Add error injection for single
 lun
Content-Language: en-US
To:     <dgilbert@interlog.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221109155950.3536976-1-haowenchao@huawei.com>
 <58472d12-c1e4-59f3-bb37-a98db17ef2ba@interlog.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <58472d12-c1e4-59f3-bb37-a98db17ef2ba@interlog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/14 5:48, Douglas Gilbert wrote:
> On 2022-11-09 10:59, Wenchao Hao wrote:
>> The original error injection mechanism was based on scsi_host which
>> could not inject fault for a single SCSI device.
>>
>> This patchset provides the ability to inject errors for a single
>> SCSI device. Now we supports inject timeout errors, queuecommand
>> errors, and hostbyte, driverbyte, statusbyte, and sense data for
>> specific SCSI Command
>>
>> The first patch add an sysfs interface to add and inquiry single
>> device's error injection info; the second patch defined how to remove
>> an injection which has been added. The following 3 patches use the
>> injection info and generate the related error type.
>>
>> Wenchao Hao (5):
>>    scsi:scsi_debug: Add sysfs interface to manager single devices' error inject
>>    scsi:scsi_debug: Add interface to remove injection which has been added
>>    scsi:scsi_debug: make command timeout if timeout error is injected
>>    scsi:scsi_debug: Return failed value for specific command's queuecommand
>>    scsi:scsi_debug: fail specific scsi command with result and sense data
>>
>>   drivers/scsi/scsi_debug.c | 295 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 295 insertions(+)
> 
> Hi,
> This patchset seems to assume all scsi_debug devices will be disk (-like) SCSI
> devices. That leaves out other device types: tapes, enclosures, WLUNs, etc.
> 
> Have you considered putting these device specific additions under:
>    /sys/class/scsi_device/<hctl>/device/error_inject/
> instead of
>    /sys/block/sdb/device/error_inject/
> 
> ?
> 
> Doug Gilbert
> 

Thanks for your reply. I did not notice other device types, but the error_inject interface is
added for scsi_device, so it is available for all types. I would update the path in patch description.

Do you have other suggestions?

