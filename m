Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F14700840
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbjELMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbjELMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:42:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57E171F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:42:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aad5245571so68729065ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683895330; x=1686487330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qu/58O+9pf0u9+V9v8oS+vJYZNsaPk6xzd+mj1JOqFQ=;
        b=drUCX9L1rNzpL99T066bzQ1ykR+zm9d4HaTIie5pcv/T2mw5Ob9YeHWALcaqvyJipm
         YbYg6nOkOr/TKqy9VdNSVeef0wxc7wz6MZqksJJJS1lHnM+TT3uqokc1v1lJo1qZRl1w
         M00+XxB9j8d3UdiHW/qg0glG01JlDsNSyYTj4baj+RVgYXG6kbaoOIPq83DQjHqPJkv3
         D26OZlxwl2Etzse2yz9sn+CBOhgz+iG4c/poStueJ0wddzXn9zB5fFRCgFe9S8+TmX7H
         h+/AVI2MHgQVyfbzdbyWyIGDJKbcScJpCaD/MAqgqNggRxARF5+Z8eGd84vfB/0DoikW
         6Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683895330; x=1686487330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu/58O+9pf0u9+V9v8oS+vJYZNsaPk6xzd+mj1JOqFQ=;
        b=LHY2x5HCNn0gR5pQ1j8cqnk8E1r/ncTTOFYUaeeebJKrQ62pWamPxpr7T73c4J5yRE
         jbV5BPxHkc/H5OZJcUCthpJ/HWHaBl0f7hpZSPw4pLBN7KiZp3NO0UuUEKOS/e4lwNm9
         69AkwmSpg1ziONq6KROF1UT9bu1dbywNS7Nfbn/haP0Q4G9hR80rfIrEO6rHW5RH//Nx
         Zn4+iB/pPNImD2rNmgJKzaPoRG8Tfd41OrPUz6ysWHfA6gql74yq7lGb6ftxuQ/0B457
         OAPExOMSstX6UDiM2T3ji1u3R0+ssDN7QfRZx5B4M2ESwfKzWFsuHqDnmpu4Nk3x0kro
         R6bw==
X-Gm-Message-State: AC+VfDwPSsG7lgWwxXDZEpXkm5c93bvS2MbLJnMhcnoRKL39vM6YFzOV
        Phu7IkVtBQS9JFApUD//kjoi
X-Google-Smtp-Source: ACHHUZ7QsZqjOg1/Tz1AHBUSyhMYiIoxZXlvNXvnn6SZwWdImt8AJZ6Qwj6TxHJeOv6Sv04r4SlEZQ==
X-Received: by 2002:a17:902:f547:b0:1ab:bfb:4b6e with SMTP id h7-20020a170902f54700b001ab0bfb4b6emr33563395plf.31.1683895329810;
        Fri, 12 May 2023 05:42:09 -0700 (PDT)
Received: from thinkpad ([117.202.185.214])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm7826980plt.290.2023.05.12.05.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 05:42:09 -0700 (PDT)
Date:   Fri, 12 May 2023 18:12:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Abel Vesa <abel.vesa@linaro.org>
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
Message-ID: <20230512124203.GA13620@thinkpad>
References: <20230510074404.3520340-1-abel.vesa@linaro.org>
 <20230510082555.GA7268@thinkpad>
 <ZF4otoqwH4sNwF6o@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZF4otoqwH4sNwF6o@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:53:26PM +0300, Abel Vesa wrote:
> On 23-05-10 13:55:55, Manivannan Sadhasivam wrote:
> > On Wed, May 10, 2023 at 10:44:04AM +0300, Abel Vesa wrote:
> > > The following error was reported when building x86_64 allmodconfig:
> > > 
> > > error: the following would cause module name conflict:
> > >   drivers/soc/qcom/ice.ko
> > >   drivers/net/ethernet/intel/ice/ice.ko
> > > 
> > > Seems the 'ice' module name is already used by some Intel ethernet
> > > driver, so lets rename the Qualcomm Inline Crypto Engine (ICE) from
> > > 'ice' to 'qcom-ice' to avoid any kind of errors/confusions.
> > > 
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > > 
> > > The build failure was reported here:
> > > https://lore.kernel.org/all/20230510111833.17810885@canb.auug.org.au/
> > > 
> > >  drivers/soc/qcom/Makefile              | 2 +-
> > >  drivers/soc/qcom/{ice.c => qcom-ice.c} | 0
> > >  2 files changed, 1 insertion(+), 1 deletion(-)
> > >  rename drivers/soc/qcom/{ice.c => qcom-ice.c} (100%)
> > > 
> > 
> > You can just rename the module name to "qcom-ice" and still keep the driver name
> > as "ice" as it is already under "qcom" subdirectory.
> > 
> > We do it for other drivers as well.
> 
> Yes, but in this case, it is not worth keeping the file name as is.
> 

Since you already have "qcom" as the parent directory name, I don't know how
adding "qcom" prefix for the drivers in child directory helps. It is required
for the module name but not for the driver name.

If you look at current qcom soc drivers, then most of them are without prefix
but _some_ are with prefix. And the later ones doesn't make sense to me,

But I'll leave it to Bjorn to take the call.

- Mani

> I'll send another version of this patch with the filename as qcom_ice.c
> in order to be inline with the other ones.
> 
> > 
> > - Mani
> > 
> > > diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> > > index 0f43a88b4894..30219c164cb0 100644
> > > --- a/drivers/soc/qcom/Makefile
> > > +++ b/drivers/soc/qcom/Makefile
> > > @@ -32,4 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
> > >  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
> > >  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
> > >  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
> > > -obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
> > > +obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom-ice.o
> > > diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/qcom-ice.c
> > > similarity index 100%
> > > rename from drivers/soc/qcom/ice.c
> > > rename to drivers/soc/qcom/qcom-ice.c
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
