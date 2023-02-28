Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1924E6A60BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjB1UvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjB1UvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:51:15 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80386D51A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:51:08 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536c02c9dfbso308632637b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtTqwj+D3jwps+3QoXdwgydtBnQr2/Gk4zbwXxgg29Q=;
        b=L5KZNYW7qHsWkjdPhZ6TanqjcxdyG+lFCPjAGGAgZ/GYJgivhxC0HiJ621wgsw0XE8
         rRC/neOY7eRtCzl6jhhdcfDr2AUXcJoYHQC5+wvUly53UbPDB3u+mxlZJddRzl1MIEHn
         ydJQT2oQdKvwtqOWbjjkM3DDVnfKH6nfVyfnxh/a1FvbGLH0JyzcCYIGu7nuptCfYTZE
         Tbvhc8AzmXw7cddrkRlFWbcH8B3xfhYixu/jv0NU2/uWL2mdNTSWvM9lGaRn/akBdoKV
         JE0Oa2k1RfsAEOXqv6Zpj0KLOY1MaGoxYn4L/0dohyZoYkpELZATVX4rBnn4VC/P2xtB
         5GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtTqwj+D3jwps+3QoXdwgydtBnQr2/Gk4zbwXxgg29Q=;
        b=U/zU+1QQb2xmCUoSR57TF9boVfzrySdGQdLtRuhHRB1gW5nqQtVRMBhX0O6yUI2MLo
         mJcLDI+xtwUGw37SuloOIHHvqpV3c+sKsTxTzOviSu2iz4eoE8zWTljZPdlV5YspXkU6
         y2RZePoyxxTAcZxZ2g/gqmQblvHK19A9iFIB4yaOd+QWA+/o+e5dUqs0rWzBCPIN41+c
         z0xTkn3e5fNm4OidW4Nk2z7rCt/jxST4Xgc9yZ8+1QiYycHXbPDC3ImKEQEU5n3xW2ro
         ZGgcsTcGVjicVYbmCo0niHbw0E2r4rxtEW64lHQJplfLazEAGJ8vuuLjjqWlh7qNuV+Z
         ScEQ==
X-Gm-Message-State: AO0yUKWb/KoDx3RRYZJsuwgBivZB99/M10CymopGPexEOYjKZVv3gVLB
        z+TDclkqJC1AkvrpHCDP6fLIAqQLW6Ho6Cg65SzXKA==
X-Google-Smtp-Source: AK7set9XZhbPRnpNk3LHyPWKqLU1EdXohqOA1vByAEMUPDHg9Vi4AWB6jaKLAb6zwZPk7goq8rB6OBW1VgL6AKuX/Aw=
X-Received: by 2002:a05:6902:4d1:b0:ab8:1ed9:cfd2 with SMTP id
 v17-20020a05690204d100b00ab81ed9cfd2mr1268507ybs.5.1677617467634; Tue, 28 Feb
 2023 12:51:07 -0800 (PST)
MIME-Version: 1.0
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au> <20230224231430.2948-1-kunyu@nfschina.com>
 <Y/cy5wUtk10OahpO@gondor.apana.org.au> <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
 <Y/c7iVW67Xhhdu8e@gondor.apana.org.au> <Y/hQdzsKMYgkIfMY@gondor.apana.org.au>
 <Y/yIbPBVCPx9K/0s@gondor.apana.org.au> <CACRpkdZC4z2Xng4=k94rmM=AFzNzTdXkvtkArMnK7afouz=7VA@mail.gmail.com>
 <Y/3FYZJeLE7DVPBf@gondor.apana.org.au> <Y/3IA4OjmUmjMgh1@gondor.apana.org.au> <Y/3N6zFOZeehJQ/p@gondor.apana.org.au>
In-Reply-To: <Y/3N6zFOZeehJQ/p@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Feb 2023 21:50:55 +0100
Message-ID: <CACRpkdZ3rCsOWqooNkPL6m7vZ2Z2Frh2sdxruKhrS0t3QHcSKw@mail.gmail.com>
Subject: Re: [v4 PATCH] crypto: stm32 - Save and restore between each request
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:48 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:

> v4 fixes hmac to not reload the key over and over again causing
> the hash state to be corrupted.

OK I tested this, sadly the same results.

Notice though: the HMAC versions fail on test vector 0 and
the non-MAC:ed fail on vector 1, so I guess that means test
vector 0 works with those?

Here is the complete log:

