Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889D6712AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjEZQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjEZQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:46:10 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2E8BC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:46:09 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b02497f4cfso248195ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685119568; x=1687711568;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZ7xESGkDIP+gv/TyxcTjr26EqMcpWBeDTIWa0uSfo8=;
        b=FRrKuTiEl6n5Y3SnJf7OM9YV33dkaJsET/iDYZbH2iDp5VEd+6QdkqWJLIcF7byu35
         ERe/EyYmkO6oGZlmZZD4Pu4WeIN4eoToGi4pQ/nOs5SMnbdHH/UWVsj9R1dHx/1nkE/l
         svK3D9XEzcDe/OuaZfEgtaLjN0uXqlQI87ma88b7GE6lcFRnlexK+Zsgk6DbpJS1j4+U
         0WmWDMnChBIENDNx4ZHLj9ao7/kiRFg5L5Fahg+UbB9cESus4bW+LxNLPeBl3sAz0AWk
         gViCwh65WqPWzRzKHBUKPB9rB1T1UAoXEB4+1bxETax/wteUAyJIncG85owVreUXL3gu
         KyNw==
X-Gm-Message-State: AC+VfDxX+tPlgGrRAg2bnWa9T37WEnQhsgCr/sdxmoaDmwKMQxHLBGQc
        rG6R9/pvvZUIjOuJsrbZ39u9KQ==
X-Google-Smtp-Source: ACHHUZ7Xubhmddh9lHC80YV+z3qVxVDPAYZeGbq4cA+Ll4YhSqJ35CM4QoUFgfB49VTsdGyJNaRudw==
X-Received: by 2002:a17:903:4282:b0:1b0:fe9:e57e with SMTP id ju2-20020a170903428200b001b00fe9e57emr2665913plb.0.1685119568432;
        Fri, 26 May 2023 09:46:08 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id jc21-20020a17090325d500b001afba6edc8esm3481642plb.166.2023.05.26.09.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 09:45:48 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
In-Reply-To: <20230523114618.laajn2et5nbcxszv@blmsp>
References: <20230511133226.913600-1-msp@baylibre.com>
 <20230523114618.laajn2et5nbcxszv@blmsp>
Date:   Fri, 26 May 2023 09:45:47 -0700
Message-ID: <7hsfbjxcqs.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> just wanted to ask if I need to do something specific for it to go into
> a rc? Sorry if I missed doing something for that, I haven't had to fix
> something in an rc that often before.

I think the  Fixes tag is enough to indicate that.

Steven, is there still time for this fix be queued up for v6.4-rc?

Thanks,

Kevin

> On Thu, May 11, 2023 at 03:32:26PM +0200, Markus Schneider-Pargmann wrote:
>> The given operations are inverted for the wrong registers which makes
>> multiple of the mt8365 hardware units unusable. In my setup at least usb
>> did not work.
>> 
>> Fixed by swapping the operations with the inverted ones.
>> 
>> Reported-by: Alexandre Mergnat <amergnat@baylibre.com>
>> Fixes: 905b7430d3cc ("clk: mediatek: mt8365: Convert simple_gate to mtk_gate clocks")
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>  drivers/clk/mediatek/clk-mt8365.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
>> index 6b4e193f648d..6d785ec5754d 100644
>> --- a/drivers/clk/mediatek/clk-mt8365.c
>> +++ b/drivers/clk/mediatek/clk-mt8365.c
>> @@ -583,15 +583,15 @@ static const struct mtk_gate_regs top2_cg_regs = {
>>  
>>  #define GATE_TOP0(_id, _name, _parent, _shift)			\
>>  	GATE_MTK(_id, _name, _parent, &top0_cg_regs,		\
>> -		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
>> +		 _shift, &mtk_clk_gate_ops_no_setclr)
>>  
>>  #define GATE_TOP1(_id, _name, _parent, _shift)			\
>>  	GATE_MTK(_id, _name, _parent, &top1_cg_regs,		\
>> -		 _shift, &mtk_clk_gate_ops_no_setclr)
>> +		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
>>  
>>  #define GATE_TOP2(_id, _name, _parent, _shift)			\
>>  	GATE_MTK(_id, _name, _parent, &top2_cg_regs,		\
>> -		 _shift, &mtk_clk_gate_ops_no_setclr)
>> +		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
>>  
>>  static const struct mtk_gate top_clk_gates[] = {
>>  	GATE_TOP0(CLK_TOP_CONN_32K, "conn_32k", "clk32k", 10),
>> -- 
>> 2.40.1
>> 
