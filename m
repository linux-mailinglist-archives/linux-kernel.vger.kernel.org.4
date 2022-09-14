Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2702D5B868A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiINKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiINKop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:44:45 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD093885
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:44:44 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id t14so25025071wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QOL+oMNg0eM0tTAE71ld0QPIqQDtfEjtKFkdkyTQhU8=;
        b=OoiCrkMGjYeDHP/qDM8AwxS5RFsCVf3V3ShgtEHAgjQw0008iI+nyzhACN4zsaVc+V
         2uFupAHCgWC26r5ZHoCIwH3uI7cZRtE96lKXAOEW/H42vL+Yg8E+mS0l1vJAT/kK/D0R
         EASi4kH/nO14fdyF6M87HIczvIrgqnZopxK2Qa/O6CDZBZqmMLoVr0mG9iKCutImq9Z2
         FnKpu/FslGbNpoX9sc22LR8pdUO2LZFSpMbYQf2w6ge2HP+Ypf6F9KANoU4XHom3+ko3
         RwfioKETZAkB0E16a+w9f2l9fSwnanCAVldhu/6gEu81n5T40MzVrjXNyErGdxZV5lSO
         Utjw==
X-Gm-Message-State: ACgBeo0/5CzbAjZ7KP2xaVWabONC7KfQmIWOBYMM12G9ipnZ+lpxQZQv
        7O33kAplFsKQYbAakNZxYA8E7BRb50E=
X-Google-Smtp-Source: AA6agR5hggG1w1ie4m5/qGfpPM6I176LS3LXTZ7FXZkrQh7NWVRUy5TQGGY3eCREse2cj5hP0ldGiA==
X-Received: by 2002:a05:6000:2c5:b0:225:618e:1708 with SMTP id o5-20020a05600002c500b00225618e1708mr22022909wry.510.1663152282539;
        Wed, 14 Sep 2022 03:44:42 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003b47ff307e1sm11793345wmg.31.2022.09.14.03.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 03:44:42 -0700 (PDT)
Message-ID: <b3362f45-fcb5-4ace-16e5-97a77ca3ca10@grimberg.me>
Date:   Wed, 14 Sep 2022 13:44:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] nvmet-tcp: Fix NULL pointer dereference during
 release
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc:     kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, fmdefrancesco@gmail.com
References: <20220913014253.931724-1-pizhenwei@bytedance.com>
 <20220913014253.931724-2-pizhenwei@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220913014253.931724-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/22 04:42, zhenwei pi wrote:
> nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
> and waits the inflight IO requests in nvmet_sq_destroy(). During wait
> the inflight IO requests, the callback nvmet_tcp_queue_response()
> is called from backend after IO complete, this leads a typical
> Use-After-Free issue like this:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #12
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
>   RIP: 0010:shash_ahash_digest+0x2b/0x110
>   Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
>   RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
>   RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
>   RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
>   R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
>   R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
>   FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
>   Call Trace:
>    <TASK>
>    nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
>    ? __switch_to+0x106/0x420
>    process_one_work+0x1ae/0x380
>    ? process_one_work+0x380/0x380
>    worker_thread+0x30/0x360
>    ? process_one_work+0x380/0x380
>    kthread+0xe6/0x110
>    ? kthread_complete_and_exit+0x20/0x20
>    ret_from_fork+0x1f/0x30
> 
> Suggested by Sagi, separate nvmet_tcp_uninit_data_in_cmds() into two
> steps:
>    uninit data in cmds                  <- new step 1
>    nvmet_sq_destroy();
>    cancel_work_sync(&queue->io_work);
>    free CMD buffers                     <- new step 2
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/target/tcp.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index a3694a32f6d5..3ac9750b41ad 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1423,14 +1423,29 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>   		if (nvmet_tcp_need_data_in(cmd))
>   			nvmet_req_uninit(&cmd->req);
> +	}
> +
> +	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
> +		/* failed in connect */
> +		nvmet_req_uninit(&queue->connect.req);
> +	}
> +}
>   
> +static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
> +{
> +	struct nvmet_tcp_cmd *cmd = queue->cmds;
> +	int i;
> +
> +	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
> +		if (!nvmet_tcp_need_data_in(cmd))
> +			continue;
>   		nvmet_tcp_unmap_pdu_iovec(cmd);

This will cause a merge conflict, because nvme-6.1
nvmet_tcp_unmap_pdu_iovec does no longer exist.

Other than that, looks fine to me,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
