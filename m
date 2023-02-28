Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3396A5133
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjB1CbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB1CbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:31:07 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71C26CC5;
        Mon, 27 Feb 2023 18:31:01 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DC53924E3AC;
        Tue, 28 Feb 2023 10:30:59 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 10:30:59 +0800
Received: from [192.168.125.82] (113.72.145.171) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 10:30:58 +0800
Message-ID: <6f3a30e0-6c8e-04d9-53b2-48a26d8a70a6@starfivetech.com>
Date:   Tue, 28 Feb 2023 10:30:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 11/19] clk: starfive: Add StarFive JH7110 system clock
 driver
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-12-hal.feng@starfivetech.com>
 <CAJM55Z8Hf+kJ72CV1uFvNL2g3YjCgEciG7rMJQhZ5O7R1F3RAw@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z8Hf+kJ72CV1uFvNL2g3YjCgEciG7rMJQhZ5O7R1F3RAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2023 17:07:04 +0100, Emil Renner Berthing wrote:
> On Tue, 21 Feb 2023 at 03:47, Hal Feng <hal.feng@starfivetech.com> wrote:
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> new file mode 100644
>> index 000000000000..6e230b81a387
>> --- /dev/null
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> @@ -0,0 +1,448 @@
[...]
>> +static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
>> +       /* root */
>> +       JH71X0__MUX(JH7110_SYSCLK_CPU_ROOT, "cpu_root", 2,
>> +                   JH7110_SYSCLK_OSC,
>> +                   JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_CPU_CORE, "cpu_core", 7, JH7110_SYSCLK_CPU_ROOT),
>> +       JH71X0__DIV(JH7110_SYSCLK_CPU_BUS, "cpu_bus", 2, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0__MUX(JH7110_SYSCLK_GPU_ROOT, "gpu_root", 2,
>> +                   JH7110_SYSCLK_PLL2_OUT,
>> +                   JH7110_SYSCLK_PLL1_OUT),
>> +       JH71X0_MDIV(JH7110_SYSCLK_PERH_ROOT, "perh_root", 2, 2,
>> +                   JH7110_SYSCLK_PLL0_OUT,
>> +                   JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0__MUX(JH7110_SYSCLK_BUS_ROOT, "bus_root", 2,
>> +                   JH7110_SYSCLK_OSC,
>> +                   JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_NOCSTG_BUS, "nocstg_bus", 3, JH7110_SYSCLK_BUS_ROOT),
>> +       JH71X0__DIV(JH7110_SYSCLK_AXI_CFG0, "axi_cfg0", 3, JH7110_SYSCLK_BUS_ROOT),
>> +       JH71X0__DIV(JH7110_SYSCLK_STG_AXIAHB, "stg_axiahb", 2, JH7110_SYSCLK_AXI_CFG0),
>> +       JH71X0_GATE(JH7110_SYSCLK_AHB0, "ahb0", CLK_IS_CRITICAL, JH7110_SYSCLK_STG_AXIAHB),
>> +       JH71X0_GATE(JH7110_SYSCLK_AHB1, "ahb1", CLK_IS_CRITICAL, JH7110_SYSCLK_STG_AXIAHB),
>> +       JH71X0__DIV(JH7110_SYSCLK_APB_BUS, "apb_bus", 8, JH7110_SYSCLK_STG_AXIAHB),
>> +       JH71X0_GATE(JH7110_SYSCLK_APB0, "apb0", CLK_IS_CRITICAL, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0__DIV(JH7110_SYSCLK_PLL0_DIV2, "pll0_div2", 2, JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_PLL1_DIV2, "pll1_div2", 2, JH7110_SYSCLK_PLL1_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_PLL2_DIV2, "pll2_div2", 2, JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_AUDIO_ROOT, "audio_root", 8, JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_MCLK_INNER, "mclk_inner", 64, JH7110_SYSCLK_AUDIO_ROOT),
>> +       JH71X0__MUX(JH7110_SYSCLK_MCLK, "mclk", 2,
>> +                   JH7110_SYSCLK_MCLK_INNER,
>> +                   JH7110_SYSCLK_MCLK_EXT),
>> +       JH71X0_GATE(JH7110_SYSCLK_MCLK_OUT, "mclk_out", 0, JH7110_SYSCLK_MCLK_INNER),
>> +       JH71X0_MDIV(JH7110_SYSCLK_ISP_2X, "isp_2x", 8, 2,
>> +                   JH7110_SYSCLK_PLL2_OUT,
>> +                   JH7110_SYSCLK_PLL1_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_ISP_AXI, "isp_axi", 4, JH7110_SYSCLK_ISP_2X),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GCLK0, "gclk0", 0, 62, JH7110_SYSCLK_PLL0_DIV2),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GCLK1, "gclk1", 0, 62, JH7110_SYSCLK_PLL1_DIV2),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GCLK2, "gclk2", 0, 62, JH7110_SYSCLK_PLL2_DIV2),
>> +       /* cores */
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE, "core", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE1, "core1", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE2, "core2", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE3, "core3", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE4, "core4", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_DEBUG, "debug", 0, JH7110_SYSCLK_CPU_BUS),
>> +       JH71X0__DIV(JH7110_SYSCLK_RTC_TOGGLE, "rtc_toggle", 6, JH7110_SYSCLK_OSC),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE0, "trace0", 0, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE1, "trace1", 0, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE2, "trace2", 0, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE3, "trace3", 0, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE4, "trace4", 0, JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE_COM, "trace_com", 0, JH7110_SYSCLK_CPU_BUS),
>> +       /* noc */
>> +       JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_CPU_AXI, "noc_bus_cpu_axi", CLK_IS_CRITICAL,
>> +                   JH7110_SYSCLK_CPU_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI, "noc_bus_axicfg0_axi", CLK_IS_CRITICAL,
>> +                   JH7110_SYSCLK_AXI_CFG0),
>> +       /* ddr */
>> +       JH71X0__DIV(JH7110_SYSCLK_OSC_DIV2, "osc_div2", 2, JH7110_SYSCLK_OSC),
>> +       JH71X0__DIV(JH7110_SYSCLK_PLL1_DIV4, "pll1_div4", 2, JH7110_SYSCLK_PLL1_DIV2),
>> +       JH71X0__DIV(JH7110_SYSCLK_PLL1_DIV8, "pll1_div8", 2, JH7110_SYSCLK_PLL1_DIV4),
>> +       JH71X0__MUX(JH7110_SYSCLK_DDR_BUS, "ddr_bus", 4,
>> +                   JH7110_SYSCLK_OSC_DIV2,
>> +                   JH7110_SYSCLK_PLL1_DIV2,
>> +                   JH7110_SYSCLK_PLL1_DIV4,
>> +                   JH7110_SYSCLK_PLL1_DIV8),
>> +       JH71X0_GATE(JH7110_SYSCLK_DDR_AXI, "ddr_axi", CLK_IGNORE_UNUSED, JH7110_SYSCLK_DDR_BUS),
>> +       /* gpu */
>> +       JH71X0__DIV(JH7110_SYSCLK_GPU_CORE, "gpu_core", 7, JH7110_SYSCLK_GPU_ROOT),
>> +       JH71X0_GATE(JH7110_SYSCLK_GPU_CORE_CLK, "gpu_core_clk", 0, JH7110_SYSCLK_GPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_GPU_SYS_CLK, "gpu_sys_clk", 0, JH7110_SYSCLK_ISP_AXI),
>> +       JH71X0_GATE(JH7110_SYSCLK_GPU_APB, "gpu_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GPU_RTC_TOGGLE, "gpu_rtc_toggle", 0, 12, JH7110_SYSCLK_OSC),
>> +       JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_GPU_AXI, "noc_bus_gpu_axi", 0, JH7110_SYSCLK_GPU_CORE),
>> +       /* isp */
>> +       JH71X0_GATE(JH7110_SYSCLK_ISP_TOP_CORE, "isp_top_core", 0, JH7110_SYSCLK_ISP_2X),
>> +       JH71X0_GATE(JH7110_SYSCLK_ISP_TOP_AXI, "isp_top_axi", 0, JH7110_SYSCLK_ISP_AXI),
>> +       JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_ISP_AXI, "noc_bus_isp_axi", CLK_IS_CRITICAL,
>> +                   JH7110_SYSCLK_ISP_AXI),
>> +       /* hifi4 */
>> +       JH71X0__DIV(JH7110_SYSCLK_HIFI4_CORE, "hifi4_core", 15, JH7110_SYSCLK_BUS_ROOT),
>> +       JH71X0__DIV(JH7110_SYSCLK_HIFI4_AXI, "hifi4_axi", 2, JH7110_SYSCLK_HIFI4_CORE),
>> +       /* axi_cfg1 */
>> +       JH71X0_GATE(JH7110_SYSCLK_AXI_CFG1_MAIN, "axi_cfg1_main", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_ISP_AXI),
>> +       JH71X0_GATE(JH7110_SYSCLK_AXI_CFG1_AHB, "axi_cfg1_ahb", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_AHB0),
>> +       /* vout */
>> +       JH71X0_GATE(JH7110_SYSCLK_VOUT_SRC, "vout_src", 0, JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_VOUT_AXI, "vout_axi", 7, JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_DISP_AXI, "noc_bus_disp_axi", 0, JH7110_SYSCLK_VOUT_AXI),
>> +       JH71X0_GATE(JH7110_SYSCLK_VOUT_TOP_AHB, "vout_top_ahb", 0, JH7110_SYSCLK_AHB1),
>> +       JH71X0_GATE(JH7110_SYSCLK_VOUT_TOP_AXI, "vout_top_axi", 0, JH7110_SYSCLK_VOUT_AXI),
>> +       JH71X0_GATE(JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK, "vout_top_hdmitx0_mclk", 0,
>> +                   JH7110_SYSCLK_MCLK),
>> +       JH71X0__DIV(JH7110_SYSCLK_VOUT_TOP_MIPIPHY_REF, "vout_top_mipiphy_ref", 2,
>> +                   JH7110_SYSCLK_OSC),
>> +       /* jpegc */
>> +       JH71X0__DIV(JH7110_SYSCLK_JPEGC_AXI, "jpegc_axi", 16, JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0_GATE(JH7110_SYSCLK_CODAJ12_AXI, "codaj12_axi", 0, JH7110_SYSCLK_JPEGC_AXI),
>> +       JH71X0_GDIV(JH7110_SYSCLK_CODAJ12_CORE, "codaj12_core", 0, 16, JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0_GATE(JH7110_SYSCLK_CODAJ12_APB, "codaj12_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       /* vdec */
>> +       JH71X0__DIV(JH7110_SYSCLK_VDEC_AXI, "vdec_axi", 7, JH7110_SYSCLK_BUS_ROOT),
>> +       JH71X0_GATE(JH7110_SYSCLK_WAVE511_AXI, "wave511_axi", 0, JH7110_SYSCLK_VDEC_AXI),
>> +       JH71X0_GDIV(JH7110_SYSCLK_WAVE511_BPU, "wave511_bpu", 0, 7, JH7110_SYSCLK_BUS_ROOT),
>> +       JH71X0_GDIV(JH7110_SYSCLK_WAVE511_VCE, "wave511_vce", 0, 7, JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0_GATE(JH7110_SYSCLK_WAVE511_APB, "wave511_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_VDEC_JPG, "vdec_jpg", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_JPEGC_AXI),
>> +       JH71X0_GATE(JH7110_SYSCLK_VDEC_MAIN, "vdec_main", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_VDEC_AXI),
>> +       JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_VDEC_AXI, "noc_bus_vdec_axi", 0, JH7110_SYSCLK_VDEC_AXI),
>> +       /* venc */
>> +       JH71X0__DIV(JH7110_SYSCLK_VENC_AXI, "venc_axi", 15, JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0_GATE(JH7110_SYSCLK_WAVE420L_AXI, "wave420l_axi", 0, JH7110_SYSCLK_VENC_AXI),
>> +       JH71X0_GDIV(JH7110_SYSCLK_WAVE420L_BPU, "wave420l_bpu", 0, 15, JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0_GDIV(JH7110_SYSCLK_WAVE420L_VCE, "wave420l_vce", 0, 15, JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0_GATE(JH7110_SYSCLK_WAVE420L_APB, "wave420l_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_VENC_AXI, "noc_bus_venc_axi", 0, JH7110_SYSCLK_VENC_AXI),
>> +       /* axi_cfg0 */
>> +       JH71X0_GATE(JH7110_SYSCLK_AXI_CFG0_MAIN_DIV, "axi_cfg0_main_div", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_AHB1),
>> +       JH71X0_GATE(JH7110_SYSCLK_AXI_CFG0_MAIN, "axi_cfg0_main", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_AXI_CFG0),
>> +       JH71X0_GATE(JH7110_SYSCLK_AXI_CFG0_HIFI4, "axi_cfg0_hifi4", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_HIFI4_AXI),
>> +       /* intmem */
>> +       JH71X0_GATE(JH7110_SYSCLK_AXIMEM2_AXI, "aximem2_axi", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_AXI_CFG0),
>> +       /* qspi */
>> +       JH71X0_GATE(JH7110_SYSCLK_QSPI_AHB, "qspi_ahb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_AHB1),
>> +       JH71X0_GATE(JH7110_SYSCLK_QSPI_APB, "qspi_apb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0__DIV(JH7110_SYSCLK_QSPI_REF_SRC, "qspi_ref_src", 16, JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0_GMUX(JH7110_SYSCLK_QSPI_REF, "qspi_ref", CLK_IGNORE_UNUSED, 2,
>> +                   JH7110_SYSCLK_OSC,
>> +                   JH7110_SYSCLK_QSPI_REF_SRC),
>> +       /* sdio */
>> +       JH71X0_GATE(JH7110_SYSCLK_SDIO0_AHB, "sdio0_ahb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_AHB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_SDIO1_AHB, "sdio1_ahb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_AHB0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_SDIO0_SDCARD, "sdio0_sdcard", CLK_IGNORE_UNUSED, 15,
>> +                   JH7110_SYSCLK_AXI_CFG0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_SDIO1_SDCARD, "sdio1_sdcard", CLK_IGNORE_UNUSED, 15,
>> +                   JH7110_SYSCLK_AXI_CFG0),
>> +       /* stg */
>> +       JH71X0__DIV(JH7110_SYSCLK_USB_125M, "usb_125m", 15, JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_STG_AXI, "noc_bus_stg_axi", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_NOCSTG_BUS),
>> +       /* gmac1 */
>> +       JH71X0_GATE(JH7110_SYSCLK_GMAC1_AHB, "gmac1_ahb", 0, JH7110_SYSCLK_AHB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_GMAC1_AXI, "gmac1_axi", 0, JH7110_SYSCLK_STG_AXIAHB),
>> +       JH71X0__DIV(JH7110_SYSCLK_GMAC_SRC, "gmac_src", 7, JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_GMAC1_GTXCLK, "gmac1_gtxclk", 15, JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_GMAC1_RMII_RTX, "gmac1_rmii_rtx", 30,
>> +                   JH7110_SYSCLK_GMAC1_RMII_REFIN),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GMAC1_PTP, "gmac1_ptp", 0, 31, JH7110_SYSCLK_GMAC_SRC),
>> +       JH71X0__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 2,
>> +                   JH7110_SYSCLK_GMAC1_RGMII_RXIN,
>> +                   JH7110_SYSCLK_GMAC1_RMII_RTX),
>> +       JH71X0__INV(JH7110_SYSCLK_GMAC1_RX_INV, "gmac1_rx_inv", JH7110_SYSCLK_GMAC1_RX),
>> +       JH71X0_GMUX(JH7110_SYSCLK_GMAC1_TX, "gmac1_tx", 0, 2,
>> +                   JH7110_SYSCLK_GMAC1_GTXCLK,
>> +                   JH7110_SYSCLK_GMAC1_RMII_RTX),
>> +       JH71X0__INV(JH7110_SYSCLK_GMAC1_TX_INV, "gmac1_tx_inv", JH7110_SYSCLK_GMAC1_TX),
>> +       JH71X0_GATE(JH7110_SYSCLK_GMAC1_GTXC, "gmac1_gtxc", 0, JH7110_SYSCLK_GMAC1_GTXCLK),
>> +       /* gmac0 */
>> +       JH71X0_GDIV(JH7110_SYSCLK_GMAC0_GTXCLK, "gmac0_gtxclk", 0, 15, JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GMAC0_PTP, "gmac0_ptp", 0, 31, JH7110_SYSCLK_GMAC_SRC),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GMAC_PHY, "gmac_phy", 0, 31, JH7110_SYSCLK_GMAC_SRC),
>> +       JH71X0_GATE(JH7110_SYSCLK_GMAC0_GTXC, "gmac0_gtxc", 0, JH7110_SYSCLK_GMAC0_GTXCLK),
>> +       /* apb misc */
>> +       JH71X0_GATE(JH7110_SYSCLK_IOMUX_APB, "iomux_apb", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_MAILBOX_APB, "mailbox_apb", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_INT_CTRL_APB, "int_ctrl_apb", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_APB_BUS),
>> +       /* can0 */
>> +       JH71X0_GATE(JH7110_SYSCLK_CAN0_APB, "can0_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GDIV(JH7110_SYSCLK_CAN0_TIMER, "can0_timer", 0, 24, JH7110_SYSCLK_OSC),
>> +       JH71X0_GDIV(JH7110_SYSCLK_CAN0_CAN, "can0_can", 0, 63, JH7110_SYSCLK_PERH_ROOT),
>> +       /* can1 */
>> +       JH71X0_GATE(JH7110_SYSCLK_CAN1_APB, "can1_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GDIV(JH7110_SYSCLK_CAN1_TIMER, "can1_timer", 0, 24, JH7110_SYSCLK_OSC),
>> +       JH71X0_GDIV(JH7110_SYSCLK_CAN1_CAN, "can1_can", 0, 63, JH7110_SYSCLK_PERH_ROOT),
>> +       /* pwm */
>> +       JH71X0_GATE(JH7110_SYSCLK_PWM_APB, "pwm_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       /* wdt */
>> +       JH71X0_GATE(JH7110_SYSCLK_WDT_APB, "wdt_apb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_WDT_CORE, "wdt_core", CLK_IGNORE_UNUSED, JH7110_SYSCLK_OSC),
>> +       /* timer */
>> +       JH71X0_GATE(JH7110_SYSCLK_TIMER_APB, "timer_apb", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_TIMER0, "timer0", CLK_IGNORE_UNUSED, JH7110_SYSCLK_OSC),
>> +       JH71X0_GATE(JH7110_SYSCLK_TIMER1, "timer1", CLK_IGNORE_UNUSED, JH7110_SYSCLK_OSC),
>> +       JH71X0_GATE(JH7110_SYSCLK_TIMER2, "timer2", CLK_IGNORE_UNUSED, JH7110_SYSCLK_OSC),
>> +       JH71X0_GATE(JH7110_SYSCLK_TIMER3, "timer3", CLK_IGNORE_UNUSED, JH7110_SYSCLK_OSC),
>> +       /* temp sensor */
>> +       JH71X0_GATE(JH7110_SYSCLK_TEMP_APB, "temp_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GDIV(JH7110_SYSCLK_TEMP_CORE, "temp_core", 0, 24, JH7110_SYSCLK_OSC),
>> +       /* spi */
>> +       JH71X0_GATE(JH7110_SYSCLK_SPI0_APB, "spi0_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_SPI1_APB, "spi1_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_SPI2_APB, "spi2_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_SPI3_APB, "spi3_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_SPI4_APB, "spi4_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_SPI5_APB, "spi5_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_SPI6_APB, "spi6_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       /* i2c */
>> +       JH71X0_GATE(JH7110_SYSCLK_I2C0_APB, "i2c0_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_I2C1_APB, "i2c1_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_I2C2_APB, "i2c2_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_I2C3_APB, "i2c3_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_I2C4_APB, "i2c4_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_I2C5_APB, "i2c5_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       JH71X0_GATE(JH7110_SYSCLK_I2C6_APB, "i2c6_apb", 0, JH7110_SYSCLK_APB_BUS),
>> +       /* uart */
>> +       JH71X0_GATE(JH7110_SYSCLK_UART0_APB, "uart0_apb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_UART0_CORE, "uart0_core", CLK_IGNORE_UNUSED, JH7110_SYSCLK_OSC),
>> +       JH71X0_GATE(JH7110_SYSCLK_UART1_APB, "uart1_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_UART1_CORE, "uart1_core", 0, JH7110_SYSCLK_OSC),
>> +       JH71X0_GATE(JH7110_SYSCLK_UART2_APB, "uart2_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_UART2_CORE, "uart2_core", 0, JH7110_SYSCLK_OSC),
>> +       JH71X0_GATE(JH7110_SYSCLK_UART3_APB, "uart3_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_UART3_CORE, "uart3_core", 0, 10, JH7110_SYSCLK_PERH_ROOT),
>> +       JH71X0_GATE(JH7110_SYSCLK_UART4_APB, "uart4_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_UART4_CORE, "uart4_core", 0, 10, JH7110_SYSCLK_PERH_ROOT),
>> +       JH71X0_GATE(JH7110_SYSCLK_UART5_APB, "uart5_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_UART5_CORE, "uart5_core", 0, 10, JH7110_SYSCLK_PERH_ROOT),
>> +       /* pwmdac */
>> +       JH71X0_GATE(JH7110_SYSCLK_PWMDAC_APB, "pwmdac_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_PWMDAC_CORE, "pwmdac_core", 0, 256, JH7110_SYSCLK_AUDIO_ROOT),
>> +       /* spdif */
>> +       JH71X0_GATE(JH7110_SYSCLK_SPDIF_APB, "spdif_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_SPDIF_CORE, "spdif_core", 0, JH7110_SYSCLK_MCLK),
>> +       /* i2stx0 */
>> +       JH71X0_GATE(JH7110_SYSCLK_I2STX0_APB, "i2stx0_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_I2STX0_BCLK_MST, "i2stx0_bclk_mst", 0, 32, JH7110_SYSCLK_MCLK),
>> +       JH71X0__INV(JH7110_SYSCLK_I2STX0_BCLK_MST_INV, "i2stx0_bclk_mst_inv",
>> +                   JH7110_SYSCLK_I2STX0_BCLK_MST),
>> +       JH71X0_MDIV(JH7110_SYSCLK_I2STX0_LRCK_MST, "i2stx0_lrck_mst", 64, 2,
>> +                   JH7110_SYSCLK_I2STX0_BCLK_MST_INV,
>> +                   JH7110_SYSCLK_I2STX0_BCLK_MST),
>> +       JH71X0__MUX(JH7110_SYSCLK_I2STX0_BCLK, "i2stx0_bclk",   2,
>> +                   JH7110_SYSCLK_I2STX0_BCLK_MST,
>> +                   JH7110_SYSCLK_I2STX_BCLK_EXT),
>> +       JH71X0__INV(JH7110_SYSCLK_I2STX0_BCLK_INV, "i2stx0_bclk_inv", JH7110_SYSCLK_I2STX0_BCLK),
>> +       JH71X0__MUX(JH7110_SYSCLK_I2STX0_LRCK, "i2stx0_lrck", 2,
>> +                   JH7110_SYSCLK_I2STX0_LRCK_MST,
>> +                   JH7110_SYSCLK_I2STX_LRCK_EXT),
>> +       /* i2stx1 */
>> +       JH71X0_GATE(JH7110_SYSCLK_I2STX1_APB, "i2stx1_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_I2STX1_BCLK_MST, "i2stx1_bclk_mst", 0, 32, JH7110_SYSCLK_MCLK),
>> +       JH71X0__INV(JH7110_SYSCLK_I2STX1_BCLK_MST_INV, "i2stx1_bclk_mst_inv",
>> +                   JH7110_SYSCLK_I2STX1_BCLK_MST),
>> +       JH71X0_MDIV(JH7110_SYSCLK_I2STX1_LRCK_MST, "i2stx1_lrck_mst", 64, 2,
>> +                   JH7110_SYSCLK_I2STX1_BCLK_MST_INV,
>> +                   JH7110_SYSCLK_I2STX1_BCLK_MST),
>> +       JH71X0__MUX(JH7110_SYSCLK_I2STX1_BCLK, "i2stx1_bclk", 2,
>> +                   JH7110_SYSCLK_I2STX1_BCLK_MST,
>> +                   JH7110_SYSCLK_I2STX_BCLK_EXT),
>> +       JH71X0__INV(JH7110_SYSCLK_I2STX1_BCLK_INV, "i2stx1_bclk_inv", JH7110_SYSCLK_I2STX1_BCLK),
>> +       JH71X0__MUX(JH7110_SYSCLK_I2STX1_LRCK, "i2stx1_lrck", 2,
>> +                   JH7110_SYSCLK_I2STX1_LRCK_MST,
>> +                   JH7110_SYSCLK_I2STX_LRCK_EXT),
>> +       /* i2srx */
>> +       JH71X0_GATE(JH7110_SYSCLK_I2SRX_APB, "i2srx_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_I2SRX_BCLK_MST, "i2srx_bclk_mst", 0, 32, JH7110_SYSCLK_MCLK),
>> +       JH71X0__INV(JH7110_SYSCLK_I2SRX_BCLK_MST_INV, "i2srx_bclk_mst_inv",
>> +                   JH7110_SYSCLK_I2SRX_BCLK_MST),
>> +       JH71X0_MDIV(JH7110_SYSCLK_I2SRX_LRCK_MST, "i2srx_lrck_mst", 64, 2,
>> +                   JH7110_SYSCLK_I2SRX_BCLK_MST_INV,
>> +                   JH7110_SYSCLK_I2SRX_BCLK_MST),
>> +       JH71X0__MUX(JH7110_SYSCLK_I2SRX_BCLK, "i2srx_bclk", 2,
>> +                   JH7110_SYSCLK_I2SRX_BCLK_MST,
>> +                   JH7110_SYSCLK_I2SRX_BCLK_EXT),
>> +       JH71X0__INV(JH7110_SYSCLK_I2SRX_BCLK_INV, "i2srx_bclk_inv", JH7110_SYSCLK_I2SRX_BCLK),
>> +       JH71X0__MUX(JH7110_SYSCLK_I2SRX_LRCK, "i2srx_lrck", 2,
>> +                   JH7110_SYSCLK_I2SRX_LRCK_MST,
>> +                   JH7110_SYSCLK_I2SRX_LRCK_EXT),
>> +       /* pdm */
>> +       JH71X0_GDIV(JH7110_SYSCLK_PDM_DMIC, "pdm_dmic", 0, 64, JH7110_SYSCLK_MCLK),
>> +       JH71X0_GATE(JH7110_SYSCLK_PDM_APB, "pdm_apb", 0, JH7110_SYSCLK_APB0),
>> +       /* tdm */
>> +       JH71X0_GATE(JH7110_SYSCLK_TDM_AHB, "tdm_ahb", 0, JH7110_SYSCLK_AHB0),
>> +       JH71X0_GATE(JH7110_SYSCLK_TDM_APB, "tdm_apb", 0, JH7110_SYSCLK_APB0),
>> +       JH71X0_GDIV(JH7110_SYSCLK_TDM_INTERNAL, "tdm_internal", 0, 64, JH7110_SYSCLK_MCLK),
>> +       JH71X0__MUX(JH7110_SYSCLK_TDM_TDM, "tdm_tdm", 2,
>> +                   JH7110_SYSCLK_TDM_INTERNAL,
>> +                   JH7110_SYSCLK_TDM_EXT),
>> +       JH71X0__INV(JH7110_SYSCLK_TDM_TDM_INV, "tdm_tdm_inv", JH7110_SYSCLK_TDM_TDM),
>> +       /* jtag */
>> +       JH71X0__DIV(JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG, "jtag_certification_trng", 4,
>> +                   JH7110_SYSCLK_OSC),
>> +};
> 
> Hi Hal,
> 
> I noticed this list still contains both clocks with the
> CLK_IS_CRITICAL flag and the CLK_IGNORE_UNUSED. I fear I may be source
> of this because I used the CLK_IGNORE_UNUSED as a placeholder until I
> figured out if the clock was critical or not. For the next revision
> could you please go through clocks marked with CLK_IGNORE_UNUSED and
> determine if they're critical or they can be safely turned off when
> not used by any peripheral.

I had synchronized these clock flags with JH7110 SDK before. I will
recheck these again. Thanks.

Best regards,
Hal
