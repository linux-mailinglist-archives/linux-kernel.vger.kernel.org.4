Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119375BE0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiITItP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiITItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:49:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6463DF2A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:49:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8237A6601F65;
        Tue, 20 Sep 2022 09:48:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663663739;
        bh=3O1gIy6Vy/Ms9LXKAt/hkcmUK5uDCj1tR4GUjf/uneA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dRhnYDPrVJMp1Ip6BavnyMePgoxD6nH+8UU9E6dMEBlah5z4aogJg2zDXvw5TyvEo
         yXhHi6UbMEFotN6D3gsICRJZIaDMqBSyhhYTI/qkWOG3YicwF1c3JaADwp2y7MwW0p
         My9O/LRGF77G/OK/vmZ+vHmr4bHhPv8JWt2049TVlQgd9zWzlklXlbMJ8+X5NWT4Tk
         +Neeo7aYESSTX0mCuRMZFOJ82DA22+kNWaPo02/uBFbJ8NtNHDqSScXhthGPVgrB0N
         Mp9E0lmXI/ITWEu+RyAbO8BLWNxFJumJByNqknWCTSDb/1ACSr9ODCK58YDvUBpiDb
         lHAY9WVJ1Fseg==
Message-ID: <afa996b6-ee13-5add-9248-9339aa0beb02@collabora.com>
Date:   Tue, 20 Sep 2022 10:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RESEND PATCH v2] mailbox: mtk-cmdq: fix gce timeout issue
Content-Language: en-US
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20220919071238.23920-1-yongqiang.niu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919071238.23920-1-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/22 09:12, Yongqiang Niu ha scritto:
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
>   drivers/mailbox/mtk-cmdq-mailbox.c | 66 +++++++++++++++++++++++++++---
>   1 file changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 9465f9081515..3a1b11de84be 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -80,16 +80,60 @@ struct cmdq {
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
> +
> +	usage = atomic_inc_return(&cmdq->usage);
> +
> +	ret = clk_bulk_enable(cmdq->gce_num, cmdq->clocks);
> +	if (usage <= 0 || ret < 0) {
> +		dev_err(cmdq->mbox.dev, "ref count %d ret %d suspend %d\n",
> +			usage, ret, cmdq->suspended);
> +	} else if (usage == 1) {
> +		if (cmdq->sw_ddr_en)
> +			writel((0x7 << 16) + 0x7, cmdq->base + GCE_GCTL_VALUE);

Can this be used on MT8192/MT8195?
If yes, you can avoid adding that sw_ddr_en, as you would be able to simply
use `control_by_sw`, which already seems to be doing most of what you're adding
here.

Also, I dislike all this locking: the point of having MTK CMDQ is to improve
performance (I know it's more than that, but there's no ISP upstream) and part
of that happens because locking is greatly reduced.

If you add it back up, we're losing part of the point.

Though, in this driver, we are already tracking the usage of the CMDQ threads
and, when there's no more usage, we're turning off the clocks: this is done
through the usage of `task_busy_list`, so you *do* have a way to avoid adding
more locks around.
Besides that, you could also add a clock notifier for the same, but since
the state is already tracked, I'd avoid using that.

Moreover, (7 << 16) == GENMASK(18, 16)

#define GCE_CMD_SOMETHING GENMASK(18, 16)

Regards,
Angelo



