Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B685E9C94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiIZIzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiIZIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:55:10 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E236B32EE4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:55:03 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3321c2a8d4cso61360307b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZoLWcmvp+RvSPkYWvItSPxsdfZmwp4ei8jd4nndeSm4=;
        b=fnU9TxGggwpHc3T3uIe210n82Vcbi+qzwEcDkWWdKjNEJgkbn4+v80fy64yIZLdO8D
         dXHRV2sA5XLQ2QbB0p518iCdO2jir+aFivdx99VQHc4yQ43MT4buGb+2LeNC/aXEGKCI
         5w/I6mF4LRDcMV61XFU5CPzF20kbXCMCeAR34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZoLWcmvp+RvSPkYWvItSPxsdfZmwp4ei8jd4nndeSm4=;
        b=yl5p4AZbGrJR2aYjhGdx4MkWsQDre0IWddXWoQ2fW6FbjOT6bVMQjzKClYzaRoPJux
         olkLLDlXxhUNNEOBnhuf6bo/LkyOPy7FiHRGITwVcpQZRbkRK7Hi4IAnifeqn+YNp5tY
         lwCWYBINHxLiZUXFE72mhzL9H7V61KwR/O870bX3Z27LIZ9vGwb/IqpOSYbN11fjuWeN
         NFf2oefGWUGG/Lk2shCjaT6esXKIVkjKmkjrJB1tTLBeHAtCqKJYTZwJJ/2NmT/8R+Ar
         ywy1/9Ztw8xHmHfTaUqpD0Y6rsB8S/hM8cZ9WNslU3e4w/XKoosoJGzqXDzcfj8cmo2y
         p/OA==
X-Gm-Message-State: ACrzQf2C6fitvpIE7k/6CWeP4bRaG/B9WgKE5+z5An2XJ1sKkrq8EEDg
        rIW3rL7i7PH58pDMDmF8VA3Aw7HnT5fPNNVEgM8N7g==
X-Google-Smtp-Source: AMsMyM4FyTbskSDbEOFQfTU3e4rqIm/BNqsWAkbka54SngLa+fcV7DQivhjU5/iMPqlHA6WwRq1U6B/s4XBrlc3ofSQ=
X-Received: by 2002:a81:4995:0:b0:350:b1ac:891f with SMTP id
 w143-20020a814995000000b00350b1ac891fmr6363214ywa.263.1664182502779; Mon, 26
 Sep 2022 01:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220926083511.3382-1-yongqiang.niu@mediatek.com>
In-Reply-To: <20220926083511.3382-1-yongqiang.niu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 26 Sep 2022 16:54:36 +0800
Message-ID: <CAJMQK-jQiJTdeY-AYEjzT=LtwGkEffc+PfRkOs6_VF1MTZ10OA@mail.gmail.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq: fix gce timeout issue
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 4:35 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
Please include v3 in the title and add change logs next time.


