Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314946AF6FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCGUyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjCGUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:54:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00806A9081
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:54:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id k10so33723087edk.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678222465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1a1wUr/c8UneDltFnq/GcX6Q8fOFZMqB2rkkJLxpEA=;
        b=gOEtkVbZ4ASgeHG6Zs1ydUV8FfFAJNaOpw2xQ3GFBni4xp2Gi+ImjdltT0scnqNaBc
         YerVhh48BZzejtZeo74rKuNBXMYitUPCt6oCuFA/WegkYQ1MG9TGiKhxrZDCFSWjOXeq
         whXM4SnqvZM3tmqxOGEaN7XbkkuUDTguuZ+YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1a1wUr/c8UneDltFnq/GcX6Q8fOFZMqB2rkkJLxpEA=;
        b=v2v6guTxMG8s4yDk526lIfpqsQWg1zb6vuln6MsnrcmzHekY4riZl8jm+gz1P7nZ8j
         cbdei1uu/slNoQuYkOwjMXhHIaA70CM00V1agQT+5SVOHgi7LQcR+1LiYxs19ARFysYt
         jj7ehHHRGDHHi8lqz4HuDjrgwi7HfnlxnoRAFAL5gapSnVTDS7FYOFBiRY7UzjjW7ihx
         bfqMaEHLUlT2xZHXhVys+eMEgZOVS6y6U7/l51qt8utZ03AKa9lBBzxDVVYZDRxOqzVr
         jnjH3wYGYuFJSo6Ux7s+WBabI/7bPF3Xqdt+npRpB+FKZG7YfW8+J5ONh45AHv7Hp1qA
         MqcA==
X-Gm-Message-State: AO0yUKUUnzlYtMZy4ScNqKFZGxwx9rr2OCr5JsWvKYysmc98ZX/H2Lm3
        UVtc4Ebao05tGLrKZVspnz85Ry0PdGesQq+5abKrIaJt
X-Google-Smtp-Source: AK7set9DVNRJH+FgQtFqWX6SaciTiZtgD0TKauvj6bcbUFVCNB/2BBSSXssNprYM+UisjrIqWWOdBg==
X-Received: by 2002:a17:906:550a:b0:8e6:1726:df82 with SMTP id r10-20020a170906550a00b008e61726df82mr12962985ejp.30.1678222465415;
        Tue, 07 Mar 2023 12:54:25 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id si7-20020a170906cec700b008e68d2c11d8sm6576069ejb.218.2023.03.07.12.54.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 12:54:25 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id a25so57854207edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:54:24 -0800 (PST)
X-Received: by 2002:a50:cd94:0:b0:4c2:1a44:642e with SMTP id
 p20-20020a50cd94000000b004c21a44642emr8987314edi.5.1678222464569; Tue, 07 Mar
 2023 12:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
In-Reply-To: <ZAeh8g0nr3IFRSVI@tucnak>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Mar 2023 12:54:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
Message-ID: <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, james.morse@arm.com, babu.moger@amd.com,
        ananth.narayan@amd.com, vschneid@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 12:43=E2=80=AFPM Jakub Jelinek <jakub@redhat.com> wr=
ote:
>
> Are we actually talking here about "p" constraint or about p/P (x86) modi=
fiers
> (asm ("%p0" : : "i" (42));)?

In this case it's actually the "p" constraint.

And the "percpu_stable_op()" thing uses it exactly because it thinks
it wants the "I don't care about data dependencies in memory, because
this memory location doesn't change".

Of course, that "this memory location doesn't change" is then always
technically a lie. It's exactly things like "current" that obviously
*does* change in the big picture, but from the context of a particular
_thread_, "current" is a fixed value.

Which then causes problems when you use that "percpu_stable_op()"
thing from within the scheduler (generally without being *aware* of
this issue at all, since the use is hidden a few macro expansions
down).

I think the problem is that the <asm/resctrl.h> code is disgusting and
horrible in multiple ways:

 (a) it shouldn't define and declare a static function in a header file

 (b) the resctrl_sched_in() inline function is midesigned to begin with

basically, the actual scheduling functions should *never* look at
"current" at all. They are - byu definition - changing it, and they
already *know* what both the "incoming current" (aka "prev_p") and
"new current" (aka "next_p") are.

So any scheduling function that uses "current" is hot garbage.

In this case, that hot garbage is resctrl_sched_in().

I do not believe this is a compiler issue. This is literally just a
kernel bug, and that resctrl code being very very wrong.

              Linus
