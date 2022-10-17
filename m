Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F86008E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJQImf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJQImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:42:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7074E2AC45
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:42:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k2so23261584ejr.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L0+ooTDUWCVf4fTxwoa2iE5Cp8+DUn+KX9+M86VZbeI=;
        b=B501c7ncvCls66K+7a7cmbz7vc3qr0riRN1ZBHiwUfIfcE9GNmI4guswKcdJbSKoge
         Jn4oSn4A/BfeqoGyro25wD/wuA04OT2gapxSvEx0TifR7Wfwt6TSWKuStnosxabplMnE
         f8a8ucSgc+E5EM2tpb9NbOlObvGxY7eWmVZs3CW/etvTKLqkl0LSvMT9QztQhzsH7Sat
         uJQyoTf61aSNlv9K47akELwNRitGtj7Zi+xbJnR6UP/DFaQRbQmzbBAWL17qJdcDiI/Q
         J15yH7F69GqIiQUi55/HpKjceDsfz+ZQCeJKI68KPnUXWTe2fBvxfNapCUprry6D64LP
         3GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0+ooTDUWCVf4fTxwoa2iE5Cp8+DUn+KX9+M86VZbeI=;
        b=BCBW37rwtd8U54RqhV8Ttm32F4r4JSycFrADGR9TWt03WDCoeaU/VAJGwMcc9QHY70
         kZ/rqnK8d7ul9jmUiYLcTocYOSV/9DwfFYAqpWZHdb7lS6ahAAV/5Rjl/EwwvXzgpSv7
         2deSuBgBFC7Ad6Dsr/YMG9dvwsiiv+3wEWU2ptjgwVHCvXuvPx6atWcLurKYxLEbpHZX
         +NOEe+nTNsg+3937CK/HnAMnD1Ft3ZhmENmocLzFkK8s6vYYXOnG5IveUIVDzUZI+AqV
         zh5gzY1guy4sYFrI9jNSaNSL4gxVwmvTIcE+uWGstCytzdDdlv6Vu/m/RsTyMWckhwoL
         vHLA==
X-Gm-Message-State: ACrzQf3nwJgFTbLPfiJTo/KPAjhzl4/+bNodUdel7SQFddA6KJck+Bbh
        vcaeP/RA5izFfk0CXIzmXrQZ2rIbZxTU5nMeeUCWUARiLr8=
X-Google-Smtp-Source: AMsMyM7VRpm6/n9klzXCC6uewapqa1SXg1oG/i3La9N59gDH2LSWlbD9jRko8dhJwq815Kx98FgpKWbYjhsRR3Wd2Vw=
X-Received: by 2002:a17:907:a06b:b0:78d:d25f:b726 with SMTP id
 ia11-20020a170907a06b00b0078dd25fb726mr7809602ejc.203.1665996151064; Mon, 17
 Oct 2022 01:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221005133337.19245-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221005133337.19245-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 10:42:19 +0200
Message-ID: <CACRpkdY3PVWqh6GAf4To6YsEEhz3KBktSuTX-qrXrO72wbMZAQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: actions: make irq_chip immutable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 3:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since recently, the kernel is nagging about mutable irq_chips:
>
>    "not an immutable chip, please consider fixing it!"
>
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

No response from maintainers for 12 days so patch applied
for next, let's see what happens.

Yours,
Linus Walleij
