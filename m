Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9026B204F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCIJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCIJkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:40:22 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478FFE8240;
        Thu,  9 Mar 2023 01:40:20 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 0EF2A127D;
        Thu,  9 Mar 2023 10:40:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678354816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6A1cqIav5oN+sJ0Pm8CyKz7tSgwht+condPuImcVwY=;
        b=zsMPy9kNOSpYIQk2v92UlAChhQ1RPWvR19mptAEqIVjK7y7MtNDhCwb2WjCLD1XqQrz1Lw
        q8s4RCfCX8HShn15fWBvySjzhsBHUFHE1ZVKHu5VkB4RcwxibgapaU57G1lZ9MaCbGS+ZB
        d8zZihUMbqMqbCgfK1NPj8qFc6HdOzqsvmbsDviuS3ZwcHJ6DMQw2zRg/+2Ht3+IwL13B9
        3XbUFM/uL/TIFiDCwAouAEb4qEnSGJF/f7NhSKUHWODVLEtFviq2WFQVuobulTjGODAOt4
        qJx7Hf6BNV7PeSGwCgjwgSvM/epAZE1St3F3Qp7iV4+07CGebjwrTQ4MPMgtqQ==
From:   Michael Walle <michael@walle.cc>
To:     zajec5@gmail.com
Cc:     a.zummo@towertech.it, agross@kernel.org,
        alexandre.belloni@bootlin.com, alexandre.torgue@foss.st.com,
        alyssa@rosenzweig.io, andersson@kernel.org,
        angelogioacchino.delregno@collabora.com, asahi@lists.linux.dev,
        baolin.wang@linux.alibaba.com, claudiu.beznea@microchip.com,
        festevam@gmail.com, hayashi.kunihiko@socionext.com,
        heiko@sntech.de, jbrunet@baylibre.com, jernej.skrabec@gmail.com,
        kernel@pengutronix.de, khilman@baylibre.com,
        konrad.dybcio@linaro.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-rockchip@lists.infradead.org,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, marcan@marcan.st,
        martin.blumenstingl@googlemail.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        michal.simek@xilinx.com, miquel.raynal@bootlin.com,
        neil.armstrong@linaro.org, orsonzhai@gmail.com, rafal@milecki.pl,
        richard@nod.at, s.hauer@pengutronix.de, samuel@sholland.org,
        shawnguo@kernel.org, srinivas.kandagatla@linaro.org,
        sven@svenpeter.dev, vigneshr@ti.com, vincent.sunplus@gmail.com,
        wens@csie.org, zbr@ioremap.net, zhang.lyra@gmail.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH V2] nvmem: add explicit config option to read OF fixed cells
Date:   Thu,  9 Mar 2023 10:40:10 +0100
Message-Id: <20230309094010.1051573-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230224072903.20945-1-zajec5@gmail.com>
References: <20230224072903.20945-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[as this mentions  nvmem layouts it would have been nice to include me]

> NVMEM subsystem looks for fixed NVMEM cells (specified in DT) by
> default. This behaviour made sense in early days before adding support
> for dynamic cells.

Why is that? It still makes sense, doesn't it?

> With every new supported NVMEM device with dynamic cells current
> behaviour becomes non-optimal. It results in unneeded iterating over DT
> nodes and may result in false discovery of cells (depending on used DT
> properties).

What false discoveries?

> This behaviour has actually caused a problem already with the MTD
> subsystem. MTD subpartitions were incorrectly treated as NVMEM cells.

But this is solved, correct?

> Also with upcoming support for NVMEM layouts no new binding or driver
> should support fixed cells defined in device node.

How would you support older device trees with newer kernels or the
other way around? I'm not sure I get your motivation to drop handling
the fixed cells.

> Solve this by modifying drivers for bindings that support specifying
> fixed NVMEM cells in DT. Make them explicitly tell NVMEM subsystem to
> read cells from DT.

How can a driver know when there are fixed cells and when not? IOW.
only new ones can be affected.

If you want to get rid of the schema for *new* drivers then what
about having a new child node, something like "nvmem-fixed-cells",
similar to "nvmem-layout".

And then you'd tell the new drivers to use the new-style dt binding. But
there are no new drivers yet. So I'm still not sure I get your motivation.

-michael