[    2.997312] alg: extra crypto tests enabled.  This is intended for
developer use only.
[   15.203609] Key type encrypted registered
[   22.553791] stm32-hash a03c2000.hash: allocated hmac(sha256) fallback
[   22.561976] alg: ahash: stm32-hmac-sha256 test failed (wrong
result) on test vector 0, cfg="init+update+final aligned buffer"
[   22.573387] Expected:
[   22.575674] 00000000: a2 1b 1f 5d 4c f4 f7 3a 4d d9 39 75 0f 7a 06 6a
[   22.582160] 00000010: 7f 98 cc 13 1c b1 6a 66 92 75 90 21 cf ab 81 81
[   22.588613] Obtained:
[   22.590917] 00000000: 46 24 76 a8 97 dd fd bd 40 d1 42 0e 08 a5 bc fe
[   22.597368] 00000010: eb 25 c3 e2 ad e6 a0 a9 08 3b 32 7b 9e f9 fc a1
[   22.603865] alg: self-tests for hmac(sha256) using
stm32-hmac-sha256 failed (rc=-22)
[   22.603887] ------------[ cut here ]------------
[   22.616297] WARNING: CPU: 1 PID: 75 at crypto/testmgr.c:5864
alg_test.part.0+0x4d0/0x4dc
[   22.624437] alg: self-tests for hmac(sha256) using
stm32-hmac-sha256 failed (rc=-22)
[   22.624448] Modules linked in:
[   22.635258] CPU: 1 PID: 75 Comm: cryptomgr_test Not tainted
6.2.0-12020-g1c3e1a0051be #67
[   22.643437] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[   22.650405]  unwind_backtrace from show_stack+0x10/0x14
[   22.655650]  show_stack from dump_stack_lvl+0x40/0x4c
[   22.660724]  dump_stack_lvl from __warn+0x94/0xc0
[   22.665447]  __warn from warn_slowpath_fmt+0x118/0x164
[   22.670601]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[   22.676537]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[   22.682037]  cryptomgr_test from kthread+0xc0/0xc4
[   22.686843]  kthread from ret_from_fork+0x14/0x2c
[   22.691553] Exception stack(0xf0f45fb0 to 0xf0f45ff8)
[   22.696604] 5fa0:                                     00000000
00000000 00000000 00000000
[   22.704779] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   22.712953] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   22.719596] ---[ end trace 0000000000000000 ]---
[   22.724494] stm32-hash a03c2000.hash: allocated sha256 fallback
[   22.769732] alg: ahash: stm32-sha256 test failed (wrong result) on
test vector 1, cfg="init+update+final aligned buffer"
[   22.780648] Expected:
[   22.782952] 00000000: ba 78 16 bf 8f 01 cf ea 41 41 40 de 5d ae 22 23
[   22.789392] 00000010: b0 03 61 a3 96 17 7a 9c b4 10 ff 61 f2 00 15 ad
[   22.795874] Obtained:
[   22.798147] 00000000: e3 b0 c4 42 98 fc 1c 14 9a fb f4 c8 99 6f b9 24
[   22.804607] 00000010: 27 ae 41 e4 64 9b 93 4c a4 95 99 1b 78 52 b8 55
[   22.811074] alg: self-tests for sha256 using stm32-sha256 failed (rc=-22)
[   22.811083] ------------[ cut here ]------------
[   22.822480] WARNING: CPU: 1 PID: 85 at crypto/testmgr.c:5864
alg_test.part.0+0x4d0/0x4dc
[   22.830607] alg: self-tests for sha256 using stm32-sha256 failed (rc=-22)
[   22.830615] Modules linked in:
[   22.840457] CPU: 1 PID: 85 Comm: cryptomgr_test Tainted: G        W
         6.2.0-12020-g1c3e1a0051be #67
[   22.850109] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[   22.857069]  unwind_backtrace from show_stack+0x10/0x14
[   22.862307]  show_stack from dump_stack_lvl+0x40/0x4c
[   22.867373]  dump_stack_lvl from __warn+0x94/0xc0
[   22.872090]  __warn from warn_slowpath_fmt+0x118/0x164
[   22.877237]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[   22.883167]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[   22.888662]  cryptomgr_test from kthread+0xc0/0xc4
[   22.893462]  kthread from ret_from_fork+0x14/0x2c
[   22.898169] Exception stack(0xf0f6dfb0 to 0xf0f6dff8)
[   22.903216] dfa0:                                     00000000
00000000 00000000 00000000
[   22.911388] dfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   22.919559] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   22.926182] ---[ end trace 0000000000000000 ]---
[   36.677933] stm32-hash a03c2000.hash: allocated hmac(sha1) fallback
[   36.686991] alg: ahash: stm32-hmac-sha1 test failed (wrong result)
on test vector 0, cfg="init+update+final aligned buffer"
[   36.698242] Expected:
[   36.700547] 00000000: b6 17 31 86 55 05 72 64 e2 8b c0 b6 fb 37 8c 8e
[   36.707002] 00000010: f1 46 be 00
[   36.710345] Obtained:
[   36.712624] 00000000: 12 3f d7 8b da 01 00 78 6a e8 6b 76 f5 0f 01 bd
[   36.719072] 00000010: 18 e4 77 f3
[   36.722450] alg: self-tests for hmac(sha1) using stm32-hmac-sha1
failed (rc=-22)
[   36.722472] ------------[ cut here ]------------
[   36.734495] WARNING: CPU: 1 PID: 88 at crypto/testmgr.c:5864
alg_test.part.0+0x4d0/0x4dc
[   36.742628] alg: self-tests for hmac(sha1) using stm32-hmac-sha1
failed (rc=-22)
[   36.742637] Modules linked in:
[   36.753097] CPU: 1 PID: 88 Comm: cryptomgr_test Tainted: G        W
         6.2.0-12020-g1c3e1a0051be #67
