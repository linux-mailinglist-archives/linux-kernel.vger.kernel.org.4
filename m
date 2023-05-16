Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78767056C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjEPTIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPTIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:08:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A518E7A;
        Tue, 16 May 2023 12:08:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96aadfb19d7so988358566b.2;
        Tue, 16 May 2023 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684264118; x=1686856118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WtzMLu63pIrTGFp+PcKVzZjdLbw2sc1wB016+LNuaU=;
        b=UTDLK4JBXJdCSsteU249UG5b0kr62BoJEtt/hUKzhj09Rr78qyUa3slTquGZhGkZfM
         RV3BAbyoQTatQUS66ycgD0Vgk/MwBEo/LrszGnPA9OWAD9FNg6v/JQa8WB1fssf6MB18
         q1xJj4lraxXhLckehH06aljsrrPcycuHHoJTYu4gWc3t/pmegbfL2HpkvcnQClUNfO3m
         ixnRtgW8ffIddpC9fdnetEZyCUk9yhhv7tPI5TCVK7/rEFglF9IfoQ3K0n5ekMpl29qC
         r+KM2Dd4DuhPXWoHd4Ee3jO9SEfR6JF5FxTgLQx/pXso3EqL6ZYuRzWdvZelCYeL4oDa
         Ge0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684264118; x=1686856118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WtzMLu63pIrTGFp+PcKVzZjdLbw2sc1wB016+LNuaU=;
        b=eDeeQj9BQsYmb4e5v5Xbq6UE8a2aNJOsx3nC47aG1S0P29DuMu9yViZYRKdjqbFft2
         Nck1DRx4S05hcfmY7zLM1G3n5gIyb9IoSgmVKDMwFRbgWCeWbnZJYMeQ+86NFRzevSjI
         adL8ie3VjFtxV+qzHPaIizUrAnQCubxq9Jvz7uOcEJ7ztZ28j6poFeMcCPIVZj3B1hPT
         m+Si0k8jgzLPxqhw2jz4alTsc5FKkzNNNStJ9KEzIaIYRgp2bsbfOmpUQLnB8d9/cZRK
         NLzH5AZW1Z55HJVe8qGKJ0C9cr55p0fjuZGvu8hLtjJ+rwwt1xocg4MYgJNrCDveqgg0
         3bEw==
X-Gm-Message-State: AC+VfDy+pok/jkDU3FSsjBISsYTGB4EoKBma6rdW0asF+dHQI3OC3OEM
        snk3aSNejg+/dUcHSjoO3pvDz+nu6QiC2URThi+2ecGE
X-Google-Smtp-Source: ACHHUZ4eC8eESbfjQaOZgv2ujRD9L5D7PpQo/8swdsxdY5pdDtBYJDm7UhynpXSDjE2x5IatL1oZ+1rsKe2dYgWqwRg=
X-Received: by 2002:a17:907:c1e:b0:94f:250b:2536 with SMTP id
 ga30-20020a1709070c1e00b0094f250b2536mr36485052ejc.28.1684264117702; Tue, 16
 May 2023 12:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
In-Reply-To: <20230515210545.2100161-1-gnstark@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 16 May 2023 21:08:26 +0200
Message-ID: <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        andy.shevchenko@gmail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

thank you for this patch!

On Mon, May 15, 2023 at 11:06=E2=80=AFPM George Stark <gnstark@sberdevices.=
ru> wrote:
>
> From: George Stark <GNStark@sberdevices.ru>
>
> According to datasheets of supported meson SOCs
> length of ADC_CLK_DIV field is 6 bits long
I have a question about this sentence which doesn't affect this patch
- it's only about managing expectations:
Which SoC are you referring to?
This divider is only relevant on older SoCs that predate GXBB (S905).
To my knowledge all SoCs from GXBB onwards place the divider in the
main or AO clock controller, so this bitmask is irrelevant there.

> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Aml=
ogic Meson SoCs")
> Signed-off-by: George Stark <GNStark@sberdevices.ru>
Since my question above doesn't affect this patch:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
