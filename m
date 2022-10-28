Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6A610C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJ1IO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJ1IOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:14:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B68F3E;
        Fri, 28 Oct 2022 01:14:27 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MzFdl4Xzlz685K1;
        Fri, 28 Oct 2022 16:12:27 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 10:14:24 +0200
Received: from [10.48.144.136] (10.48.144.136) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 09:14:23 +0100
Message-ID: <a3fe8284-d002-36b0-7e09-67f132353088@huawei.com>
Date:   Fri, 28 Oct 2022 09:14:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <bvanassche@acm.org>, <hch@lst.de>,
        <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.garry2@mail.dcu.ie>
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <3ef0347f-f3e2-cf08-2b27-f65a7afe82a2@suse.de>
 <ea0be367-a4e0-3cc2-c4c7-04d8db1714cd@huawei.com>
 <07028dac-d6cc-d707-db08-b92c365a6220@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <07028dac-d6cc-d707-db08-b92c365a6220@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.144.136]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 23:35, Damien Le Moal wrote:
>> At what stage do you want to send these commands? The tags for the shost
>> are not setup until scsi_add_host() -> scsi_mq_setup_tags() is called,
>> so can't expect blk-mq to manage reserved tags before then.
>>
>> If you are required to send commands prior to scsi_add_host(), then I
>> suppose the low-level driver still needs to manage tags until the shost
>> is ready. I guess that some very simple scheme can be used, like always
>> use tag 0, since most probe is done serially per-host. But that's not a
>> case which I have had to deal with yet.
> In libata case, ata_dev_configure() will cause a lot of
> ata_exec_internal_sg() calls for IDENTIFY and various READ LOG commands.
> That is all done with non-ncq commands, which means that we do not require
> a hw tag. But given that you are changing ata_exec_internal_sg() to call
> alloc_request + blk_execute_rq_nowait(), how would these work without a
> tag, at least a soft one ? Or we would need to keep the current code to
> use ata_qc_issue() directly for probe time ? That will look very ugly...
> 

I am not sure if there is really a problem. So libata/libsas allocs the 
shost quite early, and that is before we try using 
ata_exec_internal_sg(). Also note that I added patch "ata: libata-scsi: 
Allocate sdev early in port probe" so that we have ata_device.sdev ready 
before issuing ata_exec_internal_sg() (sorry if I'm stating the obvious).

I think Hannes' issue is that some SCSI HBA driver needs to send 
"internal" commands to probe the HW for info, and this would be before 
shost is ready. He can tell us more.

Thanks,
John
