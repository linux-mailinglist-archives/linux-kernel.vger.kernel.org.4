Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB46A5B14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjB1Oth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjB1Ote (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:49:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C311B76E;
        Tue, 28 Feb 2023 06:49:13 -0800 (PST)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PR0YP0Ly4zRs4h;
        Tue, 28 Feb 2023 22:46:17 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Feb 2023 22:49:09 +0800
Message-ID: <5867eb0a-f42b-fac8-7ca7-e051a933fbaf@huawei.com>
Date:   Tue, 28 Feb 2023 22:49:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] scsi: mpt3sas: fix NULL pointer access in
 mpt3sas_transport_port_add()
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>
References: <20230225100135.2109330-1-haowenchao2@huawei.com>
Content-Language: en-US
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <20230225100135.2109330-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/25 18:01, Wenchao Hao wrote:
> port is allocated by sas_port_alloc_num() and rphy is allocated by
> sas_end_device_alloc() or sas_expander_alloc() which may return NULL,
> so we need to check the rphy to avoid possible NULL pointer access.
> 
> If sas_rphy_add() called with failure rphy is set to NULL, we would
> access the rphy in next lines which would also result NULL pointer
> access.
> 
> Fix commit 78316e9dfc24 ("scsi: mpt3sas: Fix possible resource leaks
> in mpt3sas_transport_port_add()")
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   drivers/scsi/mpt3sas/mpt3sas_transport.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> index e5ecd6ada6cd..e8a4750f6ec4 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> @@ -785,7 +785,7 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *ioc, u16 handle,
>   		goto out_fail;
>   	}
>   	port = sas_port_alloc_num(sas_node->parent_dev);
> -	if ((sas_port_add(port))) {
> +	if (!port || (sas_port_add(port))) {
>   		ioc_err(ioc, "failure at %s:%d/%s()!\n",
>   			__FILE__, __LINE__, __func__);
>   		goto out_fail;
> @@ -824,6 +824,12 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *ioc, u16 handle,
>   			    mpt3sas_port->remote_identify.sas_address;
>   	}
>   
> +	if (!rphy) {
> +		ioc_err(ioc, "failure at %s:%d/%s()!\n",
> +			__FILE__, __LINE__, __func__);
> +		goto out_delete_port;
> +	}
> +
>   	rphy->identify = mpt3sas_port->remote_identify;
>   
>   	if ((sas_rphy_add(rphy))) {
> @@ -831,6 +837,7 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *ioc, u16 handle,
>   			__FILE__, __LINE__, __func__);
>   		sas_rphy_free(rphy);
>   		rphy = NULL;
> +		goto out_delete_port;
>   	}
>   
>   	if (mpt3sas_port->remote_identify.device_type == SAS_END_DEVICE) {
> @@ -857,7 +864,10 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *ioc, u16 handle,
>   		    rphy_to_expander_device(rphy), hba_port->port_id);
>   	return mpt3sas_port;
>   
> - out_fail:
> +out_delete_port:
> +	sas_port_delete(port);
> +
> +out_fail:
>   	list_for_each_entry_safe(mpt3sas_phy, next, &mpt3sas_port->phy_list,
>   	    port_siblings)
>   		list_del(&mpt3sas_phy->port_siblings);

friendly ping...
