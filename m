Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8681D6B386B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCJIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCJIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:20:24 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E026CFB263
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:20:21 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e194so4499190ybf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678436421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8wdUyw8fSfdXMH6H2GMHNYbsZPQ+dxQcBkQUk9D5Ek=;
        b=HZcuImlQSmXT5Cdn5HrO47r/VsfKdbDlfjmL10YBCB7i7UVb8Ev8WlhL/XEsWToAnD
         5QHltDSMMzJ0hChY7HFHi/Vn7Me3NGwOA/fhtY0qGArU9DnIBc1AOFQHyiyL5WlPz7il
         LeaxeDPq/rKMcOMBBHAprGezzUFUKBpHlv8vpUhsB37pZuXjf5pvQGZ1qR9FZ5Wv40AT
         Q4B5Giob+jMWqTLFdEJfs4Ix0GFxbxEeuATVVRyd//IN5Fkh6SLYGfrX96zW9WzjigYy
         gQ4z/cQThmJGJl/2gKg1ACG24VUlvKm0iodfummCknZY1XsNUCzJB9RuquTP7779ioNb
         7giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8wdUyw8fSfdXMH6H2GMHNYbsZPQ+dxQcBkQUk9D5Ek=;
        b=zmXk7XAjlWCiNgHhnEqVaPC9dLmGdvjdALYx9Ky6chqL4ubo9jImQVeLcH0d1k4Qwe
         7BiOiQ1wcH8bF2kB/gmhACCJbl51pFh2NVi8++Y53rnwY65+IWKdDKoJ5VqIIIYhaTBD
         y6m75wn5gkToILL/9BiZJmh6gOFADKrv/yA9gjK3vkm0j/D3aAnviRGgJ3mNiMcb+Tcx
         OAOH12CbrBcZuXduERBQVk6fuK5OAC7XoQJ2Eaw6LTdu7xhDgpHxDkeZHh00iEBp8WQU
         HgFreh2vL1XPmxbmGvwPTHqkVhgcGwZo4uc5htihIahOSK0hUMjeFjxyGhXbWxCE33zn
         M/9g==
X-Gm-Message-State: AO0yUKVprys06ZzL1p9kPNhC+gKE5vQUzXkIZ1NneLOA7Ve2tXDzq3Od
        WOjRxBirRd5IUTBkf2FoEipMvciZshn3Udc6ioAUDmEuPSlnSr/Y
X-Google-Smtp-Source: AK7set/0N51ntUl3KWUbhDYFC1LUpkaIO+frJ4fj1Qq0dFt6gT6gmmsqP80OoatIMWx7l7YY3lzUI3fQXppBpYF3nV0=
X-Received: by 2002:a25:8b8f:0:b0:906:307b:1449 with SMTP id
 j15-20020a258b8f000000b00906307b1449mr15092072ybl.5.1678436421105; Fri, 10
 Mar 2023 00:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-3-sre@kernel.org>
In-Reply-To: <20230309225041.477440-3-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:20:09 +0100
Message-ID: <CACRpkdZofL-cuYcyNAwMAshoQAr3z7-boJoHftVnjt80YQmAOQ@mail.gmail.com>
Subject: Re: [PATCHv1 02/11] power: supply: core: auto-exposure of
 simple-battery data
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

thanks for your patch!

On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:

> +       /*
> +        * Set if constant battery information from firmware should be
> +        * exposed automatically. No driver specific code is required
> +        * in that case. If the driver also handles a property provided
> +        * by constant firmware data, the driver's handler is preferred.
> +        */
> +       bool expose_battery_info;

Playing it safe with opt-in I see! But I would probably invert it and add
a hide_battery_info for those that don't wanna expose it. It seems
pretty useful to just expose this in general.

However I have no insight in what happens on laptops etc for this
so I guess you have your reasons, either way:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +extern bool power_supply_battery_info_has_prop(struct power_supply_batte=
ry_info *info,
> +                                              enum power_supply_property=
 psp);
> +extern int power_supply_battery_info_get_prop(struct power_supply_batter=
y_info *info,
> +                                             enum power_supply_property =
psp,
> +                                             union power_supply_propval =
*val);

I think the build robots complain because you need to add some stubs
for the not enabled case.

Yours,
Linus Walleij
