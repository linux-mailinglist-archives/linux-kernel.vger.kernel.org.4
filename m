Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EC6DB47B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjDGTtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDGTt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3257EC9;
        Fri,  7 Apr 2023 12:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE8965215;
        Fri,  7 Apr 2023 19:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DFCC433D2;
        Fri,  7 Apr 2023 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680896966;
        bh=k3rEJvN6OcdfsS7djVPf2/IZ21/jhRKFWcyEmi+OzIc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=NEuTACBOiD+ytvaG/5SgC3rc9OepJH3/VuSw+b8tFzueXQ9+NvYxv/+KLvC1LzqIJ
         QFYzfbtJk77zwrB2vD+H4mI/5cGMtoAF9NG6FVcPJyZukXBGoINWl8nHNfuH8dqu3z
         2tFQveH4/s7c7ds1X2tuBqEWkFGVVmfWkYRZHnZVoCuj9Y8EZGYyb57gy4GezfynFt
         5pqgTzswMA7gSK+8/NH74ohCY/8sSM+saMZ6vBn7CqoGwnfdrx5nWTyG/f1lhdHcUo
         rWsdiO4ZrnmG+u4eF/PSUV0gSoSzXTvM3JP/1TjelXe/KcwIqCnTg6DnqQ8X5fJabI
         /tBrLQLhJX6Xg==
Date:   Fri, 07 Apr 2023 12:49:25 -0700
From:   Kees Cook <kees@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kees Cook <keescook@chromium.org>
CC:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6/9=5D_fortify=3A_Split_repor?= =?US-ASCII?Q?ting_and_avoid_passing_string_pointer?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHp75VfyT9A0xAYquSS0AeOemLPZSq9+6H2D-PLaGfGoDa3_9w@mail.gmail.com>
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-6-keescook@chromium.org> <CAHp75Vf-nG865UwbVjwFjVTtXA7mAdi4FfKCpTHDx55eFnbvAA@mail.gmail.com> <642f4e62.170a0220.1f11f.36df@mx.google.com> <CAHp75VfyT9A0xAYquSS0AeOemLPZSq9+6H2D-PLaGfGoDa3_9w@mail.gmail.com>
Message-ID: <778548BD-653C-4F7C-8B1C-B4A40E23BC85@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 7, 2023 1:34:41 AM PDT, Andy Shevchenko <andy=2Eshevchenko@gmail=
=2Ecom> wrote:
>On Fri, Apr 7, 2023 at 1:57=E2=80=AFAM Kees Cook <keescook@chromium=2Eorg=
> wrote:
>> On Thu, Apr 06, 2023 at 01:20:52PM +0300, Andy Shevchenko wrote:
>> > On Thu, Apr 6, 2023 at 3:02=E2=80=AFAM Kees Cook <keescook@chromium=
=2Eorg> wrote:
>
>=2E=2E=2E
>
>> > > +       WARN(1, "%s: detected buffer %s overflow\n", name, write ? =
"write" : "read");
>> >
>> > Using str_read_write() ?
>> >
>> > Dunno if it's already there or needs to be added=2E I have some patch=
es
>> > to move those str_*() to string_choices=2Eh=2E We can also prepend yo=
urs
>> > with those=2E
>>
>> Oh! Hah=2E I totally forgot about str_read_write=2E :) I will use that=
=2E
>
>Btw, makes sense to add
>
>  #define str_write_read(v)    str_read_write(!(v))
>
>to the header, so we won't use negation in the parameter for better reada=
bility=2E

I ended up not going this far because the use of str_read_write() gets rem=
oved again in the last patch in the series=2E



--=20
Kees Cook
