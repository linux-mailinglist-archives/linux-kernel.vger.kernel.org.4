Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FED67F418
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjA1Clj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1Clh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:41:37 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA18725291;
        Fri, 27 Jan 2023 18:41:36 -0800 (PST)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P3dvF5Yc1znVK9;
        Sat, 28 Jan 2023 10:39:37 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 10:41:34 +0800
Subject: Re: [PATCH] scsi: libsas: Add missing check for dma_map_single
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <john.garry@huawei.com>,
        <damien.lemoal@wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221228042431.24923-1-jiasheng@iscas.ac.cn>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <eaef8660-522a-50c0-0973-15d909e0fbd5@huawei.com>
Date:   Sat, 28 Jan 2023 10:41:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221228042431.24923-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

This patch looks good to me, but can you change your subject to "scsi: 
aic94xx: Add missing check for dma_map_single" since this is not in 
libsas code.

Thanks,
Jason

On 2022/12/28 12:24, Jiasheng Jiang wrote:
> Add check for dma_map_single and return error if it fails in order
> to avoid invalid dma address.
> 
> Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/scsi/aic94xx/aic94xx_task.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
> index ed119a3f6f2e..7f0208300110 100644
> --- a/drivers/scsi/aic94xx/aic94xx_task.c
> +++ b/drivers/scsi/aic94xx/aic94xx_task.c
> @@ -50,6 +50,9 @@ static int asd_map_scatterlist(struct sas_task *task,
>   		dma_addr_t dma = dma_map_single(&asd_ha->pcidev->dev, p,
>   						task->total_xfer_len,
>   						task->data_dir);
> +		if (dma_mapping_error(&asd_ha->pcidev->dev, dma))
> +			return -ENOMEM;
> +
>   		sg_arr[0].bus_addr = cpu_to_le64((u64)dma);
>   		sg_arr[0].size = cpu_to_le32(task->total_xfer_len);
>   		sg_arr[0].flags |= ASD_SG_EL_LIST_EOL;
> 
