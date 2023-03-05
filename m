Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABA26AB2C2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCEWIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCEWIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:08:38 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFAC126D4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 14:08:36 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-53cb9ac9470so150433457b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 14:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRCcECmc5fSO0nKesxcSn029SHM/zDGcM4+3/41gr6c=;
        b=lTfHOvr5JJbwf+Cfi8naXqrMfiBxiENVDfeLx/qLuj6JqDSNwp2WztLXRPJVBcSGoJ
         x/lF+9GiQ7jByR3i0HKc+pkoQy1lgcV5Vp9uC+Rp6k0CKSOqideVM5Rj8HAkUKdRq0rl
         oV9LfTNWGxhj55Yyikw8HxfCQeH9jiOyWZ5em0IoJl70/V/cQcGp7TcmyIISiCWubjSg
         sLN5rdh6C+vh1nInOulWtTluqDV4zYmv3RhvfS0krgt5n0seoZVVaybjaSm9AhPGJBme
         aBwISzvqSATiKw3mbyBoPpZow7UwCZ4l1W8rEQZ65+U5uNSzGNWPPLXcZVha2he4LZ1m
         +WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRCcECmc5fSO0nKesxcSn029SHM/zDGcM4+3/41gr6c=;
        b=O+/EBRSjrF3EP6hhpqjO+aXWYg7WvaLmCXgaXVeNnlXVWdAFaIYgb8Wd7+wzyJfYpr
         RFOHUMWPh8DG0Oxy0xZGsZBhj8xvZ9ZGwMb4hSbSUzr9YaATxa8JbBIPIWfzCAH4Qwks
         NhGRpe8D3XiexnuMXi2fiP0P1kBt7/Rwbp8xra3a5K/S+PMoS8iaxsvOgtYuEcWYE0aI
         VLUplW2tncTfqxs8pF1dJpkMKCkyt1B0NalGAv4WSshyYSJz7eVTPav+HYIEAJnGY23+
         CeWV+97UoUpUhF/KczqabHEbyA5PhVf5yVIsbdHU/LRg5Y/VPlDnwLQvsBNOmz3TFzw1
         vEHQ==
X-Gm-Message-State: AO0yUKVWR4gqa4njpZDwYz4T6DSsQWemAjS/7RenZikN5k83ggf529PJ
        g1hrEJirojHUgWL+lyDUFUyoReOHOisqFmO9bDIURQ==
X-Google-Smtp-Source: AK7set/SvlsXEqpmm2ZkVi1mWKZcJFFh/+qljEe//o9m1fAW+FY7IiZoJybLIxmW2KdOc0CbbPVAk0LfSEAYpidB3SU=
X-Received: by 2002:a81:ad24:0:b0:52e:bb2d:2841 with SMTP id
 l36-20020a81ad24000000b0052ebb2d2841mr5057583ywh.10.1678054115521; Sun, 05
 Mar 2023 14:08:35 -0800 (PST)
MIME-Version: 1.0
References: <ZAMQjOdi8GfqDUQI@gondor.apana.org.au> <E1pYOKH-000GYy-Rv@formenos.hmeau.com>
In-Reply-To: <E1pYOKH-000GYy-Rv@formenos.hmeau.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Mar 2023 23:08:24 +0100
Message-ID: <CACRpkdbVMkV1=hS38BUzhzccEH2HqUxSB44aan3e7ZcmNQ=m5w@mail.gmail.com>
Subject: Re: [v5 PATCH 3/7] crypto: stm32 - Simplify finup
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
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

On Sat, Mar 4, 2023 at 10:37=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:

> The current finup code is unnecessarily convoluted.  There is no
> need to call update and final separately as update already does
> all the necessary work on its own.
>
> Simplify this by utilising the HASH_FLAGS_FINUP bit in rctx to
> indicate only finup and use the HASH_FLAGS_FINAL bit instead to
> signify processing common to both final and finup.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

