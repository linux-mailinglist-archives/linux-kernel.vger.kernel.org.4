Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B4C6B9DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCNSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCNSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:01:22 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFBAA9082
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:01:18 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54195ef155aso141457677b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678816877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhpChpDnYzRgDCLfFYmayugPU/QEuab/jcblVRZdX+0=;
        b=WE4h/xj/p5Qib8Xi6XVgVWVqL/xki8CU1n3C9MkBvJg8zNzusRdBAhv1G9mmbir+Y9
         sC65KA1Ny916sF3agVzXmyCWpz4oiRDz7bfAvZDR8oXrt1q/Gt0JU0YNEOW3ZEI+RgkY
         b2oscXng2uSLlYKAm6LykvUiFJd/X5dfk12lP5YUG8xExAjfzXLu8USoGLAZEe9Y2ffQ
         oKq6di6Qq465LFO4seCDCJTfaHGj6Tn2c8vYfKiDQSMUL3JFOmFhALKTRDFlugUNSOEX
         daFouMOnCeayCnJy2dRyhLJZvW3bHBWwMmC9tew5hN+H0hGisPefZnm62OXD0lcql5jh
         tkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhpChpDnYzRgDCLfFYmayugPU/QEuab/jcblVRZdX+0=;
        b=hkvcqDfUzCQUFgH6K2PeGQp2EXifPli3hrs/N0yj9O05uowRcROtXm7w8WMadbjHO5
         6uc/D6jQpRt5CmnBEnxuQVO4VMBaFguznK7233dzL1JlHO8HH4wYWlkGwjM5hULx3EBh
         HZxW3eG0cS1bIF6NUlegin+EB0o6iPQL1o1mUMJD4DUFCTZs/uzuCWKH3txbjO5MCwHW
         xnUEC1qQUWW4LOZypLcfNL3JI4Uu9xATr/eD/GGFpL62OhCOoOY2abkXe89ZGtIt5o+l
         BgF1g5OWw0YQSbmuSsqdGirqL9pTUg+IGIOmEmmdfVrbp/xgxa4RzaSW6YajL5V0Y17A
         a/Ug==
X-Gm-Message-State: AO0yUKWd+HZO2X3oaJNzF7LBiabrc7BPxRqCBf4tkulbGCzWtG7Tbjbp
        /gDlDXG4+ii2gd2Kyl4zcorMd6BQATViVck/Hcde4XvoZpcRQp1O
X-Google-Smtp-Source: AK7set9irUAqYRGoxKyt7y0ItQw/wqe0vFICY9m0xDO0dSynNWsPS2tydx/N5F4beW7gyWZDvl6dZEX8Z1DURPa6U2Y=
X-Received: by 2002:a81:4005:0:b0:532:e887:2c23 with SMTP id
 l5-20020a814005000000b00532e8872c23mr26717340ywn.9.1678816877438; Tue, 14 Mar
 2023 11:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230314154117.477138-1-robh@kernel.org>
In-Reply-To: <20230314154117.477138-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Mar 2023 19:01:06 +0100
Message-ID: <CACRpkdaKxO8Nq1nqSh35imRY3HAHvh=TYgua_irj_TVRHZWNNg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Use of_property_read_bool() for boolean properties
To:     Rob Herring <robh@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 4:41=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
