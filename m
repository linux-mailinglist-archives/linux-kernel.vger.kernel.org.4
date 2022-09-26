Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653135E99A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiIZGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIZGhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:37:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE04101C8;
        Sun, 25 Sep 2022 23:37:31 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbXxS00xZzHthl;
        Mon, 26 Sep 2022 14:32:43 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:37:29 +0800
Subject: Re: [PATCH v2 0/8] scsi: libsas: sas address comparation refactor
To:     Jinpu Wang <jinpu.wang@ionos.com>
CC:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>
References: <20220924073455.2186805-1-yanaijie@huawei.com>
 <CAMGffE=6BGVLqTbO3SGFZhCYDjo0U=Ay+JO4h+pNi10Hcb0w9g@mail.gmail.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <b1cd66fa-411c-2d68-45d7-89aa6219c3cf@huawei.com>
Date:   Mon, 26 Sep 2022 14:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMGffE=6BGVLqTbO3SGFZhCYDjo0U=Ay+JO4h+pNi10Hcb0w9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/26 14:09, Jinpu Wang wrote:
> On Sat, Sep 24, 2022 at 9:24 AM Jason Yan <yanaijie@huawei.com> wrote:
>>
>> Sas address conversion and comparation is widely used in libsas and
>> drivers. However they are all opencoded and to avoid the line spill over
>> 80 columns, are mostly split into multi-lines.
>>
>> To make the code easier to read, introduce some helpers with clearer
>> semantics and replace the opencoded segments with them.
>>
>> v1->v2:
>>    First factor out sas_find_attached_phy() and replace LLDDs's code
>>          with it.
>>    Remove three too simple helpers.
>>    Rename the helpers with 'sas_' prefix.
>>
> Hi Jason,
> 
> Thx for doing this.
>> Jason Yan (8):
>>    scsi: libsas: introduce sas_find_attached_phy() helper
>>    scsi: pm8001: use sas_find_attached_phy() instead of open coded
>>    scsi: mvsas: use sas_find_attached_phy() instead of open coded
>>    scsi: hisi_sas: use sas_find_attathed_phy() instead of open coded
> These 4 look good to me.
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>

Hi Jack,
Thank you very much for the review.

>>    scsi: libsas: introduce sas address comparation helpers
>>    scsi: libsas: use sas_phy_match_dev_addr() instead of open coded
>>    scsi: libsas: use sas_phy_addr_same() instead of open coded
>>    scsi: libsas: use sas_phy_match_port_addr() instead of open coded
> These helpers are too simple to replace, we add more loc in the end.

The initial purpose to introduce these helpers is to stop cutting 
compare expressions into two lines and to make the code looks clean. We 
add more loc in the end because of function declaration and more blank 
lines between them.

Thanks,
Jason

>>
>>   drivers/scsi/hisi_sas/hisi_sas_main.c | 12 ++------
>>   drivers/scsi/libsas/sas_expander.c    | 40 ++++++++++++++++-----------
>>   drivers/scsi/libsas/sas_internal.h    | 17 ++++++++++++
>>   drivers/scsi/mvsas/mv_sas.c           | 15 +++-------
>>   drivers/scsi/pm8001/pm8001_sas.c      | 16 ++++-------
>>   include/scsi/libsas.h                 |  2 ++
>>   6 files changed, 54 insertions(+), 48 deletions(-)
>>
>> --
>> 2.31.1
>>
> .
> 
