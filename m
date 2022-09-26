Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34E5EAC98
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiIZQdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiIZQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:32:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E1782D29
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:21:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C04086600371;
        Mon, 26 Sep 2022 16:21:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664205671;
        bh=CUjqHy4tnGfM2kkCAOfVdjkEold9qGI9EH5hPzPlOkI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ty75L7GMLlZIna8DWvtOYYFccyAcn3A/3yv52cjxgdoMwL7gnOa8VI7qfyKAhnlH0
         CHQS/QvvIUCcQDjc2xdrCEsmDg5JrWRhQg2aZXEiSylUDdEFS2KNoZMOtfBCqz3JRX
         Hm13kgdPk7j7t00VSaiwfFcZDPWK5SjQnr74H0jOcEjfx5BPnxgmhRJg8chX2NLB+y
         x2pvUfqS70XkwwjwpvzKloLoT+G7YgEPCqqpNtvKhnNm3tq/VJZt5WpwFVSm4rKQIw
         JFrZSeHUxWwMuAz9gzUT5XVfjA8vWybGIhEeL4Jr1fFZTlh3JqE6ZiKJHKu478sfiF
         N5E72ZgF22d7w==
Message-ID: <dcdc61d0-a979-b746-6259-48a67175c675@collabora.com>
Date:   Mon, 26 Sep 2022 17:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RESEND PATCH v3] mailbox: mtk-cmdq: fix gce timeout issue
Content-Language: en-US
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20220926090219.11871-1-yongqiang.niu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220926090219.11871-1-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/09/22 11:02, Yongqiang Niu ha scritto:
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
> change sinc v2:
> 1. add definition GCE_CTRL_BY_SW and GCE_DDR_EN instead of magic number
> ---
> 
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 68 +++++++++++++++++++++++++++---
>   1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 9465f9081515..bd63773b05fd 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -38,6 +38,8 @@
>   #define CMDQ_THR_PRIORITY		0x40
>   
>   #define GCE_GCTL_VALUE			0x48
> +#define GCE_CTRL_BY_SW				GENMASK(18, 16)
> +#define GCE_DDR_EN				GENMASK(2, 0)
>   
>   #define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
>   #define CMDQ_THR_ENABLED		0x1
> @@ -80,16 +82,60 @@ struct cmdq {
>   	bool			suspended;
>   	u8			shift_pa;
>   	bool			control_by_sw;
> +	bool			sw_ddr_en;
>   	u32			gce_num;
> +	atomic_t		usage;
> +	spinlock_t		lock;
>   };
>   
>   struct gce_plat {
>   	u32 thread_nr;
>   	u8 shift;
>   	bool control_by_sw;
> +	bool sw_ddr_en;
>   	u32 gce_num;
>   };
>   
> +static s32 cmdq_clk_enable(struct cmdq *cmdq)
> +{
> +	s32 usage, ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cmdq->lock, flags);

All this locking is avoidable on all SoCs where (sw_ddr_en == false), which means
that this is needed only for one SoC (MT8186).

You can solve that by adding a callback pointer on the gce_plat data, so that
we get something like:

static int cmdq_clk_swddr_enable(struct cmdq *cmdq)
{
	lock, atomic_inc, clk_bulk_enable, writel(....);
}

static int cmdq_clk_enable(struct cmdq *cmdq)
{
	return clk_bulk_enable(cmdq->gce_num, cmdq->clocks);
};

static const struct gce_plat gce_plat_v7 = {
	...........
	.clk_enable = cmdq_clk_swddr_enable,
	.clk_disable = cmdq_clk_swddr_disable,
	..........
};

Please care about older SoCs' performance.

Regards,
Angelo


