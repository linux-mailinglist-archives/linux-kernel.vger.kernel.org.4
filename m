Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098645F62DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJFIhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJFIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:37:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9EC95AD5;
        Thu,  6 Oct 2022 01:37:09 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MjlBk1khBz6H73T;
        Thu,  6 Oct 2022 16:35:42 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 6 Oct 2022 10:37:07 +0200
Received: from [10.126.169.169] (10.126.169.169) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 09:37:06 +0100
Message-ID: <9cc48b3f-5dbe-665e-d125-dffd53e930fb@huawei.com>
Date:   Thu, 6 Oct 2022 09:37:06 +0100
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
        Linuxarm <linuxarm@huawei.com>,
        yangxingui <yangxingui@huawei.com>,
        yanaijie <yanaijie@huawei.com>
References: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
 <YzwvpUUftX6Ziurt@x1-carbon>
 <cfa52b91-db81-a179-76c2-8a61266c099d@huawei.com>
 <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
 <Yz33FGwd3YvQUAqT@x1-carbon>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Yz33FGwd3YvQUAqT@x1-carbon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.169.169]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2022 22:28, Niklas Cassel wrote:
> Do you know why it fails to read the log?
> Can you read the NCQ Command Error log using ATA16 passthrough commands?
> 
> sudo sg_sat_read_gplog -d --log=0x10 /dev/sdc
> 
> The first byte is the last NCQ tag (in hex) that failed.

Please see other reply.

> 
> 
> I tried your patch, and it looks good:

Thanks, good to know.

> 
> [ 6656.228131] ata5.00: exception Emask 0x0 SAct 0x460000 SErr 0x0 action 0x0
> [ 6656.252759] ata5.00: failed command: WRITE FPDMA QUEUED
> [ 6656.271554] ata5.00: cmd 61/00:00:00:d8:8a/04:00:ce:03:00/40 tag 17 ncq dma 524288 out
>                          res 41/04:00:00:00:00/00:00:00:00:00/00 Emask 0x1 (device error)
> [ 6656.309308] ata5.00: status: { DRDY ERR }
> [ 6656.316403] ata5.00: error: { ABRT }
> [ 6656.322300] ata5.00: failed command: WRITE FPDMA QUEUED
> [ 6656.330871] ata5.00: cmd 61/00:00:00:dc:8a/04:00:ce:03:00/40 tag 18 ncq dma 524288 out
>                          res 41/04:00:00:00:00/00:00:00:00:00/00 Emask 0x1 (device error)
> [ 6656.356295] ata5.00: status: { DRDY ERR }
> [ 6656.362931] ata5.00: error: { ABRT }
> [ 6656.368897] ata5.00: failed command: WRITE FPDMA QUEUED
> [ 6656.377471] ata5.00: cmd 61/00:00:00:d4:8a/04:00:ce:03:00/40 tag 22 ncq dma 524288 out
>                          res 43/04:00:ff:d7:8a/00:00:ce:03:00/40 Emask 0x400 (NCQ error) <F>
> [ 6656.403149] ata5.00: status: { DRDY SENSE ERR }
> [ 6656.410624] ata5.00: error: { ABRT }
> 
> However, since this is a change from the existing behavior of this driver,
> this could go as a separate patch, and does not need to delay this series.
> 
> 

ok, but I am not sure about this series for 6.1 since it's now, so I 
will just wait.

> 
> I also think that we should do a similar patch for sas_ata_task_done():
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index d35c9296f738..648d0693ceee 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -140,7 +140,7 @@ static void sas_ata_task_done(struct sas_task *task)
>                          }
>   
>                          dev->sata_dev.fis[3] = 0x04; /* status err */
> -                       dev->sata_dev.fis[2] = ATA_ERR;
> +                       dev->sata_dev.fis[2] = ATA_ERR | ATA_DRDY;
>                  }
>          }
> 
> To avoid all SAS errors from being reported as HSM errors.

Yeah, I tend to agree. I can put that change in another patch.

Thanks,
John
