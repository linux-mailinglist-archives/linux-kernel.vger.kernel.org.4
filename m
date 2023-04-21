Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62076EB303
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjDUUpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjDUUpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:45:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3881FE4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:45:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f3cd32799so360090266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682109936; x=1684701936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjzyPI+dsLA9tFzE+qKkauFePAkFasKeOC/4yMxjAAI=;
        b=DUuLCebzYtE+ayM8PjgVfm071n3KjKq4Uxh2tvIlKRsXDugAbe9KvWb9IypVj+KeA/
         LaU1gkfuO19/c+8yyPvVaVvXNuS0LXGgfchDY68c/LT4En+R/i4TsI4Shsba9bWd35Ab
         5QXEisavijws5iGjZ+nokU1cr5G+/mKuNH4SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682109936; x=1684701936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjzyPI+dsLA9tFzE+qKkauFePAkFasKeOC/4yMxjAAI=;
        b=LPlrK5UDUt5JhXAsEffAZ5w2pYNqzIL9p0M63q1skv7zaV+lMunYBMANLPN+73FUW1
         dPvOqQ335z2Zm7YqULNFS90BCv+cvO3rTd3aWMCNU4j3ZGPXCEMQbgQLcwMrllOjKVUf
         ggXCX5S+9X6Dq30dkIy7aijTXM2HHPCZQTkTrIx4aMvfrhsQ/ZYjVMBSeW+ALqum57Dp
         wde6ev038naf0nx5csbx1PfbUHYo/5WWkAJBOZk2m6fJyAUJ3CKOTnK0/0zz9iMyfWab
         L5Ur/9ZcfCg/pWeEF0S45R7Rjp3Wnza2Ih4BYO+eWFkxRyxpj5pIlEseLqzdmxdA9SQN
         yA7A==
X-Gm-Message-State: AAQBX9cjO/nEBfu+Q9rKioLzi0UBMabeVvDacM39Jn3eB+x9zwlPYP8m
        bpHuZ5I1NA2YcSKV8oUfkLRe11JfTHoH/qolQPDpyw==
X-Google-Smtp-Source: AKy350aFquTJnXPsk3/YxURkSUB0wkbVD/Jksz2cpHmtti6/iI+McI+xyiJ9L0GLkuaYRbX+AhTdxg==
X-Received: by 2002:a17:906:358f:b0:94f:2916:7d6 with SMTP id o15-20020a170906358f00b0094f291607d6mr3890173ejb.19.1682109936337;
        Fri, 21 Apr 2023 13:45:36 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id md23-20020a170906ae9700b0094fa846be48sm2468844ejb.132.2023.04.21.13.45.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 13:45:35 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso3649473a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:45:35 -0700 (PDT)
X-Received: by 2002:a05:6402:641:b0:504:921b:825 with SMTP id
 u1-20020a056402064100b00504921b0825mr5638433edx.36.1682109935212; Fri, 21 Apr
 2023 13:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <168166781352.1843526.278570500979918184@leemhuis.info>
 <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
 <CAJZ5v0j_MwW6JaqTRNhmz=LcW8==GZ0X-=W0+z0tOsGQyDd0Dw@mail.gmail.com>
 <b51f571a-d6b2-1908-d94a-bc0b2a751905@leemhuis.info> <CAJZ5v0j+VieZvQUXtyEJg47oggji2zgcJ6W9Mnge9Xz867QTJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+VieZvQUXtyEJg47oggji2zgcJ6W9Mnge9Xz867QTJQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Apr 2023 13:45:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgD98pmSK3ZyHk_d9kZ2bhgN6DuNZMAJaV0WTtbkf=RDw@mail.gmail.com>
Message-ID: <CAHk-=wgD98pmSK3ZyHk_d9kZ2bhgN6DuNZMAJaV0WTtbkf=RDw@mail.gmail.com>
Subject: Re: the wake-on-lan regression from 6.2 (was: Re: Linux regressions
 report for mainline [2023-04-16])
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 12:22=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> It will get fixed, most likely by reverting the offending commit and
> most likely during the 6.4 merge window.

No.

It's now reverted in my tree.

We're not doing *another* release with this known-broken garbage. It's
been pending for much too long already.

Known-broken commits either

 (a) get a timely fix that doesn't have other questions

or

 (b) get reverted

Not this kind of "this is broken, has been known to be broken for a
long time, people have bisected it, and we're just sitting here
wondering what to do".

> Note that ACPICA is involved, so the analogous revert needs to be
> submitted there and I'm traveling right now.

No, we're not waiting for "it's broken in the ACPICA tree" and using
that as an excuse to have a broken kernel.

If the ACPICA tree can't get their act together in two months, that's
their problem. It does not mean that users should need to suffer known
issues.

                Linus
