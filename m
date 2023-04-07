Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BAE6DA931
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbjDGHCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbjDGHCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:02:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872FD83D1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 00:02:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso9856103wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 00:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680850959; x=1683442959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDRZJb+gw9WKl+q/YP3+9vfEWrdxXYb08xE3KjrncwY=;
        b=TlUNuHXhE7dkX3ma2znO7zdAacJiO27ghArmpkXlH8c3ATv+KBTc8LUhyVrkypI+mP
         0zQlggzvEemyf2P17MWTNYZVT5pEmY7G8l0KpU4b0QsyPvMfMJZshCs5c4HdBgpV6MQP
         XN2grzseW68CfcpULpwxh3ynO/USV/6im6FxHW40/svQL+ApI5uK1eCRpcAHn1PqPRYE
         iwww25egOIvVPfxbt4pMX674CTKLbiVEO/0Ip1e+6ahSlHwFQkQF7naCFmxlgJCIHPZU
         6QypBjxTNvF8oRGQexdGN9PM2UNsP9cuq6GQxZBhFfnm80WY+czp/4FjLGOZC9ZJW9dw
         8zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680850959; x=1683442959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDRZJb+gw9WKl+q/YP3+9vfEWrdxXYb08xE3KjrncwY=;
        b=dqCMbqLLWjWrvvcFJ3bknp6OjtnHvDSZuPIENW16jv++iBCAjjINvnZB4h+EMMcp51
         ryajmNY9lPsBPqZBjwrtN7pKLk1AhTw+xN4bWF21R2AeKeN1gdZQXORK2KSEBNiCA4l7
         XGNL611cxLi//RkZb5I4lUvFveVsfndHMEa7Jrge5ypX5wRKc6otGtWju4f0V5BMJyi3
         nqFlG/QOf8/0YB5kIqtYkWScheFrBtvbpKY6995pd0AbNDWQqYR+142F8jTJohoAvcSE
         N9iJyiavGn9Z/cM7l2nutphEzfl0K0Fu0W3jHJd5fRyyyeq+IHJa5P14Gq2qkUsQnE5Z
         W90A==
X-Gm-Message-State: AAQBX9edGDqzymgZ3mw8ut5N8E0TdDL7NoISYRZLLpN1YuETY//7cuPi
        wvcNZ+Kae5LqK5i1N+dN7+VtCQ==
X-Google-Smtp-Source: AKy350Yf7cZzWZgOSGchAXM9/7IoYqhc4Z0zpcrhQUgBsDYEyMpw3OS/oAAO8/EgLIduuLczRZdj6g==
X-Received: by 2002:a05:600c:2202:b0:3ee:289a:3c3a with SMTP id z2-20020a05600c220200b003ee289a3c3amr566623wml.30.1680850958894;
        Fri, 07 Apr 2023 00:02:38 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i42-20020a05600c4b2a00b003f0321c22basm7224793wmp.12.2023.04.07.00.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:02:38 -0700 (PDT)
Date:   Fri, 7 Apr 2023 10:02:36 +0300
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
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v5 4/6] scsi: ufs: ufs-qcom: Switch to the new ICE API
Message-ID: <ZC/ADOlol2XO7ACL@linaro.org>
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
 <20230403200530.2103099-5-abel.vesa@linaro.org>
 <20230406201634.GA20288@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406201634.GA20288@sol.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-06 13:16:34, Eric Biggers wrote:
> Hi Abel,
> 
> On Mon, Apr 03, 2023 at 11:05:28PM +0300, Abel Vesa wrote:
> > Now that there is a new dedicated ICE driver, drop the ufs-qcom-ice and
> > use the new ICE api provided by the Qualcomm soc driver ice. The platforms
> > that already have ICE support will use the API as library since there will
> > not be a devicetree node, but instead they have reg range. In this case,
> > the of_qcom_ice_get will return an ICE instance created for the consumer's
> > device. But if there are platforms that do not have ice reg in the
> > consumer devicetree node and instead provide a dedicated ICE devicetree
> > node, the of_qcom_ice_get will look up the device based on qcom,ice
> > property and will get the ICE instance registered by the probe function
> > of the ice driver.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> This is still silent about how the ICE clock behavior is being changed.

Right, I'll add the some more info into the commit message about the
clock being handled by the ICE driver.

> 
> I'm still trying to understand all this myself, so please bear with me, but my
> understanding is that the UFS clocks can be disabled even while the host
> controller is runtime-resumed.  This is called "clock gating" in the code.

The ICE clock is now being controlled by the new driver.
> 
> Before, the ICE clock was just listed as one of the UFS clocks.  So, it was just
> managed like the other UFS clocks.
> 
> Now, it appears that the ICE clock is always enabled while the host controller
> is runtime-resumed.  So, this patch removes support for gating of the ICE clock.

I just tested this and it works as expected, which is:

ICE clock gets enable on qcom_ice_create (via *clk_get*_enabled) and
then, on the runtime suspend of the UFS, the qcom_ice_suspend is called
which will disable the clock. Then, every time UFS runtime
resumes/suspends the clock gets enabled/disabled.

Hope that makes sense.

Let me know if you think I'm missing something here.

> 
> Is that intended?
> 
> - Eric
