Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846EA6406E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiLBMeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiLBMd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:33:59 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5A9D836;
        Fri,  2 Dec 2022 04:33:55 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 7EF755FD0B;
        Fri,  2 Dec 2022 15:33:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669984433;
        bh=282kx+HEwvxtZ+H+mSqaI8GU81yvcnptjbfPg0xRDS4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=d2P6mwXz96RuDx0v+EaGl68N58etx16QPu4Nh1WYVurzd7uW5M7ioALfUdL65oMw2
         wi/9tGc91qZ+9tn1OgAeTZUN+WdoMzRb3iV2PVhbpCdkRYkN8naIgoKa79l3LOGghS
         7zf1uUQgJY+ISVTDAden9/Lv4PKL+KvPd/+YPL7q94qufWxjljEB19Utm9SH0J4kGQ
         oVWCreWmp9BrqkrLneDMJbQy9DHg2jOQqAap/afg175Rw1GZspgEoDhmiNlokTUjL1
         qf7//iSE6/xQAGPT5zulmS+uXsP7762cCvnCJhgOUWj4gLr8zaVO3NzO8Kyr0xaPyU
         tkOBMTScwLRCA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 15:33:53 +0300 (MSK)
Date:   Fri, 2 Dec 2022 15:33:53 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 04/11] clk: meson: a1: add support for Amlogic A1
 Peripheral clock driver
Message-ID: <20221202123353.d6l5h5jb26fp5snm@CAB-WSD-L081021>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-5-ddrokosov@sberdevices.ru>
 <1j359y82fn.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1j359y82fn.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/02 07:44:00 #20636821
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...

> > +		.ops = &clk_regmap_gate_ro_ops,
> > +		.parent_data = &(const struct clk_parent_data) {
> > +			.fw_name = "xtal",
> > +		},
> > +		.num_parents = 1,
> > +	},
> > +};
> > +
> > +static struct clk_regmap a1_xtal_fixpll = {
> > +	.data = &(struct clk_regmap_gate_data){
> > +		.offset = SYS_OSCIN_CTRL,
> > +		.bit_idx = 1,
> > +	},
> > +	.hw.init = &(struct clk_init_data) {
> > +		.name = "xtal_fixpll",
> 
> same here, this is not a crystal.
> It is the fixpll input gate, what about "fixpll_in"
> 
> Same bellow - you get the idea ...
> 

Yep, got it. Will fix in the v9.

...

> > +static struct clk_regmap a1_rtc_32k_sel = {
> > +	.data = &(struct clk_regmap_mux_data) {
> > +		.offset = RTC_CTRL,
> > +		.mask = 0x3,
> > +		.shift = 0,
> > +		.flags = CLK_MUX_ROUND_CLOSEST,
> > +	},
> > +	.hw.init = &(struct clk_init_data){
> > +		.name = "rtc_32k_sel",
> > +		.ops = &clk_regmap_mux_ops,
> > +		.parent_hws = (const struct clk_hw *[]) {
> > +			&a1_rtc_32k_xtal.hw,
> > +			&a1_rtc_32k_div.hw,
> > +		},
> > +		.num_parents = 2,
> > +		.flags = CLK_SET_RATE_PARENT,
> > +	},
> > +};
> > +
> > +struct clk_regmap a1_rtc_clk = {
> > +	.data = &(struct clk_regmap_gate_data){
> > +		.offset = RTC_BY_OSCIN_CTRL0,
> > +		.bit_idx = 30,
> > +	},
> > +	.hw.init = &(struct clk_init_data){
> > +		.name = "rtc_clk",
> 
> Everytime there is an "_clk" suffix, you can remove it.
> In this driver, we know we are going to get clocks ;)
> 

Exactly! :-)

...

> > +static struct clk_regmap a1_dspa_en = {
> > +	.data = &(struct clk_regmap_gate_data){
> > +		.offset = DSPA_CLK_EN,
> > +		.bit_idx = 1,
> > +	},
> > +	.hw.init = &(struct clk_init_data) {
> > +		.name = "dspa_en",
> > +		.ops = &clk_regmap_gate_ops,
> > +		.parent_hws = (const struct clk_hw *[]) {
> > +			&a1_dspa_sel.hw
> > +		},
> > +		.num_parents = 1,
> > +		.flags = CLK_SET_RATE_PARENT,
> 
> Maybe as a 2nd step, but I suspect a "CLK_SET_RATE_NOREPARENT" is going to
> be needed here at some point.
> 

I will think about it, and try to mark all needed points with that in
the next version.

...

> > +static struct clk_regmap a1_dspb_a = {
> > +	.data = &(struct clk_regmap_gate_data){
> > +		.offset = DSPB_CLK_CTRL0,
> > +		.bit_idx = 13,
> > +	},
> > +	.hw.init = &(struct clk_init_data) {
> > +		.name = "dspb_a",
> > +		.ops = &clk_regmap_gate_ops,
> > +		.parent_hws = (const struct clk_hw *[]) {
> > +			&a1_dspb_a_div.hw
> > +		},
> > +		.num_parents = 1,
> > +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> 
> Any chance we can remove this CLK_IGNORE_UNUSED, or comment why it is
> needed ?
> 

This is needed for DSP accelerator in the SoC. I'm afraid it can't be
disabled by kernel logic run on Core IP.

...

-- 
Thank you,
Dmitry
