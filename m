Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998EA5F3231
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJCOyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJCOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:54:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630F3AE60
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 07:54:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4CEB86601B15;
        Mon,  3 Oct 2022 15:54:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664808857;
        bh=ZsZW6LIMD7DHK9CJfXlywHYlJVcDHHTqRYvHEu2AQuQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Upa3fvOXjvZ8LuhUJroA93qxsldU81ctGpJu1Iif7bMMGqMrD/pqaM5cd0ERxbKSy
         gt405EkWH7bBQFMsSQwphjbXcVpHyNGR7W4/AVQINtub4P7SKRutgLSJHqWN8PweR9
         ysRByU2dkqLAD7bw8KANWZaOR6H86Ql6LGITU9Zj5K/zaqm1OpwSHwGv5effXnZRX9
         2VJyzu8XpMiXaeoz/YkfuZOEgso1N9cYW8vxtnkhe4miJJMQTuuzOsX2SEgmQH9kqb
         qevk3+CEHVwbWCwUzOqC398M8Vf7BM7f86qd75K/MBJd1Q4neQbAE08pPKmTBzaIRJ
         Y0HfQvCgKzUMw==
Message-ID: <6bcf2f53-ffd1-5159-47a5-b3d7db548158@collabora.com>
Date:   Mon, 3 Oct 2022 16:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v8, 3/4] mailbox: mtk-cmdq: add gce ddr enable support
 flow
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
References: <20220930160638.7588-1-yongqiang.niu@mediatek.com>
 <20220930160638.7588-4-yongqiang.niu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220930160638.7588-4-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/09/22 18:06, Yongqiang Niu ha scritto:
> add gce ddr enable control flow when gce suspend/resume
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 04eb44d89119..2db82ff838ed 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -94,6 +94,18 @@ struct gce_plat {
>   	u32 gce_num;
>   };
>   
> +static void cmdq_sw_ddr_enable(struct cmdq *cmdq, bool enable)
> +{
> +	WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
> +
> +	if (enable)
> +		writel(GCE_DDR_EN | GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);

My only concern here is about the previous value stored in the GCE_GCTL_VALUE
register, as you're overwriting it in its entirety with
GCE_DDR_EN | GCE_CTRL_BY_SW.

Can you guarantee that this register is not pre-initialized with some value,
and that these are the only bits to be `1` in this register?

Otherwise, you will have to readl and modify the bits instead... by the way,
if this register doesn't get any changes during runtime, you may cache it
at probe time to avoid reading it for every suspend/resume operation.

Regards,
Angelo


