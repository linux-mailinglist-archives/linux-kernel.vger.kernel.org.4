Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE0D688B0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBBXom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjBBXoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:44:30 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259566AC87;
        Thu,  2 Feb 2023 15:44:28 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso920652oti.10;
        Thu, 02 Feb 2023 15:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUtIlqowlh77/2rCcvCPqEo8bYeoC8RahUA3A2M1OwM=;
        b=g5MNn16l7fPCgQx1m5ThNcv/H+03C9wCqSJGYZG5zhnjgGZkTTpe18Ct1BqD8LOT9P
         qCzoQs2VKwslvImTIWYmx/FP2Xb9u44JSGXso/x4ryvRlNqd6NkEyNLE0TVuEmrMTL/B
         SLUnnbE7ipoCnAGpbbjclXxqt0+XgxNr+zkjeQVqRCZNCzIriZ2GUic8Un9q17+7mu0C
         cZxELNHF58Ac/OUZxEPj7brzOHJMfdQQ9N8CnVnZSqBo0iw5v75aMAqkKs1XD25nmyLe
         0PVAQOxRFwgpNQsOnGaHNSZvLFXly3+x/ZeYjA3cJAJ4Lr/5Z+MUpx3mOxdTDP/wQMk1
         Rddg==
X-Gm-Message-State: AO0yUKXth3A6fT3dV9+/U/qKwUFExJ6OFLLb/ePmUt9RZs745D6sWbfg
        LXJxKtJ7osipijWg/SuFUg==
X-Google-Smtp-Source: AK7set/QrFi2MQe/q9DdZissE1xaOXkrFs42A3E3MZWLN/cgUehiBDdNmYDs9PB1jCYYQD5oMreucg==
X-Received: by 2002:a9d:6749:0:b0:68b:d4bd:c375 with SMTP id w9-20020a9d6749000000b0068bd4bdc375mr4039512otm.30.1675381467327;
        Thu, 02 Feb 2023 15:44:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f6-20020a9d7b46000000b0068d51cb1fb7sm451911oto.6.2023.02.02.15.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:44:26 -0800 (PST)
Received: (nullmailer pid 2915928 invoked by uid 1000);
        Thu, 02 Feb 2023 23:44:25 -0000
Date:   Thu, 2 Feb 2023 17:44:25 -0600
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
Message-ID: <20230202234425.GA2898249-robh@kernel.org>
References: <20230201064717.18410-4-zajec5@gmail.com>
 <20230201084821.1719839-1-michael@walle.cc>
 <8452b341-8695-05d8-9d03-47c9aeca0ec7@gmail.com>
 <017a17eb99ac2b2c858d27b65c5dd372@walle.cc>
 <20230201185402.GA4084724-robh@kernel.org>
 <1b3024876259eab4464db9ca676a884f@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b3024876259eab4464db9ca676a884f@walle.cc>
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

On Wed, Feb 01, 2023 at 09:15:50PM +0100, Michael Walle wrote:
> Am 2023-02-01 19:54, schrieb Rob Herring:
> > On Wed, Feb 01, 2023 at 11:46:01AM +0100, Michael Walle wrote:
> > > > Before I convert brcm,nvram to NVMEM layout I need some binding & driver
> > > > providing MMIO device access. How to handle that?
> > > 
> > > I'm not arguing against having the mmio nvmem driver. But I don't
> > > think we should sacrifice possible write access with other drivers.
> > > And
> > > I presume write access won't be possible with your generic driver as
> > > it
> > > probably isn't just a memcpy_toio().
> > > 
> > > It is a great fallback for some nvmem peripherals which just maps a
> > > memory region, but doesn't replace a proper driver for an nvmem
> > > device.
> > > 
> > > What bothers me the most isn't the driver change. The driver can be
> > > resurrected once someone will do proper write access, but the generic
> > > "mediatek,efuse" compatible together with the comment above the older
> > > compatible string. These imply that you should use "mediatek,efuse",
> > > but we don't know if all mediatek efuse peripherals will be the
> > > same - esp. for writing which is usually more complex than the
> > > reading.
> > 
> > Because the kernel can't pick the "best" driver when there are multiple
> > matches, it's all Mediatek platforms use the generic driver or all use
> > the Mediatek driver.
> 
> Isn't that the whole point of having multiple compatible strings?
>   compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
> The OS might either load the driver for "fsl,imx21-mmc" or one for
> "fsl,imx27-mmc", with the latter considered to be the preferred one.

No, there's some assumption they would be similar enough to be served by 
the same driver.

While it seems like we'd want to fix this, it's been an issue I've been 
aware of as long as I've been involved with DT and yet I don't recall 
anyone really having an issue. Could just be everyone couples their 
kernel and dtb versions...

> > Personally, I think it is easy enough to revive the driver if needed
> > unless writing is a soon and likely feature.
> 
> That what was actually triggered my initial reply. We are planning a
> new board with a mediatek SoC and we'll likely need the write support.

If write support is on the horizon, then I'd say keep the Mediatek 
driver.

> But I thought the "mediatek,efuse" was a new compatible with this patch
> and the (new!) comment make it looks like these compatible are deprecated
> in favor of "mmio-nvmem". Which would make it impossible to distinguish
> between the different efuse peripherals and thus make it impossible to
> add write support.

No, it's in the schema and dts files.

> 
> > The other way to share is providing library functions for drivers to
> > use. Then the Mediatek driver can use the generic read functions and
> > custom write functions.
> > 
> > > nitpick btw: why not "nvmem-mmio"?
> > > 
> > > So it's either:
> > >  (1) compatible = "mediatek,mt8173-efuse"
> > >  (2) compatible = "mediatek,mt8173-efuse", "mmio-nvmem"
> > > 
> > > (1) will be supported any anyway for older dts and you need to add
> > > the specific compatibles to the nvmem-mmio driver - or keep the
> > > driver as is.
> > > 
> > > With (2) you wouldn't need to do that and the kernel can load the
> > > proper driver if available or fall back to the nvmem-mmio one. I'd
> > > even make that one "default y" so it will be available on future
> > > kernels and boards can already make use of the nvmem device even
> > > if there is no proper driver for them.
> > > 
> > > I'd prefer (2). Dunno what the dt maintainers agree.
> > 
> > No because you are changing the DT. The DT can't change when you want to
> > change drivers. This thinking is one reason why 'generic' bindings are
> > rejected.
> 
> There is no change in the DT. Newer bindings will have
> 
>   compatible = "vendor,ip-block", "mmio-nvmem"
> 
> when the ip block is compatible with mmio-nvmem. Otherwise I don't get
> why there is a mmio-nvmem compatible at all. Just having
> 
>   compatible = "mmio-nvmem"
> 
> looks wrong as it would just work correctly in some minor cases, i.e.
> when write support is just a memcpy_toio() - or we deliberately ignore
> any write support. But even then, you always tell people to add specific
> compatibles for the case when quirks are needed..

Yes, I do. I was assuming these are simple cases unlikely to need 
platform specific support. We're just reading static bits from 
registers...

If you may need write support or have other complications, then 
"mmio-nvmem" should not be used. You can use the driver, but it should 
match with a platform specific compatible, not the generic one.

Rob
