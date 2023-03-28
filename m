Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81026CBFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjC1M5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjC1M5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:57:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A09EEE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:57:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u10so11528900plz.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680008236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cnqt2KDpfFtGxo7NM9abnZ0QYf18epNb8nX+e0XiQcs=;
        b=G3k1IxoPlSK6oA51ZOfIJU5whId5sRD0rPOtk8SaMishf5NxCLleEHV5Hi3w+FMrOP
         OyCCydwF88MI9MSy4mCtjL99rJO1exsIVRW4ZP/gTW9GgjS84o21+/dOG16RM7XlfuY1
         wgfLmAVZ3yR0nxsjnISSfX1jp97tggj5+U5ZFST7391fYTDuR0PaWjRux/lKM8qnT26i
         SICXDWLO4m+dcjhTbSKPrEmqIhEyAnOLrs6Qy91vjghlC/iWA7lb7QP9nm0LXzRHhciE
         laIYrtm7lp98M8qJMY/74DhXA/GKlz1oMsf+NBXv9WedFzikQmkpaYuYty0fED5LGrGP
         gQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680008236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cnqt2KDpfFtGxo7NM9abnZ0QYf18epNb8nX+e0XiQcs=;
        b=VAEvVAoEZbY4vTIzcZr6ZikbV4OeN8gY0K2/JyOF7IDCnZOY37GaCB2UvLAqXI5Y3b
         2Q8uugGIDs3kL7Bf39O4KA90EQfDWRrxYejlVBl6L7YtTqwBvLsuoI8fSEfSb/m2tyZl
         A/LY9JswA640StV2vzzfdT9OpBffjY5REeRQ1tybEXlwhxjNjD4mlBtEVyEy9q3Wl3cb
         U2hgAZSax8QjOaumLbfbd+CSe92dd069e49sI29xRW3dD9Yr2/pYEsUy/17PMwXvpQZX
         r7I3TJ28AYabf0r7PoUSMA1reXB9kd5jRR8xrMgyuISZ/ocUvRP9rC3hbZZCwtDbboxw
         2c2g==
X-Gm-Message-State: AAQBX9eyTxBA4nTqRX9hlN9vOCZia0rPJK+gdMeF/RyZ9lijfyC5Sm6E
        /CW3U6BJVLK126tbQXlwf2NtK35rfRHAwzh31g==
X-Google-Smtp-Source: AKy350aBYPPthGJS7n5GXGjAxdKZ0jVz1I0ANqkUPZ4irdmozlvd1uosOJ+ub/RO5g/YvZvQLzAx1w==
X-Received: by 2002:a17:902:e882:b0:1a1:f413:70b1 with SMTP id w2-20020a170902e88200b001a1f41370b1mr19091817plg.18.1680008235878;
        Tue, 28 Mar 2023 05:57:15 -0700 (PDT)
Received: from thinkpad ([117.202.191.80])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902b28400b001a06b33923bsm21111938plr.164.2023.03.28.05.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:57:15 -0700 (PDT)
Date:   Tue, 28 Mar 2023 18:27:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     andersson@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] usb: dwc3: qcom: Allow runtime PM
Message-ID: <20230328125705.GG5695@thinkpad>
References: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
 <20230325165217.31069-6-manivannan.sadhasivam@linaro.org>
 <ZCK3fGkgowvAd6Dw@hovoldconsulting.com>
 <20230328100501.GD5695@thinkpad>
 <ZCLbCJi80AKyVgnq@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCLbCJi80AKyVgnq@hovoldconsulting.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:18:16PM +0200, Johan Hovold wrote:
> On Tue, Mar 28, 2023 at 03:35:01PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Mar 28, 2023 at 11:46:36AM +0200, Johan Hovold wrote:
> > > On Sat, Mar 25, 2023 at 10:22:17PM +0530, Manivannan Sadhasivam wrote:
> > > > dwc3-qcom driver is capable of doing runtime PM on its own, but currently
> > > > it requires userspace intervention to enable it. But there is no harm in
> > > > letting the driver to enable runtime PM on its own. So let's get rid of the
> > > > "pm_runtime_forbid()" and make sure that the dependency is maintained with
> > > > child devices using "pm_suspend_ignore_children(dev, false)".
> > > 
> > > Well, the potential harm is that these paths have hardly been tested so
> > > enabling it by default is a risk (e.g. as you noticed when trying to
> > > enable this by default). And especially if we don't address the layering
> > > violations first.
> > > 
> > 
> > I certainly tested this on a couple of boards with host and gadget mode and
> > noticed no issue (except one issue noticed by Steev on a docking station with
> > display but that should be related to orientation switch).
> > 
> > Even if we allow runtime PM on this driver, still userspace needs to enable it
> > for dwc3 and xhci drivers. So this essentially reduces one step in that process
> > if someone tries to enable runtime PM for usb intentionally. So I don't forsee a
> > potential harm here.
> 
> Well this whole driver is a mess so I don't have any problem imagining
> ways in which things can break. ;)
> 
> > > > Also during remove(), the device needs to be waken up first if it was
> > > > runtime suspended. Finally, pm_runtime_allow() can be removed.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/usb/dwc3/dwc3-qcom.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > > > index f1059dfcb0e8..5f26bb66274f 100644
> > > > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > > > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > > > @@ -920,7 +920,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> > > >  	qcom->is_suspended = false;
> > > >  	pm_runtime_set_active(dev);
> > > >  	pm_runtime_enable(dev);
> > > > -	pm_runtime_forbid(dev);
> > > > +	pm_suspend_ignore_children(dev, false);
> > > 
> > > There's no need to explicitly disable ignore-children as that is the
> > > default.
> > > 
> > 
> > Other dwc drivers were doing it, so I thought someone (maintainer) wanted to
> > explicitly disable ignore_children. But if that's not the case, I can remove it.
> 
> Yeah, please remove it. I doubt these runtime pm implementations have
> gotten much review.
> 
> Note how several dwc3 glue drivers just do an unconditional get in
> probe(), which means that these paths are probably never exercised at
> all and effectively amounts to that pm_runtime_forbid() you are removing
> here.
> 
> Probably there to tick off "runtime pm" on some internal project
> manager's list of "features".
> 

Agree.

> > > >  	return 0;
> > > >  
> > > > @@ -948,6 +948,8 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
> > > >  	struct device *dev = &pdev->dev;
> > > >  	int i;
> > > >  
> > > > +	pm_runtime_get_sync(dev);
> > > 
> > > This call needs to be balanced. But this is a fix for a bug in the
> > > current implementation that should go in a separate patch.
> > > 
> > 
> > Ok. For balancing I could add pm_runtime_put_noidle() before pm_runtime_disable.
> 
> You should do it after disabling runtime pm.
> 

May I know why?

Thanks,
Mani

> > > > +
> > > >  	device_remove_software_node(&qcom->dwc3->dev);
> > > >  	of_platform_depopulate(dev);
> > > >  
> > > > @@ -960,7 +962,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
> > > >  	dwc3_qcom_interconnect_exit(qcom);
> > > >  	reset_control_assert(qcom->resets);
> > > >  
> > > > -	pm_runtime_allow(dev);
> > > >  	pm_runtime_disable(dev);
> > > >  
> > > >  	return 0;
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
