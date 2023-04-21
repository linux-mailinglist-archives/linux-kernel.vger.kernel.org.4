Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42116EA613
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjDUImY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjDUImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:42:22 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B49EED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:41:50 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-555d2b43a23so15390707b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066510; x=1684658510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqPKWSvbX4VNO0qn/jU+y/bKk/xVC6QNeAEqYppXymg=;
        b=Yoy93+lUDhYGIBv3wl8nKbvz6OKs+90gS5OCo6gA6c5LP241BIrunAVF6TOwmJU8bI
         BFhbOdDvlxxM7vZ/MSoCCIjMetktHmYAjTTE+ml4AyHkgny5/F49I5Bwna/KG8N4vawR
         upPH+MzOYEE/xk3vfO1UAZWuWjhkDGaLuVLQUf9LISsAj8EYajGSguZF8u/RYKz/IBcR
         FoHzVaAz+kYyUy8eGQaAhIGATZ8YUpKT6ecedyrwjl6sp+7SLvYhNAkFqRaSoIei/pV6
         JE90o+oWIJndWsis+WaP0XpDKMPU0KDZLPVhZiAQGg90IWW/HFsQzRNPJxxn6zAC1R9o
         VNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066510; x=1684658510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqPKWSvbX4VNO0qn/jU+y/bKk/xVC6QNeAEqYppXymg=;
        b=GWV+M+w3FuYdNqFyge/85zgqGeIVv+3fSJff4uhweqslyaz1ayUbbwKDCgJRfah9hj
         IyiDTV0iDAXWUMz7guK6Xq4Itjbn1NOqOjxPL/nHsZl5v7+0mkpoFu5/kIhlhSpl/U5+
         ZYwbm/SdE9idknuFjCgTiqzff4mnu4t24ajEVTz/7tWFmHsnaCVZ9nmpD2IS+9tZOddl
         x+L2+nuDN3Nl1cHTqDuKwpQ1Z1G+Xclj0t9L17blohCuLTvz5EG/QgUBH6AoH6tok1pU
         cN6IpIOsCUkuF748QUzHDhU7xs/l3tYEWkA2AT2kvXMT+TlpKRkTRL/K+a+QcH1Op5nU
         9pcQ==
X-Gm-Message-State: AAQBX9cNS1E2oESsfgDPePdxumxNhPl7FsdWDjNkbtxB3iCKEfplxb80
        cv0bPjOTaSSU5eqsnkoU8PgyEhGp7Wj9eXM3+ypJRw==
X-Google-Smtp-Source: AKy350apF4ud3JDmiTq6f0qUKsmsjPAkr2kW6mvjGN33FBYp8ECRDVzGjIff6wPMnV3tfgKoHFVbL3Aw36vsD6zcDWE=
X-Received: by 2002:a0d:e64d:0:b0:54f:8b56:bb2 with SMTP id
 p74-20020a0de64d000000b0054f8b560bb2mr1371719ywe.9.1682066509796; Fri, 21 Apr
 2023 01:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230415231130.115094-1-mail@mariushoch.de> <20230415231130.115094-3-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-3-mail@mariushoch.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:41:39 +0200
Message-ID: <CACRpkda-tTBipOnKwouZT-muPbkMTJ2u3x5iSMmGwtwUc8=fTQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: magnetometer: st_accel: Add LSM303D
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
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

On Sun, Apr 16, 2023 at 1:12=E2=80=AFAM Marius Hoch <mail@mariushoch.de> wr=
ote:

> The lsm303d has the same register mapping as the lsm9ds0,
> thus we can just re-use that.
>
> Tested on a Lenovo Yoga Tablet 2 1051-F.
>
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
