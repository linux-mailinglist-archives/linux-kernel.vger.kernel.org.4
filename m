Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE027215FD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 12:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjFDKU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 06:20:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AFEA3;
        Sun,  4 Jun 2023 03:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24D6D60F55;
        Sun,  4 Jun 2023 10:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D51C433EF;
        Sun,  4 Jun 2023 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685874049;
        bh=KNWTkBNxkUm0++34/5RGlpBQ8nek3uIrv2ErreqYNkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ET68GUTN8XQJzGbSbl3yHcepbNoqbblEZuRWjiDbNT52xCz3Es63iVrSuT2hGzd6x
         n52iZlrLTDbd7ipeLxVTqbZhITWiTJq0VrKNuWpzQ5iP/u6w6Dwyx1XB5FZmdyBUBt
         Rde+1BNaRYyH0jHUAIugHRSYI1Szx4a/MNIlv4ytVGD4eyms/jj6xV/8naJ6Ej4ims
         qJoxFCD5Zs+OoYg8dVqOGbx3bHVv4tBsnpq4hWVFCGxOt+buRU5gwDQPJIRcDqcM2H
         uBsqjrXhoNqwWPM1Nxd+JH/qo0s+SqDb/xBgdjICr6YRq8D9omNpyqnZNcXOKMHORx
         qGw0JU6f+hPsg==
Date:   Sun, 4 Jun 2023 11:20:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        gustavo.padovan@collabora.com, kernel@collabora.com,
        serge.broslavsky@collabora.com, Simon Xue <xxm@rock-chips.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 2/8] iio: adc: rockchip_saradc: Add support for
 RK3588
Message-ID: <20230604112043.43b1ada0@jic23-huawei>
In-Reply-To: <ZHunAIbK7-tIvsm1@surfacebook>
References: <20230603185340.13838-1-shreeya.patel@collabora.com>
        <20230603185340.13838-3-shreeya.patel@collabora.com>
        <ZHunAIbK7-tIvsm1@surfacebook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2023 23:48:00 +0300
andy.shevchenko@gmail.com wrote:

> Sun, Jun 04, 2023 at 12:23:34AM +0530, Shreeya Patel kirjoitti:
> > From: Simon Xue <xxm@rock-chips.com>
> > 
> > Add new start and read functions to support rk3588 device.
> > Also, add a device compatible string for the same.  
> 
> ...
> 
> > +/* v2 registers */
> > +#define SARADC2_CONV_CON		0x0
> > +#define SARADC_T_PD_SOC			0x4
> > +#define SARADC_T_DAS_SOC		0xc  
> 
> Can you use fixed-width values for all registers?
> 
> 	0x000
> 	0x004
> 	0x00c
> 
> > +#define SARADC2_END_INT_EN		0x104
> > +#define SARADC2_ST_CON			0x108
> > +#define SARADC2_STATUS			0x10c
> > +#define SARADC2_END_INT_ST		0x110
> > +#define SARADC2_DATA_BASE		0x120  
> 

I tidied this up whilst applying.

Jonathan
