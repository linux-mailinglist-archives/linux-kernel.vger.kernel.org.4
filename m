Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC06DA1D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbjDFTpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjDFTpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:45:50 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF0D9F;
        Thu,  6 Apr 2023 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EK3fzbe5+X0+zxNKNJ1I6F2pPMdvVE8OkksanhvKrFs=; b=3V1WE+ztaydYic26h12m7RgGCa
        96Ex3OZ4X2tNddmqeyQv0L3WI/gAZnA24HtxNF3KdB2EHmj3NJKebU+EmhxlZHE9jOPex5K5vfack
        KDcximceBQL+N8xgyem1pfEwIZFqPiQ8628mT0wuaC5sNsJUtDwH3/7QamQuAfTiqzN5WTqJ4KX+e
        2yOycYWpcjMN/FvMzskcycqfwObkircCO9HvMN7YpI6DxRFurkVbIwvyPo4QkDbaOdi7fq9ldqRe6
        r/nXGyGaGQIGs95az2mnrpsP/RJmvBudHbW6Kg51UiAGAlG1c99RNjq4eo/p/U8B02Dx3QAacX+5f
        rCF7l8YQ==;
Received: from p200300ccff190e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff19:e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pkVYD-00038N-CR; Thu, 06 Apr 2023 21:45:41 +0200
Date:   Thu, 6 Apr 2023 21:45:39 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
Subject: Re: [PATCH 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel i2c
 LED driver
Message-ID: <20230406214539.59dfaac7@aktux>
In-Reply-To: <7d8c558f-0d21-91ed-ecd0-cac079d366ee@gmail.com>
References: <20230406060825.103187-1-andreas@kemnade.info>
        <20230406060825.103187-3-andreas@kemnade.info>
        <7d8c558f-0d21-91ed-ecd0-cac079d366ee@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 11:57:15 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

[...]

> 
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/leds.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#define BD2606_MAX_LEDS 6
> > +#define BD2606_MAX_BRIGHTNESS 63
> > +#define BD2606_REG_PWRCNT 3
> > +#define ldev_to_led(c)	container_of(c, struct bd2606mvv_led, ldev)
> > +
> > +struct bd2606mvv_led {
> > +	bool active;  
> 
> I didn't spot where this 'active' was used?
> 
[..]

> > +		if (reg < 0 || reg >= BD2606_MAX_LEDS ||
> > +		    priv->leds[reg].active) {

here

> > +			of_node_put(child);
> > +			return -EINVAL;
> > +		}
> > +		led = &priv->leds[reg];
> > +
> > +		led->active = true;

and here

Regards,
Andreas
