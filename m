Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E72F5EBD94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiI0Ij1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiI0IjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:39:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E906345069;
        Tue, 27 Sep 2022 01:38:30 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McCh34XGDz687w4;
        Tue, 27 Sep 2022 16:38:27 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 10:38:28 +0200
Received: from [10.48.156.245] (10.48.156.245) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:38:27 +0100
Message-ID: <dc414029-bf05-7eba-e69f-bce0319bcb53@huawei.com>
Date:   Tue, 27 Sep 2022 09:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/8] scsi: libsas: introduce sas address comparison
 helpers
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
References: <20220927032605.78103-1-yanaijie@huawei.com>
 <20220927032605.78103-2-yanaijie@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220927032605.78103-2-yanaijie@huawei.com>
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
> Sas address comparison is widely used in libsas. However they are all
> opencoded and to avoid the line spill over 80 columns, are mostly split
> into multi-lines. Introduce some helpers to prepare some refactor.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   drivers/scsi/libsas/sas_internal.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
> index 8d0ad3abc7b5..3384429b7eb0 100644
> --- a/drivers/scsi/libsas/sas_internal.h
> +++ b/drivers/scsi/libsas/sas_internal.h
> @@ -111,6 +111,23 @@ static inline void sas_smp_host_handler(struct bsg_job *job,
>   }
>   #endif
>   
> +static inline bool sas_phy_match_dev_addr(struct domain_device *dev,
> +					 struct ex_phy *phy)
> +{
> +	return SAS_ADDR(dev->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
> +}
> +
> +static inline bool sas_phy_match_port_addr(struct asd_sas_port *port,
> +					   struct ex_phy *phy)
> +{
> +	return SAS_ADDR(port->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
> +}
> +
> +static inline bool sas_phy_addr_match(struct ex_phy *p1, struct ex_phy *p2)
> +{
> +	return  SAS_ADDR(p1->attached_sas_addr) == SAS_ADDR(p2->attached_sas_addr);
> +}
> +

note: I did think that we could use a macro as a generic matching API, like:

#define sas_phy_match_addr_common(x, ex_phy) \
	({ typeof(x) __dummy; \
	if (__builtin_types_compatible_p(typeof(__dummy), struct asd_sas_port))\
	sas_phy_match_port_addr(x, ex_phy);\
	if (__builtin_types_compatible_p(typeof(__dummy), struct domain_device))\
	sas_phy_match_dev_addr(x, ex_phy);\
	0; \
})

But I couldn't get it to work after 60 minutes of messing ... indeed, 
that latest code doesn't even compile..

Thanks,
John

>   static inline void sas_fail_probe(struct domain_device *dev, const char *func, int err)
>   {
>   	pr_warn("%s: for %s device %016llx returned %d\n",

