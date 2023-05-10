Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417B86FD93A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjEJI0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbjEJI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:26:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA39A6189
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:26:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso10390583a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683707167; x=1686299167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qAE2fvj6ngiYCTALJ8b5fSfpwVP8HXfEvzHqNFJqicg=;
        b=GcteouF28l9Xdngx3lT29G9bjqnkDEypYnNEAW9ECSjcFbL5o4VXOmw/p25PcHRUU1
         Q782amV7v0Oo7WAJEhxdyO0VBq6YxuQ+geZeRjWBIERMCB3DL3FiK22Dyr+aY9lxpLRn
         1qUc/RbrGlnT0RiBJ8P2gs/eByEgwn93n2V3uZ8yJ0RXASYW3pbFmKeCcFGNMJxndWDz
         8y1korS/tKyBvGJe6k0Ghi+F+hjN7GIMngGd7twqeOFgJRN+aWgug+zm85JMkxZkbpTk
         BN/jVEqIOtMDgiYEgSv3Xh8bx8B2CU4LJIjsYBXpy979JcbO0QgeZ8RXHL1absEMMh7O
         GS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707167; x=1686299167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAE2fvj6ngiYCTALJ8b5fSfpwVP8HXfEvzHqNFJqicg=;
        b=R2ozjIqVG+sOZUn6kvvcNGt2J0u3ygBx3H9B7D+h2RR6Mpd5GK7gQcE+8/ANSBNtsL
         OzvpW9pYsSn7nrjYCziRVhWu/9OmF3NgouO/JJ8ZxJGteL9RObmf5ej3t5o4ZHxuHpTv
         +vFeL8TAJU1uz0kR1SjN5nkh1mpDvMJQOkFZnIY+cG9cpY4Eq9P0bBzulvkLOd1IYryA
         ffX5NlIlRe/AvL7ANt7CcYDIAZPGtxAjVUGRjpciUgygqBnnZzSqP1vlqdVjwcosdSuK
         e6imlMpFJn6UxINuJXILmByUmPD8rjEfc0PxaHihYebK48DCWSiclxev3FeqRF/jKylf
         PdVA==
X-Gm-Message-State: AC+VfDzYZcwZVruXUiuAxicYdEFHyGiZ54vZENub6a2tIt8uN2v9YtX7
        zdqYIR7sMK0qPa533tU9rOjj
X-Google-Smtp-Source: ACHHUZ6ANRgSKht5oULvyIaPdfZ5v19or9q+4ru9P0mW8AkYLxwvHRrDE4izHVwXKdQpFue8bhYPdQ==
X-Received: by 2002:a17:907:ea4:b0:969:fd4b:554a with SMTP id ho36-20020a1709070ea400b00969fd4b554amr4090831ejc.24.1683707166800;
        Wed, 10 May 2023 01:26:06 -0700 (PDT)
Received: from thinkpad ([117.193.209.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090665c600b00968382ebf40sm2360767ejn.40.2023.05.10.01.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:26:06 -0700 (PDT)
Date:   Wed, 10 May 2023 13:55:55 +0530
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
Message-ID: <20230510082555.GA7268@thinkpad>
References: <20230510074404.3520340-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510074404.3520340-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:44:04AM +0300, Abel Vesa wrote:
> The following error was reported when building x86_64 allmodconfig:
> 
> error: the following would cause module name conflict:
>   drivers/soc/qcom/ice.ko
>   drivers/net/ethernet/intel/ice/ice.ko
> 
> Seems the 'ice' module name is already used by some Intel ethernet
> driver, so lets rename the Qualcomm Inline Crypto Engine (ICE) from
> 'ice' to 'qcom-ice' to avoid any kind of errors/confusions.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The build failure was reported here:
> https://lore.kernel.org/all/20230510111833.17810885@canb.auug.org.au/
> 
>  drivers/soc/qcom/Makefile              | 2 +-
>  drivers/soc/qcom/{ice.c => qcom-ice.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/soc/qcom/{ice.c => qcom-ice.c} (100%)
> 

You can just rename the module name to "qcom-ice" and still keep the driver name
as "ice" as it is already under "qcom" subdirectory.

We do it for other drivers as well.

- Mani

> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 0f43a88b4894..30219c164cb0 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -32,4 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
> -obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
> +obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom-ice.o
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/qcom-ice.c
> similarity index 100%
> rename from drivers/soc/qcom/ice.c
> rename to drivers/soc/qcom/qcom-ice.c
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
