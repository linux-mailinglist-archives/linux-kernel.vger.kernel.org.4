Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3338A5EC0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiI0LOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiI0LON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:14:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7B8543CD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:14:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32D226601F41;
        Tue, 27 Sep 2022 12:14:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664277244;
        bh=j18CSzZPjorCp5QZjTjWeiVjbPAV3d1+ZgVxWIiWxE4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TAd6MAzaMuUMP4SEOFsmA6cLZDPOdxxflDLvs9TK9zl4YRknnTBg8nJywJMCZjwL9
         baQfa7sJi/H+Zt2BVgOFEl4cKWus6jVpd3CozoQBsveVSuloowNfCbSaKSAknZDiiQ
         KY3HRCxuQIe42dh6IOH5zr3vP2BsbMh9UktjzlDgRi/3i7s0DDRtRyYfmhv2mJKd93
         xne2BUL4binjdYeocv2ZHt0llr5OY5gGGGht8+50vnnf5tfKn+aJyZ3qoKEkQyXj4r
         +pMnulHfJAhzbRXdkBFXcPQlbu8CHkGYbv1hXih37gmxfYm9b5fHRM0bqoh2GuyNre
         ym7fMb+eU7lDg==
Message-ID: <4b6ed7d1-31b7-265b-6f0f-58f0f7015177@collabora.com>
Date:   Tue, 27 Sep 2022 13:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5] mailbox: mtk-cmdq: fix gce timeout issue
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
References: <20220927083925.28433-1-yongqiang.niu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220927083925.28433-1-yongqiang.niu@mediatek.com>
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

Il 27/09/22 10:39, Yongqiang Niu ha scritto:
> 1. enable gce ddr enable(gce reigster offset 0x48, bit 16 to 18) when gce work,
> and disable gce ddr enable when gce work job done
> 2. add cmdq ddr enable/disable api, and control gce ddr enable/disable
> to make sure it could protect when cmdq is multiple used by display and mdp
> 
> this is only for some SOC which has flag "gce_ddr_en".
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
> change since v4:
> 1. remove spin lock control flow
> 2. move ddr control into suspend/resume/remove function
> ---
> 
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 44 +++++++++++++++++++++++++++++-
>   1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 9465f9081515..e9ead72b9bd3 100644
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
> @@ -80,6 +82,7 @@ struct cmdq {
>   	bool			suspended;
>   	u8			shift_pa;
>   	bool			control_by_sw;
> +	bool			sw_ddr_en;
>   	u32			gce_num;
>   };
>   
> @@ -87,9 +90,25 @@ struct gce_plat {
>   	u32 thread_nr;
>   	u8 shift;
>   	bool control_by_sw;
> +	bool sw_ddr_en;
>   	u32 gce_num;
>   };
>   
> +static void cmdq_sw_ddr_enable(struct cmdq *cmdq, bool enable)
> +{
> +	if (!cmdq->sw_ddr_en)
> +		return;
> +
> +	WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
> +
> +	if (enable)
> +		writel(GCE_DDR_EN + GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);

Adding up values to activate bits in this case works, but that's wrong.
You want GCE_DDR_EN | GCE_CTRL_BY_SW.

Regards,
Angelo
