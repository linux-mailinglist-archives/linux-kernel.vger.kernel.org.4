Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557BB5EDD88
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiI1NOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI1NOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:14:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A429C222;
        Wed, 28 Sep 2022 06:14:02 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mcxhv5hnTzHptq;
        Wed, 28 Sep 2022 21:11:43 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 21:14:00 +0800
Subject: Re: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
To:     John Garry <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-2-git-send-email-john.garry@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <e47fe754-c8a7-99ff-88f2-8b09d98306ab@huawei.com>
Date:   Wed, 28 Sep 2022 21:13:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1664368034-114991-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/28 20:27, John Garry wrote:
> blk-mq already provides a unique tag per request. Some libsas LLDDs - like
> hisi_sas - already use this tag as the unique per-IO HW tag.
> 
> Add a common function to provide the request associated with a sas_task
> for all libsas LLDDs.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   include/scsi/libsas.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index f86b56bf7833..bc51756a3317 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -644,6 +644,28 @@ static inline bool sas_is_internal_abort(struct sas_task *task)
>   	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
>   }
>   
> +static inline struct request *sas_task_find_rq(struct sas_task *task)
> +{
> +	struct scsi_cmnd *scmd;
> +
> +	if (!task || !task->uldd_task)
> +		return NULL;
> +
> +	if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
> +		struct ata_queued_cmd *qc;
> +
> +		qc = task->uldd_task;
> +		scmd = qc->scsicmd;

Can we remove that local qc?

and
	scmd = ((struct ata_queued_cmd *)task->uldd_task)->scsicmd;

Thanks,
Jason

> +	} else {
> +		scmd = task->uldd_task;
> +	}
> +
> +	if (!scmd)
> +		return NULL;
> +
> +	return scsi_cmd_to_rq(scmd);
> +}
> +
>   struct sas_domain_function_template {
>   	/* The class calls these to notify the LLDD of an event. */
>   	void (*lldd_port_formed)(struct asd_sas_phy *);
> 
