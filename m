Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8F72837D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbjFHPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjFHPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:17:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBA330EB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:16:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-650352b89f6so459106b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686237413; x=1688829413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kiyhnHcKDOBzoeAnFI9BVgwjzQkyxa/Y9kkA33HbNN0=;
        b=eal4zHXfjlKZMB14rbh91Ry1/isoqhVWzGhLfxZgb0uoQjmDYdJ9r1wuSHqAEyOWc1
         ZVsM2SYGSuXVZHcAW2+D7opvQLHyc3j18leKuaTOn92Htk47uInT/FR9jX5UeUYboyLd
         SpvA4osn+SFpRJ7PTkL9u9wvqC1VL96qCNwcyLNOA0sf9KP/KZygU2whEfieNCOzWtuy
         hpjo3+WZ6nSZ2DV3LHsKok5D1fSHgWl9EKn70Pzya5hwfRUpcM0005Z9zQsGzIMJCtII
         sZK4jLjJRtXS23s3pyez9nIuDNp9i/zvK7I91vI7VmE8Za6uX9do8QqUrFnHXjfWmQa3
         OmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686237413; x=1688829413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiyhnHcKDOBzoeAnFI9BVgwjzQkyxa/Y9kkA33HbNN0=;
        b=Vw6xitR+pgWDFf7+x32YYYXRboDPfZrAkJwRoOGaIIMG/FNEOxAhuFcVZ7w1oPSr8I
         W+JscWamFMVmOmXrHGVgk5x3otrzK34bFBBcSJkJ6Fky9gAw8hTCT5Zei5oNA3oUsRSo
         /pLIGzr4KFXNiaVjRpG+9Ou+/Uj65plyzGNUV7Wvge94l31lxaZjn7fw3YGEtDxJfyTW
         fFEMtmHZl8RCD2yceEhJxAc298FngUL+2P+P/bN6VhUoDZ4jnIbm8prp0ngIm6yjUidu
         wS0Gk66mBhqc9FBWmCCgKU94aHkBbjSHtxS9PKNuosamkCxZuic733dZswsmx++k9c7y
         6d6w==
X-Gm-Message-State: AC+VfDwPyNsIzMp4BWg8ZI4Bg/H4u6OEJ4gJqAKdfFPi1Kl2ynYWlIVZ
        gBmRsoGKnV+hZT7C9TBfjI+K
X-Google-Smtp-Source: ACHHUZ6g12hcR5RsXes44rDIC42wWSUUb2AAjwP175B+ZA0ks73GoPrUGDVnrP+EUEthRVd4rLf4bA==
X-Received: by 2002:a05:6a20:c1a5:b0:10e:a8e6:35c5 with SMTP id bg37-20020a056a20c1a500b0010ea8e635c5mr3605322pzb.59.1686237413535;
        Thu, 08 Jun 2023 08:16:53 -0700 (PDT)
Received: from thinkpad ([117.202.186.138])
        by smtp.gmail.com with ESMTPSA id i26-20020a63585a000000b00543f7538d64sm1379430pgm.31.2023.06.08.08.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:16:52 -0700 (PDT)
Date:   Thu, 8 Jun 2023 20:46:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Li Jun <jun.li@nxp.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [PATCH 2/2] USB: dwc3: fix use-after-free on core driver unbind
Message-ID: <20230608151646.GH5672@thinkpad>
References: <20230607100540.31045-1-johan+linaro@kernel.org>
 <20230607100540.31045-3-johan+linaro@kernel.org>
 <20230608130246.GF5672@thinkpad>
 <ZIHTBw3pMNjieVyj@hovoldconsulting.com>
 <20230608132313.GG5672@thinkpad>
 <ZIHchsMdf2nPv3wh@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIHchsMdf2nPv3wh@hovoldconsulting.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:49:58PM +0200, Johan Hovold wrote:
> On Thu, Jun 08, 2023 at 06:53:13PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jun 08, 2023 at 03:09:27PM +0200, Johan Hovold wrote:
> > > On Thu, Jun 08, 2023 at 06:32:46PM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Jun 07, 2023 at 12:05:40PM +0200, Johan Hovold wrote:
> > > > > Some dwc3 glue drivers are currently accessing the driver data of the
> > > > > child core device directly, which is clearly a bad idea as the child may
> > > > > not have probed yet or may have been unbound from its driver.
> > > > > 
> > > > > As a workaround until the glue drivers have been fixed, clear the driver
> > > > > data pointer before allowing the glue parent device to runtime suspend
> > > > > to prevent its driver from accessing data that has been freed during
> > > > > unbind.
> > > 
> > > > > @@ -1929,6 +1929,11 @@ static int dwc3_remove(struct platform_device *pdev)
> > > > >  	pm_runtime_disable(&pdev->dev);
> > > > >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > > > >  	pm_runtime_put_noidle(&pdev->dev);
> > > > > +	/*
> > > > > +	 * HACK: Clear the driver data, which is currently accessed by parent
> > > > > +	 * glue drivers, before allowing the parent to suspend.
> > > > > +	 */
> > > > > +	platform_set_drvdata(pdev, NULL);
> > > > 
> > > > This is required because you have seen the glue driver going to runtime suspend
> > > > once the below pm_runtime_set_suspended() is completed?
> > > 
> > > This is based on analysis of the code. The parent (glue) can not suspend
> > > while the child (core) is in the active state, but once we set the
> > > suspended state that could happen.
> > 
> > I could see that the driver core is setting drvdata to NULL during
> > device_unbind_cleanup(), so not sure if this scenario could be met otherwise it
> > will be redundant.
> 
> If this was redundant I wouldn't have added it. ;)
> 
> The parent driver has no business accessing the driver data of the child
> in the first place, but it must absolutely not do so after the child has
> been unbound from its driver and the driver data is getting freed.
> 
> Relying on the clean up in driver core that resets this pointer does not
> work as that would still leave a window where the parent could access
> this stale data.
> 

Well, I agree with the small window here.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
