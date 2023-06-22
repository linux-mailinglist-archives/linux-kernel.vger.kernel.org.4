Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECE7397BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFVHC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFVHCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:02:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866EB1BD3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:02:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso8682658a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687417372; x=1690009372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Sxq2D1Pi6NZiEBOnH2qdeVUWhttdMHZfreLodTzhEE=;
        b=yYUgNsMrj3xuvCcgzGXPbzjbSkW9p1D43qESgbwIVVshJ53Zs5aC4U6Ro0i5gK/t/K
         SpwZIDbGmdwZofsZdZ/QzEIhISMc43PgVU0GarADwmqbw6rIAmztG35YEobmdLHegHJ2
         vlJtlr1JemHBD44JqzIqyojk3pFpLCFOKa0A/KP5Jafxg8hhIdkznPh0vt4vZ7tJ9wDU
         fqHO9WtZLBv5/QGEKoa6Z7TjmIKkbrrBZnjS/ATCDkw04+BCrdu8Wgr5+xMEFV0ILW6X
         AF9B7r6i+XATybTiVqtDr4XY2obc+JXCVIrBGd9JqEjQ7niG4Rd4KfXFCDjR2E9k/XEk
         ldeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687417372; x=1690009372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sxq2D1Pi6NZiEBOnH2qdeVUWhttdMHZfreLodTzhEE=;
        b=hJijked4QyjkwSFmeGacn2AVHUTRWi+0RjxhWNmhp12GEVEIOZZkENIfJyRyHmXoq+
         /xvYPUcgxozZYAe2yOI8Fi2XYbsgBKahHeqnS1gw2SnGulluX9bbdutfavR3mCswckb/
         +tVNsktaSg8t91tTawy33KSOy3JhTjDGdpoF/G/j7kV8QSWr0DBdiQf0j+xveizJWD5z
         ihLzYP4SIukvNMrkTG1DYYxlvylksz0vHnlJg1QFgd7o7U4pkDN75AR/SVpnI2kuun1c
         6Y20CWIwZZw8RIIbCDl1YlLI22e6EdJCYy8n6hLAoH2YB721VcUsPoONp8LtTL3+bxg4
         +pbA==
X-Gm-Message-State: AC+VfDyutSA5WhxeTrkd7yzIFJQ/wKnYMz+GElrAjwU+Tss7mJ9Rc8H7
        y/SlYvc/Th16seagON+WyxF/4A==
X-Google-Smtp-Source: ACHHUZ5ukNukwYHHv8TsonoqFE7mHUyfEWuDNcZ1NmDmk/3S0+NaZRbPRoKiPoAhvItJvuBXGXfaTA==
X-Received: by 2002:a05:6402:498:b0:519:b784:b157 with SMTP id k24-20020a056402049800b00519b784b157mr10627419edv.12.1687417371921;
        Thu, 22 Jun 2023 00:02:51 -0700 (PDT)
Received: from linaro.org ([62.231.110.100])
        by smtp.gmail.com with ESMTPSA id i9-20020a056402054900b0051873c201a0sm3507830edx.26.2023.06.22.00.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:02:51 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:02:49 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: ufs: qcom: Add ICE phandle
Message-ID: <ZJPyGW2I4fHqFMRV@linaro.org>
References: <20230408214041.533749-1-abel.vesa@linaro.org>
 <20230408214041.533749-2-abel.vesa@linaro.org>
 <4aadaf24-11f6-5cc1-4fbd-addbef4f891b@linaro.org>
 <yq1ilbgqoq6.fsf@ca-mkp.ca.oracle.com>
 <80ca0da4-5243-9771-0c4c-62b956e97b2f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ca0da4-5243-9771-0c4c-62b956e97b2f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-22 08:07:51, Krzysztof Kozlowski wrote:
> On 22/06/2023 03:19, Martin K. Petersen wrote:
> > 
> > Abel,
> > 
> >> Un-reviewed. This is broken and was never tested. After applying this
> >> patch, I can see many new warnings in all DTBs (so it is easy to spot
> >> that it was not actually tested).
> >>
> >> Your probably meant here:
> >>   if:
> >>     required:
> > 
> > Please provide a fix for this. I don't want to rebase this late in the
> > cycle.
> 
> AFAIK, this was not applied. At least as of next 20210621 and I
> commented on this few days ago. Anything changed here?

Check this one:
https://lore.kernel.org/all/yq1a5x1wl4g.fsf@ca-mkp.ca.oracle.com/

I'll send a fix today.

> 
> Best regards,
> Krzysztof
> 
