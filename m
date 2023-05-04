Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D496F687E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjEDJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjEDJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:42:09 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9847049DC
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:42:06 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f1754e6ac2so434325e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683193325; x=1685785325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6ks9TYcNYIgolfeiqwFXS6bLsfNO1zCPee3FDqk03c=;
        b=Y1AkSVU9aZK/fcEceWVvVvGo9Xa9FJj/rDd0/o9EXrdqxWGfxmKQ5sE6+O9wpwLVBO
         uSmeOMmu6YqAcaeUfah+K0AavZTk4i88sJf88oSWoCGbOuioit4LUrLrex1gf7gp0okf
         VMy6cgCrdSMZEsgHSSWAjY/yiJ9MUmihGYnarMBYBJL4vP68/zIRUkkeVbHimXCrkVkc
         HHcBYzWXS1171OZpgPk0UUt9QuDCa7WJVRMpVRMMrESwYtqywE5sfV8EtR93DvtQhHgf
         2vAwNzv/knL0LeT5cJvwYDUoWy5+bdB2ThFWDaEdS+oLmi6H6NdSE8u9rwdI22pdvy1p
         l79Q==
X-Gm-Message-State: AC+VfDwUhngYbGa9MBW/XjhSzT9qCtDNCzvSEfJ/aoqKHOyzUyQs9FEL
        stTPvyjzl9MkK8oDbuYSq2t9fLBzBoQ=
X-Google-Smtp-Source: ACHHUZ4hwe2eChJ+OaGDYzpzq9IKg3p4ZsNY9li74nw9i7GrFdS7mUy4Lyfd1Kad05+JPHbo7MYmrw==
X-Received: by 2002:a05:600c:3b82:b0:3f1:7a4b:bf17 with SMTP id n2-20020a05600c3b8200b003f17a4bbf17mr6893987wms.1.1683193324828;
        Thu, 04 May 2023 02:42:04 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d43d1000000b003047ea78b42sm26743481wrr.43.2023.05.04.02.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 02:42:04 -0700 (PDT)
Message-ID: <d3d5dbd4-d96f-643e-b177-8f683ac8b7e2@grimberg.me>
Date:   Thu, 4 May 2023 12:42:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v3 8/9] nvme: move queue flags to middle layer
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
References: <20230504091259.29100-1-dwagner@suse.de>
 <20230504091259.29100-9-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230504091259.29100-9-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The queue flags are used to track the state of the queue (deleted, live,
> ...). Move this generic feature into the fabric middle layer.
> 
> Unfortunately, rdma uses an transport flag (TR_READY) which is not used
> in the generic part of the state machine.

This would be a transport specific flag, it is only accessed in a
transport specific function. So this would need to be in a
nvme_rdma_queue flags field.

