Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B6652E89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiLUJ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiLUJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:28:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349CB13CE5;
        Wed, 21 Dec 2022 01:28:26 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NcSl46Lg1zRpnj;
        Wed, 21 Dec 2022 17:27:12 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 17:28:23 +0800
Message-ID: <a2ca30e4-a7fe-cae9-7a71-b54ae076170d@huawei.com>
Date:   Wed, 21 Dec 2022 17:28:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
 <f15c142c-669d-6bc7-f9b9-c05cc3df1542@huawei.com>
 <9b8da72d-f251-9c1b-0727-28254d7007c3@oracle.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <9b8da72d-f251-9c1b-0727-28254d7007c3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm500006.china.huawei.com (7.185.36.236) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/19 22:53, John Garry wrote:
> On 19/12/2022 12:59, yangxingui wrote:
>>> Firstly, I think that there is a bug in sas_ata_device_link_abort() 
>>> -> ata_link_abort() code in that the host lock in not grabbed, as the 
>>> comment in ata_port_abort() mentions. Having said that, libsas had 
>>> already some dodgy host locking usage - specifically dropping the 
>>> lock for the queuing path (that's something else to be fixed up ... I 
>>> think that is due to queue command CB calling task_done() in some 
>>> cases), but I still think that sas_ata_device_link_abort() should be 
>>> fixed (to grab the host lock).
>> ok, I agree with you very much for this, I had doubts about whether we 
>> needed to grab lock before.
> 
> ok, I hope that you can fix this up separately.
> 
>>>
>>> Secondly, this just seems like a half solution to the age-old problem 
>>> - that is, EH eventually kicking in only after 30 seconds when a disk 
>>> is removed with active IO. I say half solution as SAS disks still 
>>> have this issue for libsas. Can we instead push to try to solve both 
>>> of them now?
>>
>> Jason said you must have such an opinion "a half solution". As libsas 
>> does not have any interface to mark all outstanding commands as failed 
>> for SAS disk currently and SAS disk support I/O resumable transmission 
>> after intermittent disconnections
> 
> I don't know what you mean by "resumable transmission after intermittent 
> disconnections".
> 
>> , so I want to optimize sata disk first.
>> If we want to achieve a complete solution, perhaps we need to define 
>> such an interface in libsas and implement it by lldd. My current idea 
>> is to call sas_abort_task() for all outstanding commands in lldd. I 
>> wonder if you approve of this?
> 
> Are you sure you mean sas_abort_task()? That is for the LLDD to issue an 
> abort TMF. I assume that you mean sas_task_abort(). If so, I am not too 
> keen on the idea of libsas calling into the LLDD to inform of such an 
> event.
I've implemented this solution. The verification seems to be ok both for 
sas/sata device. I'll update the version again. Please have a look?

Thanks,
Xingui
  Note that maybe a tagset iter function could be used by libsas to
> abort each active IO, but I don't like libsas messing with such a thing; 
> in addition, there may be some conflict between libsas aborting the IO 
> and the IO completing with error in the LLDD.
> 
> Please note that I need to refresh my memory on this whole EH topic...
> 
> Thanks,
> John
> 
> .