All tests sadly fail after this patch:

[    4.699857] stm32-hash a03c2000.hash: allocated hmac(sha256) fallback
[    4.708231] alg: ahash: stm32-hmac-sha256 test failed (wrong
result) on test vector 0, cfg=3D"init+finup aligned buffer"
[    4.719048] alg: self-tests for hmac(sha256) using
stm32-hmac-sha256 failed (rc=3D-22)
[    4.719070] ------------[ cut here ]------------
[    4.731602] WARNING: CPU: 0 PID: 88 at crypto/testmgr.c:5858
alg_test.part.0+0x4d0/0x4dc
[    4.739832] alg: self-tests for hmac(sha256) using
stm32-hmac-sha256 failed (rc=3D-22)
[    4.739853] Modules linked in:
[    4.750718] CPU: 0 PID: 88 Comm: cryptomgr_test Not tainted
6.2.0-13567-g410ada7489b7 #76
[    4.758915] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Suppo=
rt)
[    4.765897]  unwind_backtrace from show_stack+0x10/0x14
[    4.771169]  show_stack from dump_stack_lvl+0x40/0x4c
[    4.776270]  dump_stack_lvl from __warn+0x94/0xc0
[    4.781022]  __warn from warn_slowpath_fmt+0x118/0x164
[    4.786199]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[    4.792167]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[    4.797696]  cryptomgr_test from kthread+0xc0/0xc4
[    4.802527]  kthread from ret_from_fork+0x14/0x2c
[    4.807257] Exception stack(0xf10b9fb0 to 0xf10b9ff8)
[    4.812320] 9fa0:                                     00000000
00000000 00000000 00000000
[    4.820510] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    4.828698] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    4.835475] ---[ end trace 0000000000000000 ]---
[    4.840713] stm32-hash a03c2000.hash: allocated sha256 fallback
[    4.854071] alg: ahash: stm32-sha256 test failed (wrong result) on
test vector 1, cfg=3D"init+finup aligned buffer"
[    4.864487] alg: self-tests for sha256 using stm32-sha256 failed (rc=3D-=
22)
[    4.864500] ------------[ cut here ]------------
[    4.875924] WARNING: CPU: 0 PID: 98 at crypto/testmgr.c:5858
alg_test.part.0+0x4d0/0x4dc
[    4.884108] alg: self-tests for sha256 using stm32-sha256 failed (rc=3D-=
22)
[    4.884119] Modules linked in:
[    4.894022] CPU: 0 PID: 98 Comm: cryptomgr_test Tainted: G        W
         6.2.0-13567-g410ada7489b7 #76
