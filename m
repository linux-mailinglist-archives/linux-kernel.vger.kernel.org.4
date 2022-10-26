Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3560DAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiJZGKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZGKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:10:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83E2DAA6;
        Tue, 25 Oct 2022 23:10:17 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mxz1Q0J98zHtv1;
        Wed, 26 Oct 2022 14:10:02 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 14:10:14 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 14:10:14 +0800
Message-ID: <6d00d240-0c86-d593-6efe-44fec21421a8@huawei.com>
Date:   Wed, 26 Oct 2022 14:10:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <sudeep.holla@arm.com>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <huangdaode@huawei.com>, <tanxiaofei@huawei.com>,
        Loc Ho <lho@apm.com>, Hoan Tran <hotran@apm.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221016034043.52227-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping.

在 2022/10/16 11:40, Huisong Li 写道:
> As ACPI protocol descripted, if interrupts are level, a GSIV may
> be shared by multiple subspaces, but each one must have unique
> platform interrupt ack preserve and ack set masks. Therefore, need
> set to shared interrupt for types that can distinguish interrupt
> response channel if platform interrupt mode is level triggered.
>
> The distinguishing point isn't definitely command complete register.
> Because the two status values of command complete indicate that
> there is no interrupt in a subspace('1' means subspace is free for
> use, and '0' means platform is processing the command). On the whole,
> the platform interrupt ack register is more suitable for this role.
> As ACPI protocol said, If the subspace does support interrupts, and
> these are level, this register must be supplied. And is used to clear
> the interrupt by using a read, modify, write sequence. This register
> is a 'WR' register, the bit corresponding to the subspace is '1' when
> the command is completed, or is '0'.
>
> Therefore, register shared interrupt for multiple subspaces if support
> platform interrupt ack register and interrupts are level, and read the
> ack register to ensure the idle or unfinished command channels to
> quickly return IRQ_NONE.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/mailbox/pcc.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 3c2bc0ca454c..86c6cc44c73d 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -100,6 +100,7 @@ struct pcc_chan_info {
>   	struct pcc_chan_reg cmd_update;
>   	struct pcc_chan_reg error;
>   	int plat_irq;
> +	u8 plat_irq_trigger;
>   };
>   
>   #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
> @@ -236,6 +237,15 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	int ret;
>   
>   	pchan = chan->con_priv;
> +	ret = pcc_chan_reg_read(&pchan->plat_irq_ack, &val);
> +	if (ret)
> +		return IRQ_NONE;
> +	/* Irq ack GAS exist and check if this interrupt has the channel. */
> +	if (pchan->plat_irq_ack.gas) {
> +		val &= pchan->plat_irq_ack.set_mask;
> +		if (val == 0)
> +			return IRQ_NONE;
> +	}
>   
>   	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>   	if (ret)
> @@ -309,10 +319,21 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	spin_unlock_irqrestore(&chan->lock, flags);
>   
>   	if (pchan->plat_irq > 0) {
> +		unsigned long irqflags;
>   		int rc;
>   
> -		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
> -				      MBOX_IRQ_NAME, chan);
> +		/*
> +		 * As ACPI protocol descripted, if interrupts are level, a GSIV
> +		 * may be shared by multiple subspaces.
> +		 * Therefore, register shared interrupt for multiple subspaces
> +		 * if support platform interrupt ack register and interrupts
> +		 * are level.
> +		 */
> +		irqflags = (pchan->plat_irq_ack.gas &&
> +			    pchan->plat_irq_trigger == ACPI_LEVEL_SENSITIVE) ?
> +			    IRQF_SHARED : 0;
> +		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
> +				      irqflags, MBOX_IRQ_NAME, chan);
>   		if (unlikely(rc)) {
>   			dev_err(dev, "failed to register PCC interrupt %d\n",
>   				pchan->plat_irq);
> @@ -457,6 +478,8 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
>   		       pcct_ss->platform_interrupt);
>   		return -EINVAL;
>   	}
> +	pchan->plat_irq_trigger = (pcct_ss->flags & ACPI_PCCT_INTERRUPT_MODE) ?
> +				ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>   
>   	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
>   		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
