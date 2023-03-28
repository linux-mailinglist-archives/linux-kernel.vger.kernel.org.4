Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BAD6CBBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjC1KF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjC1KFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:05:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1297565B3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:05:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so11956260pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679997908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vbAeF/q4puGBHB30GEkNPpQcAvRu+9MbMvkqaMKXnBY=;
        b=N/hUGfZoczN3Pg/z8HKjl9dm38fgrahylvaMAeBz4U+0FI7thq5T4HCsq8QxobKFYn
         WJXd3tLrwx7JaNUoIIv47Gf3OvtwE8GNHOkvz5MskH3HggP2CI+Zyyp75aQ10exvAG7P
         CjUHSRhO6ImpgWTd1PzPx1QMA9Ae0eY8nklOMKPkNvyEqfQe81pWkMT1RsPvHf/W7GNa
         rWDGTt+maAzqstMTcDH4tmRu3PsYJx1er4/moiH72T0UMxjbLXj5mpKpCMVws1fx/Dep
         E5wiKaJWOd5rTpQx93vgZZGw7IV2odNGO/M1QmKBW4kldKuE+A3IkXTFs+O3v5fx6rQg
         eyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbAeF/q4puGBHB30GEkNPpQcAvRu+9MbMvkqaMKXnBY=;
        b=L38lpU3i8TqtCsIhh19Md+sjo7gRI6lwaZPi7yJPQg5b/nzL7aiQVFNzSkoWr421Kd
         CHB9AR4NQYpvt4DK3G881dOvTgn6ZdSaufExLo5Fy83Xr52Ck9+OcbokAEEEgytuPt7K
         aD4zqe1MuvtDkxSSGDMbe8vmsWec706JAZDfzqxXpXQt7tRFIt5P5nJYEuM4t77SAEM/
         3Nm0v71GZTXtGo7o5HMfBQXkm1d9kbUXjuIQL1PuEb4FCej7XXO8Et1epz9P7OsnWBJe
         b17pZ1sxd9eo3cmz0fjQ15hql0xZ//V6sonuxqs03GmYylEtDQu3voUWtXTalparIglY
         iPBw==
X-Gm-Message-State: AO0yUKXURdxyWIFC/Q4ROAFHxhDbYvxaJF+ZCZmX+0+Qjp1oZtj67Ogn
        obHKpM0nDyrujP+jYe3DQL8k
X-Google-Smtp-Source: AK7set+lwReY2NPXkOJR+EBgtum4SrJ6381r8NXBBjrHBxs47d/fAM2boVcLG/RDewj8Pp6fVpXhtw==
X-Received: by 2002:a05:6a20:1326:b0:cd:91bc:a9af with SMTP id g38-20020a056a20132600b000cd91bca9afmr10898154pzh.58.1679997908438;
        Tue, 28 Mar 2023 03:05:08 -0700 (PDT)
Received: from thinkpad ([117.202.191.80])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b001990028c0c9sm20809821plg.68.2023.03.28.03.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:05:08 -0700 (PDT)
Date:   Tue, 28 Mar 2023 15:35:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     andersson@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] usb: dwc3: qcom: Allow runtime PM
Message-ID: <20230328100501.GD5695@thinkpad>
References: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
 <20230325165217.31069-6-manivannan.sadhasivam@linaro.org>
 <ZCK3fGkgowvAd6Dw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCK3fGkgowvAd6Dw@hovoldconsulting.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:46:36AM +0200, Johan Hovold wrote:
> On Sat, Mar 25, 2023 at 10:22:17PM +0530, Manivannan Sadhasivam wrote:
> > dwc3-qcom driver is capable of doing runtime PM on its own, but currently
> > it requires userspace intervention to enable it. But there is no harm in
> > letting the driver to enable runtime PM on its own. So let's get rid of the
> > "pm_runtime_forbid()" and make sure that the dependency is maintained with
> > child devices using "pm_suspend_ignore_children(dev, false)".
> 
> Well, the potential harm is that these paths have hardly been tested so
> enabling it by default is a risk (e.g. as you noticed when trying to
> enable this by default). And especially if we don't address the layering
> violations first.
> 

I certainly tested this on a couple of boards with host and gadget mode and
noticed no issue (except one issue noticed by Steev on a docking station with
display but that should be related to orientation switch).

Even if we allow runtime PM on this driver, still userspace needs to enable it
for dwc3 and xhci drivers. So this essentially reduces one step in that process
if someone tries to enable runtime PM for usb intentionally. So I don't forsee a
potential harm here.

> > Also during remove(), the device needs to be waken up first if it was
> > runtime suspended. Finally, pm_runtime_allow() can be removed.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/usb/dwc3/dwc3-qcom.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > index f1059dfcb0e8..5f26bb66274f 100644
> > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > @@ -920,7 +920,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  	qcom->is_suspended = false;
> >  	pm_runtime_set_active(dev);
> >  	pm_runtime_enable(dev);
> > -	pm_runtime_forbid(dev);
> > +	pm_suspend_ignore_children(dev, false);
> 
> There's no need to explicitly disable ignore-children as that is the
> default.
> 

Other dwc drivers were doing it, so I thought someone (maintainer) wanted to
explicitly disable ignore_children. But if that's not the case, I can remove it.

> >  	return 0;
> >  
> > @@ -948,6 +948,8 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	int i;
> >  
> > +	pm_runtime_get_sync(dev);
> 
> This call needs to be balanced. But this is a fix for a bug in the
> current implementation that should go in a separate patch.
> 

Ok. For balancing I could add pm_runtime_put_noidle() before pm_runtime_disable.

- Mani

> > +
> >  	device_remove_software_node(&qcom->dwc3->dev);
> >  	of_platform_depopulate(dev);
> >  
> > @@ -960,7 +962,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
> >  	dwc3_qcom_interconnect_exit(qcom);
> >  	reset_control_assert(qcom->resets);
> >  
> > -	pm_runtime_allow(dev);
> >  	pm_runtime_disable(dev);
> >  
> >  	return 0;
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
