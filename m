Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4646ED2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDXQtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjDXQtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:49:18 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C06580;
        Mon, 24 Apr 2023 09:49:17 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so3488503a91.0;
        Mon, 24 Apr 2023 09:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354957; x=1684946957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQPzlQXVK7yiO98rLUpsr4qSlOZNSd2wUC44NfOzC5o=;
        b=mD2yZUgU4vFwM/2a2hOoJlMnZL2RXtayE//pPGgUFJwp31MTQCELpisKaabXt49X2m
         JMJ+DrwkOPMTQOey2CO8+OYMl9zCJd1QWLOq6++Cb8dQ581ZZJ83YuSICUa5UnIpmNrE
         lTdBzRIBX8Fgd2QgETunPh3YskW68tQm7NUav3Xhu0KChqm5/7FRzEoFNgrv9f+7/3aN
         ITBDMjVITA5fps6CeOMio+AZzgEvl3Hvj3soR4twOspa55J+aAHqERthPfG4aaLat3Ry
         mpRszr5Ex0XRq3JczpYl5xusKSWXfZn5w385SC2SVstfXEMMLMBGb8IhCiYk/cX370+j
         o6og==
X-Gm-Message-State: AAQBX9euutcyErEqt5vkTP+PwHMnFH3CUUMAfHuJVv2WCnXQdwDdVv3v
        vPHrU1pERrG7Qj7jl1HIhsw=
X-Google-Smtp-Source: AKy350buLU0OlbzX25JOXcAqUZe69CK7FS254G2Wob6KCJ3eWiKz4m8UCiG1J0FN5j8wYX04LKmdtg==
X-Received: by 2002:a17:90a:ca81:b0:247:a272:71be with SMTP id y1-20020a17090aca8100b00247a27271bemr14748647pjt.46.1682354957075;
        Mon, 24 Apr 2023 09:49:17 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1f14:a83c:1e8:6ae2? ([2620:15c:211:201:1f14:a83c:1e8:6ae2])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024677263e36sm6528524pjq.43.2023.04.24.09.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 09:49:16 -0700 (PDT)
Message-ID: <8948f2b1-e11f-8f84-62e7-e5b13be587b4@acm.org>
Date:   Mon, 24 Apr 2023 09:49:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/1] scsi: ufs: core: Fix &hwq->cq_lock deadlock issue
Content-Language: en-US
To:     Alice Chao <alice.chao@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        cc.chou@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com, tun-yu.yu@mediatek.com,
        eddie.huang@mediatek.com, wsd_upstream@mediatek.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230424080400.8955-1-alice.chao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230424080400.8955-1-alice.chao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 01:03, Alice Chao wrote:
> [name:lockdep&]WARNING: inconsistent lock state
> [name:lockdep&]--------------------------------
> [name:lockdep&]inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [name:lockdep&]kworker/u16:4/260 [HC0[0]:SC0[0]:HE1:SE1] takes:
>    ffffff8028444600 (&hwq->cq_lock){?.-.}-{2:2}, at:
> ufshcd_mcq_poll_cqe_lock+0x30/0xe0
> [name:lockdep&]{IN-HARDIRQ-W} state was registered at:
>    lock_acquire+0x17c/0x33c
>    _raw_spin_lock+0x5c/0x7c
>    ufshcd_mcq_poll_cqe_lock+0x30/0xe0
>    ufs_mtk_mcq_intr+0x60/0x1bc [ufs_mediatek_mod]
>    __handle_irq_event_percpu+0x140/0x3ec
>    handle_irq_event+0x50/0xd8
>    handle_fasteoi_irq+0x148/0x2b0
>    generic_handle_domain_irq+0x4c/0x6c
>    gic_handle_irq+0x58/0x134
>    call_on_irq_stack+0x40/0x74
>    do_interrupt_handler+0x84/0xe4
>    el1_interrupt+0x3c/0x78
> <snip>
> 
> Possible unsafe locking scenario:
>         CPU0
>         ----
>    lock(&hwq->cq_lock);
>    <Interrupt>
>      lock(&hwq->cq_lock);
>    *** DEADLOCK ***
> 2 locks held by kworker/u16:4/260:
> 
> [name:lockdep&]
>   stack backtrace:
> CPU: 7 PID: 260 Comm: kworker/u16:4 Tainted: G S      W  OE
> 6.1.17-mainline-android14-2-g277223301adb #1
> Workqueue: ufs_eh_wq_0 ufshcd_err_handler
> 
>   Call trace:
>    dump_backtrace+0x10c/0x160
>    show_stack+0x20/0x30
>    dump_stack_lvl+0x98/0xd8
>    dump_stack+0x20/0x60
>    print_usage_bug+0x584/0x76c
>    mark_lock_irq+0x488/0x510
>    mark_lock+0x1ec/0x25c
>    __lock_acquire+0x4d8/0xffc
>    lock_acquire+0x17c/0x33c
>    _raw_spin_lock+0x5c/0x7c
>    ufshcd_mcq_poll_cqe_lock+0x30/0xe0
>    ufshcd_poll+0x68/0x1b0
>    ufshcd_transfer_req_compl+0x9c/0xc8
>    ufshcd_err_handler+0x3bc/0xea0
>    process_one_work+0x2f4/0x7e8
>    worker_thread+0x234/0x450
>    kthread+0x110/0x134
>    ret_from_fork+0x10/0x20
> 
> ufs_mtk_mcq_intr() could refer to
> https://lore.kernel.org/all/20230328103423.10970-3-powen.kao@mediatek.com/
> 
> When ufshcd_err_handler() is executed, CQ event interrupt can enter
> waiting for the same lock. It could happened in upstream code path
> ufshcd_handle_mcq_cq_events() and also in ufs_mtk_mcq_intr(). This
> warning message will be generated when &hwq->cq_lock is used in IRQ
> context with IRQ enabled. Use ufshcd_mcq_poll_cqe_lock() with
> spin_lock_irqsave instead of spin_lock to resolve the deadlock issue.

For future patches, please make sure that the patch description occurs 
before the call traces. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
