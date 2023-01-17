Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C966DDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbjAQMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbjAQMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:41:27 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917BCC29
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:41:26 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 203so33792364yby.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y9QIA/V4bDEUjUAAW2PtICLFUIpbS63vkePZ0oEaXn8=;
        b=K7XcUQWcKUigIQjH9Ab45aOqevURxKQDrIN2QU24OfimqO/fVOL0vQuTrxBxWV7EWF
         xuJF2AJQwoZY6WNP6kY7xDfb7xkQEUpxDsTlFrspfdm3ibrNgQjg1FpmfbGCvcS5DreS
         /jNwebNRKiQRrwroLebcDupVO/6ISptUed88hAk6Lz13+WRuBnZDMEyiPOdengg/23ci
         XWhdgeHwlPtUQIPtQJwXHeODzYXmTY2J/CMhkjiokTE9rr9AOus1iYYQkSm5dv4RppcC
         oFXN3NOdLv58TTWReJ6hQTYlEuYGDXMIFbWWiosjVba1AiYkco5JzJDOOPk3Qs0NxHsZ
         KiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9QIA/V4bDEUjUAAW2PtICLFUIpbS63vkePZ0oEaXn8=;
        b=7xfk8JX4or3TjjusvfhtxKaMTRAjl8TQzpbceqXyk+zr00P4ssEEgagfrwphF9gJg3
         uqAKCxjz7MXHzJj5T8y47HDp1q/5+KDKj+CzKFRhcgvwYdLaraVJgAYT1f7MwDY3LWJP
         I5cIRcNsFTuS7jGeoZrWi/vaqHtWdrZSkyhvtZowPdBoU2Ma/KkEQUvtuKDOh2GOKuxE
         a4E+b4NknijD5viwimPkGM8kytxXlRYOVMqyA0D8bbFPvojLQG4xLqHmLyxbPOQGz5wY
         0pmrRL94YqXxnv+TKRiWCNXZAkSxuGc0fh/NAR25l7Dm85CPBb6ZAIqZe+VNfUefKYJz
         89NQ==
X-Gm-Message-State: AFqh2kp5WNJC2UQj+o3TsaWfth+b7JpntHCHgEhptKCUt+vuH/xeqEx6
        rIucvqtzCm7cKVfq0felTejI24d99eo3yYlrt6Ed3g==
X-Google-Smtp-Source: AMrXdXuioNctbL36fG54j97dRfrv3UWZHItbhW7nihF+esCJNfGA6omk5aTautjJ/aLXzWHvDUz8c0G9VrL/H9KLjQY=
X-Received: by 2002:a25:8746:0:b0:70b:87d5:4a73 with SMTP id
 e6-20020a258746000000b0070b87d54a73mr278970ybn.584.1673959285242; Tue, 17 Jan
 2023 04:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com> <20230116124704.30470-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230116124704.30470-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Jan 2023 13:41:14 +0100
Message-ID: <CACRpkdaAicyx0Pzwc7oP+x=kM7DCKi2YJ_rqPnt2_9jKCfCwvQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: pcf857x: Make use of device properties
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 1:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Add mod_devicetable.h include.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> -       of_property_read_u32(np, "lines-initial-states", &n_latch);
> +       device_property_read_u32(&client->dev, "lines-initial-states", &n_latch);

Haha we even managed to sneak in an official property for this,
I don't know when that happened but very good to have, this
is the first time I see it used actually.

Now I will recommend everyone with this problem to just
follow the PCF857x example.

Yours,
Linus Walleij
