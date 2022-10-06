Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3DA5F6BF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiJFQlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:41:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2ED1F2EB;
        Thu,  6 Oct 2022 09:41:43 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mjxxq5Jgxz6896k;
        Fri,  7 Oct 2022 00:40:15 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 6 Oct 2022 18:41:41 +0200
Received: from [10.126.169.216] (10.126.169.216) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 17:41:40 +0100
Message-ID: <bc7d74dc-5aaa-1ad3-626f-df89955b1380@huawei.com>
Date:   Thu, 6 Oct 2022 17:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
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
 <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
 <Yz4BLTPkXqyjW4a4@x1-carbon>
 <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
 <f190f19e-34b2-611c-1cf4-f8f34d12fe74@huawei.com>
 <Yz7qD+gpmI1bdw16@x1-carbon>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Yz7qD+gpmI1bdw16@x1-carbon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.169.216]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On 06/10/2022 15:45, Niklas Cassel wrote:
>> I think that it gets frozen when the internal command for read log ext times
>> out. More below about that timeout.
> ata_read_log_page() will first try to read using READ LOG DMA EXT.
> If that fails it will retry with READ LOG EXT.
> 
> Your log has this:
> [  350.257870] ata1.00: qc timeout (cmd 0x47)
> 
> So it is definitely ATA_CMD_READ_LOG_DMA_EXT that times out.
> 
> On timeout, ata_exec_internal_sg() will freeze the port:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c?h=v6.0#n1577
> 
> When ata_read_log_page() retries with the port frozen,
> READ LOG EXT will obviously fail (since the port is frozen).
> 
> Not sure why READ LOG DMA EXT would timeout for you...
> Perhaps your drive does not implement this command,
> and incorrectly reports supporting this command via
> ata_id_has_read_log_dma_ext().
> 
> Perhaps you could try boot your kernel with libata.force=nodmalog
> on the kernel command line, so that ata_read_log_page() will use
> READ LOG EXT on the first try.
> 

I tried that and unfortunately it does not appear to help.

I get this log, which proves no dmalog

[   15.757617] ata1.00: FORCE: horkage modified (nodmalog)

but then still fails with timeout:

[  123.094430] ata1.00: qc timeout (cmd 0x2f)
[  123.098637] pm80xx0:: mpi_sata_completion 2293: task null, freeing 
CCB tag 2
[  123.105711] ata1.00: Read log 0x10 page 0x00 failed, Emask 0x5
[  123.118081] ata1: failed to read log page 10h (errno=-5)

> 
> Damien, it seems that there is no use in retrying if the port
> is frozen/we got a timeout, so perhaps:
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e74ab6c0f1a0..1aa628332c8e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2035,7 +2035,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>          if (err_mask) {
>                  if (dma) {
>                          dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
> -                       goto retry;
> +                       if (err_mask != AC_ERR_TIMEOUT)
> +                               goto retry;
>                  }
> 
> or:
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e74ab6c0f1a0..2fa03b7573ac 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2035,7 +2035,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>          if (err_mask) {
>                  if (dma) {
>                          dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
> -                       goto retry;
> +                       if (!(dev->link->ap->pflags & ATA_PFLAG_FROZEN))
> +                               goto retry;
>                  }
> 
> would be in order, so that we actually print the real error, instead of a bogus
> AC_ERR_SYSTEM (returned by ata_exec_internal_sg()) when the port is frozen.
> 
>>>> ata_do_link_abort() calls ata_eh_set_pending() without activating fast drain:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-eh.c?h=v6.0#n989
>>>>
>>>> So I'm not sure why your port is frozen.
>>>> (The fast drain timer does freeze the port, but it shouldn't be enabled.)
>>>> It might be worthwhile to see who freezes the port in your case.
>>> Might come from the command timeout. John has had many problems with the
>>> pm80xx HBA in his Arm machine from a while back. Likely not a driver issue
>>> but a hw one... No-one seems to be able to recreate the same problem.
>>>
>>> We need to try the HBA on our Arm board to see what happens.
>>>
>> Yeah, it just looks to be the longstanding issue of using this card on my
>> arm64 machine - that is that I get IO timeouts quite regularly. I should
>> have mentioned that yesterday. This just seems to be a driver issue.
> Out of curiosity, which arm64 SoC is this?

HiSilicon hi1620 which contains a custom arm v8 implementation. Note 
that others have also seen the issue with this card on other arm 
implementations.

> 
> While it is very unlikely that this is your problem, but I've encountered
> an issue on an ARM board before, where the PCIe controller was incorrectly
> configured in device tree, causing the controller to miss interrrupts,
> which presented itself to the user as timeouts in the WiFi driver:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=97131f85c08e024df49480ed499aae8fb754067f

Unlikely. Indeed, when I was checking this issue some time go, I found 
that not only was there no completion interrupt but also no completion 
when I manually examine the completion ring buffer read and write pointers.

Here's where I discuss this issue earlier a bit:
https://lore.kernel.org/linux-scsi/PH0PR11MB511238B8FF7B44C375DDDFADEC519@PH0PR11MB5112.namprd11.prod.outlook.com/

Thanks,
John
