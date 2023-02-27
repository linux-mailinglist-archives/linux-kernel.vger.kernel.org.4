Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552B46A3BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjB0Hry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjB0Hrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:47:52 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4538E;
        Sun, 26 Feb 2023 23:47:49 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7173C24E094;
        Mon, 27 Feb 2023 15:47:48 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 15:47:48 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 15:47:47 +0800
Message-ID: <ca9bed19-9809-9443-7ca1-1d11984ded55@starfivetech.com>
Date:   Mon, 27 Feb 2023 15:47:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 0/4] StarFive's SDIO/eMMC driver support
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        <linux-kernel@vger.kernel.org>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <CAPDyKFqJxrLh+pgQ-u_Lwxv4_TsH--rga049GBTqKAa_M14_yw@mail.gmail.com>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAPDyKFqJxrLh+pgQ-u_Lwxv4_TsH--rga049GBTqKAa_M14_yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/15 20:37, Ulf Hansson wrote:
> On Wed, 15 Feb 2023 at 12:32, William Qiu <william.qiu@starfivetech.com> wrote:
>>
>> Hi,
>>
>> This patchset adds initial rudimentary support for the StarFive
>> designware mobile storage host controller driver. And this driver will
>> be used in StarFive's VisionFive 2 board. The main purpose of adding
>> this driver is to accommodate the ultra-high speed mode of eMMC.
>>
>> The last patch should be applied after the patchset [1]:
>> [1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
>>
>> Changes v3->v4:
>> - Added documentation to describe StarFive System Controller Registers.
>> - Added aon_syscon and stg_syscon node.
>> - Fixed some checkpatch errors/warnings.
>>
>> Changes v2->v3:
>> - Wraped commit message according to Linux coding style.
>> - Rephrased the description of the patches.
>> - Changed the description of syscon regsiter.
>> - Dropped redundant properties.
>>
>> Changes v1->v2:
>> - Renamed the dt-binding 'starfive,jh7110-sdio.yaml' to 'starfive,jh7110-mmc.yaml'.
>> - Changed the type of 'starfive,syscon' and modify its description.
>> - Deleted unused head files like '#include <linux/gpio.h>'.
>> - Added comment for the 'rise_point' and 'fall_point'.
>> - Changed the API 'num_caps' to 'common_caps'.
>> - Changed the node name 'sys_syscon' to 'syscon'.
>> - Changed the node name 'sdio' to 'mmc'.
>>
>> The patch series is based on v6.1.
>>
>> William Qiu (4):
>>   dt-bindings: mmc: Add StarFive MMC module
>>   mmc: starfive: Add sdio/emmc driver support
>>   riscv: dts: starfive: Add mmc node
>>   dt-bindings: syscon: Add StarFive syscon doc
>>
>>  .../bindings/mmc/starfive,jh7110-mmc.yaml     |  77 ++++++++
>>  .../bindings/soc/starfive/jh7110-syscon.yaml  |  51 +++++
>>  MAINTAINERS                                   |  11 ++
>>  .../jh7110-starfive-visionfive-2.dtsi         |  23 +++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  47 +++++
>>  drivers/mmc/host/Kconfig                      |  10 +
>>  drivers/mmc/host/Makefile                     |   1 +
>>  drivers/mmc/host/dw_mmc-starfive.c            | 186 ++++++++++++++++++
>>  8 files changed, 406 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
>>
> 
> I have dropped the v3 patches and applied patch1 and patch2 from the
> v4 series instead, for my next branch, thanks!
> 
> Kind regards
> Uffe

Hi Uffe,

Sorry to bother you.But I found a bug that in drivers/mmc/host/dw_mmc-starfive.c:

    47 static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
    48                                              u32 opcode)
    49 {
    50         static const int grade  = MAX_DELAY_CHAIN;
    51         struct dw_mci *host = slot->host;
    52         struct starfive_priv *priv = host->priv;
    53         int rise_point = -1, fall_point = -1;
    54         int err, prev_err;
    55         int i;
    56         bool found = 0;
    57         u32 regval;
    58 
    59         /*
    60          * Use grade as the max delay chain, and use the rise_point and
    61          * fall_point to ensure the best sampling point of a data input
    62          * signals.
    63          */
    64         for (i = 0; i < grade; i++) {
    65                 regval = i << priv->syscon_shift;
    66                 err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
    67                                                 priv->syscon_mask, regval);
    68                 if (err)
    69                         return err;
    70                 mci_writel(host, RINTSTS, ALL_INT_CLR);
    71 
    72                 err = mmc_send_tuning(slot->mmc, opcode, NULL);
    73                 if (!err)
    74                         found = 1;
    75 
    76                 if (i > 0) {
--> 77                         if (err && !prev_err)

prev_err was never initialized to zero.

So I'm here to ask for your suggestion, should I send a new version
to fix it or send you a patch with a fixes tag?

Best regards
William
