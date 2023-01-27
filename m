Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614E867E6EC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjA0Nkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjA0Nkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:40:36 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1B7D2BF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:40:13 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id h5so5976382ybj.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4MVwNaOTh9TVsQvOOmcikG6XSnsMoScG1h8pFfVLJ9c=;
        b=FC2n2ma/s+8vXWF6ffQjT49RZ0PQIYbjAhgd22ON8jlfyo9eonNftBrAEAci/4irCs
         xhH5NeBYYUIJX1xIANt507Goy7fRS+3UqqLcQxcOwp7QzHzwimo3RX3D4ZVLHUbLSqjP
         +7BthlJ6clLQvfi5pajOIVw34pZyedn8EQKh+WluBzecbwPXL6xNacryUMXgj0e9EbFh
         Bf5hGjgxCmOLyNJ6qUmuoMOX9DGH4aKNnDvtmOgyGHzAqKseZbwDJhPCdrl7xTJ9o88V
         qp2zwUf6X1cKFNR1ONY5VcmQzR+yaSpz3kZA6SuGCbwhYK/KXuv3UWvzcCfMLEKH7H6n
         ggwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MVwNaOTh9TVsQvOOmcikG6XSnsMoScG1h8pFfVLJ9c=;
        b=REVyMt+fTg896bHoVuQGAidzitKJhRHbAfBsF256t6vMiuQHqge+pousMsTiYCvGor
         aAv8SmTcVvbSQWM1pg2q11H+fhQO0sgaGq8CoVLLxpV5sARZ/HEeEsJhRdv1caWWnnI0
         SPK5V8CFIMHol6MxijpVhGJUJ/NDpfoAqh9mR/pmCGHmXH592c1giyqQlys0bwSy5tRy
         NbK6RFYx4NwDyB2pssBHxAat6qsnUTIC35QUl1SvJYNiBNDdyM8WsDz+7vM5s8tDEf6k
         kD7Rj8lejOxMMVZwdVRNAKQSZqTmFc7wHWWl4yAePIKA1Bp85RjZY5+sGt/+p64vocu+
         IVFQ==
X-Gm-Message-State: AFqh2kppXQQA8gek3gtVEc7BDBW7BCuf1sQYzjylj+pyHMTwyxhqPUVT
        nbIgzx53gPwTNnKFBhiMrTx7sqA68DqXtaO3SFmKfg==
X-Google-Smtp-Source: AMrXdXvIs5OfShN0Qpqyu/Awr0JysGwM5oBnzTY+H+VFO2BYszmdTZxtAX6Jm80v/Dldv+f3xseeEG7R/5rZjLdi6UQ=
X-Received: by 2002:a25:9d88:0:b0:7c0:acd2:6300 with SMTP id
 v8-20020a259d88000000b007c0acd26300mr3769907ybp.520.1674826807208; Fri, 27
 Jan 2023 05:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20230127101149.3475929-1-arnd@kernel.org> <20230127101149.3475929-8-arnd@kernel.org>
In-Reply-To: <20230127101149.3475929-8-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:39:56 +0100
Message-ID: <CACRpkdZbMbbihUnQDMc-Q_r0n9E5TZYMohe4hUApux1xDU7_9A@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] gpiolib: split of_mm_gpio_chip out of linux/of_gpio.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:12 AM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This is a rarely used feature that has nothing to do with the
> client-side of_gpio.h.
>
> Split it out with a separate header file and Kconfig option
> so it can be removed on its own timeline aside from removing
> the of_gpio consumer interfaces.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
