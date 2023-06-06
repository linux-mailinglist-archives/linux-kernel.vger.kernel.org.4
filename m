Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6F724CB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbjFFTOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjFFTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:14:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E66C1FEA;
        Tue,  6 Jun 2023 12:13:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f63ea7bfb6so422498e87.3;
        Tue, 06 Jun 2023 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686078816; x=1688670816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrOtHMOtxFEsrK/86LD6CuaBtGJsQ5p6+/iYIqFOon4=;
        b=ePBpqDJ2a2vAoDkaYvDm1GefoAf6ndk6vrzOq34yOzf2KAxeKjBz4VulhvxJNJDa44
         m/6xGZd2U8tqQ2gd0n0zQQMWZKZGj62RYtEXK9cV5cgLwFBkFNfnMc276MYa99lpfXw8
         xWBgTaxz5D5GidVNBeAq+D37hrQmvDEqdPETCeznucNOZaKQb+WN9XHMUYXcz+XJ+GHJ
         ubfCv+7v3xuoNWjfxamqIFAMQmUfrHaKrbIDeAcBp3zPFFKnDpIAK4/ZU8OIDdpm8zyV
         mz2kus1YtiAHMgblMl2/A3qGeaHbywJVzSos5sS/LuFWsyUS3hUX6IDUA9sC/jUJ6uyx
         rNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078816; x=1688670816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrOtHMOtxFEsrK/86LD6CuaBtGJsQ5p6+/iYIqFOon4=;
        b=gYZLHgWuMTMO+UZewt8vq8MzioT3eAnof687/QuRVkHzxE/6WRBrGrcTCWOx0vZU06
         zTbV81oPYkuGxBd79zSUWIFFU4HlRz5+caEToSePvR/jEk0M5lOQam/9OwTcwAnVPskU
         R0s2OUEooJalrvFWQxv2HitAFA7NJafV87m9U72ZqJDU1rbEFebKjlnOLr4+SCEWaEuy
         RDD53lsjrO6vfkYnJwPsayTsHTlYy61MyT47Rcg7+VpXpKbz546asvUPjWn3dmR1ZYh1
         NXTz9UOfqStMtHrsUhusK4PrxtzmcAiWaaHSiuy/6KU6ci4eIORpz3feRDJIpiOYDk9H
         zc7Q==
X-Gm-Message-State: AC+VfDzTt+IrqtQ8Yt5uyqblpI/t3qEHQMPMHe/Mus/LIp+uXBLoeKCN
        9qP2OBR4+8J7cN78f3oM9XJLU79plWo=
X-Google-Smtp-Source: ACHHUZ75J/c5UdnyjOxf+oHjR0stNYe3PZPSB+s4CXGh70nzHyolpp2qcA3S8tRivntY10rpNEuxDQ==
X-Received: by 2002:ac2:523c:0:b0:4f4:d41b:f416 with SMTP id i28-20020ac2523c000000b004f4d41bf416mr1200788lfl.4.1686078815993;
        Tue, 06 Jun 2023 12:13:35 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id u9-20020a056512040900b004eb0dcc52ddsm1553667lfk.41.2023.06.06.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:13:35 -0700 (PDT)
Date:   Tue, 6 Jun 2023 22:13:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Abe Kohandel <abe.kohandel@intel.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] spi: dw: Add compatible for Intel Mount Evans SoC
Message-ID: <20230606191333.247ucbf7h3tlooxf@mobilestation>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
 <20230606145402.474866-2-abe.kohandel@intel.com>
 <20230606172836.rbvhaxala2voaany@mobilestation>
 <ZH+EDLkdn+u2Rgwe@ekohande-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH+EDLkdn+u2Rgwe@ekohande-desk2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 12:07:56PM -0700, Abe Kohandel wrote:
> Hi Serge,
> 
> On 23/06/06 08:28PM, Serge Semin wrote:
> > Hi Abe
> > 
> > On Tue, Jun 06, 2023 at 07:54:01AM -0700, Abe Kohandel wrote:
> > > The Intel Mount Evans SoC's Integrated Management Complex uses the SPI
> > > controller for access to a NOR SPI FLASH. However, the SoC doesn't
> > > provide a mechanism to override the native chip select signal.
> > > 
> > > This driver doesn't use DMA for memory operations when a chip select
> > > override is not provided due to the native chip select timing behavior.
> > > As a result no DMA configuration is done for the controller and this
> > > configuration is not tested.
> > > 
> > > The controller also has an errata where a full TX FIFO can result in
> > > data corruption. The suggested workaround is to never completely fill
> > > the FIFO. The TX FIFO has a size of 32 so the fifo_len is set to 31.
> > > 
> > > Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/spi/spi-dw-mmio.c | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > > 
> > > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > > index 5f2aee69c1c1..c1d16157de61 100644
> > > --- a/drivers/spi/spi-dw-mmio.c
> > > +++ b/drivers/spi/spi-dw-mmio.c
> > > @@ -236,6 +236,31 @@ static int dw_spi_intel_init(struct platform_device *pdev,
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * The Intel Mount Evans SoC's Integrated Management Complex uses the
> > > + * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
> > > + * provide a mechanism to override the native chip select signal.
> > > + *
> > 
> > > + * This driver doesn't use DMA for memory operations when a chip select
> > > + * override is not provided due to the native chip select timing behavior.
> > > + * As a result no DMA configuration is done for the controller and this
> > > + * configuration is not tested.
> > 
> > Based on what is written you didn't test the DMA-based memory
> > operations on your hardware. Well, this driver doesn't use DMA for
> > memory operations on the platforms with the native CS just because
> > nobody has implemented that feature so far. AFAICS if DMA-based memory
> > operations were supported by the driver I don't think that the native
> > CS auto de-assertion would have been an issue except when there is no
> > hw-accelerated LLPs list handling in the DMA controller (in the later
> > case we could have fallen back to the IRQ-less implementation though).
> > Moreover having the DMA-based memory ops implemented would have been
> > even better than what the driver provides at the moment since it would
> > have eliminated the mem-op transfers in the atomic context. So the
> > comment seems misleading. Another problem is that it refers to a
> > feature which may be added in future. So the comment will be wrong
> > then. So I would suggest to either drop the comment or change to
> > something that just states that the DMA-based mem ops weren't tested
> > for this hardware.
> > 
> > Am I wrong in some aspects of understanding your comment? Did you mean
> > something else than what I inferred from it?
> > 
> > -Serge(y)
> > 
>
 
> You have interpreted my comments correctly. I can see how the comment is
> misleading and can become obsolete in the future. I will shorten the comment
> to just indicated that no DMA-based mem ops are tested for this hardware.

Ok. Thanks. Could you submit a fixup patch then? Mark has already
merged the series in as is:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=0760d5d0e9f0c0e2200a0323a61d1995bb745dee

-Serge(y)

> 
> Thanks,
> Abe
