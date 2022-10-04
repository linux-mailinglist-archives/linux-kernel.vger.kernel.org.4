Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C925F3D11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJDHNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJDHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:13:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34C220F6C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:13:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hy2so26856539ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GPCtShCbSyDzwVbcHV+pLByAKo7NFJt5Qsu/XrbzZYU=;
        b=cxXD3Lt8p84hMFLzhG0XxCduK8GhdUzNfP6y1/V9N8hZnprngpah8XjAl9jWe4ioNU
         tRsaiKOKx9X9MR0Ieie+35o2JPcfo+WecI2JpKnogS01JdqbrHslZtujj5J9Z+xAANcw
         G+f+RbX78kZ5srB3oYRlyQ5rSh6Pxv7tE1RXfkQrLnoP+IGnt2Ba0OhhcNDyLoo0ShR0
         kdabFycEHyZ6vtnylEzaKdk/yCb8ZV7qiUbv9xyOhTupyAX4FExlIXReoIozZ71iJ5C3
         mTWt+LrWQF0sQY0S/Jv/jor8KoeBk538wS0sNuYaUoSWhYmmItR9rSmefDywS1OvcgoR
         Vq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GPCtShCbSyDzwVbcHV+pLByAKo7NFJt5Qsu/XrbzZYU=;
        b=ljty/8B9XVUVvQ2lAGAJ2i8REzHFGGgzfrvtgvuoacQKfiBUJONLPbq+Mdnm0IwwPn
         UHBySeJp/wGdTGMZgQBrCjKP2ItV48WKULBsG4CU+doT0ykOpU0XBtCiYkdreem4Se15
         M961iE4kMNW9jXEXi+qLPwO4e1oCMG7mFztMag/jwb9ld7vgaVhoN1QzDn6QtU/+UPyv
         7L9S+zll+dW8CQEbEYjbDVFzD2H1gzraH/mk+tyb/wegrw/PwQbKYG7VbH9q9lBB1sdn
         TRcTKAH4ecAxkKTmY70MeYu2AJKb+Shh9aL7sFffU8yZy+6ioV9NPi/d+p+J/435jtl/
         OuOA==
X-Gm-Message-State: ACrzQf1PPZj5VhdgeALss6jjm2CGrYmEJDT09kuWwngmze7A9MeVM7bZ
        nPuoILFIanidFI/rek/VBkyxeO2cFPa1vGtAyFrRRQ==
X-Google-Smtp-Source: AMsMyM7bJYaqKdEXLdr4K12/gr8Z6r+mws4ryUjSTArXKsX2AbSxB2IWTJSEOGxALJG9xnEKagYz37jDrE/oeM7u0CY=
X-Received: by 2002:a17:907:7b9e:b0:783:10cb:2826 with SMTP id
 ne30-20020a1709077b9e00b0078310cb2826mr18451663ejc.208.1664867610518; Tue, 04
 Oct 2022 00:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220920103108.23074-1-jay.xu@rock-chips.com> <20220920103108.23074-5-jay.xu@rock-chips.com>
In-Reply-To: <20220920103108.23074-5-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 09:13:19 +0200
Message-ID: <CACRpkdb78PCZ0JXmMt29bB9zy8VXsS13rm9atGiOfYLZjpOvHg@mail.gmail.com>
Subject: Re: [PATCH 04/20] pinctrl/rockchip: switch to use device_get_match_data
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     heiko@sntech.de, brgl@bgdev.pl, andriy.shevchenko@linux.intel.com,
        robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:31 PM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> -       match = of_match_node(rockchip_pinctrl_dt_match, node);
> -       ctrl = (struct rockchip_pin_ctrl *)match->data;
> -
> +       ctrl = (struct rockchip_pin_ctrl *)device_get_match_data(dev);

Drop the cast: these pointers are void * and can be assigned to anything.

Yours,
Linus Walleij
