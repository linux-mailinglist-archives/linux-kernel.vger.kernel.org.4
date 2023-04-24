Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756716EC36B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 03:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDXBgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 21:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXBgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 21:36:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D8A10CE;
        Sun, 23 Apr 2023 18:36:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8dc00ade2so36639281fa.0;
        Sun, 23 Apr 2023 18:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682300174; x=1684892174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6aqoC9dPFtpf3SM23IBF/5iiAH7dEsrwMZeoRqWySc=;
        b=h7dURazMP4F2Nh70Sh6/I/wMOfK4H5Aof0Bwsai9k0WhGXGYdh9RCDrNnje1Sy8CyL
         epfkNZFljEa38NoF6otxhl+GYI+NZHNU6bYPK+LH8v5zDUFdPsXb9cQkBsPllruXBua/
         e0AA9APX4lTV4wZdyO7WkJHv0OjE3Xmp2BtkKOU5zrOJz7aEK7fT1+TBDzrLW3hE0rIT
         PKgz8/BS+geIHyLYIFH0iiCgX6FnIZycUhlS2i57CpAsKshTho5YF56T2hT17T7KFfI1
         OF+hwg7D4L/jZXciE44vUQ+nrbsYe0t/SgN1l/bBM3MQPUqgRpQPo+FYdYtdz+WvVBAa
         iC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682300174; x=1684892174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6aqoC9dPFtpf3SM23IBF/5iiAH7dEsrwMZeoRqWySc=;
        b=O90iezcdbjLGvB0KY0U6yQ6/TgBuOoKXdoq+9Fo3xh+DPR9DOq1KrsuhPVPznwovPM
         Y2vYQSrmXWSJwEcTfiQyybYRlcoLIWjRkoxVbKdjgMMtOlJrgrH+gUrnHLCmTng/1uSY
         RBsFgqH4aI5ml2jTCpYK7jqnLOk2BeEfxCT3L60lgssVjgDeZJ8pYN7Wpr6/r2l3jCdX
         P0N2X/c5f6jvcRxudZNXAUbp7JpxodOK+JlchdRd8gQaMCufnODgIzsx/cNMTHRkdDlo
         LJEACTKkeYcNRdOKZQ4KvGg1tKAqkss32emRk2pf998eUS1jAABA9yGa9wDGPbuIuO7F
         W6Wg==
X-Gm-Message-State: AAQBX9dMrpVcfRc9DvJ07/x67jHFesfUZ0VkDdUhA6ngyzOdya70gICt
        Q+s9EWpJ8Tycqnyw5elH3mRSvPgPRLUEjNoPwg==
X-Google-Smtp-Source: AKy350bgD/CUSWWCOBwCf63h+PjnZokihstmsZMZBSNM1B/NhgpICayXhu+ukCYsQYF0/iBspyFHjJHMi/ggotOwTUI=
X-Received: by 2002:a2e:8187:0:b0:2a8:bb4b:fd94 with SMTP id
 e7-20020a2e8187000000b002a8bb4bfd94mr2460334ljg.0.1682300174012; Sun, 23 Apr
 2023 18:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230421075636.24946-1-alice.chao@mediatek.com>
In-Reply-To: <20230421075636.24946-1-alice.chao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Mon, 24 Apr 2023 09:36:02 +0800
Message-ID: <CAGaU9a-zQTz8hTxkLk-OT6QXqbkMQqYN5svqkJDPpZmiJrzSsw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ufs: core: fix &hwq->cq_lock deadlock issue
To:     Alice Chao <alice.chao@mediatek.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stanley.chu@mediatek.com,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        cc.chou@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com, tun-yu.yu@mediatek.com,
        eddie.huang@mediatek.com, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alice,

Alice Chao <alice.chao@mediatek.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=8821=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> [name:lockdep&]WARNING: inconsistent lock state
> [name:lockdep&]--------------------------------
> [name:lockdep&]inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [name:lockdep&]kworker/u16:4/260 [HC0[0]:SC0[0]:HE1:SE1] takes:
>   ffffff8028444600 (&hwq->cq_lock){?.-.}-{2:2}, at:
> ufshcd_mcq_poll_cqe_lock+0x30/0xe0
> [name:lockdep&]{IN-HARDIRQ-W} state was registered at:
>   lock_acquire+0x17c/0x33c
>   _raw_spin_lock+0x5c/0x7c
>   ufshcd_mcq_poll_cqe_lock+0x30/0xe0
>   ufs_mtk_mcq_intr+0x60/0x1bc [ufs_mediatek_mod]
>   __handle_irq_event_percpu+0x140/0x3ec
>   handle_irq_event+0x50/0xd8
>   handle_fasteoi_irq+0x148/0x2b0
>   generic_handle_domain_irq+0x4c/0x6c
>   gic_handle_irq+0x58/0x134
>   call_on_irq_stack+0x40/0x74
>   do_interrupt_handler+0x84/0xe4
>   el1_interrupt+0x3c/0x78
> <snip>
>
> Possible unsafe locking scenario:
>        CPU0
>        ----
>   lock(&hwq->cq_lock);
>   <Interrupt>
>     lock(&hwq->cq_lock);
>   *** DEADLOCK ***
> 2 locks held by kworker/u16:4/260:
>
> [name:lockdep&]
>  stack backtrace:
> CPU: 7 PID: 260 Comm: kworker/u16:4 Tainted: G S      W  OE
> 6.1.17-mainline-android14-2-g277223301adb #1
> Workqueue: ufs_eh_wq_0 ufshcd_err_handler
>
>  Call trace:
>   dump_backtrace+0x10c/0x160
>   show_stack+0x20/0x30
>   dump_stack_lvl+0x98/0xd8
>   dump_stack+0x20/0x60
>   print_usage_bug+0x584/0x76c
>   mark_lock_irq+0x488/0x510
>   mark_lock+0x1ec/0x25c
>   __lock_acquire+0x4d8/0xffc
>   lock_acquire+0x17c/0x33c
>   _raw_spin_lock+0x5c/0x7c
>   ufshcd_mcq_poll_cqe_lock+0x30/0xe0
>   ufshcd_poll+0x68/0x1b0
>   ufshcd_transfer_req_compl+0x9c/0xc8
>   ufshcd_err_handler+0x3bc/0xea0
>   process_one_work+0x2f4/0x7e8
>   worker_thread+0x234/0x450
>   kthread+0x110/0x134
>   ret_from_fork+0x10/0x20
>
> ufs_mtk_mcq_intr() could refer to
> https://lore.kernel.org/all/20230328103423.10970-3-powen.kao@mediatek.com=
/
>
> When ufshcd_err_handler() is executed, CQ event interrupt can enter
> waiting for the same lock. It could happened in upstream code path
> ufshcd_handle_mcq_cq_events() and also in ufs_mtk_mcq_intr(). This
> warning message will be generated when &hwq->cq_lock is used in IRQ
> context with IRQ enabled. Use ufshcd_mcq_poll_cqe_lock() with
> spin_lock_irqsave instead of spin_lock to resolve the deadlock issue.
>
> Signed-off-by: Alice Chao <alice.chao@mediatek.com>
> ---

After adding a Fixes: tag, feel free to add,

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
