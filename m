Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E306ABAE6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCFKIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCFKI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:08:29 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374AED50E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:08:27 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536c02c9dfbso173685827b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuykXggvsDzQHIeBJBHcszr/OGsNgXxnAq3pjOU/BU8=;
        b=CY/ZOM60Rpa6EpY/DW2nrkrZhm7PoXgOkhTRPWMucTyi1AM4BwmKv21XzKnmK5XfNR
         U2XC6W4MOEqUJT+BbIU/LJ6VaixSobWtQPJUU+Fmt0BYbTYoZn5wGjRHkfiP9gvmacuO
         87M4f7EtxRsbkKm/w4nm01XbyJ2LvxOFnpsIhBG3yOV8lnh4+SCFMZq8NLRN6ARq5ZLZ
         jxY/3eBvuZFiEivv8noOkNjgojaZ1NbdVVlb0PgqcGeHCvMjRXSxGBfMtcic4XNj2/SP
         9WK+1S7NZ4G6CTncuzVwDJzeBEP23q4VLplO4Z3cErlMasqgb6RJtCdCb5sGSUuKvOk3
         wu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuykXggvsDzQHIeBJBHcszr/OGsNgXxnAq3pjOU/BU8=;
        b=5AkCicbn96mKv4FYzq1iW77uKjSxDFqcDUdL2faI9Bl3xlpka3ZICn9fB2EJG40lk1
         +Of3MzA8EGjl6lxmw6KnGIkvtdK3zD1a4MP2gunET9n7uDibt+KfrzF7UIZgupAJabe8
         4QITQ2WpJaS62Ttb3WMFN3L2XPv3lgviVj4Za067Glp4PkhzXnHtX3v9giZ1EKAxyFzS
         IDY33MhWZHj+/xejzCSPBVnzVIpifLTwoFlO4uiyUT+UxH3ph/NzQ2J4IxFJMVdUAsyy
         8WTwLVmUVVYZ4OoFy/qGW2viDQ5nOqBORgNAWHDpVpjSal5iewaSgwOnjpXtEWJNIGEo
         e92Q==
X-Gm-Message-State: AO0yUKXm0i0ZYgnxfbzVic3n5MRJs5WcaRrzAq7jN2x0OrOjgvPZbrWQ
        ZTK3vQWA9ePIJjJQlq0JcfAYf6JJ1YGW33YyCuuoAg==
X-Google-Smtp-Source: AK7set+WvjIbrX1O0qmYHcTPqcnUqha8IcmKrc2fT19jOthmIdLaMC0q5ENuPGxERjuzb/ss8PPKrfrUhf98fggs1kM=
X-Received: by 2002:a81:ad44:0:b0:52a:92e9:27c1 with SMTP id
 l4-20020a81ad44000000b0052a92e927c1mr6492232ywk.10.1678097306341; Mon, 06 Mar
 2023 02:08:26 -0800 (PST)
MIME-Version: 1.0
References: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au> <E1pZ2fs-000e27-4H@formenos.hmeau.com>
In-Reply-To: <E1pZ2fs-000e27-4H@formenos.hmeau.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 11:08:13 +0100
Message-ID: <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com>
Subject: Re: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each request
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 5:42=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:

> The Crypto API hashing paradigm requires the hardware state to
> be exported between *each* request because multiple unrelated
> hashes may be processed concurrently.
>
> The stm32 hardware is capable of producing the hardware hashing
> state but it was only doing it in the export function.  This is
> not only broken for export as you can't export a kernel pointer
> and reimport it, but it also means that concurrent hashing was
> fundamentally broken.
>
> Fix this by moving the saving and restoring of hardware hash
> state between each and every hashing request.
>
> Also change the emptymsg check in stm32_hash_copy_hash to rely
> on whether we have any existing hash state, rather than whether
> this particular update request is empty.
>
> Fixes: 8a1012d3f2ab ("crypto: stm32 - Support for STM32 HASH module")
> Reported-by: Li kunyu <kunyu@nfschina.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

