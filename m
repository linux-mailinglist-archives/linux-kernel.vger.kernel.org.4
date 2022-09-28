Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006315EDE48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiI1N4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiI1N42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:56:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4FB2B196;
        Wed, 28 Sep 2022 06:56:25 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McyhK6qbhz6HJG9;
        Wed, 28 Sep 2022 21:56:17 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 15:56:22 +0200
Received: from [10.126.175.219] (10.126.175.219) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:56:22 +0100
Message-ID: <99efb876-69b1-eb7c-dfa6-8ac621a25438@huawei.com>
Date:   Wed, 28 Sep 2022 14:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "hare@suse.de" <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "ipylypiv@google.com" <ipylypiv@google.com>,
        "changyuanl@google.com" <changyuanl@google.com>,
        "hch@lst.de" <hch@lst.de>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-2-git-send-email-john.garry@huawei.com>
 <PH0PR04MB74164CE477846FFDB843D5419B549@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <PH0PR04MB74164CE477846FFDB843D5419B549@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.219]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 14:17, Johannes Thumshirn wrote:
>> +static inline struct request *sas_task_find_rq(struct sas_task *task)
>> +{
>> +	struct scsi_cmnd *scmd;
>> +
>> +	if (!task || !task->uldd_task)
>> +		return NULL;
> Is anyone actually calling sas_task_find_rq with a NULL task?

Yeah, unfortunately. An example - the only one I think - is in the 
pm8001 driver: pm8001_ccb_alloc() function which takes a task pointer 
which may be NULL, and this function calls sas_task_find_rq()

> That doesn't make a lot of sense from an API POV for me, having
> the only argument allowed to be NULL (and not being a *free()
> kind of function).

I suppose that I could change to only call sas_task_find_rq() for 
non-NULL sas_task pointers (and remove the task check).

Thanks,
John