[    4.903679] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Suppo=
rt)
[    4.910642]  unwind_backtrace from show_stack+0x10/0x14
[    4.915884]  show_stack from dump_stack_lvl+0x40/0x4c
[    4.920954]  dump_stack_lvl from __warn+0x94/0xc0
[    4.925675]  __warn from warn_slowpath_fmt+0x118/0x164
[    4.930826]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[    4.936764]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[    4.942265]  cryptomgr_test from kthread+0xc0/0xc4
[    4.947070]  kthread from ret_from_fork+0x14/0x2c
[    4.951780] Exception stack(0xf10e1fb0 to 0xf10e1ff8)
[    4.956830] 1fa0:                                     00000000
00000000 00000000 00000000
[    4.965005] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    4.973179] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    4.979850] ---[ end trace 0000000000000000 ]---
[    5.449257] stm32-hash a03c2000.hash: allocated hmac(sha1) fallback
[    5.458347] alg: ahash: stm32-hmac-sha1 test failed (wrong result)
on test vector 0, cfg=3D"init+finup aligned buffer"
[    5.469070] alg: self-tests for hmac(sha1) using stm32-hmac-sha1
failed (rc=3D-22)
[    5.469112] ------------[ cut here ]------------
[    5.481280] WARNING: CPU: 1 PID: 101 at crypto/testmgr.c:5858
alg_test.part.0+0x4d0/0x4dc
[    5.489663] alg: self-tests for hmac(sha1) using stm32-hmac-sha1
failed (rc=3D-22)
[    5.489699] Modules linked in:
[    5.500277] CPU: 1 PID: 101 Comm: cryptomgr_test Tainted: G
W          6.2.0-13567-g410ada7489b7 #76
[    5.510038] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Suppo=
rt)
[    5.517014]  unwind_backtrace from show_stack+0x10/0x14
[    5.522287]  show_stack from dump_stack_lvl+0x40/0x4c
[    5.527390]  dump_stack_lvl from __warn+0x94/0xc0
[    5.532140]  __warn from warn_slowpath_fmt+0x118/0x164
[    5.537318]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[    5.543284]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[    5.548815]  cryptomgr_test from kthread+0xc0/0xc4
[    5.553648]  kthread from ret_from_fork+0x14/0x2c
[    5.558378] Exception stack(0xf10edfb0 to 0xf10edff8)
[    5.563443] dfa0:                                     00000000
00000000 00000000 00000000
[    5.571633] dfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    5.579822] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.586511] ---[ end trace 0000000000000000 ]---
[    5.591474] stm32-hash a03c2000.hash: allocated sha1 fallback
[    5.610829] alg: ahash: stm32-sha1 test failed (wrong result) on
test vector 1, cfg=3D"init+finup aligned buffer"
[    5.621005] alg: self-tests for sha1 using stm32-sha1 failed (rc=3D-22)
[    5.621014] ------------[ cut here ]------------
[    5.632136] WARNING: CPU: 0 PID: 113 at crypto/testmgr.c:5858
alg_test.part.0+0x4d0/0x4dc
[    5.640368] alg: self-tests for sha1 using stm32-sha1 failed (rc=3D-22)
[    5.640377] Modules linked in:
[    5.649882] CPU: 0 PID: 113 Comm: cryptomgr_test Tainted: G
W          6.2.0-13567-g410ada7489b7 #76
[    5.659620] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Suppo=
rt)
[    5.666579]  unwind_backtrace from show_stack+0x10/0x14
[    5.671817]  show_stack from dump_stack_lvl+0x40/0x4c
[    5.676881]  dump_stack_lvl from __warn+0x94/0xc0
[    5.681594]  __warn from warn_slowpath_fmt+0x118/0x164
[    5.686739]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[    5.692669]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[    5.698163]  cryptomgr_test from kthread+0xc0/0xc4
[    5.702962]  kthread from ret_from_fork+0x14/0x2c
[    5.707668] Exception stack(0xf10edfb0 to 0xf10edff8)
[    5.712716] dfa0:                                     00000000
00000000 00000000 00000000
[    5.720887] dfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    5.729057] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.735717] ---[ end trace 0000000000000000 ]---

As usual the fallback works. I tried to look into it but I don't
understand this part:

@ -768,17 +773,14 @@ static int stm32_hash_final_req(struct
stm32_hash_dev *hdev)

> +       if (rctx->flags & HASH_FLAGS_FINUP)
> +               return stm32_hash_update_req(hdev);

stm32_hash_update_req() will do

if (!(rctx->flags & HASH_FLAGS_CPU))
    return stm32_hash_dma_send(hdev);
(...)
return stm32_hash_update_cpu(hdev);

So it replaces:

> -       if (!(rctx->flags & HASH_FLAGS_CPU))
> -               err =3D stm32_hash_dma_send(hdev);
> -       else
> -               err =3D stm32_hash_xmit_cpu(hdev, rctx->buffer, buflen, 1=
);

But now we are calling stm32_hash_update_cpu() instead of
stm32_hash_xmit_cpu(), because that is what stm32_hash_update_cpu()
does.

Yours,
Linus Walleij