> 1. enable gce ddr enable(gce reigster offset 0x48, bit 16 to 18) when gce work,
> and disable gce ddr enable when gce work job done
> 2. split cmdq clk enable/disable api, and control gce ddr enable/disable
> in clk enable/disable function to make sure it could protect when cmdq
> is multiple used by display and mdp
>
> this is only for some SOC which has flag "control_by_sw".
> for this kind of gce, there is a handshake flow between gce and ddr
> hardware,
> if not set ddr enable flag of gce, ddr will fall into idle mode,
> then gce instructions will not process done.
> we need set this flag of gce to tell ddr when gce is idle or busy
> controlled by software flow.
>
> ddr problem is a special case.
> when test suspend/resume case, gce sometimes will pull ddr, and ddr can
> not go to suspend.
> if we set gce register 0x48 to 0x7, will fix this gce pull ddr issue,
> as you have referred [1] and [2] (8192 and 8195)
> but for mt8186, the gce is more special, except setting of [1] and [2],
> we need add more setting set gce register 0x48 to (0x7 << 16 | 0x7)
> when gce working to make sure gce could process all instructions ok.
> this case just need normal bootup, if we not set this, display cmdq
> task will timeout, and chrome homescreen will always black screen.
>
> and with this patch, we have done these test on mt8186:
> 1.suspend/resume
> 2.boot up to home screen
> 3.playback video with youtube.
>
> suspend issue is special gce hardware issue, gce client  driver
> command already process done, but gce still pull ddr.
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 68 +++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 9465f9081515..bd63773b05fd 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -38,6 +38,8 @@
>  #define CMDQ_THR_PRIORITY              0x40
>
>  #define GCE_GCTL_VALUE                 0x48
> +#define GCE_CTRL_BY_SW                         GENMASK(18, 16)
> +#define GCE_DDR_EN                             GENMASK(2, 0)
>
>  #define CMDQ_THR_ACTIVE_SLOT_CYCLES    0x3200
>  #define CMDQ_THR_ENABLED               0x1
> @@ -80,16 +82,60 @@ struct cmdq {
>         bool                    suspended;
>         u8                      shift_pa;
>         bool                    control_by_sw;
> +       bool                    sw_ddr_en;
>         u32                     gce_num;
> +       atomic_t                usage;
> +       spinlock_t              lock;
>  };
>
>  struct gce_plat {
>         u32 thread_nr;
>         u8 shift;
>         bool control_by_sw;
> +       bool sw_ddr_en;
>         u32 gce_num;
>  };
>
> +static s32 cmdq_clk_enable(struct cmdq *cmdq)
> +{
> +       s32 usage, ret;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&cmdq->lock, flags);
> +
> +       usage = atomic_inc_return(&cmdq->usage);
> +
> +       ret = clk_bulk_enable(cmdq->gce_num, cmdq->clocks);
> +       if (usage <= 0 || ret < 0) {
> +               dev_err(cmdq->mbox.dev, "ref count %d ret %d suspend %d\n",
> +                       usage, ret, cmdq->suspended);
> +       } else if (usage == 1) {
> +               if (cmdq->sw_ddr_en)
> +                       writel(GCE_DDR_EN + GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
> +       }
> +
> +       spin_unlock_irqrestore(&cmdq->lock, flags);
> +
> +       return ret;
> +}
> +
> +static void cmdq_clk_disable(struct cmdq *cmdq)
> +{
> +       s32 usage;
> +
> +       usage = atomic_dec_return(&cmdq->usage);
> +
> +       if (usage < 0) {
> +               dev_err(cmdq->mbox.dev, "ref count %d suspend %d\n",
> +                       usage, cmdq->suspended);
> +       } else if (usage == 0) {
> +               if (cmdq->sw_ddr_en)
> +                       writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
> +       }
> +
> +       clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
> +}
> +
>  u8 cmdq_get_shift_pa(struct mbox_chan *chan)
>  {
>         struct cmdq *cmdq = container_of(chan->mbox, struct cmdq, mbox);
> @@ -266,7 +312,8 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
>
>         if (list_empty(&thread->task_busy_list)) {
>                 cmdq_thread_disable(cmdq, thread);
> -               clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
> +
> +               cmdq_clk_disable(cmdq);
>         }
>  }
>
> @@ -355,8 +402,7 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
>         task->pkt = pkt;
>
>         if (list_empty(&thread->task_busy_list)) {
> -               WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
> -
> +               WARN_ON(cmdq_clk_enable(cmdq) < 0);
>                 /*
>                  * The thread reset will clear thread related register to 0,
>                  * including pc, end, priority, irq, suspend and enable. Thus
> @@ -428,7 +474,7 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
>         }
>
>         cmdq_thread_disable(cmdq, thread);
> -       clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
> +       cmdq_clk_disable(cmdq);
>
>  done:
>         /*
> @@ -468,7 +514,8 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
>
>         cmdq_thread_resume(thread);
>         cmdq_thread_disable(cmdq, thread);
> -       clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
> +
> +       cmdq_clk_disable(cmdq);
>
>  out:
>         spin_unlock_irqrestore(&thread->chan->lock, flags);
> @@ -543,6 +590,7 @@ static int cmdq_probe(struct platform_device *pdev)
>         cmdq->thread_nr = plat_data->thread_nr;
>         cmdq->shift_pa = plat_data->shift;
>         cmdq->control_by_sw = plat_data->control_by_sw;
> +       cmdq->sw_ddr_en = plat_data->sw_ddr_en;
>         cmdq->gce_num = plat_data->gce_num;
>         cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>         err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
> @@ -615,6 +663,7 @@ static int cmdq_probe(struct platform_device *pdev)
>
>         WARN_ON(clk_bulk_prepare(cmdq->gce_num, cmdq->clocks));
>
> +       spin_lock_init(&cmdq->lock);
>         cmdq_init(cmdq);
>
>         return 0;
> @@ -660,9 +709,18 @@ static const struct gce_plat gce_plat_v6 = {
>         .gce_num = 2
>  };
>
> +static const struct gce_plat gce_plat_v7 = {
> +       .thread_nr = 24,
> +       .shift = 3,
> +       .control_by_sw = true,
> +       .sw_ddr_en = true,
> +       .gce_num = 1
> +};
> +
>  static const struct of_device_id cmdq_of_ids[] = {
>         {.compatible = "mediatek,mt8173-gce", .data = (void *)&gce_plat_v2},
>         {.compatible = "mediatek,mt8183-gce", .data = (void *)&gce_plat_v3},
> +       {.compatible = "mediatek,mt8186-gce", .data = (void *)&gce_plat_v7},
>         {.compatible = "mediatek,mt6779-gce", .data = (void *)&gce_plat_v4},
>         {.compatible = "mediatek,mt8192-gce", .data = (void *)&gce_plat_v5},
>         {.compatible = "mediatek,mt8195-gce", .data = (void *)&gce_plat_v6},
> --
> 2.25.1
>
