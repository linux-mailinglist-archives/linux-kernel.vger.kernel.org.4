Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A974B738CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFUROy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjFUROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C531B10C;
        Wed, 21 Jun 2023 10:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D80B6160E;
        Wed, 21 Jun 2023 17:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFFEC433C0;
        Wed, 21 Jun 2023 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687367689;
        bh=Ig7h1rTYEsmEV7G81Nmb1HvjJThz1FZiBSw0DAESgX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EA+TkeH1zdh3UTzsbnvhz/ioWY5n7H6RjkWnD00fHvi4+stRfuZX+x9vMwniFILUg
         FhZYFFhMluHx6AVq3fKebL794/lTV/x8JXQNlJMe81XN5iUUQm5S/5k3uK6RVohenq
         dGGH51ZmKV7Kx/s2T1JHAMbRYat2EnDvdIhKuFHUUzQEk3oU9xhDtNlda1PnVVgLMa
         d52J84klyVwN7tqYzNREAlOT+vKV5iPb4SZ8cOyXXtEc/GcNmI0JpFBCEUITDZdBgB
         O97hxJZRYunt0QBh4OWakgEY3rFFt69DtwA4GSGBMySSt9XuNtywsNZag8t2um5Twp
         /114G7uIe7Xkg==
Date:   Wed, 21 Jun 2023 18:14:41 +0100
From:   Lee Jones <lee@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230621171441.GM10378@google.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-6-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412111256.40013-6-okan.sahin@analog.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023, Okan Sahin wrote:

> MFD driver for MAX77541/MAX77540 to enable its sub
> devices.
> 
> The MAX77541 is a multi-function devices. It includes
> buck converter and ADC.
> 
> The MAX77540 is a high-efficiency buck converter
> with two 3A switching phases.
> 
> They have same regmap except for ADC part of MAX77541.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  drivers/mfd/Kconfig          |  13 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77541.c       | 224 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77541.h |  91 ++++++++++++++
>  4 files changed, 329 insertions(+)
>  create mode 100644 drivers/mfd/max77541.c
>  create mode 100644 include/linux/mfd/max77541.h

Applied, thanks

-- 
Lee Jones [李琼斯]
