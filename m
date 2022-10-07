Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1934D5F75AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJGI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:57:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7196D0CEE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:57:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A9CC6602329;
        Fri,  7 Oct 2022 09:57:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665133047;
        bh=DQBkdVd/FiyJTSnISGC19lKx+6Sgmh+oa4zSGkVpqG4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FcR0TT2y8evoR2oLeK1bAVfv/ZpYL8gQrpcURHLomLY4wcuZEoRM4T5LsUbYHpkG9
         KPdFI3XZG8n/IWeAweqgsyQjoZY0KYIn/yGd4inEOHDXu2kOKFraXcwnKBHNTKZz7R
         Z5XNCrxjzZ19fYEpMr7hAuOShI33dQEVoiIkRdBCaZ3wtpQP4KyVxtZQj8Vt9TVYXC
         mqQyQE/eEifafc+jyCCMHViBsVujEPu5Mxc8ZsDMZC0X0JXU2PoIZ/bn/O6v1vCnHJ
         v6KMmKz+Umvtbe8Phw/Winzs2kNWHiQAOfzRp3k3YEjlm+1fzuIbazr1Ik5aYB15Yn
         VKQncYwdhs9YA==
Message-ID: <603804c4-770e-80ed-3133-94b04be98240@collabora.com>
Date:   Fri, 7 Oct 2022 10:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9, 2/4] mailbox: mtk-cmdq: add gce software ddr enable
 private data
Content-Language: en-US
To:     "yongqiang.niu" <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20221006043456.8754-1-yongqiang.niu@mediatek.com>
 <20221006043456.8754-3-yongqiang.niu@mediatek.com>
 <ded0300b-5b54-48eb-038e-102ae91573c5@collabora.com>
 <a4b0e7744f6934dee8f0247492cc399bbf3973bf.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a4b0e7744f6934dee8f0247492cc399bbf3973bf.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/10/22 03:51, yongqiang.niu ha scritto:
> On Thu, 2022-10-06 at 11:29 +0200, AngeloGioacchino Del Regno wrote:
>> Il 06/10/22 06:34, Yongqiang Niu ha scritto:
>>> if gce work control by software, we need set software enable
>>> for MT8186 Soc
>>>
>>> there is a handshake flow between gce and ddr hardware,
>>> if not set ddr enable flag of gce, ddr will fall into idle
>>> mode, then gce instructions will not process done.
>>> we need set this flag of gce to tell ddr when gce is idle or busy
>>> controlled by software flow.
>>>
>>> 0x48[2:0] means control by software
>>> 0x48[18:16] means ddr enable
>>> 0x48[2:0] is pre-condition of 0x48[18:16].
>>> if we want set 0x48[18:16] ddr enable, 0x48[2:0] must be set at
>>> same
>>> time.
>>> and only these bits is useful, other bits is useless bits
>>>
>>> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
>>> ---
>>>    drivers/mailbox/mtk-cmdq-mailbox.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
>>> b/drivers/mailbox/mtk-cmdq-mailbox.c
>>> index c3cb24f51699..04eb44d89119 100644
>>> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
>>> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>>> @@ -39,6 +39,7 @@
>>>    
>>>    #define GCE_GCTL_VALUE			0x48
>>>    #define GCE_CTRL_BY_SW				GENMASK(2, 0)
>>> +#define GCE_DDR_EN				GENMASK(18, 16)
>>>    
>>>    #define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
>>>    #define CMDQ_THR_ENABLED		0x1
>>> @@ -81,6 +82,7 @@ struct cmdq {
>>>    	bool			suspended;
>>>    	u8			shift_pa;
>>>    	bool			control_by_sw;
>>> +	bool			sw_ddr_en;
>>>    	u32			gce_num;
>>>    };
>>>    
>>> @@ -88,6 +90,7 @@ struct gce_plat {
>>>    	u32 thread_nr;
>>>    	u8 shift;
>>>    	bool control_by_sw;
>>> +	bool sw_ddr_en;
>>>    	u32 gce_num;
>>>    };
>>>    
>>> @@ -132,6 +135,9 @@ static void cmdq_init(struct cmdq *cmdq)
>>>    	if (cmdq->control_by_sw)
>>>    		writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
>>>    
>>> +	if (cmdq->sw_ddr_en)
>>> +		writel(GCE_DDR_EN | GCE_CTRL_BY_SW, cmdq->base +
>>> GCE_GCTL_VALUE);
>>> +
>>
>> No. That's redundant.
>> Here's a better way:
>>
>> 	u32 gctl_regval = 0;
>>
>> 	if (cmdq->control_by_sw)
>> 		gctl_regval = GCE_CTRL_BY_SW;
>> 	if (cmdq->sw_ddr_en)
>> 		gctl_regval |= GCE_DDR_EN;
>>
>> 	if (val)
>> 		writel(gctl_regval, cmdq->base + GCE_GCTL_VALUE);
>>
>> Regards,
>> Angelo
> 
> thanks very much for your advise.
> shall i separate this into two patches?
> 1st one is
> 	u32 gctl_regval = 0;
> 	if (cmdq->control_by_sw)
>> 		gctl_regval = GCE_CTRL_BY_SW;
>> 	if (val)
>> 		writel(gctl_regval, cmdq->base + GCE_GCTL_VALUE);
> 
> 
> 
> 2nd just add this
> 	if (cmdq->sw_ddr_en)
>> 		gctl_regval |= GCE_DDR_EN;
> 
> or one patch is ok?
> 

One patch is ok.

Thanks,
Angelo

>>
>>>    	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base +
>>> CMDQ_THR_SLOT_CYCLES);
>>>    	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
>>>    		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
>>> @@ -545,6 +551,7 @@ static int cmdq_probe(struct platform_device
>>> *pdev)
>>>    	cmdq->thread_nr = plat_data->thread_nr;
>>>    	cmdq->shift_pa = plat_data->shift;
>>>    	cmdq->control_by_sw = plat_data->control_by_sw;
>>> +	cmdq->sw_ddr_en = plat_data->sw_ddr_en;
>>>    	cmdq->gce_num = plat_data->gce_num;
>>>    	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>>>    	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler,
>>> IRQF_SHARED,
>>
>>
>>
> 

