Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF061F893
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKGQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKGQM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:12:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92BA0A186;
        Mon,  7 Nov 2022 08:12:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81BE01FB;
        Mon,  7 Nov 2022 08:12:32 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FDA93F534;
        Mon,  7 Nov 2022 08:12:24 -0800 (PST)
Message-ID: <903e4690-e2da-f3c9-0c8e-bd11ae922088@arm.com>
Date:   Mon, 7 Nov 2022 17:12:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/20] arm64: dts: Update cache properties for amlogic
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     neil.armstrong@linaro.org, linux-kernel@vger.kernel.org,
        Rob.Herring@arm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20221031091918.531607-1-pierre.gondois@arm.com>
 <fac3eae5-687e-9eb0-ddfb-c659d3816d81@linaro.org>
 <3c54db0a-44fe-ee24-1833-7637e249ec79@arm.com>
 <CAFBinCBi_xT-pgdMSROHyZUfyZZE33S2YXczr9ijE52AfQVYHQ@mail.gmail.com>
 <CAL_JsqJMxH9hFo7uXRJ6rFcqhZL0AUhedk7Fq1xMdKcSDe5ciQ@mail.gmail.com>
 <CAL_JsqLnmDDPpFOcRSv9qEm5nphskhUvQFiKCFkZ6+KGtZLXJQ@mail.gmail.com>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAL_JsqLnmDDPpFOcRSv9qEm5nphskhUvQFiKCFkZ6+KGtZLXJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 11/2/22 15:31, Rob Herring wrote:
> On Mon, Oct 31, 2022 at 5:19 PM Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Mon, Oct 31, 2022 at 4:09 PM Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com> wrote:
>>>
>>> Hi Pierre,
>>>
>>> On Mon, Oct 31, 2022 at 2:33 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>> [...]
>>>> To avoid cc-ing people to DTs they are not related, the get_maintainers.pl
>>>> script was run on each patch individually. The cover-letter is at:
>>>> https://lore.kernel.org/all/20221031091848.530938-1-pierre.gondois@arm.com/
>>> I think Neil's question is the same as mine: is there a dt-bindings
>>> (yaml schema) change for this as well? The idea is to alert people (or
>>> let bots alert people) in future when adding a cache to a .dts{,i}
>>> where the cache-level property is missing.
>>
>> There's not one, but it's something to look at adding. I'm not sure
>> how we'd check for missing 'unified-cache' which is a common problem.
>> The challenge here is a lot of what needs to be checked is based on
>> the overall structure. This probably is better checked in dtc which is
>> better suited to do cross node checks.
> 
> Now there is an improved binding:
> 
> https://github.com/robherring/dt-schema/tree/cache-rework

Thanks for the branch, I used it to make the v2. I don't think it is likely
to happen, but dt-schema doesn't generate a warning if there is a
'unified-cache' property along a '[d|i]-cache-size' property (for instance).

> 
> With that schema and this series applied, I get the following errors:
> 
> arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb: l2-cache:
> 'cache-level' is a required property
> arch/arm64/boot/dts/mediatek/mt8186-evb.dtb: l2-cache0: 'cache-level'
> is a required property
> arch/arm64/boot/dts/mediatek/mt8186-evb.dtb: l2-cache1: 'cache-level'
> is a required property
> arch/arm64/boot/dts/mediatek/mt8186-evb.dtb: l3-cache: 'cache-level'
> is a required property
> arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: l2-cache0:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dtb: l2-cache:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dtb: l2-cache0:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dtb: l2-cache1:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: l2-cache0:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: l2-cache1:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dtb: l2-cache0:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dtb: l2-cache1:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dtb: l2-cache:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dtb: l2-cache:
> 'cache-level' is a required property
> arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dtb: l2-cache:
> 'cache-level' is a required property
> 
> Cases missing 'cache-unified':
> 
> arch/arm64/boot/dts/amazon/alpine-v3-evp.dtb
> arch/arm64/boot/dts/arm/corstone1000-fvp.dtb
> arch/arm64/boot/dts/arm/corstone1000-mps3.dtb
> arch/arm64/boot/dts/arm/juno.dtb
> arch/arm64/boot/dts/arm/juno-r1.dtb
> arch/arm64/boot/dts/arm/juno-r1-scmi.dtb
> arch/arm64/boot/dts/arm/juno-r2.dtb
> arch/arm64/boot/dts/arm/juno-r2-scmi.dtb
> arch/arm64/boot/dts/arm/juno-scmi.dtb
> arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dtb
> arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dtb
> arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dtb
> arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dtb
> arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb
> arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dtb
> arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dtb
> arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dtb
> arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb
> arch/arm64/boot/dts/exynos/exynos5433-tm2e.dtb
> arch/arm64/boot/dts/exynos/exynos7-espresso.dtb
> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb
> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb
> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb
> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb
> arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb
> arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb
> arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb
> arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dtb
> arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dtb
> arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dtb
> arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dtb
> arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dtb
> arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dtb
> arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
> arch/arm64/boot/dts/freescale/imx8mn-evk.dtb
> arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
> arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb
> arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb
> arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
> arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
> arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
> arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
> arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
> arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
> arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
> arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
> arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
> arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
> arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
> arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb
> arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dtb
> arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtb
> arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb
> arch/arm64/boot/dts/marvell/armada-7040-db.dtb
> arch/arm64/boot/dts/marvell/armada-7040-mochabin.dtb
> arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb
> arch/arm64/boot/dts/marvell/armada-8040-db.dtb
> arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb
> arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dtb
> arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb
> arch/arm64/boot/dts/marvell/cn9130-crb-A.dtb
> arch/arm64/boot/dts/marvell/cn9130-crb-B.dtb
> arch/arm64/boot/dts/marvell/cn9130-db-B.dtb
> arch/arm64/boot/dts/marvell/cn9130-db.dtb
> arch/arm64/boot/dts/marvell/cn9131-db-B.dtb
> arch/arm64/boot/dts/marvell/cn9131-db.dtb
> arch/arm64/boot/dts/marvell/cn9132-db-B.dtb
> arch/arm64/boot/dts/marvell/cn9132-db.dtb
> arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dtb
> arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dtb
> arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dtb
> arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dtb
> arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb
> arch/arm64/boot/dts/tesla/fsd-evb.dtb
> arch/arm64/boot/dts/ti/k3-am625-sk.dtb
> arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb
> arch/arm64/boot/dts/ti/k3-am642-sk.dtb
> arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb
> arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dtb
> arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dtb
> arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dtb
> arch/arm64/boot/dts/ti/k3-am654-base-board.dtb
> arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dtb
> arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb
> arch/arm64/boot/dts/ti/k3-j721e-sk.dtb
> arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb
> 
> 
> Rob
