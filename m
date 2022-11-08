Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9281A6211E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiKHNDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiKHNDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:03:18 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8278E5800C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:03:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i21so22332292edj.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 05:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o3T20fdGbELUpw/30bYXW9rk8UUViyvlGwNQtDEeL60=;
        b=HftOwyrtLxzbkKxUC8HfvovTHmxETKauLq+2NZsmwAsaMGT6OQPWRuF5ff1cijRifO
         wITQzfD0MbU45cAGywh7YwS+ps2iau6ZaG2lIqsWGKvD3SY8gBLFkxkCsjFGyd3gmUyQ
         dAATAj4FpkOIkWA4ePVCwkeo3E5jCQeNXyYqkCGU+vsAHVsiH5LoKSmHjAnfAJK+Z7Gt
         d9x2V1epibgaTLN6SV3Jgw3jfliBg0IRYRMgaLmq5Fq0DSXAR+054B+BoCIpg0IyodZ5
         YjoPZmxUjN/VAVz4bhpOBNOXAyX/bC8b4TuCXCqOYiqJkroZnJk7zVEbVD58dvpx0Rc1
         m7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3T20fdGbELUpw/30bYXW9rk8UUViyvlGwNQtDEeL60=;
        b=SXgthpicnVohKzivpvePfwbGj7sxBpanJSMhTXUBbM44uI/p5R913NNJFbBjW2d8hy
         1sg8AP5JCUECyb8py70iUjByopuElmtXV7biUAZRIsJNxBNko07b2uegoT6OMMBu64J0
         Xp0DNtahlQuFDlXR1nnQlfMUz/mRNsj4eG4X+ZEgzoFJjcDKPssMux5Xhll/UEH4FLyJ
         HM17EsdMRIuo8VasiYn9vi0MfdNQT1NhXA1OWeA/hem2cBALLm07R3eqCjy4qfNcBowS
         QDPbPfBw1+RP8ligSIu21kzBeAH0p7Uelm0LXYk666RUMJIzV1ECNamIA2tJMD2QS2xu
         ryqg==
X-Gm-Message-State: ACrzQf1WkNEVkzEZrw4rCUZTlzDv2v8NQ7ST2Q3lI1ToDTwjIfT9RSyP
        8TvKGpggGibX1g3hZOck8ludVOtSYWTy2v2GcmOpng==
X-Google-Smtp-Source: AMsMyM76jkge9pSTavwCFjj3qtMVFFWyyr0y/FOcVzLJN3+Hurvyb53krF/r4r33HtFj9uBHLuQAPOvLjzn3W9ENCGY=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr55757302edb.46.1667912581984; Tue, 08
 Nov 2022 05:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20221108092840.14945-1-JJLIU0@nuvoton.com> <20221108092840.14945-2-JJLIU0@nuvoton.com>
In-Reply-To: <20221108092840.14945-2-JJLIU0@nuvoton.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 14:02:50 +0100
Message-ID: <CACRpkdb5NzUcnu6yK6t9CUPVb=FSpSJdWOwHVbJqq5FxapT_RA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpio:gpio-npcm-sgpio: Add Nuvoton sgpio driver
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim!

thanks for your patch!

On Tue, Nov 8, 2022 at 10:29 AM Jim Liu <jim.t90615@gmail.com> wrote:

> Add Nuvoton BMC sgpio driver support.
>
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
> Changes for v2:
>    - add prefix
>    - write the enum values in all capitals
>    - remove _init in npcm_sgpio_probe

Overall this looks very good.

But:

> +       u8 nin_sgpio;
> +       u8 nout_sgpio;

These seem to be software constructs, for which you also add
custom device tree bindings.

The purpose seems to be an extra layer of protection, such as
blocking a user from setting some GPIOs as input or output.

I think you should just remove this, the GPIO driver is already
sufficiently low level without the need of protecting the users
from themselves.

Yours,
Linus Walleij
