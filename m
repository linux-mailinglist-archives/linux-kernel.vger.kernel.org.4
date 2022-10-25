Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FE360D34F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiJYSOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiJYSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:14:41 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836FCFDA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:14:25 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a5so8696388qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKSf2M9cXULBGQi0KAs22w4c/g8Gdxd3T0gP82uqFls=;
        b=VD+I9qjrgFRWQeb1dHIKMbQpZgOS8wWjuauS/e8sumhy5gkJMpVGjY0dYEYrqqLsg5
         PZ1Vhq8h2VTuTJbxE2g3S7MN8bC2E6LAd9FAe3M0gvrmq/h7Cq4jxjkQzHG4gafiTM42
         BdlMZB5GPmOJ0RItLLReomnUZ2o1u1/h/FTN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKSf2M9cXULBGQi0KAs22w4c/g8Gdxd3T0gP82uqFls=;
        b=s7bdjDzu2jKACiYExl+vxJd9o5s6dyo8KyyCr+CppxK+CCHAZi9kU1kz75vV6HCiKw
         80aWCWEgZFi2zrKYQGQ365C0WA1IiD//UBkHsaxs/EMsbTv67e0yFuS4QsIslXWFctMA
         rr6zSbi67IrUC91xLxf/ajS9AmMUoozSavcojA6rUUVxjzWrMO9n7hn4QQad/A1dpvaI
         RNEsIb8HOpcb6tFdNsNp4Sk7SjcNgHHyauYmMM9i6AuAiBw7Mr4+ICwrbWYEW/L4z0Wk
         ZONuXjJVqAbFLAr9NcPgjKgF46TTNRlqcJsZjboB3MmyqtdkC6sCkAoO6sR+/6GaZG8W
         7eCw==
X-Gm-Message-State: ACrzQf09P1413m3my1cf2F/HPIHc5yq3WiLIhYkzj2eLkOyrlNMXG0VI
        sJ0N47zwGsI4tGa2gc1PNq1rwU5CNeMVqQ==
X-Google-Smtp-Source: AMsMyM6fvY+WxVqLp2VrW3uuB9v9F3CVrAxaFFYOqafaln+X88VE3S2X4r5mHL4vs5RjY9qt1AkaGQ==
X-Received: by 2002:a05:620a:343:b0:6ec:f4b3:e3c8 with SMTP id t3-20020a05620a034300b006ecf4b3e3c8mr27756066qkm.225.1666721664645;
        Tue, 25 Oct 2022 11:14:24 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id bb20-20020a05622a1b1400b003992448029esm1941972qtb.19.2022.10.25.11.14.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 11:14:23 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-333a4a5d495so122250067b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:14:23 -0700 (PDT)
X-Received: by 2002:a81:1902:0:b0:36b:2578:f6e2 with SMTP id
 2-20020a811902000000b0036b2578f6e2mr16541602ywz.352.1666721663328; Tue, 25
 Oct 2022 11:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221024114536.44686c83@gandalf.local.home> <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
 <20221024145250.08cfc147@gandalf.local.home> <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
 <Y1eu2wFVp1zcLg5b@hirez.programming.kicks-ass.net> <Y1e3i3RJRxOHTcJS@hirez.programming.kicks-ass.net>
 <CAHk-=wjwjWAhPD=C7sW7804eOTSQRnpSrrQh44PFYpVjn8SjKg@mail.gmail.com> <Y1ghRheOJeAfJvdY@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1ghRheOJeAfJvdY@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Oct 2022 11:14:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvuanYPtndJR2iDpn60ry4FMueEg2DCRdQresvkdRgHQ@mail.gmail.com>
Message-ID: <CAHk-=wgvuanYPtndJR2iDpn60ry4FMueEg2DCRdQresvkdRgHQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> mm_alloc() uses allocate_mm() which requires a kmem_cache to be set-up.

Well, that seems to be just a strange effect of mm_cachep being set up
by the oddly named "proc_caches_init" (I say oddly named because these
days I associate "proc" with proc-fs, but I think it actually comes
from "process").

That would actually probably make more sense if it was part of
mm_init(), much earlier (where we do "kmem_cache_init()")

So this is another oddity in how we do "mm_init()", but we haven't
actually initialized _that_ part of the mm setup.

Extra bonus points for another strange thing: we have "fork_init()",
but that too doesn't actually initialize the mm_cachep that fork()
actually uses. It does initialize the process one
(task_struct_cachep). So that kind of makes sense, but yeah, the
mm_alloc() cachep should have been set up by mm_init.

I think this is all "we just ended up randomly initializing things due
to hysterical raisins"

              Linus
