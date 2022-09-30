Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605285F092C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiI3Kcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiI3Kao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:30:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B041F9B03;
        Fri, 30 Sep 2022 03:21:35 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mf5n967Tfz67b1p;
        Fri, 30 Sep 2022 18:19:25 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Fri, 30 Sep 2022 12:20:42 +0200
Received: from [10.126.175.8] (10.126.175.8) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 11:20:41 +0100
Message-ID: <5e570c35-ed98-a29b-736f-677aa896f654@huawei.com>
Date:   Fri, 30 Sep 2022 11:20:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 4/6] scsi: pm8001: Use sas_task_find_rq() for tagging
To:     Jinpu Wang <jinpu.wang@ionos.com>, <damien.lemoal@wdc.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <ipylypiv@google.com>,
        <changyuanl@google.com>, <hch@lst.de>, <yanaijie@huawei.com>
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
 <1664528184-162714-5-git-send-email-john.garry@huawei.com>
 <CAMGffEkgR6VmfMV1eLVeTn+b8b0GC_B9=vj3HxF6cn5Er6+CTg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAMGffEkgR6VmfMV1eLVeTn+b8b0GC_B9=vj3HxF6cn5Er6+CTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.8]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 10:17, Jinpu Wang wrote:
> On Fri, Sep 30, 2022 at 11:03 AM John Garry<john.garry@huawei.com>  wrote:
>> The request associated with a scsi command coming from the block layer
>> has a unique tag, so use that when possible for getting a CCB.
>>
>> Unfortunately we don't support reserved commands in the SCSI midlayer yet,
>> so in the interim continue to manage those tags internally (along with
>> tags for private commands).
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
> Reviewed-by: Jack Wang<jinpu.wang@ionos.com>
> nice, I would expect this can improve performance, do you have numbers?

Unfortunately my system hangs after I run for an appreciable period of 
time. I normally get around it by turning on much heavy debug options, 
but that would not be much use for performance testing.

But we did get considerable performance improvement for hisi_sas when we 
made the equivalent change.

Damien, if you are interested then sharing any results would be great.

BTW, I do notice that we still have this global lock in delivery path 
which should be removed at some stage:

int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags)
{
	...

	spin_lock_irqsave(&mvi->lock, flags);
	rc = mvs_task_prep(task, mvi, is_tmf, tmf, &pass);
	...
	spin_unlock_irqrestore(&mvi->lock, flags);
}

That really will affect performance...

Thanks,
John

