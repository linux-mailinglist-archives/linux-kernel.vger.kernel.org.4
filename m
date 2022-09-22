Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689765E643B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiIVNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiIVNvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:51:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B187EBBFE;
        Thu, 22 Sep 2022 06:51:25 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYGpB0jFDzpV1c;
        Thu, 22 Sep 2022 21:48:34 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:51:23 +0800
Subject: Re: [PATCH v4 1/7] scsi: libsas: Add sas_ata_device_link_abort()
To:     John Garry <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>
References: <1663840018-50161-1-git-send-email-john.garry@huawei.com>
 <1663840018-50161-2-git-send-email-john.garry@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <8f336809-d594-8ee5-f3bd-4393730cd01a@huawei.com>
Date:   Thu, 22 Sep 2022 21:51:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1663840018-50161-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/22 17:46, John Garry wrote:
> Similar to how AHCI handles NCQ errors in ahci_error_intr() ->
> ata_port_abort() -> ata_do_link_abort(), add an NCQ error handler for LLDDs
> to call to initiate a link abort.
> 
> This will mark all outstanding QCs as failed and kick-off EH.
> 
> Note:
> A "force reset" argument is added for drivers which require the ATA error
> handling to always reset the device.
> 
> A driver may require this feature for when SATA device per-SCSI cmnd
> resources are only released during reset for ATA EH. As such, we need an
> option to force reset to be done, regardless of what any EH autopsy
> decides.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/scsi/libsas/sas_ata.c | 12 ++++++++++++
>   include/scsi/sas_ata.h        |  6 ++++++
>   2 files changed, 18 insertions(+)

Reviewed-by: Jason Yan <yanaijie@huawei.com>
