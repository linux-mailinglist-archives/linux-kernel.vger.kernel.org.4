Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2A15F406D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiJDJzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJDJza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:55:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFAD2DF8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:55:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 627AB6600368;
        Tue,  4 Oct 2022 10:55:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664877328;
        bh=b5Y8ElT7N++7SJb1cU4AMqocQ9LRd73zhGkOZ0zrkrQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PA2jqHIjLO7dKAOhVLqq624gT5DTAfZhYFeqTKTBHznAEeY/NEh3BhRf3Qht1sFD8
         Tnv/M0fX5Ajid+VmULG3brJrrdFqhUnCWVzQBjtOtpEvFYuvrkCeFr7mOBXYzuWSpe
         JcC71+F0+Vmasr3ZJkzlKbNy4QhPuNK34IH4yeul0NDEi6gEmf57huNDiK8A30dBoB
         /1GoAGurVJCuFqAe/Q0T889c5TRIxORLK5y9djenZyJLEJnScnMs/XCXHOf6TrULLl
         iJDAvNrHcgiNl129MJehQTH4wBtZFYNuvxT1j64/LHVofWpYyQVALcStB2TuFM2Dqs
         wmqBbsESJNHsg==
Message-ID: <6047c983-a367-6a45-6849-9a605f70e5c1@collabora.com>
Date:   Tue, 4 Oct 2022 11:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v8, 3/4] mailbox: mtk-cmdq: add gce ddr enable support
 flow
To:     "yongqiang.niu" <yongqiang.niu@mediatek.com>,
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
 <6bcf2f53-ffd1-5159-47a5-b3d7db548158@collabora.com>
 <af7eb0cacf8657937460287dd3ff9091f9a10f30.camel@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <af7eb0cacf8657937460287dd3ff9091f9a10f30.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/10/22 11:39, yongqiang.niu ha scritto:
> On Mon, 2022-10-03 at 16:54 +0200, AngeloGioacchino Del Regno wrote:
>> Il 30/09/22 18:06, Yongqiang Niu ha scritto:
>>> add gce ddr enable control flow when gce suspend/resume
>>>
>>> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
>>> ---
>>>    drivers/mailbox/mtk-cmdq-mailbox.c | 22 ++++++++++++++++++++++
>>>    1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
>>> b/drivers/mailbox/mtk-cmdq-mailbox.c
>>> index 04eb44d89119..2db82ff838ed 100644
>>> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
>>> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>>> @@ -94,6 +94,18 @@ struct gce_plat {
>>>    	u32 gce_num;
>>>    };
>>>    
>>> +static void cmdq_sw_ddr_enable(struct cmdq *cmdq, bool enable)
>>> +{
>>> +	WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
>>> +
>>> +	if (enable)
>>> +		writel(GCE_DDR_EN | GCE_CTRL_BY_SW, cmdq->base +
>>> GCE_GCTL_VALUE);
>>
>> My only concern here is about the previous value stored in the
>> GCE_GCTL_VALUE
>> register, as you're overwriting it in its entirety with
>> GCE_DDR_EN | GCE_CTRL_BY_SW.
>>
>> Can you guarantee that this register is not pre-initialized with some
>> value,
>> and that these are the only bits to be `1` in this register?
>>
>> Otherwise, you will have to readl and modify the bits instead... by
>> the way,
>> if this register doesn't get any changes during runtime, you may
>> cache it
>> at probe time to avoid reading it for every suspend/resume operation.
>>
>> Regards,
>> Angelo
>>
>>
> 
> 0x48[2:0] means control by software
> 0x48[18:16] means ddr enable
> 0x48[2:0] is pre-condition of 0x48[18:16].
> if we want set 0x48[18:16] ddr enable, 0x48[2:0] must be set at same
> time.
> and only these bits is useful, other bits is useless bits
> 
> we need set 0x48[18:16] to 0 disable gce access ddr when suspend.
> and  set 0x48[18:16] to 0x7 enable gce access ddr when resume, there
> will be cmdq client send task to process.
> this control flow should controlled in suspend/resume flow.
> 
> 

That's perfect. Thanks for the explanation.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


