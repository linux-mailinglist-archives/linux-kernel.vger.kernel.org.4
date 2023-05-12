Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D6700741
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbjELLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbjELLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:53:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619A11572
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:53:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3075e802738so8945392f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683892408; x=1686484408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8rnc0tkWyKP0EvmlzEBinpTb1DDJ3FVse6f2h+LYmq0=;
        b=GakfyrMD+IaS8JJ8nPpGr/EK2wW9IZUFrC0uOK9/LKOtpI9iYgjAc2v/OdGRSO6P7Y
         wKYBQSuy86MnEKVxZLQusXIjg+1G5++kWxAoRhhAre1QazEd8jH/pFRkEc1R5qt7EW5A
         RrSDZT6PnUZTumVJ1aGTDCcb5LonumKu9AOjegLlasiL3XAJs3uPSJq5QJ751kWS7sI7
         bYpygBziSz/dDK7LCliZuliO0ogl+uUpWGNVEYxAlfPCLw8hKzmObvXPXdv2XvCTKu74
         qM+SmEzXLIFh7H+58dZvxl/5ByglWteY6Q/vwemq+WrxQHWj4bB9ZWZHtoKuAcnQf5F7
         FM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683892408; x=1686484408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rnc0tkWyKP0EvmlzEBinpTb1DDJ3FVse6f2h+LYmq0=;
        b=g/KCZwZ3bqKy+RUtLRx/uXZicXZJsz/5QraVDL5FSu9ykskJL2PYu9V1TZIynygiD7
         ZfIC3G4RDdC+PAdDA/X+xtsfF4+wXt6mrX09m/Kz/qp4tzBw1uAAGNTVpCuEXL/FPwqj
         k5e1WRKAK9FYLliT5zygkF25SxnjtxqblMD1iKPwgA7luZezMmtswcxLg0DZCF8yvp57
         lR8dHDFTlxNxpRQXSBq0xcK2qX6FHy355u+HEkHHyubMGWr8qeHWhA+GbvXUqTOuC7si
         LEHwkyptBvntWz3itQzhq1+wNiyFiJyYkzNneg25yZKdKTuMBWNUmZOXqrlTWlUPeovt
         wBTQ==
X-Gm-Message-State: AC+VfDxvSZe5QCrjwCDHP0RmZXAwkTOO0i9GVpVclr1HJGNtv/5BBDt3
        p2KhqrvFkq5vvt8Wbp0exkQ7yg==
X-Google-Smtp-Source: ACHHUZ6um3MK4XUsYxCoYRkxmzAuqAjVCGemDUJM+AuqZBfmKj0Z8I7Up8dqHE4kXcqeYRYKPaagyw==
X-Received: by 2002:adf:cf06:0:b0:303:6209:65f4 with SMTP id o6-20020adfcf06000000b00303620965f4mr19121817wrj.38.1683892408345;
        Fri, 12 May 2023 04:53:28 -0700 (PDT)
Received: from linaro.org ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d67d0000000b002fae7408544sm23351302wrw.108.2023.05.12.04.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:53:27 -0700 (PDT)
Date:   Fri, 12 May 2023 14:53:26 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] soc: qcom: Rename ice to qcom-ice to avoid module name
 conflict
Message-ID: <ZF4otoqwH4sNwF6o@linaro.org>
References: <20230510074404.3520340-1-abel.vesa@linaro.org>
 <20230510082555.GA7268@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510082555.GA7268@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-10 13:55:55, Manivannan Sadhasivam wrote:
> On Wed, May 10, 2023 at 10:44:04AM +0300, Abel Vesa wrote:
> > The following error was reported when building x86_64 allmodconfig:
> > 
> > error: the following would cause module name conflict:
> >   drivers/soc/qcom/ice.ko
> >   drivers/net/ethernet/intel/ice/ice.ko
> > 
> > Seems the 'ice' module name is already used by some Intel ethernet
> > driver, so lets rename the Qualcomm Inline Crypto Engine (ICE) from
> > 'ice' to 'qcom-ice' to avoid any kind of errors/confusions.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > 
> > The build failure was reported here:
> > https://lore.kernel.org/all/20230510111833.17810885@canb.auug.org.au/
> > 
> >  drivers/soc/qcom/Makefile              | 2 +-
> >  drivers/soc/qcom/{ice.c => qcom-ice.c} | 0
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> >  rename drivers/soc/qcom/{ice.c => qcom-ice.c} (100%)
> > 
> 
> You can just rename the module name to "qcom-ice" and still keep the driver name
> as "ice" as it is already under "qcom" subdirectory.
> 
> We do it for other drivers as well.

Yes, but in this case, it is not worth keeping the file name as is.

I'll send another version of this patch with the filename as qcom_ice.c
in order to be inline with the other ones.

> 
> - Mani
> 
> > diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> > index 0f43a88b4894..30219c164cb0 100644
> > --- a/drivers/soc/qcom/Makefile
> > +++ b/drivers/soc/qcom/Makefile
> > @@ -32,4 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
> >  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
> >  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
> >  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
> > -obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
> > +obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom-ice.o
> > diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/qcom-ice.c
> > similarity index 100%
> > rename from drivers/soc/qcom/ice.c
> > rename to drivers/soc/qcom/qcom-ice.c
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