[   36.762754] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[   36.769719]  unwind_backtrace from show_stack+0x10/0x14
[   36.774963]  show_stack from dump_stack_lvl+0x40/0x4c
[   36.780036]  dump_stack_lvl from __warn+0x94/0xc0
[   36.784759]  __warn from warn_slowpath_fmt+0x118/0x164
[   36.789912]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[   36.795847]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[   36.801347]  cryptomgr_test from kthread+0xc0/0xc4
[   36.806153]  kthread from ret_from_fork+0x14/0x2c
[   36.810862] Exception stack(0xf0f79fb0 to 0xf0f79ff8)
[   36.815912] 9fa0:                                     00000000
00000000 00000000 00000000
[   36.824087] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   36.832261] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   36.838902] ---[ end trace 0000000000000000 ]---
[   36.843762] stm32-hash a03c2000.hash: allocated sha1 fallback
[   36.889782] alg: ahash: stm32-sha1 test failed (wrong result) on
test vector 1, cfg="init+update+final aligned buffer"
[   36.900507] Expected:
[   36.902786] 00000000: a9 99 3e 36 47 06 81 6a ba 3e 25 71 78 50 c2 6c
[   36.909225] 00000010: 9c d0 d8 9d
[   36.912564] Obtained:
[   36.914834] 00000000: da 39 a3 ee 5e 6b 4b 0d 32 55 bf ef 95 60 18 90
[   36.921296] 00000010: af d8 07 09
[   36.924627] alg: self-tests for sha1 using stm32-sha1 failed (rc=-22)
[   36.924635] ------------[ cut here ]------------
[   36.935687] WARNING: CPU: 1 PID: 100 at crypto/testmgr.c:5864
alg_test.part.0+0x4d0/0x4dc
[   36.943902] alg: self-tests for sha1 using stm32-sha1 failed (rc=-22)
[   36.943909] Modules linked in:
[   36.953406] CPU: 1 PID: 100 Comm: cryptomgr_test Tainted: G
W          6.2.0-12020-g1c3e1a0051be #67
[   36.963144] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[   36.970103]  unwind_backtrace from show_stack+0x10/0x14
[   36.975340]  show_stack from dump_stack_lvl+0x40/0x4c
[   36.980404]  dump_stack_lvl from __warn+0x94/0xc0
[   36.985120]  __warn from warn_slowpath_fmt+0x118/0x164
[   36.990266]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[   36.996195]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[   37.001689]  cryptomgr_test from kthread+0xc0/0xc4
[   37.006488]  kthread from ret_from_fork+0x14/0x2c
[   37.011193] Exception stack(0xf0f8dfb0 to 0xf0f8dff8)
[   37.016240] dfa0:                                     00000000
00000000 00000000 00000000
[   37.024411] dfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   37.032581] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   37.039222] ---[ end trace 0000000000000000 ]---

Here I have applied a patch like this to see the failing vectors:

commit 1c3e1a0051be234ef109e97075783c28e3b07452 (HEAD ->
ux500-fixup-stm32-cryp-herbert-v4)
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Mon Dec 26 09:53:10 2022 +0100

    test hacks

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index c91e93ece20b..db511293933b 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -1203,6 +1203,10 @@ static int check_hash_result(const char *type,
        if (memcmp(result, vec->digest, digestsize) != 0) {
                pr_err("alg: %s: %s test failed (wrong result) on test
vector %s, cfg=\"%s\"\n",
                       type, driver, vec_name, cfg->name);
+               pr_err("Expected:\n");
+               hexdump(vec->digest, digestsize);
+               pr_err("Obtained:\n");
+               hexdump(result, digestsize);
                return -EINVAL;

I'm a bit lost on what to try next :/

Yours,
Linus Walleij
