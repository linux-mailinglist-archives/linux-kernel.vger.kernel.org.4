Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC8726529
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbjFGP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbjFGPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:55:53 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7351FEE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:55:40 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77a62a84855so60837039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686153339; x=1688745339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shFCn1taKYYR4uXtcODKRu6RVrXZ9N+/Qi7dvctYzAc=;
        b=IF++AEQA5yaSxAq98V3Vt7vWEnQdOIufTloie6dqjCCg+N81d3AXkkUYAL30urhNO1
         Xd6sHbgTQEoRTWYkXFLU+yUb0D9s6H5cHn8neoYkuGYfHu8c0aHFcpGD6cIFkuhalVvS
         uULnRxkVGVsarFTapMMKIHawMzQa08itXOYpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686153339; x=1688745339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shFCn1taKYYR4uXtcODKRu6RVrXZ9N+/Qi7dvctYzAc=;
        b=MTSv8bnu+DiYa33Z7S1Vs9wy791yvzd5kxcpsrlWxiKPMlsq2iHzOZPCmS01p8nr7M
         AYXte5zzRlwY6teu7O9EaBXjxKY3Dt3NjzYs+iZUdSG0OYKHNq6vGYVbsPpdp/mmplmk
         ZF80KHlIZO+n67E3m/SJ9LC4p2Mwal+9GHvHWaK8ikBekfvBlQOiI7gCUWAAb6O93XJu
         O4LlSlzSTgQE8fdXtKj8Hte282LtQvSzy62akxx5QvQECXDWi1SvdeqgdrOWHZ5SjVGb
         7OjeufJwpZ5WtA23Hyazf8JOy/vC0KJYmRPYYNK56mxxdo+BSR2w+siBhRMKF8hVZvA3
         Q+Bw==
X-Gm-Message-State: AC+VfDxbNaSwTyxHkvAW9XoMwvTCkhB7l/ZfEfSeb1L/0MaryMMqjdei
        3rxH3Q8cwuODmK55d7IOs33Od2HJ7/xoPc3FqvA=
X-Google-Smtp-Source: ACHHUZ6QE3Dyo5DHR7TUUWzq+jPNHBWnt1IdOw5FcDikLL6RG3MclZdEO0lxtHt1nN1Nx1X7hvGSIA==
X-Received: by 2002:a5e:c80d:0:b0:774:91f6:9530 with SMTP id y13-20020a5ec80d000000b0077491f69530mr4675550iol.9.1686153338798;
        Wed, 07 Jun 2023 08:55:38 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id u28-20020a02cbdc000000b004065707eb2bsm544570jaq.42.2023.06.07.08.55.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:55:38 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so123725ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:55:37 -0700 (PDT)
X-Received: by 2002:a92:cda1:0:b0:33d:75d4:c83a with SMTP id
 g1-20020a92cda1000000b0033d75d4c83amr254713ild.16.1686153337336; Wed, 07 Jun
 2023 08:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
In-Reply-To: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 08:55:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VB9JgLhJjAirxBJaQZsCzD=R+6iGbYoHVB_FoE-HbNsA@mail.gmail.com>
Message-ID: <CAD=FV=VB9JgLhJjAirxBJaQZsCzD=R+6iGbYoHVB_FoE-HbNsA@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 0/2] Fix Goodix touchscreen power leakage for
 MT8186 boards
To:     Fei Shao <fshao@chromium.org>, Jiri Kosina <jikos@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri

On Tue, May 23, 2023 at 8:45=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> These changes are based on the series in [1], which modified the
> i2c-hid-of-goodix driver and removed the workaround for a power leakage
> issue, so the issue revisits on Mediatek MT8186 boards (Steelix).
>
> The root cause is that the touchscreen can be powered in different ways
> depending on the hardware designs, and it's not as easy to come up with
> a solution that is both simple and elegant for all the known designs.
>
> To address the issue, I ended up adding a new boolean property for the
> driver so that we can control the power up/down sequence depending on
> that.
>
> Adding a new property might not be the cleanest approach for this, but
> at least the intention would be easy enough to understand, and it
> introduces relatively small change to the code and fully preserves the
> original control flow.
>
> [1] https://lore.kernel.org/all/20230207024816.525938-1-dianders@chromium=
.org/
>
> Changes in v4:
> - Rebase on top of next-20230523
> - Collect the review tags
> - Minor coding style improvement
>
> Changes in v3:
> - In power-down, only skip the GPIO but not the regulator calls if the
>   flag is set
>
> Changes in v2:
> - Use a more accurate property name and with "goodix," prefix
> - Drop the change to regulator_enable logic during power-up
>
> Fei Shao (2):
>   dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend"
>     property
>   HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspend"
>     property
>
>  .../bindings/input/goodix,gt7375p.yaml           |  9 +++++++++
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c          | 16 +++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)

Just confirming that you're good to land these two patches as
discussed previously [1]. Thanks! :-)


[1] https://lore.kernel.org/r/nycvar.YFH.7.76.2305231510270.29760@cbobk.fhf=
r.pm
