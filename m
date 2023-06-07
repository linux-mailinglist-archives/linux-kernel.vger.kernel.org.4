Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C628F72734E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjFGXuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFGXuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:50:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1127211C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:50:06 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33d0b7114a9so10474105ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181805; x=1688773805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh1qTh2owhTw6iheqxXCV3Jh42E0lrVswaTb+2hzc4w=;
        b=oGua17VAzq6o1oBx0+hqcX48AmEfEBiMUNAg2PKlwD/jwK68OmonL2fpyYhMo3H0cH
         mgbSZsUJZcknP5y+T3NNF3aJ11SOZLZMTV9EhtXsBYcKf1djd5iPvBAkYNBS9XlWnqA5
         muX2eTZI5hMLO+Dq0ltEB8foUE3ltkVzruWZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181805; x=1688773805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh1qTh2owhTw6iheqxXCV3Jh42E0lrVswaTb+2hzc4w=;
        b=X4hG5ZBTOpZMvOceQM1/BnldvyzGf7WVOtGdZbha4+FTeeNY141mQapMuTw2hFiPZF
         nkcdy6QPZk0S2HXBKACDbyAhuUd67pZP+4czgFO7ZhwfBX/hk50gZyWlvA3H8I51p35P
         Xgghm/oQZIHXQigpy0YpfDuHJYqUNC0PjqWERFavf/CD6UTL+7IUZKi126BzWIAu71gC
         ZXkirCEIu/VS61bBZjpX4/0AM+F7gLTNE/mXV+jhw5VVNajcTLSNqQTo/g72BkADVMf8
         oSZdxDu5QnGLmjiQjs9O1mA/7kmoKKlZPH0rzcYdRRDxw8EtKcNl0as8v5nSyLMJe9IX
         YdCA==
X-Gm-Message-State: AC+VfDzoLXQpjFTOVAhEwtoUPGdk/im7U+aDMJJJelX82i6csw3nlD1k
        1a4D5+O4VRGMhNZKgoB9rpA+oCGmZfOwu0cOOLA=
X-Google-Smtp-Source: ACHHUZ5TxFbbZt/c1mC7qz+St39pEkJ6kPehH9SvBd6ZMdWy/dYoDOpqvha2cNtHqAwL5aM8sTNlgA==
X-Received: by 2002:a92:cc43:0:b0:33b:ef57:65b1 with SMTP id t3-20020a92cc43000000b0033bef5765b1mr10121224ilq.19.1686181805267;
        Wed, 07 Jun 2023 16:50:05 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id t7-20020a92c907000000b0032ab5a86443sm35719ilp.74.2023.06.07.16.50.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:50:02 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-775ebe161c5so360090339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:50:02 -0700 (PDT)
X-Received: by 2002:a5e:8c15:0:b0:763:5a8f:fe6 with SMTP id
 n21-20020a5e8c15000000b007635a8f0fe6mr9992800ioj.21.1686181802445; Wed, 07
 Jun 2023 16:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230607133458.4075667-1-yangcong5@huaqin.corp-partner.google.com>
 <20230607133458.4075667-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230607133458.4075667-3-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:49:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uy=UNKDEhqeguhVGn_aTPk5+MppsXChpNOinVc4HJjYg@mail.gmail.com>
Message-ID: <CAD=FV=Uy=UNKDEhqeguhVGn_aTPk5+MppsXChpNOinVc4HJjYg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] HID: i2c-hid: elan: Add ili9882t timing
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 6:35=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The ili9882t is a TDDI IC (Touch with Display Driver). The
> datasheet specifies there should be 60ms between touch SDA
> sleep and panel RESX. Doug's series[1] allows panels and
> touchscreens to power on/off together, so we can add the 65 ms
> delay in i2c_hid_core_suspend before panel_unprepare.
>
> [1]: https: //lore.kernel.org/all/20230523193017.4109557-1-dianders@chrom=
ium.org/

FWIW: I posted v2 today:

https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.org


> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/=
i2c-hid-of-elan.c
> index 76ddc8be1cbb..411d7ea2725d 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> @@ -18,7 +18,8 @@
>  #include "i2c-hid.h"
>
>  struct elan_i2c_hid_chip_data {
> -       unsigned int post_gpio_reset_delay_ms;
> +       unsigned int post_gpio_reset_on_delay_ms;
> +       unsigned int post_gpio_reset_off_delay_ms;
>         unsigned int post_power_delay_ms;
>         u16 hid_descriptor_address;
>  };

I would prefer it if you would add something to the
"elan_i2c_hid_chip_data" indicating the name of the main supply. Set
it to "vcc33" for the elan touchscreen and the NULL for your new one.

It's probably worth adding a comment next to where you set it to NULL
that this touchscreen is tightly integrated with the panel and assumes
that the relevant power rails (other than the IO rail) have already
been turned on by the panel driver because we're a panel follower.
Otherwise someone is going to be super confused about how this could
work.
