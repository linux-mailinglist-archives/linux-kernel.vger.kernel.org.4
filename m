Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC66A7315AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbjFOKpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbjFOKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:45:06 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9326272D;
        Thu, 15 Jun 2023 03:45:04 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2C0C79F4;
        Thu, 15 Jun 2023 12:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1686825903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsSe8Z4wb+yZPV3lYchso8fbKXcEJA7soRNtTWuoUl4=;
        b=U9M4bli+yI8shcz26ZIVVq6foqMB1TiQRgi7EMXlIh0Ym1N8LT036SI9Rz05qxFKNfEroM
        VnHbgEdd8aBuZN5fby0nQkZrCYbsSAjfcoa7lnzC5tGoutTFYqcjJxJPLdg8zRvLUvKDkP
        dDABhIUXKq8EYnKg1dOAdzf3zCCKdiUQs3MerUQaQmn6Txl8ENL7F7XxysQwqiHRrRSJd8
        9L6PABWQB/nvge7jyXQwLEj7+RsBDZbkivmjOrCX8pabYCMDadzByR18VSY9ZWK1nES3Z4
        2TOvSwpl1Lu8YcgmFF5pVuUJluYvfBHrQzehmD8ud8BCb1kIs3eeK8h/Zh5gOA==
MIME-Version: 1.0
Date:   Thu, 15 Jun 2023 12:45:02 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     'Andy Shevchenko' <andy.shevchenko@gmail.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        shreeya.patel@collabora.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
In-Reply-To: <010401d99f6f$26d41600$747c4200$@trustnetic.com>
References: <20230607081803.778223-1-jiawenwu@trustnetic.com>
 <CAHp75Vdbq3uHOyrfT-KFYRSj6v+s9GgOQjQ9a8mGn-4HSCpB9Q@mail.gmail.com>
 <15e2fc098a1e63317368f4812290ca35@walle.cc>
 <010401d99f6f$26d41600$747c4200$@trustnetic.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b9af98d801d2808de3460c9e4fec8bdd@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> BTW, I wonder if it has problems when unregistering gpio-regmap.
> Call Trace of irq_domain_remove() always exits in my test:
> https://lore.kernel.org/all/011c01d98d3d$99e6c6e0$cdb454a0$@trustnetic.com/
> 
> Of course, it could be because there was something wrong with my
> test code. But I want to be clear about this.

Mh, you've said you don't use the devm_ variant of 
regmap_add_irq_chip(),
correct? Do you call regmap_del_irq_chip() yourself?

It seems that gpiolib is already removing the domain itself. Mh.
I guess if the the domain is set via gpiochip_irqchip_add_domain()
gpiolib must not call irq_domain_remove() because the domain resource
is handled externally (i.e. gpiolib doesn't allocate the domain
itself) in our case.

Nice finding! Looks like it has been broken since the beginning
when I've introduced the gpiochip_irqchip_add_domain(). Will you
do another fixes patch for that? I'm not sure where to store
that information though. Maybe a new bool "no_domain_free"
in struct gpio_irq_chip?

-michael
