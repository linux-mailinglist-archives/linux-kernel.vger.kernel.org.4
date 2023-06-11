Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52B72B0B5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjFKILP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 04:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKILN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 04:11:13 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F432D70
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 01:11:10 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f80b192aecso3288095e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 01:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686471069; x=1689063069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs4T/L24Rh/WBJkxbXf4Jq3vNE1qD2C4yuQExuAw3qk=;
        b=NGKduz/kBNq5wYJ7fbCEVs/8QbPUMsBOERuDNs1ukSn9bP82+q5uHltMyo1/H+Lfez
         iHbUm5kWExKpMjL8ObkFt6bQ/HeFUq294tPieTnBN8nzz5mI4exV9/jiPm9sarYSD1hB
         aEGnKgFLSfjZ9wMpfgWNeRHWBy2ckS2H5dDFYfR9i3+Q18gdYRQB7ISIBqSkxIG5wMQN
         GqrBgY1D58Injb3feAn4oGWjlpUDVqSA5AbH/9v/zo089ltTIn8/BI4Y8ji7Vkts/Y77
         6kZAc0OZsR/+sgWzFZi5PRCXtu1u8v5OcCNZxNepFGteV7oybvSrVty0bbVq/JaglYvo
         0+Dw==
X-Gm-Message-State: AC+VfDxx7Tm8mH+Y+rxhYlkoOYF7ABN/UCV6hJepvL8sb/ymezwmzLeh
        7e5dHY8v2/VIuKs1ffJf+YA=
X-Google-Smtp-Source: ACHHUZ5fBrunO5DFyGfb4JYeNv/NPuGaBC+afHT8m5xxKngrInZAGA1n+5CiAdpA/DcIYQd11UmuWQ==
X-Received: by 2002:a05:6000:12c1:b0:309:4a41:9eb5 with SMTP id l1-20020a05600012c100b003094a419eb5mr3777192wrx.5.1686471068594;
        Sun, 11 Jun 2023 01:11:08 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b0030ae3a6be4asm9057553wrf.72.2023.06.11.01.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 01:11:08 -0700 (PDT)
Message-ID: <febff498-63e6-efe2-2f5a-9a9fa7e767c0@grimberg.me>
Date:   Sun, 11 Jun 2023 11:11:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1685350577.git.chunguang.xu@shopee.com>
 <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Hi Ming:
>>
>> Ming Lei <ming.lei@redhat.com> 于2023年6月6日周二 23:15写道：
>>>
>>> Hello Chunguang,
>>>
>>> On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
>>>> From: Chunguang Xu <chunguang.xu@shopee.com>
>>>>
>>>> We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->scan_work)
>>>> while removing ctrl. The root cause may due to the state of ctrl changed to
>>>> NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error_recovery_work()/
>>>> nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, ctrl is
>>>
>>> I didn't dig into ctrl state check in these error handler yet, but error
>>> handling is supposed to provide forward progress for any controller state.
>>>
>>> Can you explain a bit how switching to DELETING interrupts the above
>>> error handling and breaks the forward progress guarantee?
>>
>> Here we freezed ctrl, if ctrl state has changed to DELETING or
>> DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
>> freeze, so nvme_remove_namespaces() hang.
>>
>> static void nvme_tcp_error_recovery_work(struct work_struct *work)
>> {
>>          ...
>>          if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
>>                  /* state change failure is ok if we started ctrl delete */
>>                  WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
>>                               ctrl->state != NVME_CTRL_DELETING_NOIO);
>>                  return;
>>          }
>>
>>          nvme_tcp_reconnect_or_remove(ctrl);
>> }
>>
>>
>> Another path, we will check ctrl state while reconnecting, if it changes to
>> DELETING or DELETING_NIO, we will break up and lease ctrl freeze and
>> queue quiescing (through reset path), as a result Hang occurs.
>>
>> static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>> {
>>          /* If we are resetting/deleting then do nothing */
>>          if (ctrl->state != NVME_CTRL_CONNECTING) {
>>                  WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
>>                          ctrl->state == NVME_CTRL_LIVE);
>>                  return;
>>          }
>>          ...
>> }
>>
>>>> freezed and queue is quiescing . Since scan_work may continue to issue IOs to
>>>> load partition table, make it blocked, and lead to nvme_tcp_error_recovery_work()
>>>> hang in flush_work(&ctrl->scan_work).
>>>>
>>>> After analyzation, we found that there are mainly two case:
>>>> 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it issue
>>>>     new IO to load partition table.
>>>
>>> Yeah, nvme freeze usage is fragile, and I suggested to move
>>> nvme_start_freeze() from nvme_tcp_teardown_io_queues to
>>> nvme_tcp_configure_io_queues(), such as the posted change on rdma:
>>>
>>> https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0
>>
>> While drive reconnecting, I think we should freeze ctrl or quiescing queue,
>> otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
>> and the IOs may retry frequently. So I think we may better freeze ctrl
>> while entering
>> error_recovery/reconnect, but need to unfreeze it while exit.
> 
> quiescing is always done in error handling, and freeze is actually
> not a must, and it is easier to cause race by calling freeze & unfreeze
> from different contexts.
> 
> But yes, unquiesce should have been done after exiting error handling, or
> simply do it in nvme_unquiesce_io_queues().
> 
> And the following patch should cover all these hangs:
> 

