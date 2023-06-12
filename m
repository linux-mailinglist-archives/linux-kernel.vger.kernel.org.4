Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57CF72BC34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjFLJ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjFLJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:25:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E83ABA;
        Mon, 12 Jun 2023 02:19:09 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1A7066056AA;
        Mon, 12 Jun 2023 10:19:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686561548;
        bh=tX5XvShuB5NTKeh2EgZz7YxNzHFe+v26ZOrDvqrPNyE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bnmcOQbm4Y+ax96s1EBPHPXJJJhjlc3Fqhi8RvBgJYDFlOalpfYU58L+ChdoqFrtX
         B+iU6ntgnfoK4Fkw/QS59L8TEKR8R067Oy9Yg0Jqv+dxwSNfgRL7AkjAFf3X2Q8s7Q
         LnOmTs/aymm+CPCJzMlgufLRKtIakRZkTj28lx7JKww0rALa4XHDPbbaBDZQrr9cor
         dLV0sYzhFBwJHLT1SgRZj24AK9ZYQaVfZKmNHc8XdVITRuR6LgXfGMiBGEF4fXtzch
         GCnN4jGlqI940ncqMh9k1xpcbjwsb7mdCY5kLjkm0NuKIYLSyq010+NYYzy+wl7TOv
         UHzHFhkN9Kcxg==
Message-ID: <e1002fe4-8a80-21f4-f3f2-cc9a7060e4da@collabora.com>
Date:   Mon, 12 Jun 2023 11:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/2] scsi: ufs: ufs-mediatek: Add MCQ support for MTK
 platform
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        alice.chao@mediatek.com, naomi.chu@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        eddie.huang@mediatek.com
References: <20230610083321.5566-1-powen.kao@mediatek.com>
 <20230610083321.5566-3-powen.kao@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230610083321.5566-3-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/06/23 10:33, Po-Wen Kao ha scritto:
