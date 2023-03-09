Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF56B1E69
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCIIkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCIIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:39:26 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF961165C;
        Thu,  9 Mar 2023 00:38:08 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 06553D5A;
        Thu,  9 Mar 2023 09:38:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678351086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y41tMb7AS1Jh/KPkjkW3IKsx9az487kv51tekdAE29Q=;
        b=ubF2lj5lvtCp3H7KLxdAsbRS49b+6sBRLrUXT9KQPAgSrFQzeRzDS2fkDLPSfxRKxt25Py
        hhzH14kjrTJ0eUyJPpIVEPLzilgqwrH77iFF2rczY3X2G6Whjsyv75W5o2zLkv4xQr0gS3
        6/DwPS9d5+CcLnmWTtd0b2D4aR8vAOPXcJSIhsTen4XwVezu/C9iULPkPkJ8scOVW8Rqwi
        XgfaTBwuaDA9OgZLRgWwM3HjL8p90rrGeieoSN7ZzRIM0/TCOY48OR3QUrjt4XEXy+a5Nk
        4LKbiDSTBEEp1YIlprtkvdq1LtX0K44TNRpBr6xjevQvrOhW6/dMHqZlCotLiw==
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 09:38:05 +0100
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
In-Reply-To: <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation>
 <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation>
 <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f647e713a65f5d3f0f2e3af95c4d0a89@walle.cc>
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

> In an ideal world, where both the controller and the device talk about
> dummy number of cycles, I would agree with you, buswidth and dtr should
> not be relevant for the number of dummy cycles. But it seems that there
> are old controllers (e.g. spi-hisi-sfc-v3xx.c, spi-mt65xx.c, 
> spi-mxic.c)
> that support buswidths > 1 and work only with dummy nbytes, they are 
> not
> capable of specifying a smaller granularity (ncycles). Thus the older
> controllers would have to convert the dummy ncycles to dummy nbytes.
> Since mixed transfer modes are a thing (see jesd251, it talks about
> 4S-4D-4D), where single transfer mode (S) can be mixed with double
> transfer mode (D) for a command, the controller would have to guess the
> buswidth and dtr of the dummy. Shall they replicate the buswidth and 
> dtr
> of the address or of the data? There's no rule for that.

But in the end that doesn't matter because they are just dummy clock
cycles and the mode will only affect the data/address/command. 
Therefore,
the controller is free to choose the mode that suits it best.

But that begs the question, is ncycles in regard to DTR or SDR? That is,
are you counting just one type of edges or both the falling and rising
edges. The smallest granularity would be ncycles in regard of DTR. To 
me,
it's not obvious what the SEMPER Nano Flash [1] uses. I'd say we choose
the smallest granularty in spi-mem to be future proof and maybe provide
some spi-mem helper to help setting the cycles for SDR/DTR. As an 
example,
if you want to wait 4 cycles in SDR you'd have ncycles=8 in spi-mem.

So you won't need the mode nor the dtr property.

-michael

[1] 
https://www.infineon.com/dgdl/Infineon-S25FS256T_256Mb_SEMPER_Nano_Flash_Quad_SPI_1.8V-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c80027ecd0180740c5a46707a
