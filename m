Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E386EA61C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjDUInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjDUImw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:42:52 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF1C902B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:42:47 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-552a6357d02so15934217b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066567; x=1684658567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUq9DdozR50+s0bIzneFBHO+vDWvZZ8xarrXjkdfie8=;
        b=q60qS2knWMIPPYeEAQPryZoGfmvRafE+cukUeHxeOxrV8fZK+cRsn9kEBnP2j8L6V7
         sCS4hC+nj/UxEjgTu1wbM1HgiGZB/wXrmymwW9d+C+Mbhfen/UKFqzoY8PQxfJ9GiM9a
         q4OatBMRJwZ4KiAljmtZ9m6XQZ4TSQhehLcqHEu7ZV4uiXs8f9KylJINQJTJyqdfhvle
         gEOmkw0qXfGwZOtfEvOReg0HazZQ5d9Rs9EjepuptZ0zyx7Lh3VYL/Yvu1n6fTAlWh5a
         vAFbQ/0DBG1AE0lyDQM1fymISF5SeHqx/lgX9ATYa2exg8o1LKbnMxTr2M6imXuLgQIk
         5xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066567; x=1684658567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUq9DdozR50+s0bIzneFBHO+vDWvZZ8xarrXjkdfie8=;
        b=CJ4pDYUU0oDyDeQToZmhkEII1QaWhViJd8n+LJAkJXA6SHIFTQAI5ECjq8hGavcR+T
         hMVuMIUSPx604xdvGPiXUOOuT0kTeinHt4fnPt6w8lLWvp5XAi3aLIfnCj60z7twmb4G
         KWq6QH5wtkm6pMQamknWpxMIiTEvHwatKkHOgpmhgF868K2mHYAD3fXF2wyr1YDY2fB/
         LVqIcWqjw9o8u+rc9UjeqV6KcJe6KjEB0r0G+dYL2gP+YJgQmJjiarRF2OdQqeMsW3f6
         HJiLeRzDGmgXbKC+KsaKHz6rCtrvitxlDqyTEJNtywugUMc4cY6GeqjEck3tIE6UEUoP
         c8Sw==
X-Gm-Message-State: AAQBX9fzMpdLcU1Y7Y4nj+0HdBMfDTmyWdhLtHhQE9qPsSFd4JXnSwlv
        0gM38A9nbG0gRtIuXnkUCmHwDuT9I0wj0KtJKSlnVQ==
X-Google-Smtp-Source: AKy350YmTigjCqxhZkDAGpzerjdcdATqE+ADmqBh+6UhRaIk/5PrHU2bagAlHyJOYhGEyC507M2UPcumZq5K6LpXxZM=
X-Received: by 2002:a81:838b:0:b0:54f:df51:7422 with SMTP id
 t133-20020a81838b000000b0054fdf517422mr1144857ywf.34.1682066566900; Fri, 21
 Apr 2023 01:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230415231130.115094-1-mail@mariushoch.de> <20230415231130.115094-4-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-4-mail@mariushoch.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:42:35 +0200
Message-ID: <CACRpkdbFagmmO4Ood2AY7oZ2_vBwJuL5W9RhMMjCdetcjpbCjg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] iio: st_sensors: Add lsm303d support to the
 LSM9DS0 IMU driver
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

> The lsm303d is basically the lsm9ds0 without the gyroscope
> (which the LSM9DS0 IMU driver doesn't handle), as far as I
> can tell.
>
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
