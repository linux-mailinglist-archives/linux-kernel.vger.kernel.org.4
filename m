Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2456D3F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjDCIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjDCIqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:46:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B37EE9;
        Mon,  3 Apr 2023 01:46:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD82166030F1;
        Mon,  3 Apr 2023 09:46:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680511562;
        bh=Fhgq8JItzHKrMtYr/qUtaRmG44PqEvs1zKAfcmwP4Mg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hqVxJMfPFUt6Y8pTlaaLtksiUT2Dyi+mS6RqvbaN9qfvh2r/2Ru+YSLlfgMWx7hTO
         ML6CV8bl73mSx8tAG75R/4rYnjMrcILBYH1wHfgDDWNYRX9gVzJyM7vBHPR72aL0Wq
         oTCC20G2wgRvOXGsEAoQaoklmDSIbIOlBUKze8AMkJJYoBh2WK2JGssPL1kmTcg9tZ
         ij7csLVAAGh8SHElzNAQN6zKQor6elocz9upqd6GktLYRvVt9BmMCKwWJhKyRdtjNL
         VWlAKQgtFLy9c8/rD/BJ8o9NtDQCfz+ZSd4Z19sp66Xyk/Ud9vodL0IJQeZQYx/m9r
         VJm/XldxQAiYw==
Message-ID: <c6b97f15-fd43-d9c4-8a07-04d4063f8b98@collabora.com>
Date:   Mon, 3 Apr 2023 10:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: linux-next: build failure after merge of the mediatek tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230403181552.607a8b64@canb.auug.org.au>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230403181552.607a8b64@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/23 10:15, Stephen Rothwell ha scritto:
> Hi all,
> 
> After merging the mediatek tree, today's linux-next build (arm64
> defconfig) failed like this:
> 
> aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mmsys.o: in function `mtk_mmsys_update_bits':
> drivers/soc/mediatek/mtk-mmsys.c:147: undefined reference to `cmdq_pkt_write_mask'
> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mmsys.o: in function `mtk_mmsys_probe':
> drivers/soc/mediatek/mtk-mmsys.c:386: undefined reference to `cmdq_dev_get_client_reg'
> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mutex.o: in function `mtk_mutex_enable_by_cmdq':
> drivers/soc/mediatek/mtk-mutex.c:883: undefined reference to `cmdq_pkt_write'
> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mutex.o: in function `mtk_mutex_probe':
> drivers/soc/mediatek/mtk-mutex.c:1023: undefined reference to `cmdq_dev_get_client_reg'
> 
> Caused by commit
> 
>    b34884b4c878 ("soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MTK_CMDQ)")
> 

I can recheck why this happens - otherwise we can simply avoid applying that commit
if there's no time.

> I have used the mediatek tree from next-20230331 for today.
> 
> There were also the following warnings:
> 
> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:104.21-109.4: Warning (unit_address_format): /soc/i2c@11010000/accelerometer@0x10: unit name should not have leading "0x"
> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:111.20-114.4: Warning (unit_address_format): /soc/i2c@11010000/magnetometer@0x12: unit name should not have leading "0x"
> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:104.21-109.4: Warning (i2c_bus_reg): /soc/i2c@11010000/accelerometer@0x10: I2C bus unit address format error, expected "10"
> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:111.20-114.4: Warning (i2c_bus_reg): /soc/i2c@11010000/magnetometer@0x12: I2C bus unit address format error, expected "12"
> 

Matthias, should I send new versions of the commits, addressing this sad overlook
from my side, or would you fix that, or should I send new commits cleaning that up
on top?

Please let me know how to proceed here.

Thanks,
Angelo

