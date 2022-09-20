Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522935BEA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiITPem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiITPei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:34:38 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA3B7E8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:34:36 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id n8so2215045wmr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EgvGrc7uFwyZpQCtIPUuCJ8XPMVMcqHNXt6gEKSa27U=;
        b=5NhzzOau+aY/Gi4j1iBS4BcxQ6LsD8UFKHOI/mRShejkZbEqsSG0b2IsCyq/7PahtN
         w/XSS8n07VDDu+mH0/DQBdx+AgcxOsCJRCznC3QGnkfkaWUb5LUTzy5bcdTYZacwmU+f
         YE3Zkn9xwYacbB5fVk6VoasorJXYBHTUDreRdcRxaVfepCFJPqcWVuTnrjII5o9Wadzm
         hg77T4zrInkG5265GICEFTftdjFo9qw5C1rathltBDtvUlx12ZLC2INmmQcPwvyD7qRf
         BVrryBLsIgc6TnqNnfU1entMZbPS2tWHknqV4ewBp9bC1XrsQpUb9VNLNApQHbpluvGb
         +RKw==
X-Gm-Message-State: ACrzQf1zoUBAAdlhG5dN+LloappFxMRDwHhI6mX2iXyDxBP3t45xPHyd
        3KXzkCH/kbKCAebCxYFzwqM=
X-Google-Smtp-Source: AMsMyM5zBp3CeTPiQl6qw371jYWYxxIgBnszBw7oeE0WR9CNw4Kkq6AGRvUgjRfsuVyYlz8NWKmJZA==
X-Received: by 2002:a05:600c:3d15:b0:3b4:8bd9:3905 with SMTP id bh21-20020a05600c3d1500b003b48bd93905mr2875459wmb.173.1663688074995;
        Tue, 20 Sep 2022 08:34:34 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003a5fa79007fsm139919wmc.7.2022.09.20.08.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:34:34 -0700 (PDT)
Message-ID: <325841d0-16a5-a8dd-fb06-332e7b37721e@grimberg.me>
Date:   Tue, 20 Sep 2022 18:34:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND for nvme-6.1] nvmet-tcp: Fix NULL pointer dereference
 during release
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220920131617.63540-1-pizhenwei@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920131617.63540-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/22 16:16, zhenwei pi wrote:
> nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
> and waits the inflight IO requests in nvmet_sq_destroy(). During wait
> the inflight IO requests, the callback nvmet_tcp_queue_response()
> is called from backend after IO complete, this leads a typical
> Use-After-Free issue like this:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 107f80067 P4D 107f80067 PUD 10789e067 PMD 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 1 PID: 123 Comm: kworker/1:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #15
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
>   RIP: 0010:shash_ahash_digest+0x2b/0x110
>   Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
>   RSP: 0018:ffffc9000051bdd8 EFLAGS: 00010206
>   RAX: 0000000000001000 RBX: ffff888100ab5470 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: ffff888100ab5470 RDI: ffff888100ab5420
>   RBP: ffff888100ab5420 R08: ffff8881024d08c8 R09: ffff888103e1b4b8
>   R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
>   R13: 0000000000000000 R14: ffff88813412bd4c R15: ffff8881024d0800
>   FS:  0000000000000000(0000) GS:ffff88883fa40000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000008 CR3: 0000000104b48000 CR4: 0000000000350ee0
>   Call Trace:
>    <TASK>
>    nvmet_tcp_io_work+0xa52/0xb52 [nvmet_tcp]
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
>   drivers/nvme/target/tcp.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index c07de4f4f719..70baeab6af30 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1406,14 +1406,26 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>   		if (nvmet_tcp_need_data_in(cmd))
>   			nvmet_req_uninit(&cmd->req);
> -
> -		nvmet_tcp_free_cmd_buffers(cmd);
>   	}
>   
>   	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
>   		/* failed in connect */
> -		nvmet_tcp_finish_cmd(&queue->connect);

I think that nvmet_tcp_finish_cmd is now redundant and can be removed
if we fold it to its single remaining call-site.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
