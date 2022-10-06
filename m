Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5415F62C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiJFIdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiJFId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:33:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E04F92F56;
        Thu,  6 Oct 2022 01:33:27 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mjl5B1JSNz67Lm9;
        Thu,  6 Oct 2022 16:30:54 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 10:33:24 +0200
Received: from [10.126.169.169] (10.126.169.169) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 09:33:23 +0100
Message-ID: <f190f19e-34b2-611c-1cf4-f8f34d12fe74@huawei.com>
Date:   Thu, 6 Oct 2022 09:33:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        yangxingui <yangxingui@huawei.com>,
        yanaijie <yanaijie@huawei.com>
References: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
 <YzwvpUUftX6Ziurt@x1-carbon>
 <cfa52b91-db81-a179-76c2-8a61266c099d@huawei.com>
 <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
 <Yz33FGwd3YvQUAqT@x1-carbon>
 <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
 <Yz4BLTPkXqyjW4a4@x1-carbon>
 <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
In-Reply-To: <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.169.169]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2022 23:42, Damien Le Moal wrote:
>> Hello Damien,
>>
>> John explained that he got a timeout from EH when reading the log:
>> [  350.281581] ata1: failed to read log page 10h (errno=-5)
>> [  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 action 0x6 frozen
>>
>> ata_eh_read_log_10h() uses ata_read_log_page(), which will first try to read
>> the log using READ LOG DMA EXT. If that fails, it will retry using READ LOG EXT.
>>
>> Therefore, to see if this is a driver specific bug, I suggested to try to read
>> the NCQ Command Error log using ATA16 passthrough commands:
>>
>> $ sudo sg_sat_read_gplog -d --log=0x10 /dev/sdc
>> will read the log using READ LOG DMA EXT.
>>
>> $ sudo sg_sat_read_gplog --log=0x10 /dev/sdc
>> will read the log using READ LOG EXT.

Note that I can't get a distro to boot on this system from the HDD for 
the same timeout problem (so no tools easily available).

>>
>> Neither of these two suggested commands are NCQ commands.
>> (Neither command is encapsulated in a RECEIVE FPDMA QUEUED,
>> so I'm not sure what you mean.)
>>
>>
>> Garry, I now see that:
>> [  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 action 0x6 frozen
>> Your port is frozen.
>>
>> ata_read_log_page() calls ata_exec_internal() which calls ata_exec_internal_sg(),
>> which will simply return an error without sending down the command to the drive,
>> if the port is frozen.
>>
>> Not sure why your port is frozen, mine is obviously not.

I think that it gets frozen when the internal command for read log ext 
times out. More below about that timeout.

>>
>> ata_do_link_abort() calls ata_eh_set_pending() without activating fast drain:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-eh.c?h=v6.0#n989
>>
>> So I'm not sure why your port is frozen.
>> (The fast drain timer does freeze the port, but it shouldn't be enabled.)
>> It might be worthwhile to see who freezes the port in your case.
> Might come from the command timeout. John has had many problems with the
> pm80xx HBA in his Arm machine from a while back. Likely not a driver issue
> but a hw one... No-one seems to be able to recreate the same problem.
> 
> We need to try the HBA on our Arm board to see what happens.
> 

Yeah, it just looks to be the longstanding issue of using this card on 
my arm64 machine - that is that I get IO timeouts quite regularly. I 
should have mentioned that yesterday. This just seems to be a driver issue.

Interestingly this read log ext always seems to timeout, so maybe I 
could see if there is anything specific about this command which could 
give a clue to the underlying issue. But I have spent much time trying 
to debug this issue, so not too motivated any more if I’m completely 
honest ...

Thanks,
John
