Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0966EC79A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjDXIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjDXIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:07:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68229E4F;
        Mon, 24 Apr 2023 01:07:13 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF3F066031C8;
        Mon, 24 Apr 2023 09:07:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682323631;
        bh=fk2JF4cqUutVFMf5ReNQ5Z96Nq9fCMd68NIqprhYP4I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MnGUwRkrnSGoo5I2HpQ1KCjotEMOiHWLBKexRH7q759Dy2mH4gixRn5awN7Gi/NZu
         dD6TwzsjthF4hzHgSj2Y3IjJ6qT7th+XS4dCDBJHzFjX26vEOdpi48GcGSGQzU7GOy
         keTScAocTMzmC7GznLLAcu+31IA5HZ+FxSkS4XFUslc1ZE6CjaHV5hdWvRWzHRcXkH
         o3KdMzNRNiKVkICdhKOX/zTVmQZcU7DR2j0gk8riSVQde61lz+TgJYY8ytdxSQ/fGf
         BDfVSjES2saNVdhBQKoiienboJ8tM0eDhKUvd4PSPmeqFdCXbRKaACkzWr6+GW598X
         JxqlYseu52+lA==
Message-ID: <da2e268a-b209-f16e-7257-336fee2aad52@collabora.com>
Date:   Mon, 24 Apr 2023 10:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/1] scsi: ufs: core: Fix &hwq->cq_lock deadlock issue
Content-Language: en-US
To:     Alice Chao <alice.chao@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230424080400.8955-1-alice.chao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/04/23 10:03, Alice Chao ha scritto:
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
> 
> Fixes: ed975065c31c ("scsi: ufs: core: mcq: Add completion support in poll")
> Reviewed-by: Can Guo <quic_cang@quicinc.com>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> Signed-off-by: Alice Chao <alice.chao@mediatek.com>


For readability purposes only - next time please put the actual description at
the beginning and the log at the end.

Anyway,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


