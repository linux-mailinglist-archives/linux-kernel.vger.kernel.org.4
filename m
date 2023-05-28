Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC5713A88
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjE1QX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE1QXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC52FBE;
        Sun, 28 May 2023 09:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8043860B75;
        Sun, 28 May 2023 16:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73696C433D2;
        Sun, 28 May 2023 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685291002;
        bh=k6G5Xe62qpgcfKk8N9aTjJvUl9Ttz60+Svd6OPPzKjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l4VyYWsm8o4NwCyJJKBwXf9urk86ERcPauB041w8R9fDWaLGH/E0CySzkPogXje8R
         YGOeAr+W3ONLschYLex7PrhJn6ABFbZbK3+66aq0sLHdXKezmFTYZI42xzBiemwulR
         T39Rgxo6ibKafGxHoJ+JqRrCn8zMBrgEzgDUUMfwcif5Jady7vM5EkOprGHrNCjUdF
         qPNL/GTDftsPDg2tZMcfj9n8MwBO+/AgDX+nYSe/hSa6Vp3xhLyfI9o8AoEyrxG8Fa
         xkhbK9CVGULGb6TKkitEW0AXF6VVfYBJTMrMBh8IkrmdmMov564W2hZZ8jxK/0VzVQ
         jc53GxRH0uksg==
Date:   Sun, 28 May 2023 17:39:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v1 0/4] Add support for Allwinner GPADC on
 D1/T113s/R329 SoCs
Message-ID: <20230528173937.3ae59e50@jic23-huawei>
In-Reply-To: <20230524082744.3215427-1-bigunclemax@gmail.com>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 11:27:29 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

> Hi,
> 
> This series adds support for general purpose ADC (GPADC) on new
> Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
> provides basic functionality for getting ADC channels data.
> 
> All of the listed SoCs have the same IP. The only difference is the number
> of available channels:
>      T113 - 1 channel
>      D1   - 2 channels
>      R329 - 4 channels
> 
> This series is just an RFC and I would be glad to see any comments
> about it.
Why 'just an RFC'?  Normal to call out aspects that mean it doesn't yet
make sense for it to be picked up for upstream.

Looks pretty good to me in general rather than RFC material so perhaps
I'm missing something.

Jonathan

> 
> 
> Maxim Kiselev (4):
>   iio: adc: Add Allwinner D1/T113s/R329 SoCs GPADC
>   dt-bindings: iio: adc: Add Allwinner D1/T113s/R329 SoCs GPADC
>   ARM: dts: sun8i: t113s: Add GPADC node
>   riscv: dts: allwinner: d1: Add GPADC node
> 
>  .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    |  52 ++++
>  arch/arm/boot/dts/sun8i-t113s.dtsi            |  12 +
>  arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  10 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/sun20i-gpadc-iio.c            | 275 ++++++++++++++++++
>  6 files changed, 360 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
>  create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
> 

