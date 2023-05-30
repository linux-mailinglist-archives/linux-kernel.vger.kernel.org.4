Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE7715D56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjE3LhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjE3LhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:37:09 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0FEC5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:37:06 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565a022ef06so60846597b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685446626; x=1688038626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fipiLZLGfX4/1UxxNAJShfinAkElOTmQ9bvtKEuEuxw=;
        b=uOh+52nn4q+fLREJIUy7KO06MoLfqAQkv8mOsVNFntA6TzWyQ06Y2BThSyMq3wWhLq
         zKHYrBOLNFciPFL+72Uz9eRSV5XrJLjOAksd1RdT5og8gKjik+lQ1KfTUgLYLE60IEmd
         9zp1/8Fm1rhA6YA0IX+CtRsstIZSQZ/cqs3pJJGExe8gdxKRbaPwo6tuayptQlRdrqBD
         2ZuCw5ZBp4s7fk5ezVtWmyPbe0g2YIQ7jtqxmoH6hZAsHnmK7xYsms6H/1QmRoS9jpVV
         eV/4miN84WNTnl52fa2MISMlbcZfhKyJRkdJM3UV4mSfIVXpPmkV/rNFje09RhGigWJ7
         8+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446626; x=1688038626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fipiLZLGfX4/1UxxNAJShfinAkElOTmQ9bvtKEuEuxw=;
        b=ICh4gF8zpe5T5upFttiBOFe1KjW2NqQJ1L/IzhDhMcj+zSFnmS2hh9qhflgO59P0GQ
         JDAWUodAqoklC9dBQoagcVaOfQveLceObo50jOP4zXqjnfIPDAlDX7jpFdyY1JmOAYIZ
         6WDC8EmzhRbB03nySlXVX/Uc/Zo45IOmAOmLcKRCTG7ueyDk2bY/soNotv3wO7V9I31B
         +OSdNYJHHYwZM0Hm+O+4uYYIoOFyuWrCD6JvqhP7YJhs8mKYUsJS7MQmGZjsvJiJoJqZ
         /KlmnOFLAw62jdhEFFGQoNc5dwivNdGXTtwHH1dZvCIlOvYYnVSpZCsAABTZagdeVmJU
         XitQ==
X-Gm-Message-State: AC+VfDxWlHdjUMBDf/Y9l9qOE/244UDZiWfz+tkz1c9fZI4jGMKx4+1v
        o5AMzstbus2kk4pzhgoiYT6aQYBAXrkFnCXg9AJnFQ==
X-Google-Smtp-Source: ACHHUZ7RV9zV0oEPR8Q7c7k6kqfUUzMEoSzKHD+O0Fj48PMvU5x4Uul6Uh+8k+/1HYAala5Qo0yQtHV5yNCcrwYwjo8=
X-Received: by 2002:a0d:ed04:0:b0:560:befc:6682 with SMTP id
 w4-20020a0ded04000000b00560befc6682mr2020042ywe.42.1685446626022; Tue, 30 May
 2023 04:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com>
 <20230511-tps65219-add-gpio-support-v4-1-b5d6a764d722@baylibre.com>
In-Reply-To: <20230511-tps65219-add-gpio-support-v4-1-b5d6a764d722@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 May 2023 13:36:55 +0200
Message-ID: <CACRpkdZfWF5Bq5id_JyDe2GLc7OojiD7R6g2ZiHswPD3D_UT_w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        khilman@baylibre.com, msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:00=E2=80=AFAM Jerome Neanne <jneanne@baylibre.co=
m> wrote:

> Add support for TPS65219 PMICs GPIO interface.
>
> 3 GPIO pins:
> - GPIO0 only is IO but input mode reserved for MULTI_DEVICE_ENABLE usage
> - GPIO1 and GPIO2 are Output only and referred as GPO1 and GPO2 in spec
>
> GPIO0 is statically configured as input or output prior to Linux boot.
> it is used for MULTI_DEVICE_ENABLE function.
> This setting is statically configured by NVM.
> GPIO0 can't be used as a generic GPIO (specification Table 8-34).
> It's either a GPO when MULTI_DEVICE_EN=3D0 or a GPI when MULTI_DEVICE_EN=
=3D1.
>
> Datasheet describes specific usage for non standard GPIO.
> Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf
>
> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>

I agree with Andy's review comments, so fix these.
Once those are fixed you can add my:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
