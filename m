Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A85E64E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiIVOOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiIVOOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:14:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF1BF3119;
        Thu, 22 Sep 2022 07:14:10 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYHG86tvcz689lY;
        Thu, 22 Sep 2022 22:09:20 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:14:08 +0200
Received: from [10.195.244.8] (10.195.244.8) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 15:14:07 +0100
Message-ID: <650e35b7-9d90-fe03-7d92-48207644536b@huawei.com>
Date:   Thu, 22 Sep 2022 15:14:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/7] scsi: libsas: introduce sas address conversion and
 comparation helpers
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <jinpu.wang@cloud.ionos.com>
References: <20220917104311.1878250-1-yanaijie@huawei.com>
 <20220917104311.1878250-2-yanaijie@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220917104311.1878250-2-yanaijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.8]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2022 11:43, Jason Yan wrote:
> Sas address conversion and comparation is widely used in libsas and
> drivers. However they are all opencoded and to avoid the line spill over
> 80 columns, are mostly split into multi-lines. Introduce some helpers to
> prepare some refactor.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   include/scsi/libsas.h | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 2dbead74a2af..382aedf31fa4 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -648,6 +648,38 @@ static inline bool sas_is_internal_abort(struct sas_task *task)
>   	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
>   }
>   
> +static inline unsigned long long ex_phy_addr(struct ex_phy *phy)

This is a public header, so I would hope that any function would have 
"sas_" prefix

> +{
> +	return SAS_ADDR(phy->attached_sas_addr);
> +}
> +
> +static inline unsigned long long dev_addr(struct domain_device *dev)
> +{
> +	return SAS_ADDR(dev->sas_addr);
> +}
> +
> +static inline unsigned long long port_addr(struct asd_sas_port *port)
> +{
> +	return SAS_ADDR(port->sas_addr);

As below, I don't really see how these simple functions help much

> +}
> +
> +static inline bool dev_and_phy_addr_same(struct domain_device *dev,
> +					 struct ex_phy *phy)
> +{
> +	return dev_addr(dev) == ex_phy_addr(phy);
> +}
> +
> +static inline bool port_and_phy_addr_same(struct asd_sas_port *port,
> +					  struct ex_phy *phy)

I'd say sas_phy_match_port_addr() could be a better name.

> +{
> +	return port_addr(port) == ex_phy_addr(phy);

I think the following is just as good:

	return SAS_ADDR(port->sas_addr) == SAS_ADDR(phy->attached_sas_addr)

port_addr() is only used once AFAICS, so the code would not be less concise

> +}
> +
> +static inline bool ex_phy_addr_same(struct ex_phy *phy1, struct ex_phy *phy2)
> +{
> +	return  ex_phy_addr(phy1) ==  ex_phy_addr(phy2);

nit: 2x double whitespace

> +}
> +
>   struct sas_domain_function_template {
>   	/* The class calls these to notify the LLDD of an event. */
>   	void (*lldd_port_formed)(struct asd_sas_phy *);

Thanks,
John