But I don't think that we need queues array in the core nvme_ctrl.
I think that all the transports will have an admin queue and io queues.
Representing a queue in the core would be difficult IMO

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 157 +++++++++++++++++++++++++++++-------
>   drivers/nvme/host/nvme.h    |  19 ++++-
>   drivers/nvme/host/rdma.c    |  75 ++++++-----------
>   drivers/nvme/host/tcp.c     |  87 +++++++-------------
>   4 files changed, 197 insertions(+), 141 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 3d2cde17338d..5f212cb9421a 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1134,13 +1134,117 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
>   	return ERR_PTR(ret);
>   }
>   
> +static int __nvmf_alloc_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	int ret;
> +
> +	ret = ctrl->fabrics_ops->alloc_admin_queue(ctrl);
> +	if (ret)
> +		return ret;
> +
> +	set_bit(NVME_FABRICS_Q_ALLOCATED, ctrl->queues[0].flags);
> +
> +	return 0;
> +}
> +
> +static void __nvmf_free_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	if (!test_and_clear_bit(NVME_FABRICS_Q_ALLOCATED,
> +				ctrl->queues[0].flags))
> +		return;
> +
> +	ctrl->fabrics_ops->free_admin_queue(ctrl);
> +}
> +
> +static int __nvmf_start_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	int ret;
> +
> +	if (!test_bit(NVME_FABRICS_Q_ALLOCATED, ctrl->queues[0].flags))
> +		return -EINVAL;
> +
> +	ret = ctrl->fabrics_ops->start_admin_queue(ctrl);
> +	if (ret) {
> +		dev_err(ctrl->device,
> +			"failed to start admin queue: ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	set_bit(NVME_FABRICS_Q_LIVE, ctrl->queues[0].flags);
> +
> +	return 0;
> +}
> +
> +static void __nvmf_stop_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	if (!test_bit(NVME_FABRICS_Q_ALLOCATED, ctrl->queues[0].flags))
> +		return;
> +
> +	mutex_lock(ctrl->queues[0].queue_lock);
> +	if (test_and_clear_bit(NVME_FABRICS_Q_LIVE, ctrl->queues[0].flags))
> +		ctrl->fabrics_ops->stop_admin_queue(ctrl);
> +	mutex_unlock(ctrl->queues[0].queue_lock);
> +}
> +
> +static int __nvmf_alloc_io_queue(struct nvme_ctrl *ctrl, int qid)
> +{
> +	int ret;
> +
> +	ret = ctrl->fabrics_ops->alloc_io_queue(ctrl, qid);
> +	if (ret) {
> +		dev_err(ctrl->device,
> +			"failed to start I/O queue: %d ret=%d\n", qid, ret);
> +		return ret;
> +	}
> +
> +	set_bit(NVME_FABRICS_Q_ALLOCATED, ctrl->queues[qid].flags);
> +
> +	return 0;
> +}
> +
> +static void __nvmf_free_io_queue(struct nvme_ctrl *ctrl, int qid)
> +{
> +	if (!test_and_clear_bit(NVME_FABRICS_Q_ALLOCATED,
> +				ctrl->queues[qid].flags))
> +		return;
> +
> +	ctrl->fabrics_ops->free_io_queue(ctrl, qid);
> +}
> +
> +static int __nvmf_start_io_queue(struct nvme_ctrl *ctrl, int qid)
> +{
> +	int ret;
> +
> +	if (!test_bit(NVME_FABRICS_Q_ALLOCATED, ctrl->queues[0].flags))
> +		return -EINVAL;
> +
> +	ret = ctrl->fabrics_ops->start_io_queue(ctrl, qid);
> +	if (ret)
> +		return ret;
> +
> +	set_bit(NVME_FABRICS_Q_LIVE, ctrl->queues[qid].flags);
> +
> +	return 0;
> +}
> +
> +static void __nvmf_stop_io_queue(struct nvme_ctrl *ctrl, int qid)
> +{
> +	if (!test_bit(NVME_FABRICS_Q_ALLOCATED, ctrl->queues[qid].flags))
> +		return;
> +
> +	mutex_lock(ctrl->queues[qid].queue_lock);
> +	if (test_and_clear_bit(NVME_FABRICS_Q_LIVE, ctrl->queues[qid].flags))
> +		ctrl->fabrics_ops->stop_io_queue(ctrl, qid);
> +	mutex_unlock(ctrl->queues[qid].queue_lock);
> +}
> +
>   static int nvmf_start_io_queues(struct nvme_ctrl *ctrl,
>   				    int first, int last)
>   {
>   	int i, ret;
>   
>   	for (i = first; i < last; i++) {
> -		ret = ctrl->fabrics_ops->start_io_queue(ctrl, i);
> +		ret = __nvmf_start_io_queue(ctrl, i);
>   		if (ret)
>   			goto out_stop_queues;
>   	}
> @@ -1149,7 +1253,7 @@ static int nvmf_start_io_queues(struct nvme_ctrl *ctrl,
>   
>   out_stop_queues:
>   	for (i--; i >= first; i--)
> -		ctrl->fabrics_ops->stop_io_queue(ctrl, i);
> +		__nvmf_stop_io_queue(ctrl, i);
>   	return ret;
>   }
>   
> @@ -1158,7 +1262,7 @@ static void nvmf_stop_io_queues(struct nvme_ctrl *ctrl)
>   	int i;
>   
>   	for (i = 1; i < ctrl->queue_count; i++)
> -		ctrl->fabrics_ops->stop_io_queue(ctrl, i);
> +		__nvmf_stop_io_queue(ctrl, i);
>   }
>   
>   static int __nvmf_alloc_io_queues(struct nvme_ctrl *ctrl)
> @@ -1166,7 +1270,7 @@ static int __nvmf_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	int i, ret;
>   
>   	for (i = 1; i < ctrl->queue_count; i++) {
> -		ret = ctrl->fabrics_ops->alloc_io_queue(ctrl, i);
> +		ret = __nvmf_alloc_io_queue(ctrl, i);
>   		if (ret)
>   			goto out_free_queues;
>   	}
> @@ -1175,7 +1279,7 @@ static int __nvmf_alloc_io_queues(struct nvme_ctrl *ctrl)
>   
>   out_free_queues:
>   	for (i--; i >= 1; i--)
> -		ctrl->fabrics_ops->free_io_queue(ctrl, i);
> +		__nvmf_free_io_queue(ctrl, i);
>   
>   	return ret;
>   }
> @@ -1198,7 +1302,7 @@ static int nvmf_alloc_io_queues(struct nvme_ctrl *ctrl)
>   
>   	ctrl->queue_count = nr_io_queues + 1;
>   	dev_info(ctrl->device,
> -		"creating %d I/O queues.\n", nr_io_queues);
> +		 "creating %d I/O queues.\n", nr_io_queues);
>   
>   	ctrl->fabrics_ops->set_io_queues(ctrl, nr_io_queues);
>   
> @@ -1210,7 +1314,7 @@ static void nvmf_free_io_queues(struct nvme_ctrl *ctrl)
>   	int i;
>   
>   	for (i = 1; i < ctrl->queue_count; i++)
> -		ctrl->fabrics_ops->free_io_queue(ctrl, i);
> +		__nvmf_free_io_queue(ctrl, i);
>   }
>   
>   static int nvmf_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
> @@ -1279,31 +1383,31 @@ static int nvmf_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   
>   static int nvmf_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>   {
> -	int error;
> +	int ret;
>   
> -	error = ctrl->fabrics_ops->alloc_admin_queue(ctrl);
> -	if (error)
> -		return error;
> +	ret = __nvmf_alloc_admin_queue(ctrl);
> +	if (ret)
> +		return ret;
>   
>   	if (new) {
> -		error = ctrl->fabrics_ops->alloc_admin_tag_set(ctrl);
> -		if (error)
> +		ret = ctrl->fabrics_ops->alloc_admin_tag_set(ctrl);
> +		if (ret)
>   			goto out_free_admin_queue;
>   
>   	}
>   
> -	error = ctrl->fabrics_ops->start_admin_queue(ctrl);
> -	if (error)
> +	ret = __nvmf_start_admin_queue(ctrl);
> +	if (ret)
>   		goto out_remove_admin_tag_set;
>   
> -	error = nvme_enable_ctrl(ctrl);
> -	if (error)
> +	ret = nvme_enable_ctrl(ctrl);
> +	if (ret)
>   		goto out_stop_queue;
>   
>   	nvme_unquiesce_admin_queue(ctrl);
>   
> -	error = nvme_init_ctrl_finish(ctrl, false);
> -	if (error)
> +	ret = nvme_init_ctrl_finish(ctrl, false);
> +	if (ret)
>   		goto out_quiesce_queue;
>   
>   	return 0;
> @@ -1312,14 +1416,14 @@ static int nvmf_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>   	nvme_quiesce_admin_queue(ctrl);
>   	blk_sync_queue(ctrl->admin_q);
>   out_stop_queue:
> -	ctrl->fabrics_ops->stop_admin_queue(ctrl);
> +	__nvmf_stop_admin_queue(ctrl);
>   	nvme_cancel_admin_tagset(ctrl);
>   out_remove_admin_tag_set:
>   	if (new)
>   		nvme_remove_admin_tag_set(ctrl);
>   out_free_admin_queue:
> -	ctrl->fabrics_ops->free_admin_queue(ctrl);
> -	return error;
> +	__nvmf_free_admin_queue(ctrl);
> +	return ret;
>   }
>   
>   static void nvmf_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
> @@ -1332,18 +1436,17 @@ static void nvmf_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
>   
>   static void nvmf_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
>   {
> -	ctrl->fabrics_ops->stop_admin_queue(ctrl);
> +	__nvmf_stop_admin_queue(ctrl);
>   	if (remove)
>   		nvme_remove_admin_tag_set(ctrl);
> -
> -	ctrl->fabrics_ops->free_admin_queue(ctrl);
> +	__nvmf_free_admin_queue(ctrl);
>   }
>   
>   static void nvmf_teardown_admin_queue(struct nvme_ctrl *ctrl, bool remove)
>   {
>   	nvme_quiesce_admin_queue(ctrl);
>   	blk_sync_queue(ctrl->admin_q);
> -	ctrl->fabrics_ops->stop_admin_queue(ctrl);
> +	__nvmf_stop_admin_queue(ctrl);
>   	nvme_cancel_admin_tagset(ctrl);
>   	if (remove)
>   		nvme_unquiesce_admin_queue(ctrl);
> @@ -1447,7 +1550,7 @@ int nvmf_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   destroy_admin:
>   	nvme_quiesce_admin_queue(ctrl);
>   	blk_sync_queue(ctrl->admin_q);
> -	ctrl->fabrics_ops->stop_admin_queue(ctrl);
> +	__nvmf_stop_admin_queue(ctrl);
>   	nvme_cancel_admin_tagset(ctrl);
>   	nvmf_destroy_admin_queue(ctrl, new);
>   	return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index fcea2678094c..0810bc2a9e13 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -246,6 +246,18 @@ enum nvme_ctrl_flags {
>   
>   struct nvme_fabrics_ops;
>   
> +enum nvme_fabrics_queue_flags {
> +	NVME_FABRICS_Q_ALLOCATED		= 0,
> +	NVME_FABRICS_Q_TR_READY			= 1,
> +	NVME_FABRICS_Q_LIVE			= 2,
> +	NVME_FABRICS_Q_POLLING			= 3,
> +};
> +
> +struct nvme_fabrics_queue {
> +	unsigned long *flags;
> +	struct mutex *queue_lock;
> +};
> +
>   struct nvme_ctrl {
>   	bool comp_seen;
>   	enum nvme_ctrl_state state;
> @@ -253,7 +265,6 @@ struct nvme_ctrl {
>   	spinlock_t lock;
>   	struct mutex scan_lock;
>   	const struct nvme_ctrl_ops *ops;
> -	const struct nvme_fabrics_ops *fabrics_ops;
>   	struct request_queue *admin_q;
>   	struct request_queue *connect_q;
>   	struct request_queue *fabrics_q;
> @@ -342,8 +353,10 @@ struct nvme_ctrl {
>   	struct work_struct ana_work;
>   #endif
>   
> -	struct work_struct	err_work;
> -	struct delayed_work	connect_work;
> +	const struct nvme_fabrics_ops *fabrics_ops;
> +	struct nvme_fabrics_queue *queues;
> +	struct work_struct err_work;
> +	struct delayed_work connect_work;
>   
>   #ifdef CONFIG_NVME_AUTH
>   	struct work_struct dhchap_auth_work;
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 1fde65e8c2b5..023316fdc2c6 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -3,6 +3,7 @@
>    * NVMe over Fabrics RDMA host code.
>    * Copyright (c) 2015-2016 HGST, a Western Digital Company.
>    */
> +#include "linux/gfp_types.h"
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   #include <linux/module.h>
>   #include <linux/init.h>
> @@ -76,12 +77,6 @@ struct nvme_rdma_request {
>   	bool			use_sig_mr;
>   };
>   
> -enum nvme_rdma_queue_flags {
> -	NVME_RDMA_Q_ALLOCATED		= 0,
> -	NVME_RDMA_Q_LIVE		= 1,
> -	NVME_RDMA_Q_TR_READY		= 2,
> -};
> -
>   struct nvme_rdma_queue {
>   	struct nvme_rdma_qe	*rsp_ring;
>   	int			queue_size;
> @@ -425,7 +420,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
>   	struct nvme_rdma_device *dev;
>   	struct ib_device *ibdev;
>   
> -	if (!test_and_clear_bit(NVME_RDMA_Q_TR_READY, &queue->flags))
> +	if (!test_and_clear_bit(NVME_FABRICS_Q_TR_READY, &queue->flags))
>   		return;
>   
>   	dev = queue->device;
> @@ -550,7 +545,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>   		}
>   	}
>   
> -	set_bit(NVME_RDMA_Q_TR_READY, &queue->flags);
> +	set_bit(NVME_FABRICS_Q_TR_READY, &queue->flags);
>   
>   	return 0;
>   
> @@ -572,12 +567,17 @@ static int __nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
>   				   struct nvme_rdma_queue *queue)
>   {
>   	struct sockaddr *src_addr = NULL;
> +	struct nvme_fabrics_queue *fqueue;
>   	int ret;
>   
>   	mutex_init(&queue->queue_lock);
>   	queue->ctrl = ctrl;
>   	init_completion(&queue->cm_done);
>   
> +	fqueue = &ctrl->ctrl.queues[nvme_rdma_queue_id(queue)];
> +	fqueue->flags = &queue->flags;
> +	fqueue->queue_lock = &queue->queue_lock;
> +
>   	queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
>   			RDMA_PS_TCP, IB_QPT_RC);
>   	if (IS_ERR(queue->cm_id)) {
> @@ -607,8 +607,6 @@ static int __nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
>   		goto out_destroy_cm_id;
>   	}
>   
> -	set_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags);
> -
>   	return 0;
>   
>   out_destroy_cm_id:
> @@ -622,9 +620,6 @@ static int __nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
>   static void __nvme_rdma_free_queue(struct nvme_rdma_ctrl *ctrl,
>   				   struct nvme_rdma_queue *queue)
>   {
> -	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
> -		return;
> -
>   	rdma_destroy_id(queue->cm_id);
>   	nvme_rdma_destroy_queue_ib(queue);
>   	mutex_destroy(&queue->queue_lock);
> @@ -718,49 +713,18 @@ static void nvme_rdma_free_io_queue(struct nvme_ctrl *nctrl, int qid)
>   
>   static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
>   {
> -	mutex_lock(&queue->queue_lock);
> -	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags)) {
> -		rdma_disconnect(queue->cm_id);
> -		ib_drain_qp(queue->qp);
> -	}
> -	mutex_unlock(&queue->queue_lock);
> +	rdma_disconnect(queue->cm_id);
> +	ib_drain_qp(queue->qp);
>   }
>   
> -static int nvme_rdma_start_admin_queue(struct nvme_ctrl *nctrl)
> +static int nvme_rdma_start_admin_queue(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
> -	struct nvme_rdma_queue *queue = &ctrl->queues[0];
> -	int ret;
> -
> -	ret = nvmf_connect_admin_queue(nctrl);
> -
> -	if (!ret) {
> -		set_bit(NVME_RDMA_Q_LIVE, &queue->flags);
> -	} else {
> -		if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
> -			__nvme_rdma_stop_queue(queue);
> -		dev_info(ctrl->ctrl.device,
> -			"failed to connect queue: %d ret=%d\n", 0, ret);
> -	}
> -	return ret;
> +	return nvmf_connect_admin_queue(ctrl);
>   }
>   
> -static int nvme_rdma_start_io_queue(struct nvme_ctrl *nctrl, int idx)
> +static int nvme_rdma_start_io_queue(struct nvme_ctrl *ctrl, int idx)
>   {
> -	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
> -	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
> -	int ret;
> -
> -	ret = nvmf_connect_io_queue(nctrl, idx);
> -	if (!ret) {
> -		set_bit(NVME_RDMA_Q_LIVE, &queue->flags);
> -	} else {
> -		if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
> -			__nvme_rdma_stop_queue(queue);
> -		dev_info(ctrl->ctrl.device,
> -			"failed to connect queue: %d ret=%d\n", idx, ret);
> -	}
> -	return ret;
> +	return nvmf_connect_io_queue(ctrl, idx);
>   }
>   
>   static void nvme_rdma_stop_admin_queue(struct nvme_ctrl *nctrl)
> @@ -1715,7 +1679,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	struct nvme_rdma_qe *sqe = &req->sqe;
>   	struct nvme_command *c = nvme_req(rq)->cmd;
>   	struct ib_device *dev;
> -	bool queue_ready = test_bit(NVME_RDMA_Q_LIVE, &queue->flags);
> +	bool queue_ready = test_bit(NVME_FABRICS_Q_LIVE, &queue->flags);
>   	blk_status_t ret;
>   	int err;
>   
> @@ -2027,6 +1991,12 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   	if (!ctrl->queues)
>   		goto out_free_ctrl;
>   
> +	ctrl->ctrl.queues = kcalloc(ctrl->ctrl.queue_count,
> +				    sizeof(*ctrl->ctrl.queues),
> +				    GFP_KERNEL);
> +	if (!ctrl->ctrl.queues)
> +		goto out_free_ctrl_queues;
> +
>   	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
>   				0 /* no quirks, we're perfect! */);
>   	if (ret)
> @@ -2054,7 +2024,10 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   	if (ret > 0)
>   		ret = -EIO;
>   	return ERR_PTR(ret);
> +	kfree(ctrl->queues);
>   out_kfree_queues:
> +	kfree(ctrl->ctrl.queues);
> +out_free_ctrl_queues:
>   	kfree(ctrl->queues);
>   out_free_ctrl:
>   	kfree(ctrl);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 32c4346b7322..dfdf35b32adc 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -100,12 +100,6 @@ struct nvme_tcp_request {
>   	enum nvme_tcp_send_state state;
>   };
>   
> -enum nvme_tcp_queue_flags {
> -	NVME_TCP_Q_ALLOCATED	= 0,
> -	NVME_TCP_Q_LIVE		= 1,
> -	NVME_TCP_Q_POLLING	= 2,
> -};
> -
>   enum nvme_tcp_recv_state {
>   	NVME_TCP_RECV_PDU = 0,
>   	NVME_TCP_RECV_DATA,
> @@ -903,7 +897,7 @@ static void nvme_tcp_data_ready(struct sock *sk)
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
>   	if (likely(queue && queue->rd_enabled) &&
> -	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
> +	    !test_bit(NVME_FABRICS_Q_POLLING, &queue->flags))
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
> @@ -1454,6 +1448,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   static int __nvme_tcp_alloc_queue(struct nvme_tcp_ctrl *ctrl,
>   				 struct nvme_tcp_queue *queue)
>   {
> +	struct nvme_fabrics_queue *fqueue;
>   	int ret, rcv_pdu_size;
>   
>   	mutex_init(&queue->queue_lock);
> @@ -1463,6 +1458,10 @@ static int __nvme_tcp_alloc_queue(struct nvme_tcp_ctrl *ctrl,
>   	mutex_init(&queue->send_mutex);
>   	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
>   
> +	fqueue = &ctrl->ctrl.queues[nvme_tcp_queue_id(queue)];
> +	fqueue->flags = &queue->flags;
> +	fqueue->queue_lock = &queue->queue_lock;
> +
>   	ret = sock_create(ctrl->addr.ss_family, SOCK_STREAM,
>   			IPPROTO_TCP, &queue->sock);
>   	if (ret) {
> @@ -1567,7 +1566,6 @@ static int __nvme_tcp_alloc_queue(struct nvme_tcp_ctrl *ctrl,
>   		goto err_init_connect;
>   
>   	queue->rd_enabled = true;
> -	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
>   	nvme_tcp_init_recv_ctx(queue);
>   
>   	write_lock_bh(&queue->sock->sk->sk_callback_lock);
> @@ -1607,9 +1605,6 @@ static void __nvme_tcp_free_queue(struct nvme_tcp_ctrl *ctrl,
>   	struct page *page;
>   	unsigned int noreclaim_flag;
>   
> -	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> -		return;
> -
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvme_tcp_free_crypto(queue);
>   
> @@ -1699,40 +1694,14 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	cancel_work_sync(&queue->io_work);
>   }
>   
> -static int nvme_tcp_start_admin_queue(struct nvme_ctrl *nctrl)
> +static int nvme_tcp_start_admin_queue(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> -	struct nvme_tcp_queue *queue = &ctrl->queues[0];
> -	int ret;
> -
> -	ret = nvmf_connect_admin_queue(nctrl);
> -	if (!ret) {
> -		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
> -	} else {
> -		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> -			__nvme_tcp_stop_queue(queue);
> -		dev_err(nctrl->device,
> -			"failed to connect queue: %d ret=%d\n", 0, ret);
> -	}
> -	return ret;
> +	return nvmf_connect_admin_queue(ctrl);
>   }
>   
> -static int nvme_tcp_start_io_queue(struct nvme_ctrl *nctrl, int qid)
> +static int nvme_tcp_start_io_queue(struct nvme_ctrl *ctrl, int qid)
>   {
> -	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> -	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> -	int ret;
> -
> -	ret = nvmf_connect_io_queue(nctrl, qid);
> -	if (!ret) {
> -		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
> -	} else {
> -		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> -			__nvme_tcp_stop_queue(queue);
> -		dev_err(nctrl->device,
> -			"failed to connect queue: %d ret=%d\n", qid, ret);
> -	}
> -	return ret;
> +	return nvmf_connect_io_queue(ctrl, qid);
>   }
>   
>   static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
> @@ -1740,13 +1709,7 @@ static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[0];
>   
> -	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> -		return;
> -
> -	mutex_lock(&queue->queue_lock);
> -	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
> -		__nvme_tcp_stop_queue(queue);
> -	mutex_unlock(&queue->queue_lock);
> +	__nvme_tcp_stop_queue(queue);
>   }
>   
>   static void nvme_tcp_stop_io_queue(struct nvme_ctrl *nctrl, int qid)
> @@ -1754,13 +1717,7 @@ static void nvme_tcp_stop_io_queue(struct nvme_ctrl *nctrl, int qid)
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>   
> -	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> -		return;
> -
> -	mutex_lock(&queue->queue_lock);
> -	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
> -		__nvme_tcp_stop_queue(queue);
> -	mutex_unlock(&queue->queue_lock);
> +	__nvme_tcp_stop_queue(queue);
>   }
>   
>   static int nvme_tcp_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
> @@ -1843,6 +1800,7 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
>   
>   	nvmf_free_options(nctrl->opts);
>   free_ctrl:
> +	kfree(ctrl->ctrl.queues);
>   	kfree(ctrl->queues);
>   	kfree(ctrl);
>   }
> @@ -2043,7 +2001,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	struct nvme_tcp_queue *queue = hctx->driver_data;
>   	struct request *rq = bd->rq;
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> -	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
> +	bool queue_ready = test_bit(NVME_FABRICS_Q_LIVE, &queue->flags);
>   	blk_status_t ret;
>   
>   	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
> @@ -2108,14 +2066,14 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   	struct nvme_tcp_queue *queue = hctx->driver_data;
>   	struct sock *sk = queue->sock->sk;
>   
> -	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> +	if (!test_bit(NVME_FABRICS_Q_LIVE, &queue->flags))
>   		return 0;
>   
> -	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
> +	set_bit(NVME_FABRICS_Q_POLLING, &queue->flags);
>   	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
>   		sk_busy_loop(sk, true);
>   	nvme_tcp_try_recv(queue);
> -	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
> +	clear_bit(NVME_FABRICS_Q_POLLING, &queue->flags);
>   	return queue->nr_cqe;
>   }
>   
> @@ -2129,7 +2087,7 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>   
>   	mutex_lock(&queue->queue_lock);
>   
> -	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> +	if (!test_bit(NVME_CTRL_LIVE, &queue->flags))
>   		goto done;
>   	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
>   	if (ret > 0) {
> @@ -2282,6 +2240,13 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   		ret = -ENOMEM;
>   		goto out_free_ctrl;
>   	}
> +	ctrl->ctrl.queues = kcalloc(ctrl->ctrl.queue_count,
> +				    sizeof(*ctrl->ctrl.queues),
> +				    GFP_KERNEL);
> +	if (!ctrl->ctrl.queues) {
> +		ret = -ENOMEM;
> +		goto out_free_ctrl_queue;
> +	}
>   
>   	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
>   	if (ret)
> @@ -2313,6 +2278,8 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   		ret = -EIO;
>   	return ERR_PTR(ret);
>   out_kfree_queues:
> +	kfree(ctrl->ctrl.queues);
> +out_free_ctrl_queue:
>   	kfree(ctrl->queues);
>   out_free_ctrl:
>   	kfree(ctrl);
