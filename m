Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FE05F451D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJDOFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJDOE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:04:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8D6DFE6;
        Tue,  4 Oct 2022 07:04:53 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MhfYr2tm3z688JN;
        Tue,  4 Oct 2022 22:03:28 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 16:04:43 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 15:04:42 +0100
Message-ID: <cfa52b91-db81-a179-76c2-8a61266c099d@huawei.com>
Date:   Tue, 4 Oct 2022 15:04:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "yangxingui@huawei.com" <yangxingui@huawei.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>
References: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
 <YzwvpUUftX6Ziurt@x1-carbon>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YzwvpUUftX6Ziurt@x1-carbon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 14:05, Niklas Cassel wrote:
>> 2.35.3
>>
> For pm80xx (pm8001 changes untested):
> Tested-by: Niklas Cassel<niklas.cassel@wdc.com>
> 
> 

Thanks!

> 
> Notes unrelated to this patch:
> 
> Both before and after this series, this driver prints:
> [  215.845053] ata21.00: exception Emask 0x0 SAct 0xfc0000 SErr 0x0 action 0x6
> [  215.852308] ata21.00: failed command: WRITE FPDMA QUEUED
> [  215.857801] ata21.00: cmd 61/00:00:00:3a:d3/01:00:b3:04:00/40 tag 18 ncq dma 131072 out
>                          res 43/04:00:ff:3a:d3/00:00:b3:04:00/40 Emask 0x400 (NCQ error) <F>
> [  215.874396] ata21.00: status: { DRDY SENSE ERR }
> [  215.879192] ata21.00: error: { ABRT }
> [  215.882997] ata21.00: failed command: WRITE FPDMA QUEUED
> [  215.888479] ata21.00: cmd 61/00:00:00:3b:d3/01:00:b3:04:00/40 tag 19 ncq dma 131072 out
>                          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> [  215.904814] ata21.00: failed command: WRITE FPDMA QUEUED
> [  215.910311] ata21.00: cmd 61/00:00:00:3c:d3/01:00:b3:04:00/40 tag 20 ncq dma 131072 out
>                          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> [  215.932679] ata21.00: failed command: WRITE FPDMA QUEUED
> [  215.941203] ata21.00: cmd 61/00:00:00:3d:d3/01:00:b3:04:00/40 tag 21 ncq dma 131072 out
>                          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> [  215.963616] ata21.00: failed command: WRITE FPDMA QUEUED
> [  215.972150] ata21.00: cmd 61/00:00:00:3e:d3/01:00:b3:04:00/40 tag 22 ncq dma 131072 out
>                          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> [  215.994532] ata21.00: failed command: WRITE FPDMA QUEUED
> [  216.003124] ata21.00: cmd 61/00:00:00:3f:d3/01:00:b3:04:00/40 tag 23 ncq dma 131072 out
>                          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> 
> HSM (Host State Machine) violation errors.
> 
> For the same SATA drive connected via AHCI this will instead give:
> 
> [ 3796.944923] ata14.00: exception Emask 0x0 SAct 0x80800003 SErr 0xc0000 action 0x0
> [ 3796.959375] ata14.00: irq_stat 0x40000008
> [ 3796.970140] ata14: SError: { CommWake 10B8B }
> [ 3796.981231] ata14.00: failed command: WRITE FPDMA QUEUED
> [ 3796.993237] ata14.00: cmd 61/00:08:00:7e:73/02:00:8e:08:00/40 tag 1 ncq dma 262144 out
>                          res 43/04:01:00:00:00/00:00:00:00:00/40 Emask 0x1 (device error)
> [ 3797.017984] ata14.00: status: { DRDY SENSE ERR }
> [ 3797.026833] ata14.00: error: { ABRT }
> [ 3797.034664] ata14.00: failed command: WRITE FPDMA QUEUED
> [ 3797.043015] ata14.00: cmd 61/00:b8:00:60:73/0a:00:8e:08:00/40 tag 23 ncq dma 1310720 out
>                          res 43/04:00:df:67:73/00:00:8e:08:00/40 Emask 0x400 (NCQ error) <F>
> [ 3797.065224] ata14.00: status: { DRDY SENSE ERR }
> [ 3797.072914] ata14.00: error: { ABRT }
> [ 3797.079598] ata14.00: failed command: WRITE FPDMA QUEUED
> [ 3797.087920] ata14.00: cmd 61/00:f8:00:6a:73/0a:00:8e:08:00/40 tag 31 ncq dma 1310720 out
>                          res 43/04:00:00:00:00/00:00:00:00:00/00 Emask 0x1 (device error)
> [ 3797.109800] ata14.00: status: { DRDY SENSE ERR }
> [ 3797.117451] ata14.00: error: { ABRT }
> 
> device error errors.
> 
> 
> Except for the I/O that caused the NCQ error, the remaining outstanding I/Os,
> regardless if they were aborted by the drive, as a side-effect of reading the
> NCQ error log (see 13.7.4 Queued Error Log (10h) in SATA 3.5a spec),
> or if they were aborted by the host (by sas_ata_device_link_abort()),
> I don't think it is correct to report these as HSM violation errors.
> 
> HSM violation errors are e.g. when you try to issue a command to a drive
> that has ATA_BUSY bit set.

We had a similar issue for hisi_sas and solved in patch 4/7: don't set 
ATA_ERR in the fis for those IO which complete with error, but abort the 
IO via sas_abort_task().

For pm80xx the IO is either rejected (actually completes with rejection) 
or is aborted via internal abort command. Maybe we can do similar for 
pm8001 as we allow the IO to complete in both cases with error. I'll check.

Thanks,
John
