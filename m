Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47986F7FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjEEJOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjEEJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:14:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB018922;
        Fri,  5 May 2023 02:14:06 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QCPyv3hZhzpSwf;
        Fri,  5 May 2023 17:09:59 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 17:14:04 +0800
Message-ID: <1b703656-e966-63f8-19dd-33e4e9914676@huawei.com>
Date:   Fri, 5 May 2023 17:14:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
 <b13c9445-39c5-f207-d5d0-d6c86eee54ae@oracle.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <b13c9445-39c5-f207-d5d0-d6c86eee54ae@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm100017.china.huawei.com (7.185.36.220) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/5 16:25, John Garry wrote:
> On 05/05/2023 09:17, Damien Le Moal wrote:
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -26,6 +26,7 @@
>>>   #include <scsi/scsi_device.h>
>>>   #include <scsi/scsi_tcq.h>
>>>   #include <scsi/scsi_transport.h>
>>> +#include <scsi/libsas.h>
> 
> hmmm... is it really acceptable that libata is referencing libsas? I 
> didn't think that it would be. libsas uses libata, not the other way 
> around.
Yeah, I didn't expect that either. Is there any other way? If so, is 
patch v1 OK?
> 
>>>   #include <linux/libata.h>
>>>   #include <linux/hdreg.h>
>>>   #include <linux/uaccess.h>
>>> @@ -2745,10 +2746,17 @@ static struct ata_device 
>>> *__ata_scsi_find_dev(struct ata_port *ap,
>>>    *    Associated ATA device, or %NULL if not found.
>>>    */
>>>   struct ata_device *
>>> -ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device 
>>> *scsidev)
>> Why drop the const ?
>>
>>> +ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
>>>   {
>>> -    struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
>>> +    struct ata_device *dev;
>>> +
>>> +    if (ap->flags & ATA_FLAG_SAS_HOST) {
> 
> And this is SAS host. Not necessarily libsas (even though with ipr 
> libata usage gone, it would be the only user).
Add a new flag only for libsas?

Thanks,
Xingui
.
> 
>>> +        struct domain_device *ddev = sdev_to_domain_dev(scsidev);
>>> +
>>> +        return sas_to_ata_dev(ddev);
>> Do you really need the ddev variable ? Also, this really should be a 
>> libsas
>> helper. I beleive this pattern is repeated in several places in 
>> libsas, so that
>> would nicely clean things up.
>>
> Thanks,
> John
> .
