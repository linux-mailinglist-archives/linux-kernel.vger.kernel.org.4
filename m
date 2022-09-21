Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613795BF918
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiIUIYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiIUIYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:24:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EFB54C82;
        Wed, 21 Sep 2022 01:24:07 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MXWd117pLz688JQ;
        Wed, 21 Sep 2022 16:23:01 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:24:04 +0200
Received: from [10.195.245.235] (10.195.245.235) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:24:03 +0100
Message-ID: <0ae5000d-8e9a-da0f-b470-9f87f1b5e290@huawei.com>
Date:   Wed, 21 Sep 2022 09:24:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC 0/6] libata/scsi/libsas: Allocate SCSI device earlier
 for ata port probe
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <hch@lst.de>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <brking@us.ibm.com>
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <40b9e090-5ba3-1191-4fe9-80467284ae72@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <40b9e090-5ba3-1191-4fe9-80467284ae72@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.245.235]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 05:04, Damien Le Moal wrote:
> On 9/20/22 19:27, John Garry wrote:
>> Currently for libata the SCSI device (sdev) associated with an ata_device
>> is allocated when the port probe has completed.
>>
>> It's useful to have the SCSI device and its associated request queue
>> available earlier for the port probe. Specifically if we have the
>> request queue available, then we can:
>> - Easily put ATA qc in SCSI cmnd priv data
>> - Send ATA internal commands on SCSI device request queue for [0]. The
>>    current solution there is to use the shost sdev request queue, which
>>    isn't great.
>> This series changes the ata port probe to alloc the sdev in the
>> ata_device revalidation, and then just do a SCSI starget scan afterwards.
>>
>> Why an RFC?
>> 1. IPR  driver needs to be fixed up - it does not use ATA EH port probe
>>     Mail [1] needs following up
> 
> Yes. If IPR could be converted to ata error_handler, a lot of code can 
> be simplified in libata too.

Hmmm... yeah, it would be good to see progress there.

> 
>> 2. SATA PMP support needs verification, but I don't have a setup
> 
> Port multiplier behind a sas HBA will be challenging to setup :)
> I can try, but I will need to open up one of my servers and hook a small 
> PMP box to one of the pm8001 plugs. I may have the cables for that... 
> Let me check.

I was more thinking of just AHCI with a port multiplier.

As for SAS controllers, I don't think it's something to be concerned 
about. For a start, I know for sure that hisi_sas HW does not support 
port multipliers, and I don't think that pm8001 does either. In 
addition, libsas does not even support it - I did see a series in the 
scsi list from years ago (to support it), but it did not progress.

Thanks,
John
