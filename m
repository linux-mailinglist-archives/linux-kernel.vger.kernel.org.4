Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2486DF853
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDLOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:23:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758CD10C0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:23:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j8so10070592pjy.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681309427; x=1683901427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sniY/Tac8A1W1zg6TUFVsDJ2AGSVxreOz6N9SHlp3qk=;
        b=vJFBedIZHWMArO2ifi9Q8vao8wa60EyYskVgeKCE0jGTq1wu+qkHWzS49sXUerlT+C
         aolOGj7tsQwD8CXIlwjPXD3rkGqw0qzv41DIWcK5s2lbU+decSPZ1s8mzcU7+CWoOzzy
         ZGOEqQGPkai+wggf0c+WbDuJ6sMzquYBXPQi6uqvy+9wasZJvRzo/apjPB8a3ITYYHdc
         MR81Ggj7T/1bmDOdMFlBX3FuRrjbtkki6DKhOYo2y94fPtNRlQiuUa83Vob5HQbduYS7
         1pD2piidmZmJGsxS32VbT88DSQc906Gs8sxXRueA/nTnJhKJ9fcL2piqYV6ZHoHBnaHp
         Rpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309427; x=1683901427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sniY/Tac8A1W1zg6TUFVsDJ2AGSVxreOz6N9SHlp3qk=;
        b=zfwoTpmJ0sbJlSDOVivwnl2YaqhVyYbkQQe7usOfFUIwDpDSmL75QB2ZEFayWsWOB9
         aNhETJO5JQx+TumrBw4Qwr2LIFb3lKqKjL+xtOpcug7+9IV3ROsMe+1O2CYd1/VxxheL
         MzvFK6tNbmbKvrVPOkKLbM4T7somOUmvJyDbnO/fRcILl69p+pw3HK7nL3bF9WzavT/B
         pdQwwVjwOV/QAl4jt4TG5dfKhAG99wol7iheKOZi1VkGWKqnbPa/6yDFrrtDkRXeqh4i
         8R+TKZlDT+j9cTGKXs0gmv83P4tlSHQ+jaf8UZRZIBXabVsR/LbzXAgg7TKPP015iC9J
         0rcQ==
X-Gm-Message-State: AAQBX9eCDNA1STIdShxtbP/qipTYl0/HfUmaAxv7kyHZDb2SKWDJpZow
        E8adu+mrcyZ1j/xI2bObx/cp
X-Google-Smtp-Source: AKy350b2yHSuSf+/lZWKlGogXKYfHgRmTqJ85Vt6CI/QEG82FqiOycg96/NUCUl6zAYw9LdMkRqiaQ==
X-Received: by 2002:a17:902:d484:b0:1a6:6b5d:8381 with SMTP id c4-20020a170902d48400b001a66b5d8381mr3830737plg.21.1681309426789;
        Wed, 12 Apr 2023 07:23:46 -0700 (PDT)
Received: from thinkpad ([117.217.185.192])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b001a5fccab02dsm6737288pln.177.2023.04.12.07.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:23:46 -0700 (PDT)
Date:   Wed, 12 Apr 2023 19:53:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
Message-ID: <20230412142339.GC9463@thinkpad>
References: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
 <20230411174742.GA3428751-robh@kernel.org>
 <20230411184231.GA59982@thinkpad>
 <ZDZouY0PEL64MT6N@lpieralisi>
 <20230412101112.GA9463@thinkpad>
 <ZDaMCcTD/Nwx0vnh@lpieralisi>
 <20230412112918.GB9463@thinkpad>
 <ZDaxvBK9IqAhZwIM@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDaxvBK9IqAhZwIM@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 03:27:24PM +0200, Lorenzo Pieralisi wrote:
> On Wed, Apr 12, 2023 at 04:59:18PM +0530, Manivannan Sadhasivam wrote:
> 
> [...]
> 
> > > > This is fine. The plan is to remove the "iommus" property from Qcom PCI binding
> > > > since we have removed the usage of that property from devicetree [1]. Initially
> > > > the iommu properties were not documented at all in the binding. But commit,
> > > > "dt-bindings: PCI: qcom: Add SM8550 compatible" added them to the binding to
> > > > satisfy dtbs check. But in parallel, the patch removing "iommus" property from
> > > > dts got merged to qcom tree.
> > > > 
> > > > So now we have 2 options here:
> > > > 
> > > > 1. Amend the commit "dt-bindings: PCI: qcom: Add SM8550 compatible" to remove
> > > > the "iommus" property.
> > > > 
> > > > 2. I will submit a separate patch removing that property.
> > > > 
> > > > Lorenzo, let me know what works for you. Sorry for the mess! Confusion happened
> > > > due to patches getting applied without sync.
> > > 
> > > You can inline a diff here for (1), I will amend the commit.
> > > 
> > 
> > Here you go:
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index a1318a4ecadf..1548a7114732 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -60,9 +60,6 @@ properties:
> >      minItems: 1
> >      maxItems: 8
> >  
> > -  iommus:
> > -    maxItems: 1
> > -
> >    iommu-map:
> >      maxItems: 2
> 
> Done, please check, thanks.
> 

LGTM, thanks!

- Mani

> Lorenzo

-- 
மணிவண்ணன் சதாசிவம்
