Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58139701918
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjEMST2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjEMST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:19:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D819A1;
        Sat, 13 May 2023 11:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 457FD60F53;
        Sat, 13 May 2023 18:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C29C433D2;
        Sat, 13 May 2023 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684001964;
        bh=hZODh/ox4glU1Ki7513kJtAmIJxEoe+oI1Y6344lCKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OhMCDqFHA5WkhjCic4BpYmicmZn4mBltLnRwOE270wd6TpFAZdHcPToDjh5Xxorb4
         HMyKb0Ionmgx5Ei9LNU/FOvqPd8jT+PY9QYLu4uWI5jgwutpu3B43ZQF9gERDZt4dw
         KHFTnKWzZaQd3Th2IUq6ikWIMe22vsuFK3UTYljrXJMtOTj2t5hGwOPNbLLZqhSXoH
         D+8aATnVX5jkez9dIno/9VPMpBzuA5rOawBbtR+ORiWHz7ebQYkNzZ4HgQssEsvxKf
         m5DuAAg1v1IkoQcoNBt077X2LodVugf10OGDKUYyTkFjtz6h4HaCnEtr2vLtDSGX7k
         W4Q7rwam0BSrw==
Date:   Sat, 13 May 2023 19:35:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/3] iio: potentiometer: Add support for the Renesas
 X9250 potentiometers
Message-ID: <20230513193525.43a4475f@jic23-huawei>
In-Reply-To: <20230509160852.158101-3-herve.codina@bootlin.com>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
        <20230509160852.158101-3-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 May 2023 18:08:51 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> The Renesas X9250 integrates four digitally controlled potentiometers.
> On each potentiometer, the X9250T has a 100 kOhms total resistance and
> the X9250U has a 50 kOhms total resistance.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

As I only noticed one trivial thing I made the change whilst applying.
diff --git a/drivers/iio/potentiometer/x9250.c b/drivers/iio/potentiometer/x9250.c
index 3d4ca18d1f14..7e145d7d14f1 100644
--- a/drivers/iio/potentiometer/x9250.c
+++ b/drivers/iio/potentiometer/x9250.c
@@ -176,10 +176,7 @@ static int x9250_probe(struct spi_device *spi)
 
        x9250 = iio_priv(indio_dev);
        x9250->spi = spi;
-       x9250->cfg = device_get_match_data(&spi->dev);
-       if (!x9250->cfg)
-               x9250->cfg = &x9250_cfg[spi_get_device_id(spi)->driver_data];
-
+       x9250->cfg = spi_get_device_match_data(spi);
        x9250->wp_gpio = devm_gpiod_get_optional(&spi->dev, "wp", GPIOD_OUT_LOW);
        if (IS_ERR(x9250->wp_gpio))
                return dev_err_probe(&spi->dev, PTR_ERR(x9250->wp_gpio),