This partly works (after my folded in fix in patch 5)!

Clean SHA1 and SHA256 works flawlessly.
HMAC still fails, but not until we start testing random vectors:

[    7.541954] alg: ahash: stm32-hmac-sha256 digest() failed on test
vector "random: psize=3D0 ksize=3D80"; expected_error=3D0,
actual_error=3D-110, cfg=3D"random: may_sleep"
[    7.567212] alg: self-tests for hmac(sha256) using
stm32-hmac-sha256 failed (rc=3D-110)
[    7.567222] ------------[ cut here ]------------
[    7.579669] WARNING: CPU: 0 PID: 89 at crypto/testmgr.c:5858
alg_test.part.0+0x4d0/0x4dc
[    7.587809] alg: self-tests for hmac(sha256) using
stm32-hmac-sha256 failed (rc=3D-110)
[    7.587817] Modules linked in:
[    7.598702] CPU: 0 PID: 89 Comm: cryptomgr_test Not tainted
6.2.0-13572-gcdc48b2701b2 #87
[    7.606877] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Suppo=
rt)
[    7.613842]  unwind_backtrace from show_stack+0x10/0x14
[    7.619080]  show_stack from dump_stack_lvl+0x40/0x4c
[    7.624145]  dump_stack_lvl from __warn+0x94/0xc0
[    7.628861]  __warn from warn_slowpath_fmt+0x118/0x164
[    7.634007]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[    7.639936]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[    7.645430]  cryptomgr_test from kthread+0xc0/0xc4
[    7.650229]  kthread from ret_from_fork+0x14/0x2c
[    7.654936] Exception stack(0xf10b5fb0 to 0xf10b5ff8)
[    7.659984] 5fa0:                                     00000000
00000000 00000000 00000000
[    7.668154] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    7.676325] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.682986] ---[ end trace 0000000000000000 ]---
[    7.688219] stm32-hash a03c2000.hash: allocated sha256 fallback
[   10.675002] stm32-hash a03c2000.hash: allocated hmac(sha1) fallback
[   11.269604] alg: ahash: stm32-hmac-sha1 finup() failed with err
-110 on test vector "random: psize=3D0 ksize=3D15", cfg=3D"random: use_finu=
p
src_divs=3D[100.0%@+4081] i"
[   11.285037] alg: self-tests for hmac(sha1) using stm32-hmac-sha1
failed (rc=3D-110)
[   11.285048] ------------[ cut here ]------------
[   11.297141] WARNING: CPU: 1 PID: 102 at crypto/testmgr.c:5858
alg_test.part.0+0x4d0/0x4dc
[   11.305352] alg: self-tests for hmac(sha1) using stm32-hmac-sha1
failed (rc=3D-110)
[   11.305361] Modules linked in:
[   11.315894] CPU: 1 PID: 102 Comm: cryptomgr_test Tainted: G
W          6.2.0-13572-gcdc48b2701b2 #87
[   11.325633] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Suppo=
rt)
[   11.332594]  unwind_backtrace from show_stack+0x10/0x14
[   11.337832]  show_stack from dump_stack_lvl+0x40/0x4c
[   11.342897]  dump_stack_lvl from __warn+0x94/0xc0
[   11.347611]  __warn from warn_slowpath_fmt+0x118/0x164
[   11.352758]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[   11.358687]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[   11.364181]  cryptomgr_test from kthread+0xc0/0xc4
[   11.368981]  kthread from ret_from_fork+0x14/0x2c
[   11.373687] Exception stack(0xf10f1fb0 to 0xf10f1ff8)
[   11.378734] 1fa0:                                     00000000
00000000 00000000 00000000
[   11.386906] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   11.395076] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   11.401724] ---[ end trace 0000000000000000 ]---
[   11.407162] stm32-hash a03c2000.hash: allocated sha1 fallback

I will try to investigate further as time permits. (Right now I have
to go off for lunch...)

Yours,
Linus Walleij
