Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3326A70191B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjEMSTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjEMSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349326BB;
        Sat, 13 May 2023 11:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA9BC61D29;
        Sat, 13 May 2023 18:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15A0C433D2;
        Sat, 13 May 2023 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684001986;
        bh=Zyg4IDNo3r2y5cL3+p0lXSjwCwi0GcF9BeSYpYcsBUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xv/1ooKBcZaDlRjFBocEH+nBeLEomulOIbLyZcix7o60nR9Q+5MVWPb0iSZ3aB59Q
         98jbB96f41MAAp+dg/FoIjMKmi4r16/Srvfgw9vH7KtvnWbkQnAf+qI+O/6KsNA0Hb
         b+F96dhKFz2S2vd9MGKZf/XxWZ9mUANCk1dldajAwUm1SkiSec+PyNFYRNT2jnxxSy
         kj+n4+LO10JiMwZJoAPWeubBRG8hKR/vZf3x+VcpdjEXrTAYqszyenCc7dEWHbll5C
         9r9HRwR+kUViwoEl4aJv73CkgfP6v64amMKMOo6sK0mvr9AnG/09DMSKL84TtFu/2Q
         kVjXBOw2ZJFVQ==
Date:   Sat, 13 May 2023 19:35:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 0/3] Add the Renesas X9250 potentiometers IIO support
Message-ID: <20230513193547.5e2bcff3@jic23-huawei>
In-Reply-To: <20230509160852.158101-1-herve.codina@bootlin.com>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 May 2023 18:08:49 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi,
> 
> The Renesas X9250 integrated four digitally controlled potentiometers.
> On each potentiometer, the X9250T has a 100 kOhms total resistance and
> the X9250U has a 50 kOhms total resistance.
> 
> Compare to the previous iteration
>   https://lore.kernel.org/linux-kernel/20230421085245.302169-1-herve.codina@bootlin.com/
> This v4 series updates the binding, introduced the power-supply
> regulators and the write-protect gpio, uses spi_write_then_read(),
> removes spi_get_device_id(spi)->name, removes spi_set_drvdata() call.
> 
> Best regards,
> Herve Codina

Series applied to the togreg branch of iio.git with one tweak as per reply to patch 2.

Thanks,

Jonathan

> 
> Changes v3 -> v4
>   - Patch 1
>     Remove iio.yaml.
>     Add 'vcc-supply', 'avp-supply' and 'avn-supply'.
>     Add 'wp-gpios'
> 
>   - Patch 2
>     Get and enable the regulators.
>     Manage the write-protect gpio.
>     Use spi_write_then_read().
>     Remove the unneeded spi_setup() call.
>     Get name from field added in struct x9250_cfg instead of
>     spi_get_device_id(spi)->name.
> 
>   - Patch 3
>     No changes
> 
> Changes v2 -> v3
>   - Patch 1
>     Remove the reg property description
>     Use 'potentiometer' for the node name in the example.
> 
>   - Patch 2 and 3
>     No changes
> 
> Changes v1 -> v2
>   - Patch 1
>     No changes
> 
>   - Patch 2
>     Use a define for the 0x50 value used multiple times.
> 
>   - Patch 3
>     No changes
> 
> Herve Codina (3):
>   dt-bindings: iio: potentiometer: Add the Renesas X9250 potentiometers
>   iio: potentiometer: Add support for the Renesas X9250 potentiometers
>   MAINTAINERS: add the Renesas X9250 driver entry
> 
>  .../iio/potentiometer/renesas,x9250.yaml      |  78 ++++++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/potentiometer/Kconfig             |  10 +
>  drivers/iio/potentiometer/Makefile            |   1 +
>  drivers/iio/potentiometer/x9250.c             | 223 ++++++++++++++++++
>  5 files changed, 319 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
>  create mode 100644 drivers/iio/potentiometer/x9250.c
> 

