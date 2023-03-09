Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA686B2219
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCILBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCIK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:59:24 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66343E2535;
        Thu,  9 Mar 2023 02:57:24 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 02408127D;
        Thu,  9 Mar 2023 11:56:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678359411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/io0tiHurftvED5sx9LsxUT6zxO/u5fmUM2T3ONQg1w=;
        b=Q0KB9CqTeuqMIUSe2pVjnWRuOwcuUmKy9D5oFkhfi/+moFgjMCQ/lunzoGmezZzlumqVKC
        MrQg1kXbHWxTsyWsmj7NWDC/TENDDKHttjXm4yTCVHYePbZbHZoKkrXHx8CbxPIV34zeHU
        +jfWs5s6CLuPLu8k4bHcBAttFBHFY10zEQWk+lkFlnRP1ytW2BqgvY7WGvS5HgIoxF5D4K
        YNqzc1ck8iGX27ks548/YZDSqdK+1eYjVP2ukcLY5Va037kd8vocBPbRc52qQnq41ErkKV
        4ZcoSCVyIYjrBToOMlILYNHuHLBiYOvk6DiBaFHGE4O0o5TSwpozL9l8guW67g==
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 11:56:50 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>, Sergiu.Moga@microchip.com,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, chin-ting_kuo@aspeedtech.com,
        clg@kaod.org, joel@jms.id.au, andrew@aj.id.au,
        kdasu.kdev@gmail.com, han.xu@nxp.com, john.garry@huawei.com,
        matthias.bgg@gmail.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, haibo.chen@nxp.com,
        yogeshgaur.83@gmail.com, heiko@sntech.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
In-Reply-To: <1849e2c8-54f5-9e56-4ed8-8b0e4a826d04@linaro.org>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation>
 <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation>
 <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
 <f647e713a65f5d3f0f2e3af95c4d0a89@walle.cc>
 <1849e2c8-54f5-9e56-4ed8-8b0e4a826d04@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <302ecf0421fe4c99fca3eb0ca2f66127@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-09 11:42, schrieb Tudor Ambarus:
> On 09.03.2023 10:38, Michael Walle wrote:
>>> In an ideal world, where both the controller and the device talk 
>>> about
>>> dummy number of cycles, I would agree with you, buswidth and dtr 
>>> should
>>> not be relevant for the number of dummy cycles. But it seems that 
>>> there
>>> are old controllers (e.g. spi-hisi-sfc-v3xx.c, spi-mt65xx.c, 
>>> spi-mxic.c)
>>> that support buswidths > 1 and work only with dummy nbytes, they are 
>>> not
>>> capable of specifying a smaller granularity (ncycles). Thus the older
>>> controllers would have to convert the dummy ncycles to dummy nbytes.
>>> Since mixed transfer modes are a thing (see jesd251, it talks about
>>> 4S-4D-4D), where single transfer mode (S) can be mixed with double
>>> transfer mode (D) for a command, the controller would have to guess 
>>> the
>>> buswidth and dtr of the dummy. Shall they replicate the buswidth and 
>>> dtr
>>> of the address or of the data? There's no rule for that.
>> 
>> But in the end that doesn't matter because they are just dummy clock
>> cycles and the mode will only affect the data/address/command. 
>> Therefore,
>> the controller is free to choose the mode that suits it best.
>>  > But that begs the question, is ncycles in regard to DTR or SDR? 
>> That is,
>> are you counting just one type of edges or both the falling and rising
>> edges. The smallest granularity would be ncycles in regard of DTR. To 
>> me,
>> it's not obvious what the SEMPER Nano Flash [1] uses. I'd say we 
>> choose
>> the smallest granularty in spi-mem to be future proof and maybe 
>> provide
>> some spi-mem helper to help setting the cycles for SDR/DTR. As an 
>> example,
>> if you want to wait 4 cycles in SDR you'd have ncycles=8 in spi-mem.
>> 
> 
> No, we can't invent our own measuring units. We have cycles and half
> cycles (regardless of the transfer mode used (STR, DTR)).

That is basically what I was saying, just using the correct term.
Ok. So we don't need the dtr property, right? I'm still not sure,
what the semper nano flash uses. Half cycles? But according to your
naming you'd specify full cylces?

-michael
