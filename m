Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522266CD4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjC2Inc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjC2In2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:43:28 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3924740C8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:43:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i6so18387555ybu.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680079402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QFNGRe/qYkwzP+fiwIAdq/5V8K+RvjLHPqES/KYnQs=;
        b=UDmPhRlclATqTR3oU+JfMUKUNxBedWAoB8uH9wvtpOHcmS2thP3SeN9cTKn0VrfinC
         BS8aWMdByHK3ANvXGd2TbQlSY1RSbYs8C4qXS5siAu6yyRHCHAHFcIIq23MGbsCzKcoi
         mT3iQwRdCgYU8h9r9wbqAJB1xUG/cmFX1q6mNsztoypuLTBFRdUXszJXIETSUJ7o8jh+
         JbIBIU8BB+JH8Q/rSyf7YQLbzxN0dewYTF1QmUHP/Iq7dMk+z3hjTJg6X4V4swm21brD
         TSS58kMWeOue+lWNwqObAuSLfi/E1O5iQ8+/PZlpRaid+inys7UHTnBh+nbTOmTkssH/
         lgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QFNGRe/qYkwzP+fiwIAdq/5V8K+RvjLHPqES/KYnQs=;
        b=gA/Y0BnU+2GMCKf6h50m1w4mrr62MDUqAbrhTcrswaUC9SY7rA+B4yTjWMd1PLZoAI
         0G42noz8M6tc1oHNYWw2f386mqEkDzgrZyktuXJpW3v9JhpxCnCSJ0x9sLHEGxeXgbzl
         b6ZULwVM8sZo1Rwjt9MGeUAepdRLNNzvoiJy+FLAhJGjoe2McN6c85S+RRO/F85UbLFQ
         QPA4RU5ZOlBUbyd5GnIGI+ZuXaUN5P4kvZw8sZtVKq8iX3Ezdn4uZ0WLDzWIkEY7lQfP
         5ItujiVW9cHu+1PLCRhyykv82t2qtyi3T4n4g61iqQrWaepAaLzhfZU0PeIV7pnMNZOO
         XPyQ==
X-Gm-Message-State: AAQBX9c80H3H0c1nfVXpl4HKt12t103vR0vWrjoovPFM7iuwehR04KCt
        dD3Cq48zgVr/JE5UyA32DtWCVxfzMTJC13ssVdXvRw==
X-Google-Smtp-Source: AKy350ZHBV4ak74c7b80acYJQ6Xgio8lk0wyiIDmxjNMY7qeC2l8+M1gaHWSfG/aRIjosaM0+ZWTR412sobwXSpNErM=
X-Received: by 2002:a05:6902:1145:b0:b09:6f3d:ea1f with SMTP id
 p5-20020a056902114500b00b096f3dea1fmr11980914ybu.4.1680079402143; Wed, 29 Mar
 2023 01:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230323135205.1160879-1-mweigand@mweigand.net> <20230323135205.1160879-4-mweigand@mweigand.net>
In-Reply-To: <20230323135205.1160879-4-mweigand@mweigand.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Mar 2023 10:43:10 +0200
Message-ID: <CACRpkdYZ1jtTPgQaVU+hPOgNoitQYc2ykbWMjGnJ0rk+s7r=zw@mail.gmail.com>
Subject: Re: [PATCH 3/6] devicetree: input: cypress,tt21000: fix interrupt
 type in dts example
To:     Maximilian Weigand <mweigand@mweigand.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:52=E2=80=AFPM Maximilian Weigand
<mweigand@mweigand.net> wrote:

> Triggering the interrupt of the IRQ_TYPE_LEVEL_LOW type can lead to
> probing issues with the device for the current driver (encountered on
> the Pine64 PineNote). Basically the interrupt would be triggered before
> certain commands were sent to the device, leading to a race between the
> device responding fast enough and the irq handler fetching a data frame
> from it. Actually all devices currently using the driver already use a
> falling edge trigger.
>
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> Reviewed-by: Alistair Francis <alistair@alistair23.me>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
