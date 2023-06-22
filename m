Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9573A2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjFVOQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjFVOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:16:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43661BC3;
        Thu, 22 Jun 2023 07:16:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51be928b31cso891189a12.2;
        Thu, 22 Jun 2023 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687443380; x=1690035380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbN0CQqVub1z0je9yxvotXH4TJUOIymawWTi90B6Owk=;
        b=gpq/gqqBxmlQ7IGI39U7bwZq6bm3kV/96d+Q9I2mxvKVpRBfe82uiAiszl3mYVoNTi
         iyrsDqeHVTW1FHlDDJson88y2OLq+fr5wyqQkETnwHSzQpudFBuiHNAM/avom8v2Hrn/
         OuardUAwX+6vwv0ksl4slgoiKil/iuaZOces4s0FjTBsngsNAXJKcWCvb0jlfelV8O00
         Q9r9HrTrZnZuCxXPkYgJcBLoQVjuBzudL8PgqcXWG4jmyaMQE08K/8B6vjH0WkKsnUyK
         tga5+qYdXEaXCHAP4zZI/DrC5GAp1f9lruC5z+dwcMIXcXZ3KSgur+txMQXrRVJma22T
         z91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687443380; x=1690035380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbN0CQqVub1z0je9yxvotXH4TJUOIymawWTi90B6Owk=;
        b=LfFiJDp2QFHCU4F0/4ut1XCoMg4XNbXLKgkjaot4DXpKSdFe+o+mncTdqsCcRNLKid
         NNTNR1SovLw0iex/RU0VAA01qZ3+WwSP4J8w5qpzwb5GG3M17F5KqI5aCoNe4pO9ZwLL
         BJBs52i1IAhpR4KA+kVA4PAnMgK9CF0Zk03V/9fK9sjso9Aasff+qbi1OUENNXf4Lb78
         j0qOVBImMJ6VuAPTRomGpsyfCkxNftVqExYTeDgZB9A5DzYdimVt4G+NHtQsDuyR4iob
         P8DDQoPL/XSPn87LG0RNPXwPdZQlU4MuMUGGVaj9oBow4IlxogPHsSovghFnOd27U32e
         le6A==
X-Gm-Message-State: AC+VfDyH2JmYJh3tFlCBsRM1gYlfJG3XzUBwYOpq4OdwEke9Qrt3FHWZ
        4vEnRjcUhsI+fiQ9s2zrDm5gSfb3FGkN8DNSVeCPhyvxdmntwQ==
X-Google-Smtp-Source: ACHHUZ6siwF4mo65UmQ8qmRm5hsQ+CtKqayomLJhLgAFZEGheuJ8AKc6qPjFxDY16DnQjQO+qQfQ1tjblxHzgtNTdMU=
X-Received: by 2002:a05:6402:498:b0:519:b784:b157 with SMTP id
 k24-20020a056402049800b00519b784b157mr11420001edv.12.1687443379965; Thu, 22
 Jun 2023 07:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230621213115.113266-1-nick.hawkins@hpe.com> <20230621213115.113266-2-nick.hawkins@hpe.com>
In-Reply-To: <20230621213115.113266-2-nick.hawkins@hpe.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Jun 2023 17:15:43 +0300
Message-ID: <CAHp75VdJjeMwHt31tKeiVLbS36aGmhDgGowT951UVwkxr2_VXQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] gpio: gxp: Add HPE GXP GPIO
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jdelvare@suse.com, linux@roeck-us.net, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
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

On Thu, Jun 22, 2023 at 12:35=E2=80=AFAM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> The GXP SoC supports GPIO on multiple interfaces. The interfaces are
> CPLD and Host. The GPIOs is a combination of both physical and virtual

GPIOs are

> I/O across the interfaces. The gpio-gxp driver specifically covers the
> CSM(physical), FN2(virtual), and VUHC(virtual) which are the host. The

"...are the host"?! hosts?

> driver supports interrupts from the host.

I will have some comments against the code, but I will try to review
it probably later on (next week or so). Taking into account the
approaching release date, I think we have a couple more months for
polishing this series.

--
With Best Regards,
Andy Shevchenko
