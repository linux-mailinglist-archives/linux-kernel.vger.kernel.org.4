Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB45610BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJ1IBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ1IBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:01:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5868CF9;
        Fri, 28 Oct 2022 01:01:30 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MzFJr5g2kz67Y4M;
        Fri, 28 Oct 2022 15:57:48 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 10:01:28 +0200
Received: from [10.48.144.136] (10.48.144.136) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 09:01:27 +0100
Message-ID: <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
Date:   Fri, 28 Oct 2022 09:01:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <bvanassche@acm.org>, <hch@lst.de>, <ming.lei@redhat.com>,
        <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.garry2@mail.dcu.ie>
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.144.136]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On 27/10/2022 23:25, Damien Le Moal wrote:
>> So we have this overall flow:
>>
>> ata_exec_internal_sg():
>>    -> alloc request
>>    -> blk_execute_rq_nowait()
>>        ... -> scsi_queue_rq()
>> 		-> sht->reserved_queuecommd()
>> 			-> ata_internal_queuecommand()
>>
>> And then we have ata_internal_queuecommand() -> ata_sas_queuecmd() ->
>> ata_scsi_queue_internal() -> ata_qc_issue().
>>
>> Hope it makes sense.
> OK. Got it.
> However, ata_exec_internal_sg() being used only from EH context with the
> queue quiesced, will blk_execute_rq_nowait() work ? Is there an exception
> for internal reserved tags ?
> 

Well, yeah. So if some error happens and EH kicks in, then full queue 
depth of requests may be allocated. I have seen this for NCQ error. So 
this is why I make in very first patch change allow us to allocate 
reserved request from sdev request queue even when budget is fully 
allocated.

Please also note that for AHCI, I make reserved depth =1, while for SAS 
controllers it is greater. This means that in theory we could alloc > 1x 
reserved command for SATA disk, but I don't think it matters.

Thanks,
John
