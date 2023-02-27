Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7F6A3F93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjB0KkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjB0Kj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:39:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432157EF8;
        Mon, 27 Feb 2023 02:39:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id da10so23861906edb.3;
        Mon, 27 Feb 2023 02:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJv+ImXEWwKxtxcDHhbUjYhxuovb1z++sYpE1nynPoU=;
        b=iNnHcSXK8CR2HQiOlSHomQ/H0E0zNsJAgiEGSJg30AGVTMnFeeh2iCfoO1CfTXcLSp
         WdigZ0Tq8Xkm2oSgnEQ6wqoejhByNgRQfFyAyPvga3UQUyQwZErZAozhqLjK1AzE0C0N
         ajeM69Xh0/cQkQFIxfQSw8rzwWWL/xlPXemp5CC54d3hxoVZZZuAx44wx7QKsdMi2jZs
         HmgP60673rXSYowAfuKuYhecLLHUfYTBCNhpkJ9gsr/WQrUvUsxM+/DBWQ9gO7fsy/3Z
         uiF+qTqw9BSaTvHZN+8WzMgIphkVHEL5z5zOYXRyvZwIAcd7YD1O1VPite6LWv1OAx2G
         QmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJv+ImXEWwKxtxcDHhbUjYhxuovb1z++sYpE1nynPoU=;
        b=iP8AFrVdZVtTsHl3ckl7JBKFmje9ke3lZvL9KkRoP4CFXFHj0nCiYTlSKYfP2My7Ci
         Mb6bf6qDkFJUwApyxMIZgNqDDhUZQa3Xhj06jm1W14RiK5plT26b4YVik9oh1vJLs501
         rc7yIdrWc4FkDEUVMpH69Oqu/S8ngtfa0UlS0j2aFntWELQB2f8LaXQMuRbsfNgkWHxN
         WMkkogP6fWvHF9jg728IKD7ZquZVQhcckZ0O0L2jiXycFr5Yw92mNXadiRD7KnaEoAcW
         BflSRM2ofiTmg6KQwfabBuey+W7IK3+znbD6O27zJ7EJId+GWtSrSxE4Ns5Wxw57ha/G
         iaHQ==
X-Gm-Message-State: AO0yUKVYDSQFdoYwnBbr5lURdQfda1jGTN/94K4rPUeHxquRRu7H4CAV
        Yg0cCs6skP9ZCB9KTzge/U4=
X-Google-Smtp-Source: AK7set9+gkZY4Bof7ME6eWpMPhWuZ91zv7l5Xi7oUcFvbkoPTNgEi+7Ntc5u0V4JP7vjd3ysJc4rtA==
X-Received: by 2002:a17:907:5c6:b0:8af:3b78:315d with SMTP id wg6-20020a17090705c600b008af3b78315dmr43733486ejb.23.1677494396642;
        Mon, 27 Feb 2023 02:39:56 -0800 (PST)
Received: from [10.33.2.246] ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id r7-20020a170906350700b008b2e4f88ed7sm3054579eja.111.2023.02.27.02.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:39:56 -0800 (PST)
Date:   Mon, 27 Feb 2023 13:39:46 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v3 4/4] clk: mediatek: Add drivers for MediaTek MT6735
 main clock and reset drivers
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Message-Id: <AYIQQR.5R1644EUJNRV2@gmail.com>
In-Reply-To: <cd634833-b28e-d6d3-692d-5a391b85ad34@collabora.com>
References: <20230225094246.261697-1-y.oudjana@protonmail.com>
        <20230225094246.261697-5-y.oudjana@protonmail.com>
        <cd634833-b28e-d6d3-692d-5a391b85ad34@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Feb 27 2023 at 10:28:06 AM +01:00:00, AngeloGioacchino Del 
Regno <angelogioacchino.delregno@collabora.com> wrote:
> Il 25/02/23 10:42, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
>> clock and reset controllers. These provide the base clocks and resets
>> on the platform, and should be enough to bring up all essential 
>> blocks
>> including PWRAP, MSDC and peripherals (UART, I2C, SPI).
>> 
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   MAINTAINERS                                  |   4 +
>>   drivers/clk/mediatek/Kconfig                 |   9 +
>>   drivers/clk/mediatek/Makefile                |   1 +
>>   drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 139 ++++++
>>   drivers/clk/mediatek/clk-mt6735-infracfg.c   |  78 ++++
>>   drivers/clk/mediatek/clk-mt6735-pericfg.c    |  91 ++++
>>   drivers/clk/mediatek/clk-mt6735-topckgen.c   | 450 
>> +++++++++++++++++++
>>   7 files changed, 772 insertions(+)
>>   create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
>>   create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
>>   create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
>>   create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
>> 
> 
> ..snip..
> 
>> diff --git a/drivers/clk/mediatek/clk-mt6735-topckgen.c 
>> b/drivers/clk/mediatek/clk-mt6735-topckgen.c
>> new file mode 100644
>> index 000000000000..5fa743e4b0fc
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt6735-topckgen.c
>> @@ -0,0 +1,450 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-mtk.h"
>> +#include "clk-mux.h"
>> +
>> +#include <dt-bindings/clock/mediatek,mt6735-topckgen.h>
>> +
> 
> ..snip..
> 
>> +
>> +int clk_mt6735_topckgen_probe(struct platform_device *pdev)
> 
> It gets *even easier* than that!
> 
> Check out this one:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20230222092543.19187-5-angelogioacchino.delregno@collabora.com/
> 
> ...being part of:
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=724004
> 
> So you can use simple_probe for MT6735's topckgen too!

Isn't this basically what I did in v2[1][2]? What changed now?

> 
> In this case, it would be...
> 
> static const struct mtk_clk_desc topck_desc = {
> 	.clks = topckgen_muxes,
> 	.num_clks = ARRAY_SIZE(topckgen_muxes),
> 	.fixed_clks = topckgen_fixed_clks,
> 	.num_fixed_clks = ARRAY_SIZE(topckgen_fixed_clks),
> 	.factor_clks = topckgen_factors,
> 	.num_factor_clks = ARRAY_SIZE(topckgen_factors),
> 	.clk_lock = &mt6735_topckgen_lock,
> };
> 
> static const struct of_device_id of_match_mt6735_topckgen[] = {
> 	{ .compatible = "mediatek,mt6735-topckgen", .data = &topck_desc },
> 	{ /* sentinel */ }
> };
> 
> MODULE_DEVICE_TABLE(of, of_match_mt6735_topckgen)
>     ^^^^^
> You're missing that on multiple clock drivers ;-)
> 
> ...And you're replacing .probe(), .remove() callbacks with
> 
> static struct platform_driver clk_mt6735_topckgen = {
> 	.probe = mtk_clk_simple_probe,
> 	.remove = mtk_clk_simple_remove,
> 
> 	......
> 
> Other than that, good job!
> 
> After performing these changes, please make sure to mention the 
> dependency on
> my last cleanup series on your cover letter for v4, so that 
> maintainers will
> be aware of what to do.
> 
> Your v4 smells like Reviewed-by tags all over. Keep up the great work!
> 
> Cheers,
> Angelo

[1] 
https://lore.kernel.org/linux-mediatek/20220519142211.458336-5-y.oudjana@protonmail.com/
[2] 
https://patchwork.kernel.org/project/linux-clk/patch/20220519134728.456643-7-y.oudjana@protonmail.com/



