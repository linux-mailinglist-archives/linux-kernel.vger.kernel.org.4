Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58F610C47
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJ1IdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ1IdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:33:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023981C491B;
        Fri, 28 Oct 2022 01:33:22 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MzG3Z4cxzz6864S;
        Fri, 28 Oct 2022 16:31:22 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 10:33:19 +0200
Received: from [10.48.144.136] (10.48.144.136) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 09:33:18 +0100
Message-ID: <b03b37a2-35dc-5218-7279-ae68678a47ff@huawei.com>
Date:   Fri, 28 Oct 2022 09:33:19 +0100
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
 <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
 <71b56949-e4d7-fd94-c44a-867080b7a4fa@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <71b56949-e4d7-fd94-c44a-867080b7a4fa@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.144.136]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On 28/10/2022 09:07, Damien Le Moal wrote:
>> Well, yeah. So if some error happens and EH kicks in, then full queue
>> depth of requests may be allocated. I have seen this for NCQ error. So
>> this is why I make in very first patch change allow us to allocate
>> reserved request from sdev request queue even when budget is fully
>> allocated.
>>
>> Please also note that for AHCI, I make reserved depth =1, while for SAS
>> controllers it is greater. This means that in theory we could alloc > 1x
>> reserved command for SATA disk, but I don't think it matters.
> Yes, 1 is enough. However, is 1 reserved out of 32 total, meaning that the
> user can only use 31 tags ? or is it 32+1 reserved ? which we can do since
> when using the reserved request, we will not use a hw tag (all reserved
> requests will be non-ncq).
> 
> The 32 + 1 scheme will work. 

Yes, 32 + 1 is what we want. I now think that there is a mistake in my 
code in this series for ahci.

So I think we need for ahci:

can_queue = 33
nr_reserved_cmds = 1

while I only have can_queue = 32

I need to check that again for ahci driver and AHCI SHT...

> But for CDL command completion handling, we
> will need a NCQ command to do a read log, to avoid forcing a queue drain.
> For that to reliably work, we'll need a 31+1+1 setup...
> 

So is your idea to permanently reserve 1 more command from 32 commands ? 
Or re-use 1 from 32 (and still also have 1 separate internal command)?

Thanks,
John
