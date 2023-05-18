Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A49707E55
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjERKoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjERKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:44:50 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FB510D8;
        Thu, 18 May 2023 03:44:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7577f03e131so104049585a.0;
        Thu, 18 May 2023 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684406688; x=1686998688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad4zvcNwIJ/Y2lxdLHrr7ZSM1z29dpOAu+LMx49JNDM=;
        b=b2AhZYR6zvngv+IqdmflIhp7f0NhcvZ57umiQCrcz4uNi0gPFRZMtWK0up3K7NFSQK
         EWHcOA8hX9fy4FYGI1MKal2UOgWbQtST7fCojtrKxgogfIhn5bhaG3uwIFLoKkzpQoeK
         7nhnDs5GTO+FXw2RsSS7LuAu30LD3cmNF5zF8PXCs1QqOOm+uNUU4zGazcWBmDRUwQgL
         XQx8XzOjLu4VZDNmmERxzWgwjD8B+C1tBl5/x6xMCdVGIYktmO+RBYD3Kr0SIJ0Y3V2D
         jJyPo9s914C8b0WhzVm/bQ/W2raTWabMozoKzJQoc8H19feMM8uGA34lJVqg9X8RTBtv
         keDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684406688; x=1686998688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad4zvcNwIJ/Y2lxdLHrr7ZSM1z29dpOAu+LMx49JNDM=;
        b=j23IQzxt8kho69gQ4VWUIHGlWA8H2iOnQ20UrwW474Kg57zItvlCPJ2I2VWixRQM4e
         EP0coQ+SLflkGeQfBp8p9K6C6YW8iS1eoLA2SQ5pbDBvCArKM184O7qVnoazhB/GVPfh
         4a+EoGf4VoCe9WAoHfuHCl0Wn8XLUN6D3dzySk3r2fnCG8wRsxRvogYyNLT/zT4mBVWH
         sC3lo3AbwGvc4EubsdoWgzKA+ZDDp6F2sN81WgAUxPCJwaxcTYoNzn3lBQ2pvIiJvPqA
         v3OrF33gAS4GOGuooU13hjDDPBJdMkwd7RLvssBBoOddY07VMXwec6NqJqbwb7MWleR9
         MpIQ==
X-Gm-Message-State: AC+VfDx4jdRXV2tSkOX/5vq6/nd3KjWZkWXfyUlPukHeLKA0TQT9ToPz
        Ol4wK3SP525lhkVnLR4ScSKi3Zeov2Ji5PW5yUg=
X-Google-Smtp-Source: ACHHUZ4+auQIwwa/9xwdgQ6Fbzy71Bs2iS5UXlf38NxRYJCVolmxDRAUQbSyH+vxtPVwcz139sCAXC7Nz1vknB0W+TE=
X-Received: by 2002:a05:6214:1bcb:b0:5e0:7ecb:8ffb with SMTP id
 m11-20020a0562141bcb00b005e07ecb8ffbmr4587748qvc.8.1684406688384; Thu, 18 May
 2023 03:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230517195238.34069-1-mmkurbanov@sberdevices.ru> <20230517195238.34069-3-mmkurbanov@sberdevices.ru>
In-Reply-To: <20230517195238.34069-3-mmkurbanov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 May 2023 13:44:11 +0300
Message-ID: <CAHp75VdEc9x=v-NU4wqrg-S0vEjqc27JPqZAK0TJsNUc37ZTmg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] leds: add aw20xx driver
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@sberdevices.ru
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

On Wed, May 17, 2023 at 10:52=E2=80=AFPM Martin Kurbanov
<mmkurbanov@sberdevices.ru> wrote:
>
> This commit adds support for AWINIC AW20036/AW20054/AW20072 LED driver.
> This driver supports following AW200XX features:
>   - Individual 64-level DIM currents

With or without below
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

> +static int aw200xx_probe_dt(struct device *dev, struct aw200xx *chip)

_dt is not fully correct suffix, it's now firmware properties, so perhaps _=
fw?

...

I would do

  i =3D 0;

here and drop the assignment in the definition block to be more robust
against sudden reuse of i in between.

> +       device_for_each_child_node(dev, child) {

> +               i++;
> +       }

--=20
With Best Regards,
Andy Shevchenko
