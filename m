Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4497413B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjF1OTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjF1OS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF8294C;
        Wed, 28 Jun 2023 07:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B5561346;
        Wed, 28 Jun 2023 14:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C200FC433C8;
        Wed, 28 Jun 2023 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687961907;
        bh=0eE1KMd2Qanaqxou9OXa3f1XMcYB+4O+niZku/Fpy4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFTLIbeWAGyO4kEjb0jElafIXBzi8x8s25cNzKgUrgVnL1WN8Yacu/kDkxVeDBF4/
         hYCSBiPkbJ0mA/YkwLztkTUGonos5czEM3sX3e8Qkgk+s1TeQ9nSYuFeVeLx7Qnsnn
         yYmJQ7+7nydIPxLxEUFxQJ0hSqdRZONmGSzSo/fqqChq46v7Sf+Z5y7Oynz/1Nb+hL
         QkObHDDrarOpSuU4E9AuVBb/3+DbisFrMYyV7u3uY55gbOp0WdM1BjV4ZBBx0tI5m0
         +Vm2N9UT9UEJ89gYK2isO3cgK7X6FHNgDYHVpFxI5hPNfFHiXqN4Q11DISUymjFsXA
         SqTtItqRVeN+w==
Date:   Wed, 28 Jun 2023 15:18:19 +0100
From:   Lee Jones <lee@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 3/5] iio: adc: max77541: Add ADI MAX77541 ADC Support
Message-ID: <20230628141819.GK10378@google.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-4-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412111256.40013-4-okan.sahin@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023, Okan Sahin wrote:

> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/Kconfig        |  11 ++
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/max77541-adc.c | 194 +++++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 drivers/iio/adc/max77541-adc.c

Applied, thanks

-- 
Lee Jones [李琼斯]
