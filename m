Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E533C62F6F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbiKROPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiKROPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:15:09 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C7910C4;
        Fri, 18 Nov 2022 06:15:04 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D1C8688;
        Fri, 18 Nov 2022 15:15:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668780903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7qFq+hb6tsUJLwHmcXcoBAd1kn5ubQZkT0q3bCuMFs=;
        b=f5Zsxj3Q7CiBCzS/6GtFEWucZJXGEO4bbycrzcFv8lAWDB8j8cH9tig9ivOCZ1FfC/easc
        TZ2+ExmaqRA9tECLwRMsZSVjw9hz6wfLYcy4ayC8BJfS/BLgcbeNCRk3JqtZECa6x//4MA
        RmAG/a3svn/C9E0/CSvSTGhdwIaVowVDIPBBp6zrY51ET494PVd4pT8Ig40V6G0/ijsc1E
        jIR3N4sE+PeXqdPdD4FqZPEcqltWViLiCCBf+Q8LYxFjIx12e8h8AuWWiAeB/ogAnN6yRw
        8S22cwguM4h2qJ4poiyulnH9MdF7pP+CKN62DzRY5NgeEGreGnWXEcDNOyiXZQ==
From:   Michael Walle <michael@walle.cc>
To:     tudor.ambarus@microchip.com
Cc:     alexandre.belloni@bootlin.com, broonie@kernel.org,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
Subject: Re: [PATCH 1/8] spi: dt-bindings: Introduce spi-cs-setup-ns property
Date:   Fri, 18 Nov 2022 15:14:58 +0100
Message-Id: <20221118141458.954646-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117105249.115649-2-tudor.ambarus@microchip.com>
References: <20221117105249.115649-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index dca677f9e1b9..ead2cccf658f 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -44,6 +44,11 @@ properties:
>      description:
>        Maximum SPI clocking speed of the device in Hz.
>  
> +  spi-cs-setup-ns:
> +    description:
> +      Delay in nanosecods to be introduced by the controller after CS is
> +      asserted.
> +

Does this need a type as the spi-cs-setup-ns is apparently just 16bit? At
least the driver uses it that way.

But IMHO this should just be a normal uint32 value to be consistent with
all the other properties. Also the max value with 16bit will be 'just'
65us.

-michael
