Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC1F6B146C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCHVpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCHVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:45:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99C9EDF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:44:45 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g3so18209wri.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z0DHi72Ho6QJq4m3N8OZ9dErQvB6DsgdYARNWx4l/8=;
        b=Qmz6hTSfStErW/uuYxt22VPPZUMOP+dEC8iLow0ink6piNJrG6Gr86nYzMQp0kbcPy
         PvD4sVjLKeBEr+MrEPd01+8fajyY65TTeZxLw78L0CN8dYGG3qA0bZq76bQ7b6ibPv19
         VQvUoAA5HRwPy9Ey91e3ifnr2P44/jKAYDB5i2D2juWmDjFZM5YZwIGAugncAXOj+LZp
         ry2HUFsrd6q/QpIE381/h414FFVPsS1+jZgNl2uFrJhKsjHakyx6yAKueswrC5jRwQTH
         LDSYIckdebYgbAA/DEGxEResPBl8sZ1oezJlbwqD8pFXgwJDkr7k3kOGaVRWyU455kms
         TeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z0DHi72Ho6QJq4m3N8OZ9dErQvB6DsgdYARNWx4l/8=;
        b=dd+ieU4gj8Rg7uExl8oNFAfay24VQF+UUq11++ETlRaSPz97WQyU9SKmImtlMvgvmL
         wCfC1KsSWjE5wneZa1Fix15ALUIRiNXKWQniDAnFrLKkIoCFsypr1APgvUPpIvL1/Xsd
         sjOxyG+QmyUnrJoMNWGDTjiCAhgHHOmJQ62jxMaSD7rutT5noqosyI29utPXrdG0ozX+
         pGPXhphu2Ca4cSnqeoX+1Np7rZSp7XnRvYtjRgTH3sNjjLHnbe28rbIsD3WPehXpDEgd
         KSe92ET68lTeWpwrj0T/fUQ9n/enDQAyEojxof0QQ2Ih3CqezOliU0LlUFRLyedM4GU2
         i6mQ==
X-Gm-Message-State: AO0yUKUNKveGx1nrgrZuZ+r0ZqxBsmyqIZcF/W9lON3tmWFj+nvjN8YI
        Evah/HTp1YtY4xvxcZmWsXHsPg==
X-Google-Smtp-Source: AK7set82QrXg3puqALBiBX/T3axcFBDmM3MURhZbG3RHzTinBQBBF2402lh8DaHdmAhABXc6oxlhhA==
X-Received: by 2002:adf:ee8c:0:b0:2c7:9931:4f7d with SMTP id b12-20020adfee8c000000b002c799314f7dmr12344475wro.18.1678311875322;
        Wed, 08 Mar 2023 13:44:35 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d6087000000b002c567b58e9asm16416772wrt.56.2023.03.08.13.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:44:34 -0800 (PST)
Date:   Wed, 8 Mar 2023 23:44:33 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/7] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <ZAkBwZNWMTsXlt+p@linaro.org>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-5-abel.vesa@linaro.org>
 <ZAjppY2K0/XPBHxG@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAjppY2K0/XPBHxG@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-08 12:01:41, Eric Biggers wrote:
> On Wed, Mar 08, 2023 at 05:58:35PM +0200, Abel Vesa wrote:
> >  * Switched QCOM_INLINE_CRYPTO_ENGINE to tristate and made it built-in
> >    if any of the UFS or the SDHC drivers are built-in. This is to allow
> >    the API to be available even if the built-in driver doesn't have
> >    crypto enabled.
> [...]
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index a8f283086a21..c584369e9810 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -275,4 +275,10 @@ config QCOM_ICC_BWMON
> >  	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
> >  	  memory throughput even with lower CPU frequencies.
> >  
> > +config QCOM_INLINE_CRYPTO_ENGINE
> > +	tristate
> > +	depends on SCSI_UFS_CRYPTO || MMC_CRYPTO
> > +	default y if SCSI_UFS_QCOM=y || MMC_SDHCI_MSM=y
> > +	select QCOM_SCM
> 
> What are the "depends on" and "default y" lines above for?
> 
> You're already selecting this from SCSI_UFS_QCOM and MSM_SDHCI_MSM, as I had
> suggested.  Isn't that enough?

We have the following:
(SCSI_UFS_QCOM && SCSI_UFS_CRYPTO) || (MMC_SDHCI_MSM && MMC_CRYPTO)

So lets take as example the scenario: (m && y) || (y && n).

The QCOM_INLINE_CRYPTO_ENGINE will be set to 'm' and the sdhci driver
will not be able to link properly since the ICE API is part of a module.

Therefore, if just one of SCSI_UFS_QCOM and MMC_SDHCI_MSM is built-in
and at least one of the crypto options are enabled, set the
QCOM_INLINE_CRYPTO_ENGINE to 'y' by default in order to make the
built-in one linkage will not fail.

Might not be the cleanest way to do this, so I'm open to suggestions.

> 
> - Eric