> Add UFS MCQ vops and irq handler for MediaTek platform.
> PM flow is fixed accordingly.
> 
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>   drivers/ufs/host/ufs-mediatek.c | 174 +++++++++++++++++++++++++++++++-
>   drivers/ufs/host/ufs-mediatek.h |  33 ++++++
>   2 files changed, 205 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
> index 33b301649757..662b06e285c6 100644
> --- a/drivers/ufs/host/ufs-mediatek.c
> +++ b/drivers/ufs/host/ufs-mediatek.c
> @@ -27,8 +27,14 @@
>   #include <ufs/unipro.h>
>   #include "ufs-mediatek.h"
>   
> +static int  ufs_mtk_config_mcq(struct ufs_hba *hba, bool irq);
> +
>   #define CREATE_TRACE_POINTS
>   #include "ufs-mediatek-trace.h"
> +#undef CREATE_TRACE_POINTS
> +
> +#define MAX_SUPP_MAC 64
> +#define MCQ_QUEUE_OFFSET(c) ((((c) >> 16) & 0xFF) * 0x200)
>   
>   static const struct ufs_dev_quirk ufs_mtk_dev_fixups[] = {
>   	{ .wmanufacturerid = UFS_ANY_VENDOR,
> @@ -840,6 +846,37 @@ static void ufs_mtk_vreg_fix_vccqx(struct ufs_hba *hba)
>   	}
>   }
>   
> +static void ufs_mtk_init_mcq_irq(struct ufs_hba *hba)
> +{
> +	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
> +	struct platform_device *pdev;
> +	int i;
> +	int irq;
> +
> +	host->mcq_nr_intr = UFSHCD_MAX_Q_NR;
> +	pdev = container_of(hba->dev, struct platform_device, dev);
> +
> +	/* invalidate irq info */
> +	for (i = 0; i < host->mcq_nr_intr; i++)
> +		host->mcq_intr_info[i].irq = MTK_MCQ_INVALID_IRQ;

You can avoid double-writing by moving this one...

> +
> +	for (i = 0; i < host->mcq_nr_intr; i++) {
> +		/* irq index 0 is legacy irq, sq/cq irq start from index 1 */
> +		irq = platform_get_irq(pdev, i + 1);
> +		if (irq < 0) {
> +			dev_err(hba->dev, "get platform mcq irq fail: %d\n", i);
> +			goto failed;
> +		}
> +		host->mcq_intr_info[i].hba = hba;
> +		host->mcq_intr_info[i].irq = irq;
> +		dev_info(hba->dev, "get platform mcq irq: %d, %d\n", i, irq);
> +	}
> +
> +	return;
> +failed:

...here

> +	host->mcq_nr_intr = 0;
> +}
> +
>   /**
>    * ufs_mtk_init - find other essential mmio bases
>    * @hba: host controller instance
> @@ -876,6 +913,8 @@ static int ufs_mtk_init(struct ufs_hba *hba)
>   	/* Initialize host capability */
>   	ufs_mtk_init_host_caps(hba);
>   
> +	ufs_mtk_init_mcq_irq(hba);
> +
>   	err = ufs_mtk_bind_mphy(hba);
>   	if (err)
>   		goto out_variant_clear;
> @@ -1171,7 +1210,16 @@ static int ufs_mtk_link_set_hpm(struct ufs_hba *hba)
>   	else
>   		return err;
>   
> -	err = ufshcd_make_hba_operational(hba);
> +	if (!hba->mcq_enabled) {
> +		err = ufshcd_make_hba_operational(hba);
> +	} else {
> +		ufs_mtk_config_mcq(hba, false);
> +		ufshcd_mcq_make_queues_operational(hba);
> +		ufshcd_mcq_config_mac(hba, hba->nutrs);
> +		ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,

What is that 0x1? Please add a definition for it.

> +			      REG_UFS_MEM_CFG);
> +	}
> +
>   	if (err)
>   		return err;
>   
> @@ -1495,6 +1543,123 @@ static int ufs_mtk_clk_scale_notify(struct ufs_hba *hba, bool scale_up,
>   	return 0;
>   }
>   
> +static int ufs_mtk_get_hba_mac(struct ufs_hba *hba)
> +{
> +	return MAX_SUPP_MAC;
> +}
> +
> +static int ufs_mtk_op_runtime_config(struct ufs_hba *hba)
> +{
> +	struct ufshcd_mcq_opr_info_t *opr;
> +	int i;
> +
> +	for (i = 0; i < OPR_MAX; i++) {
> +		opr = &hba->mcq_opr[i];
> +		opr->stride = REG_UFS_MCQ_STRIDE;
> +	}
> +
> +	hba->mcq_opr[OPR_SQD].offset = REG_UFS_MTK_SQD;
> +	hba->mcq_opr[OPR_SQIS].offset = REG_UFS_MTK_SQIS;
> +	hba->mcq_opr[OPR_CQD].offset = REG_UFS_MTK_CQD;
> +	hba->mcq_opr[OPR_CQIS].offset = REG_UFS_MTK_CQIS;


If you move offset init before the for loop, you could do...

for (i = 0; i < OPR_MAX; i++) {
	opr = &hba->mcq_opr[i];
	opr->stride = REG_UFS_MCQ_STRIDE;
	opr->base = hba->mmio_base + opr->offset;
}

> +
> +	hba->mcq_opr[OPR_SQD].base = hba->mmio_base + REG_UFS_MTK_SQD;
> +	hba->mcq_opr[OPR_SQIS].base = hba->mmio_base + REG_UFS_MTK_SQIS;
> +	hba->mcq_opr[OPR_CQD].base = hba->mmio_base + REG_UFS_MTK_CQD;
> +	hba->mcq_opr[OPR_CQIS].base = hba->mmio_base + REG_UFS_MTK_CQIS;
> +
> +	return 0;
> +}
> +
> +static int ufs_mtk_mcq_config_resource(struct ufs_hba *hba)
> +{
> +	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
> +
> +	/* fail mcq initialization if interrupt is not filled properly */
> +	if (!host->mcq_nr_intr) {
> +		dev_info(hba->dev, "IRQs not ready. MCQ disabled.");
> +		return -EINVAL;
> +	}
> +
> +	hba->mcq_base = hba->mmio_base + MCQ_QUEUE_OFFSET(hba->mcq_capabilities);
> +	return 0;
> +}
> +
> +static irqreturn_t ufs_mtk_mcq_intr(int irq, void *__intr_info)
> +{
> +	struct ufs_mtk_mcq_intr_info *mcq_intr_info = __intr_info;
> +	struct ufs_hba *hba = mcq_intr_info->hba;
> +	struct ufs_hw_queue *hwq;
> +	u32 events;
> +	int i = mcq_intr_info->qid;

Renaming this to `int qid` will increase human readability.

> +
> +	hwq = &hba->uhq[i];
> +
> +	events = ufshcd_mcq_read_cqis(hba, i);
> +	if (events)
> +		ufshcd_mcq_write_cqis(hba, events, i);
> +
> +	if (events & UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS)
> +		ufshcd_mcq_poll_cqe_lock(hba, hwq);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ufs_mtk_config_mcq_irq(struct ufs_hba *hba)
> +{
> +	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
> +	u32 irq, i;
> +	int ret;
> +
> +	for (i = 0; i < host->mcq_nr_intr; i++) {
> +		irq = host->mcq_intr_info[i].irq;
> +		if (irq == MTK_MCQ_INVALID_IRQ) {
> +			dev_err(hba->dev, "invalid irq. %d\n", i);
> +			return -ENOPARAM;
> +		}
> +
> +		host->mcq_intr_info[i].qid = i;
> +		ret = devm_request_irq(hba->dev, irq, ufs_mtk_mcq_intr, 0, UFSHCD,
> +				       &host->mcq_intr_info[i]);
> +
> +		dev_info(hba->dev, "request irq %d intr %s\n", irq, ret ? "failed" : "");

That's too chatty... you can fix that by doing

if (ret) {
	dev_err(hba->dev, "Cannot request irq %d\n", ret);
	return ret;
}

> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ufs_mtk_config_mcq(struct ufs_hba *hba, bool irq)
> +{
> +	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
> +	int ret = 0;

int ret;

> +
> +	if (!host->mcq_set_intr) {
> +		/* Disable irq option register */
> +		ufshcd_rmwl(hba, MCQ_INTR_EN_MSK, 0, REG_UFS_MMIO_OPT_CTRL_0);
> +
> +		if (irq)
> +			ret = ufs_mtk_config_mcq_irq(hba);
> +
> +		if (ret)
> +			return ret;

if (irq) {
	ret = ...
	if (ret)
		return ret;
}

> +
> +		host->mcq_set_intr = true;
> +	}
> +
> +	ufshcd_rmwl(hba, MCQ_AH8, MCQ_AH8, REG_UFS_MMIO_OPT_CTRL_0);
> +	ufshcd_rmwl(hba, MCQ_INTR_EN_MSK, MCQ_MULTI_INTR_EN, REG_UFS_MMIO_OPT_CTRL_0);
> +
> +	return 0;
> +}
> +
> +static int ufs_mtk_config_esi(struct ufs_hba *hba)
> +{
> +	return ufs_mtk_config_mcq(hba, true);
> +}
> +
>   /*
>    * struct ufs_hba_mtk_vops - UFS MTK specific variant operations
>    *
> @@ -1518,6 +1683,11 @@ static const struct ufs_hba_variant_ops ufs_hba_mtk_vops = {
>   	.event_notify        = ufs_mtk_event_notify,
>   	.config_scaling_param = ufs_mtk_config_scaling_param,
>   	.clk_scale_notify    = ufs_mtk_clk_scale_notify,
> +	/* mcq vops */
> +	.get_hba_mac         = ufs_mtk_get_hba_mac,
> +	.op_runtime_config   = ufs_mtk_op_runtime_config,
> +	.mcq_config_resource = ufs_mtk_mcq_config_resource,
> +	.config_esi          = ufs_mtk_config_esi,
>   };
>   
>   /**
> @@ -1564,7 +1734,7 @@ static int ufs_mtk_probe(struct platform_device *pdev)
>   
>   out:
>   	if (err)
> -		dev_info(dev, "probe failed %d\n", err);
> +		dev_err(dev, "probe failed %d\n", err);
>   
>   	of_node_put(reset_node);
>   	return err;
> diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
> index 2fc6d7b87694..6e41550e1830 100644
> --- a/drivers/ufs/host/ufs-mediatek.h
> +++ b/drivers/ufs/host/ufs-mediatek.h
> @@ -10,11 +10,27 @@
>   #include <linux/pm_qos.h>
>   #include <linux/soc/mediatek/mtk_sip_svc.h>
>   
> +/*
> + * MCQ define and struct
> + */
> +#define UFSHCD_MAX_Q_NR 8
> +#define MTK_MCQ_INVALID_IRQ	0xFFFF
> +
> +/* REG_UFS_MMIO_OPT_CTRL_0 160h */
> +#define EHS_EN                  0x1
> +#define PFM_IMPV                0x2
> +#define MCQ_MULTI_INTR_EN       0x4
> +#define MCQ_CMB_INTR_EN         0x8
> +#define MCQ_AH8                 0x10

These really look like being BIT(x), specifically, bits 0, 1, 2, 3, 4.

> +
> +#define MCQ_INTR_EN_MSK         (MCQ_MULTI_INTR_EN | MCQ_CMB_INTR_EN)
> +

After that, looks fine to me.

Regards,
Angelo

