Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2015B857B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiINJtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiINJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:49:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D82DFE3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:49:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so6489281wrp.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=bbq4/4T4JjPGUfth20drkaf18DSxlzxy1kFL2s5Skkk=;
        b=ExcJVlbc0ZagiH+Rt7hA0bIVbTU/NxhHDjFnmOG97vfk7AfET8oP8YY+6s84+Q+Kob
         AJ5rZVaCR4FSyyotJ+Um7fBWBWoMhnq6QmyyFF+rO62RqwDs2N4Cn46ksL+KGnpwh78j
         S9EN8XhjlqB4zz8tP/9vhz/LY6UjBPfju8CSPIQ4BAqdnZkjw88ejZd09ya3aFzcPlFx
         1+nPK7TEXW2EAEnjLYIuPT+P98eFpC+AhVnQvUCuPinG4F1UA1iUwSzMXBNZ6rOAIuA5
         rt96dfG3b4g5SHEDUERGZ840y1RY/kPx0dSau+lT3vebZafJpjfn+RBOIRHaCUGx6/1o
         JI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bbq4/4T4JjPGUfth20drkaf18DSxlzxy1kFL2s5Skkk=;
        b=0tJbrU8kdJBGOI7x+ZJtaFyUrI/QnQv1npSddawhGceV8zNExDKKIHk28dajwLK7/l
         +odth6r/Ej0lx8qp5fmxZqHD0ssUBxNBDMVcIcO0Br+8a3n/DB0zi9djjel1Ytzpy2n8
         HbWXoJZ5rkodfFN9cxM2aZ3qr1aDVPvIdKVyQ3uNbEZ0gRmqT27gF3CSurB59+m45+Hh
         6OjHN1UqxQHO2FVa96y/DrGLJL2YWK4r/BMqegE5vc+m2H81MlUacbKab+F9P2/2rjqw
         sn/VppS5Lo5z9ATgRAKchurWIzCHrndcP/ULSZFQhyPQ30PMyUBxx9AyJd5JP8ux74HE
         BI0g==
X-Gm-Message-State: ACgBeo3Frbpp3ZuspL1pHr+5iWyITfZmwrATIwIuTIUxac4KYzyAACoT
        vnYNU7GUFxEhzeqj9DSurgLrPw==
X-Google-Smtp-Source: AA6agR44NE7mkRWSZbkSxz7tUVdtOhV3Q3E9t0A41MbdOWdyWfvzOmpa8UdB3Zu6U/6tZw10e5zx/A==
X-Received: by 2002:adf:e199:0:b0:228:60f6:f775 with SMTP id az25-20020adfe199000000b0022860f6f775mr20581130wrb.478.1663148987482;
        Wed, 14 Sep 2022 02:49:47 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id v12-20020adfe4cc000000b00228c8ed21c8sm13192128wrm.17.2022.09.14.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 02:49:47 -0700 (PDT)
Date:   Wed, 14 Sep 2022 10:49:42 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, robdclark@gmail.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        matthias.bgg@gmail.com, heiko@sntech.de, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, sricharan@codeaurora.org,
        yong.wu@mediatek.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        tglx@linutronix.de, shameerali.kolothum.thodi@huawei.com,
        thunder.leizhen@huawei.com, christophe.jaillet@wanadoo.fr,
        yangyingliang@huawei.com, jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 4/5] iommu: Regulate errno in ->attach_dev callback
 functions
Message-ID: <YyGjtsB2Yq4fQICS@myrica>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com>
 <YyB3F/o3RfymqiFW@myrica>
 <YyGaqsXSDMn8R12R@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyGaqsXSDMn8R12R@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:11:06AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 13, 2022 at 01:27:03PM +0100, Jean-Philippe Brucker wrote:
> > I think in the future it will be too easy to forget about the constrained
> > return value of attach() while modifying some other part of the driver,
> > and let an external helper return EINVAL. So I'd rather not propagate ret
> > from outside of viommu_domain_attach() and finalise().
> 
> Fortunately, if -EINVAL is wrongly returned it only creates an
> inefficiency, not a functional problem. So we do not need to be
> precise here.

Ah fair. In that case the attach_dev() documentation should indicate that
EINVAL is a hint, so that callers don't rely on it (currently words "must"
and "exclusively" indicate that returning EINVAL for anything other than
device-domain incompatibility is unacceptable). The virtio-iommu
implementation may well return EINVAL from the virtio stack or from the
host response.

Thanks,
Jean

> 
> > Since we can't guarantee that APIs like virtio or ida won't ever return
> > EINVAL, we should set all return values:
> 
> I dislike this alot, it squashes all return codes to try to optimize
> an obscure failure path :(
> 
> Jason
