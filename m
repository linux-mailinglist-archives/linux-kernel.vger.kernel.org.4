Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D247F73D423
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjFYUhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYUhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:37:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD4EEB;
        Sun, 25 Jun 2023 13:37:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-988a076a7d3so398845866b.3;
        Sun, 25 Jun 2023 13:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687725431; x=1690317431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPEEXOayrC5kIElDx6mVXihAHFqvW3pl2AK2GXH8Dz4=;
        b=XFkr/2ryDfP/kOgJUJjAhpDf4wBta7e01Hc9IRRavETIlHFtcyFKkMKrICgZxWSTCg
         wAJ2PSu99A6Q9qlsMumwpHvQoztVdQD79miZAi6j8jM1e+z/70OaWA5Xz5UFiRk+iUwX
         rfIgJ5vhUwMQdh14EjzPY9VsZuLuR3/inz1yJslvQeiu7krwFytZo6fcYgrmy3IxTgcs
         d3kMxXQfamVYcOx3WEcDB+Ft56pud1zDysYg//p5uNmt2X7eXssmvDlnoSrl9YyA5ygH
         9o60y8C93iJOQ0E3VX7N5dKB7h93dvR2cFWwf4rVDWka2R1tfaIZrGlwx46+fUZa549F
         r8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687725431; x=1690317431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPEEXOayrC5kIElDx6mVXihAHFqvW3pl2AK2GXH8Dz4=;
        b=H275/g4UA9H/YVqXopzKMTDomUkvkFnl7rlXrDFkuKe2nQ1aPE8uU5WR9fQBHgY0Xg
         NZTudh7d/eQt6NI1jsGcwtgelXlN7Cocs5ZjrUcKUkzlvV3QhD/boUrJlcqD5c97LmOA
         03sVbrdFuHVpvYZcsnfNIqG3uvchI1WQO1sl+Gy3QJrBlV4Jbs/vlXinn7MqjCX1mCGO
         dT+FzDpSzgmJAH9CGMdWAbM2uR71KWsK6bzeJjENyfct4zJhS35PLXmQnMfcZFXhMGej
         whtcpEVc7STPx22x8boxlFVVd7Sbq+bra0lVKJTnb8KJ4sFlFBdMip9r5xGUOoHcbPip
         OxUQ==
X-Gm-Message-State: AC+VfDypH1Q9rqdBbyw0dWBOLwKQ07SF7xGi3bKQ6+GdbVpyF3NfcD5I
        vI1ypf9c+H2ruJhLj1zx8wAMP7V5ImZmYUJXIaNKvEjp
X-Google-Smtp-Source: ACHHUZ4JXpMZ9XyyEpdax0IaCH+S8eNV76nhvfHU4BK6OWDEYqE7Bi4HV7SBpmZkWKitYD5YU3xkHDKGs5bBac1p3H8=
X-Received: by 2002:a17:907:a0c:b0:978:8e8c:1bcb with SMTP id
 bb12-20020a1709070a0c00b009788e8c1bcbmr25059662ejc.43.1687725431246; Sun, 25
 Jun 2023 13:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230623022334.791026-1-gnstark@sberdevices.ru>
 <20230623022334.791026-7-gnstark@sberdevices.ru> <CAFBinCBv993Xv_wk9fE-U0Tw2mzTB1z22Tj6x8Uy1rRw_dztng@mail.gmail.com>
 <67d2a9b7-ac7b-57f7-d053-cff4bf0f9d2e@sberdevices.ru>
In-Reply-To: <67d2a9b7-ac7b-57f7-d053-cff4bf0f9d2e@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Jun 2023 22:37:00 +0200
Message-ID: <CAFBinCCzx2e92S-cQp2CVup4hr6Ge12uCJ3Qh0+sqNVFRWkv7A@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] meson saradc: support reading from channel7 mux inputs
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Fri, Jun 23, 2023 at 6:38=E2=80=AFPM George Stark <gnstark@sberdevices.r=
u> wrote:
[...]
> So I think to return to double definition of meson_sar_adc_iio_channels a=
nd keep the driver backwards compatible.
Ack!

> I've just realized another moment with channels defined after MESON_SAR_A=
DC_TEMP_CHAN in channel array.
Good catch

> In dts by default channels are referenced by channel array index not even=
 by channel number.
> So channel e.g MUX_0_VSS will have the same number (due to enum patch) bu=
t different index on meson8 and gxbb.
> As alternative we can implement fwnode_xlate method in meson adc driver a=
nd use channel numbers in dts (probably not in the current patchset)
That is actually an interesting third approach. But as you said: let's
start simple and add the tables back for now.


Best regards,
Martin
