Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6389686E6A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBASyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjBASyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:54:05 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F877CCAF;
        Wed,  1 Feb 2023 10:54:04 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1631b928691so24742215fac.11;
        Wed, 01 Feb 2023 10:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sMQc0PK6ObdJHfFL3hGtO0pIoGyC7nHbzdlT3Spl2Y=;
        b=U1QHfyTbP3VlaK23DTIIDEp6dUcroQLBXgBhukcW5vl2g7ndahJ+NLGrQnnvUifnwA
         GiO/0r9HA1+Ym3ulLIm66vdYpVP32g8ARjGviYkKgf5OXxmjbxr3t2bYpgwSJcGnYkRF
         +aOcesl1/1/EggI+wMMBe6O0FYPSQ534+lJHXQ7FfOdiXUQBdm0dRf2gaRm1uZQLedAC
         7mDyWQ0I6X9u9+lRgNf2Qneuj14HQ4mzHx+gDn+oNgYglwW4fcRcc+ON9zl6Y17lbhLT
         iy3/DNz2Y1w4VtiCb67MwEYb491yMwydPPMe2wuzpL6m20Qq93smKiku1vEIQ6Nn1v0t
         6o1w==
X-Gm-Message-State: AO0yUKX77fbHNVhySGCwxMChqUlTjvY+CgXiqLbvGo2j+GcAbXBYgXr9
        UN6cLl7ByJNb/kUPE0wEycD/ACLZIA==
X-Google-Smtp-Source: AK7set+x4JYggnZQEp7fWaOZYSgRM7McC3+rmo9BC9jTfy4gSLLBzuRh3gqarJNb/Hc9cF/IrLdkpg==
X-Received: by 2002:a05:6870:ac20:b0:163:573b:3e8d with SMTP id kw32-20020a056870ac2000b00163573b3e8dmr1535116oab.30.1675277643870;
        Wed, 01 Feb 2023 10:54:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u16-20020a056870701000b0014fd7e7c3fesm7904092oae.27.2023.02.01.10.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:54:03 -0800 (PST)
Received: (nullmailer pid 4146388 invoked by uid 1000);
        Wed, 01 Feb 2023 18:54:02 -0000
Date:   Wed, 1 Feb 2023 12:54:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        devicetree@vger.kernel.org, hayashi.kunihiko@socionext.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mhiramat@kernel.org, rafal@milecki.pl,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 3/4] nvmem: mtk-efuse: replace driver with a generic MMIO
 one
Message-ID: <20230201185402.GA4084724-robh@kernel.org>
References: <20230201064717.18410-4-zajec5@gmail.com>
 <20230201084821.1719839-1-michael@walle.cc>
 <8452b341-8695-05d8-9d03-47c9aeca0ec7@gmail.com>
 <017a17eb99ac2b2c858d27b65c5dd372@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017a17eb99ac2b2c858d27b65c5dd372@walle.cc>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:46:01AM +0100, Michael Walle wrote:
> > Before I convert brcm,nvram to NVMEM layout I need some binding & driver
> > providing MMIO device access. How to handle that?
> 
> I'm not arguing against having the mmio nvmem driver. But I don't
> think we should sacrifice possible write access with other drivers. And
> I presume write access won't be possible with your generic driver as it
> probably isn't just a memcpy_toio().
> 
> It is a great fallback for some nvmem peripherals which just maps a
> memory region, but doesn't replace a proper driver for an nvmem device.
> 
> What bothers me the most isn't the driver change. The driver can be
> resurrected once someone will do proper write access, but the generic
> "mediatek,efuse" compatible together with the comment above the older
> compatible string. These imply that you should use "mediatek,efuse",
> but we don't know if all mediatek efuse peripherals will be the
> same - esp. for writing which is usually more complex than the reading.

Because the kernel can't pick the "best" driver when there are multiple 
matches, it's all Mediatek platforms use the generic driver or all use 
the Mediatek driver.

Personally, I think it is easy enough to revive the driver if needed 
unless writing is a soon and likely feature.

The other way to share is providing library functions for drivers to 
use. Then the Mediatek driver can use the generic read functions and 
custom write functions.

> nitpick btw: why not "nvmem-mmio"?
> 
> So it's either:
>  (1) compatible = "mediatek,mt8173-efuse"
>  (2) compatible = "mediatek,mt8173-efuse", "mmio-nvmem"
> 
> (1) will be supported any anyway for older dts and you need to add
> the specific compatibles to the nvmem-mmio driver - or keep the
> driver as is.
> 
> With (2) you wouldn't need to do that and the kernel can load the
> proper driver if available or fall back to the nvmem-mmio one. I'd
> even make that one "default y" so it will be available on future
> kernels and boards can already make use of the nvmem device even
> if there is no proper driver for them.
> 
> I'd prefer (2). Dunno what the dt maintainers agree.

No because you are changing the DT. The DT can't change when you want to 
change drivers. This thinking is one reason why 'generic' bindings are 
rejected.

Rob
