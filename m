Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4FB6DE671
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjDKVcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDKVcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:32:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C83468F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:32:07 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id f188so41538561ybb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681248726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeS4jHom2I9hOYAVSOLxAo/2gUtYfcTZSKxI2e4ZVrQ=;
        b=ka5LXxgNjFJr/iFnVZLhnZ7E1yCVLBfu2j0cpYW4Rd3xWKicacXWoe4ZTln/EbRX4p
         PhTK4Eqkmw0CANBJGoOa9Pxo4R8GM5I2i2Ey4gDUnxZY1fIB/QVY/kAz0eep83IQ9Wms
         7n3j2HbUoS5ULKcZopYgYzHMwSdKU7cAJEmrkKQx4555bhFckblKgDQNRbo7nTf/CA34
         p1hZ7D/MlGfL5jprrXj5lYv1BVIYoZdx+GjKJY/bLGRvod1o261ebMuQ7WS5WUk/bc0J
         /fsE4OkrGFNxCREf7V9Y6Eern+A8OQeSgrX/czXrOHlN75d4H6vEpvFwMWitncL1UGuA
         gvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681248726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeS4jHom2I9hOYAVSOLxAo/2gUtYfcTZSKxI2e4ZVrQ=;
        b=tFveUPArXIcuVKEl/hUaXKbxAJLhsRQ8K0hOp0x0+m4J3pk3g61W6dzgFX89WhFuLO
         OhuU4qz0Ge8ghvN2nKeFm5vYom2WHBu9AzNUv179A8T/YdgmFEk/9pftrNFR2Pl9hY69
         FXphAmUwMvggYziFFcPkSFLCAH94DPq9D+Ols4H4Nn5HLgqmoSeURhk4jPCGH7IiNqOc
         2sgIoN2c0g1Dhkz+UWGTXR8UgszG1bi+O2Wi1RMcLLZhbJdrV+bI6LwXAbNXnLF3u+ys
         DONTLQlNNuspzGbaDJCtJheJiGrNCvPM62Jyed86sF/Y0Kjshxu85QgJCY55Uer8XTVD
         k/xA==
X-Gm-Message-State: AAQBX9f+vAVTen4hQRh24guU1RUzACii15hbXCgIUDtA8kq6wiG3WU4I
        ZyU2v1mb61HQb2x0g650SDBOGTIQklCUyp8xrqFVpg==
X-Google-Smtp-Source: AKy350a901GIyrqbDiWssicho6VD6oQ1aF3Wwc8YpRauFzTD5PW6khekFH+UVi8XRjjeZGdz9uobkT9Kw17FeooXz5o=
X-Received: by 2002:a25:cac5:0:b0:b8e:d126:c64 with SMTP id
 a188-20020a25cac5000000b00b8ed1260c64mr2618154ybg.4.1681248726589; Tue, 11
 Apr 2023 14:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230407033341.5139-1-haibo.li@mediatek.com>
In-Reply-To: <20230407033341.5139-1-haibo.li@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 11 Apr 2023 23:31:55 +0200
Message-ID: <CACRpkda8qTuCmF_RDjtp26k_DMpME=0wAPjejh4ODkUr9SxVqg@mail.gmail.com>
Subject: Re: [PATCH] ARM:unwind:fix unwind abort for uleb128 case
To:     Haibo Li <haibo.li@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anurag Aggarwal <a.anurag@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        xiaoming.yu@mediatek.com,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Alex Sverdlin <alexander.sverdlin@nokia.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 5:33=E2=80=AFAM Haibo Li <haibo.li@mediatek.com> wro=
te:

> When unwind instruction is 0xb2,the subsequent instructions
> are uleb128 bytes.
> For now,it uses only the first uleb128 byte in code.
>
> For vsp increments of 0x204~0x400,use one uleb128 byte like below:
> 0xc06a00e4 <unwind_test_work>: 0x80b27fac
>   Compact model index: 0
>   0xb2 0x7f vsp =3D vsp + 1024
>   0xac      pop {r4, r5, r6, r7, r8, r14}
>
> For vsp increments larger than 0x400,use two uleb128 bytes like below:
> 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
>   Compact model index: 1
>   0xb2 0x81 0x01 vsp =3D vsp + 1032
>   0xac      pop {r4, r5, r6, r7, r8, r14}
> The unwind works well since the decoded uleb128 byte is also 0x81.
>
> For vsp increments larger than 0x600,use two uleb128 bytes like below:
> 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
>   Compact model index: 1
>   0xb2 0x81 0x02 vsp =3D vsp + 1544
>   0xac      pop {r4, r5, r6, r7, r8, r14}
> In this case,the decoded uleb128 result is 0x101(vsp=3D0x204+(0x101<<2)).
> While the uleb128 used in code is 0x81(vsp=3D0x204+(0x81<<2)).
> The unwind aborts at this frame since it gets incorrect vsp.
>
> To fix this,add uleb128 decode to cover all the above case.
>
> Signed-off-by: Haibo Li <haibo.li@mediatek.com>

[Added people such as Catalin, Ard and Anurag who wrote the lion's
share of actual algorithms in this file]

I would just link the wikipedia in the patch commit log actually:

Link: https://en.wikipedia.org/wiki/LEB128

for poor souls like me who need a primer on this encoding.

It's great if you also have a reference to the spec where you
found this, but I take your word for that this appears in code.
Did compilers always emit this? Then we should have a Cc stable
to this patch. Unfortunately the link in the top of the file is dead.

> +static unsigned long unwind_decode_uleb128(struct unwind_ctrl_block *ctr=
l)

So this decodes max an unsigned long? Are we sure that will always
suffice?

> +{
> +       unsigned long result =3D 0;
> +       unsigned long insn;
> +       unsigned long bytes =3D 0;
> +
> +       do {
> +               insn =3D unwind_get_byte(ctrl);
> +               result |=3D (insn & 0x7f) << (bytes * 7);
> +               bytes++;
> +               if (bytes =3D=3D sizeof(result))
> +                       break;
> +       } while (!!(insn & 0x80));

I suppose the documentation is in the commit message, but something terse
and nice that make us understand this code would be needed here as well.
Could you fold in a comment of how the do {} while-loop works and th expect=
ed
outcome? Something like:

"unwind_get_byte() will advance ctrl one instruction at a time, we loop
until we get an instruction byte where bit 7 is not set."

Is there a risk that this will loop forever or way too long if it happens
to point at some corrupted memory containing say 0xff 0xff 0xff ...?

Since we're decoding a 32 bit unsigned long maybe break the loop after max
5 bytes (35 bits)? Or are we sure this will not happen?

> @@ -361,7 +376,7 @@ static int unwind_exec_insn(struct unwind_ctrl_block =
*ctrl)
>                 if (ret)
>                         goto error;
>         } else if (insn =3D=3D 0xb2) {
> -               unsigned long uleb128 =3D unwind_get_byte(ctrl);
> +               unsigned long uleb128 =3D unwind_decode_uleb128(ctrl);

Is unsigned long always enough? We are sure?

Yours,
Linus Walleij