Ming, are you sending a formal patchset for this?

> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3ec38e2b9173..83d3818fc60b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4692,6 +4692,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	 */
>   	nvme_mpath_clear_ctrl_paths(ctrl);
>   
> +	/* unquiesce io queues so scan work won't hang */
> +	nvme_unquiesce_io_queues(ctrl);

What guarantees that the queues won't be quiesced right after this
by the transport?

I'm still unclear why this affects the scan_work?

> +
>   	/* prevent racing with ns scanning */
>   	flush_work(&ctrl->scan_work);
>   
> @@ -4701,10 +4704,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	 * removing the namespaces' disks; fail all the queues now to avoid
>   	 * potentially having to clean up the failed sync later.
>   	 */
> -	if (ctrl->state == NVME_CTRL_DEAD) {
> +	if (ctrl->state == NVME_CTRL_DEAD)
>   		nvme_mark_namespaces_dead(ctrl);
> -		nvme_unquiesce_io_queues(ctrl);
> -	}
>   
>   	/* this is a no-op when called from the controller reset handler */
>   	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 492f319ebdf3..5d775b76baca 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2578,14 +2578,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	dead = nvme_pci_ctrl_is_dead(dev);
>   	if (dev->ctrl.state == NVME_CTRL_LIVE ||
>   	    dev->ctrl.state == NVME_CTRL_RESETTING) {
> -		if (pci_is_enabled(pdev))
> -			nvme_start_freeze(&dev->ctrl);
>   		/*
>   		 * Give the controller a chance to complete all entered requests
>   		 * if doing a safe shutdown.
>   		 */
> -		if (!dead && shutdown)
> +		if (!dead && shutdown & pci_is_enabled(pdev)) {
> +			nvme_start_freeze(&dev->ctrl);
>   			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +			nvme_unfreeze(&dev->ctrl);
> +		}
>   	}
>   
>   	nvme_quiesce_io_queues(&dev->ctrl);
> @@ -2740,6 +2741,7 @@ static void nvme_reset_work(struct work_struct *work)
>   	 * controller around but remove all namespaces.
>   	 */
>   	if (dev->online_queues > 1) {
> +		nvme_start_freeze(&dev->ctrl);
>   		nvme_unquiesce_io_queues(&dev->ctrl);
>   		nvme_wait_freeze(&dev->ctrl);
>   		nvme_pci_update_nr_queues(dev);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0eb79696fb73..354cce8853c1 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>   		goto out_cleanup_tagset;
>   
>   	if (!new) {
> +		nvme_start_freeze(&ctrl->ctrl);
>   		nvme_unquiesce_io_queues(&ctrl->ctrl);
>   		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
>   			/*
> @@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>   			 * to be safe.
>   			 */
>   			ret = -ENODEV;
> +			nvme_unfreeze(&ctrl->ctrl);
>   			goto out_wait_freeze_timed_out;
>   		}
>   		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
> @@ -975,7 +977,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
>   		bool remove)
>   {
>   	if (ctrl->ctrl.queue_count > 1) {
> -		nvme_start_freeze(&ctrl->ctrl);
>   		nvme_quiesce_io_queues(&ctrl->ctrl);
>   		nvme_sync_io_queues(&ctrl->ctrl);
>   		nvme_rdma_stop_io_queues(ctrl);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bf0230442d57..5ae08e9cb16d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1909,6 +1909,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   		goto out_cleanup_connect_q;
>   
>   	if (!new) {
> +		nvme_start_freeze(ctrl);
>   		nvme_unquiesce_io_queues(ctrl);
>   		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>   			/*
> @@ -1917,6 +1918,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   			 * to be safe.
>   			 */
>   			ret = -ENODEV;
> +			nvme_unfreeze(ctrl);
>   			goto out_wait_freeze_timed_out;
>   		}
>   		blk_mq_update_nr_hw_queues(ctrl->tagset,
> @@ -2021,7 +2023,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   	if (ctrl->queue_count <= 1)
>   		return;
>   	nvme_quiesce_admin_queue(ctrl);
> -	nvme_start_freeze(ctrl);
>   	nvme_quiesce_io_queues(ctrl);
>   	nvme_sync_io_queues(ctrl);
>   	nvme_tcp_stop_io_queues(ctrl);
> 
> 
> 
> 
> Thanks
> Ming
> 
