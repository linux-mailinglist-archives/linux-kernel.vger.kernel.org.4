Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76570282D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbjEOJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbjEOJUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:20:34 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5B219BF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:15:59 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 17121625-f301-11ed-abf4-005056bdd08f;
        Mon, 15 May 2023 12:15:56 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 15 May 2023 12:15:52 +0300
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <ZGH4SPsu40Mt-Z8f@surfacebook>
References: <20230426071045.20753-1-zhuyinbo@loongson.cn>
 <20230426071045.20753-3-zhuyinbo@loongson.cn>
 <ZFkPZhF8QqScXAmH@surfacebook>
 <049c871d-c658-24c1-91e6-701098f5fc28@loongson.cn>
 <16913b76-0256-492a-ec90-d367f2b52cc3@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16913b76-0256-492a-ec90-d367f2b52cc3@loongson.cn>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 15, 2023 at 04:14:00PM +0800, zhuyinbo kirjoitti:
> 在 2023/5/11 下午3:18, zhuyinbo 写道:
> > 在 2023/5/8 下午11:04, andy.shevchenko@gmail.com 写道:

...

> > > > +config SPI_LOONGSON_CORE
> > > > +    tristate "Loongson SPI Controller Core Driver Support"
> > > 
> > > Does it need to be visible to the user?
> 
> I try to set it invisible that by removing the SPI_LOONGSON_CORE Kconfig
> or removing "tristate "Loongson SPI Controller Core Driver Support" that
> will cause spi-core driver doesn't be compiled or compiled fail issue,
> so I will still set it visible to the user.

Making a symbol selectable only can be achieved by removing the description
(near to tristate directive), have you tried that?

...

> > > > +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +    if (res == NULL) {
> > > 
> > > Why not using devm_platform_ioremap_resource()?
> > okay, I will use it.
> > > 
> > > > +        dev_err(dev, "cannot get io resource memory\n");
> > > > +        return -ENOENT;
> > > 
> > >     return dev_err_probe();
> 
> It seems that there is no need to print memory log when use
> devm_platform_ioremap_resource because this function had contained
> the this memory log print thus I will return PTR_ERR(reg_base).
> 
>         reg_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(reg_base))
>                 return PTR_ERR(reg_base);

Good catch! Sure, go with this.

-- 
With Best Regards,
Andy Shevchenko


