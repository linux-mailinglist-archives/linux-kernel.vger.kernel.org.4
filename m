Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272E35EBDB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiI0Iq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiI0IqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:46:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A1A67177;
        Tue, 27 Sep 2022 01:46:20 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McCs44kyJz689t8;
        Tue, 27 Sep 2022 16:46:16 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 27 Sep 2022 10:46:17 +0200
Received: from [10.48.156.245] (10.48.156.245) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:46:17 +0100
Message-ID: <19189c2c-91ee-f389-314f-a5133a5d3ef2@huawei.com>
Date:   Tue, 27 Sep 2022 09:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 2/8] scsi: libsas: introduce sas_find_attached_phy()
 helper
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220927032605.78103-1-yanaijie@huawei.com>
 <20220927032605.78103-3-yanaijie@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220927032605.78103-3-yanaijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.156.245]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On 27/09/2022 04:25, Jason Yan wrote:
> LLDDs are implementing their own attached phy finding code repeatedly.
> Factor it out to libsas.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Apart from nit, below:
Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   drivers/scsi/libsas/sas_expander.c | 16 ++++++++++++++++
>   include/scsi/libsas.h              |  2 ++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index fa2209080cc2..df5a64ad902f 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -2107,6 +2107,22 @@ int sas_ex_revalidate_domain(struct domain_device *port_dev)
>   	return res;
>   }
>   
> +int sas_find_attached_phy(struct expander_device *ex_dev,
> +			  struct domain_device *dev)

Maybe sas_find_attached_phy_id() is a better name

> +{
> +	struct ex_phy *phy;
> +	int phy_id;
> +
> +	for (phy_id = 0; phy_id < ex_dev->num_phys; phy_id++) {
> +		phy = &ex_dev->ex_phy[phy_id];
> +		if (sas_phy_match_dev_addr(dev, phy))
> +			return phy_id;
> +	}
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(sas_find_attached_phy);
> +
>   void sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
>   		struct sas_rphy *rphy)
>   {
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 2dbead74a2af..75faf2308eae 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -750,6 +750,8 @@ int sas_clear_task_set(struct domain_device *dev, u8 *lun);
>   int sas_lu_reset(struct domain_device *dev, u8 *lun);
>   int sas_query_task(struct sas_task *task, u16 tag);
>   int sas_abort_task(struct sas_task *task, u16 tag);
> +int sas_find_attached_phy(struct expander_device *ex_dev,
> +			  struct domain_device *dev);
>   
>   void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>   			   gfp_t gfp_flags);

