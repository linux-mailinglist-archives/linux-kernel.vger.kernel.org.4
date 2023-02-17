Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2A969ABFC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBQM5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBQM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:56:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873601A951;
        Fri, 17 Feb 2023 04:56:57 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B43D266003AF;
        Fri, 17 Feb 2023 12:56:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676638616;
        bh=1uMyMzusRsK9sVv25EojrYQNhsBuXP/sllRyPTR8+5w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UXK2QT1Yzp4lGU3SFbxfXUpO2p8O3XxLF/QmuMK75o/FD41Ioh6PZ6LuZm2ZeNdFU
         RRz8INhsaSUBa2tfqEMWSHGEg10tykwlvnE/5tmEu+mR6xCTdMxap61bkvGz5jqUwe
         KBZiEtAVcezNL7apcOdhUnwKOAp0H7RGOMHQh4bTUzIyF/DQ9+xA5EWbGWpaHM62oN
         pa5uwqzqwgjdQpHUCzMVEcG06uInl9MsO6j6YyEiPU8h5xOxXzTQLSSJwU1GsTbPIA
         aoipkvC1qmP0ksT1KCwceChlMwdCR4q2t4vcjFVweg+kwvjEMTdn/HooDYswMVal5w
         CMek6dUszn+qg==
Message-ID: <f12eff8f-7f6f-cd93-2c3e-4390d42f98ee@collabora.com>
Date:   Fri, 17 Feb 2023 13:56:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 37/47] clk: mediatek: Split MT8195 clock drivers and
 allow module build
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
 <20230214134127.59273-38-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Gf6idN3LMkei503cXnuxo7HNc8=8fG0jENVHDtxDg5jQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Gf6idN3LMkei503cXnuxo7HNc8=8fG0jENVHDtxDg5jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/23 08:37, Chen-Yu Tsai ha scritto:
> On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> MT8195 clock drivers were encapsulated in one single (and big) Kconfig
>> option: there's no reason to do that, as it is totally unnecessary to
>> build in all or none of them.
>>
>> Split them out: keep boot-critical clocks as bool and allow choosing
>> non critical clocks as tristate.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/Kconfig  | 86 +++++++++++++++++++++++++++++++++++
>>   drivers/clk/mediatek/Makefile | 20 +++++---
>>   2 files changed, 99 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
>> index 45b7aea7648d..88937d111e98 100644
>> --- a/drivers/clk/mediatek/Kconfig
>> +++ b/drivers/clk/mediatek/Kconfig
>> @@ -692,6 +692,92 @@ config COMMON_CLK_MT8195
>>           help
>>             This driver supports MediaTek MT8195 clocks.
>>
>> +config COMMON_CLK_MT8195_APUSYS
>> +       tristate "Clock driver for MediaTek MT8195 apusys"
>> +       depends on COMMON_CLK_MT8195
>> +       help
>> +         This driver supports MediaTek MT8195 AI Processor Unit System clocks.
>> +
>> +config COMMON_CLK_MT8195_AUDSYS
>> +       tristate "Clock driver for MediaTek MT8195 audsys"
>> +       depends on COMMON_CLK_MT8195
>> +       help
>> +         This driver supports MediaTek MT8195 audsys clocks.
>> +
>> +config COMMON_CLK_MT8195_CAMSYS
>> +       tristate "Clock driver for MediaTek MT8195 camsys"
>> +       depends on COMMON_CLK_MT8195_VPPSYS
> 
> One other thing. If a Kconfig option immediately follows its dependency,
> then it gets indented nicely in menuconfig, but only if.
> If other options are interspersed, then the indentation gets reset.
> 
> So could you reorder the options to follow the dependency graph?
> 

Sure, I will!

> Also how you chose the dependencies should be mentioned in the commit log.
> These are pure run time dependencies, not compile time nor link/load ones.
> 

Right.

> Last, I think an argument could be made against the proliferation of
> Kconfig options, as it dramatically increases the combinations of
> allrandconfigs. Maybe Arnd (who IIRC frequently runs allrandconfig)
> could chime in on whether this is actually a concern or not.
> 

I understand, but I don't see any way around that.
In my opinion, we shall give flexibility, and this is the only way to achieve
that: if you don't use IMGSYS, CAMSYS, WPESYS and IPESYS you should *not* be
forced to add that to the mix, as this would result in a footprint increase
for no *final* practical reason.

It's true, today we have big storage capacities and fast machines, but we can
still see a reduction in boot times (bootloader kernel load time, other than
actual kernel boot time), even if minimal, with this added flexibility.

Save a few milliseconds here, a few milliseconds there (not necessarily on
clock drivers, expand this to others) and you start reaching a meaningful
increase in boot performance.

>> +       help
>> +         This driver supports MediaTek MT8195 camsys and camsys_raw clocks.
>> +
>> +config COMMON_CLK_MT8195_IMGSYS
>> +       tristate "Clock driver for MediaTek MT8195 imgsys"
>> +       depends on COMMON_CLK_MT8195_VPPSYS
>> +       help
>> +         This driver supports MediaTek MT8195 imgsys and imgsys2 clocks.
>> +
>> +config COMMON_CLK_MT8195_IMP_IIC_WRAP
>> +       tristate "Clock driver for MediaTek MT8195 imp_iic_wrap"
>> +       depends on COMMON_CLK_MT8195
>> +       help
>> +         This driver supports MediaTek MT8195 I2C/I3C clocks.
>> +
>> +config COMMON_CLK_MT8195_IPESYS
>> +       tristate "Clock driver for MediaTek MT8195 ipesys"
>> +       depends on COMMON_CLK_MT8195_IMGSYS
>> +       help
>> +         This driver supports MediaTek MT8195 ipesys clocks.
>> +
>> +config COMMON_CLK_MT8195_MFGCFG
>> +       tristate "Clock driver for MediaTek MT8195 mfgcfg"
>> +       depends on COMMON_CLK_MT8195
>> +       help
>> +         This driver supports MediaTek MT8195 mfgcfg clocks.
>> +
>> +config COMMON_CLK_MT8195_VDOSYS
>> +       tristate "Clock driver for MediaTek MT8195 vdosys"
>> +       depends on COMMON_CLK_MT8195
> 
> Not sure why this option is here, out of order?

My alphabet skills finally failed me, lol.
I'll fix that for v3 :-)

Thanks!
Angelo
