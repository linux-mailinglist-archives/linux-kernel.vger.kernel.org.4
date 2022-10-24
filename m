Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EFA60BA25
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiJXU0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiJXUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:24:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55480EB4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:39:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k2so7133479ejr.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=doqa4EeZOoEkCz3v/Ifi0EexCSSeWFL40vnfB1aKvKE=;
        b=AsZMAmxS03NKVEIg+HuhIyqgg6rlZtH3e/5Ee4sg8xX72fBlj+AQoF5z7j2UAbTtq8
         yQ7feVRHBrlTtXAQ74dDtI5Ke56iuYfd4RA5JFM4oYTSUmEqqE6XLfsdM44+nVqAffZq
         MfVKZw0Dm4aOUDQFIpiV0VncbU3fbgQMIT/j2FYqEP0rYpTF3zfS1rTAhEG/7/Jok5au
         d2GFvsowV+1pP6YT0QH3MWsGxRs0ya+FNGU2cZnF0N73QVw7tI/5wND8F2kVWeDBiE+E
         F5dp6hdXr/8Q1Ya3TgLI4ptsr2eEKqWLwvqye2GfT7C7G4dbPHT7dcE2GHB+IxdH84sz
         QZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doqa4EeZOoEkCz3v/Ifi0EexCSSeWFL40vnfB1aKvKE=;
        b=E7Oc23+J7DJv0FYzYByMo6zjThkJSXW4v5kkww17HxtHm8YerN5KEJWXisRRCgL8u0
         FgKCiupRqgiDZPezfnkXxsMHNSuoPv/ZoOWP9uTmvd1uJIIdwEt3KsGICQFw5U77tG9L
         2S3gxryqSLBJqoT3e8TAtN/1HXNw0GlL3Ah4JEikQ2xyIxRLHXfMAjnHQ8m/jishLaMP
         nke3YFj0Gm68MjKaY0U3jc0V7xmDSdZURQqy5PefzJyCtQ9pKTzhBH2q/rMWhIOD4nQ3
         ddikFRb+CbAsLzn8xZt8tpq0LIFIzKiKkdDUovgqYEruWLfq7+dE+bny9eg8iG4OAiK6
         AsoA==
X-Gm-Message-State: ACrzQf0KpcggHo7sXmm8iuk/YwemwXruMMYZ1Vn4OvX637y2UOFvWTtf
        MmNWJxRzK4no5/f0APzTQD90OQS4kBcHAAZJt709hQ==
X-Google-Smtp-Source: AMsMyM5Cb44xF9/qC90Ybayrk8RK0+khUadnsPNGIz8OQPxvw8SCc8EsBU5ZxxSVih8sSnXTzO7fFrehicEmYwMd+kw=
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id
 ww3-20020a170907084300b0073a5b0e8352mr29213052ejb.438.1666636683926; Mon, 24
 Oct 2022 11:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N> <CABCJKuf=OB_3ZR_rwaG3H5kHKmTTDk+sihjJXYmyWgZjUX2yTQ@mail.gmail.com>
 <CAFP8O3JuC9HL1-G23vGJO=jjN7Tsgz7c8TB1_F6UQ-MqCyGNLQ@mail.gmail.com> <Y1Z0gvscALn2br2q@FVFF77S0Q05N>
In-Reply-To: <Y1Z0gvscALn2br2q@FVFF77S0Q05N>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 24 Oct 2022 11:37:27 -0700
Message-ID: <CABCJKucCa8VRgwiYBCm+tiAeX9Hneg3iH6bbvtt1Sk_ALXRprQ@mail.gmail.com>
Subject: Re: kCFI && patchable-function-entry=M,N
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Fangrui Song <maskray@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 4:18 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Oct 21, 2022 at 09:14:41PM -0700, Fangrui Song wrote:
> > On Fri, Oct 21, 2022 at 10:39 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > On Fri, Oct 21, 2022 at 8:56 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > For arm64, I'd like to use -fatchable-function-entry=M,N (where N > 0), for our
> > > > ftrace implementation, which instruments *some* but not all functions.
> > > > Unfortuntately, this doesn't play nicely with -fsanitize=kcfi, as instrumented
> > > > and non-instrumented functions don't agree on where the type hash should live
> > > > relative to the function entry point, making them incompatible with one another.
> > >
> > > Yes, the current implementation assumes that if prefix nops are used,
> > > all functions have the same number of them.
> > >
> > > > Is there any mechanism today that we could use to solve this, or could we
> > > > extend clang to have some options to control this behaviour?
> > >
> > > I don't think there's a mechanism to work around the issue right now,
> > > but we could just change where the hash is emitted on arm64.
> > >
> > > > It would also be helpful to have a symbol before both the hash and pre-function
> > > > NOPs so that we can filter those out of probes patching (I see that x86 does
> > > > this with the __cfi_function symbol).
> > >
> > > Adding a symbol before the hash isn't a problem, but if we move the
> > > hash and want the symbol to be placed before the prefix nops as well,
> > > we might need a flag to control this. Fangrui, what do you think?
> > >
> > > Sami
> >
> > Since the kcfi code expects the hash to appear in a specific location
> > so that an instrumented indirect jump can reliably obtain the hash.
> > For a translation unit `-fpatchable-function-entry=N,M` may be
> > specified or not, and we want both to work. Therefore, I agree that a
> > consistent hash location will help. This argument favors placing M
> > nops before the hash. The downside is a restriction on how the M nops
> > can be used. Previously if M>0, the runtime code needs to check
> > whether a BTI exists to locate the N-M after-function-entry NOPs. If
> > the hash appears after the M nops, the runtime code needs to
> > additionally knows whether the hash exists. My question is how to
> > reliably detect this.
>
> That's a fair point.
>
> For detecting BTI we can scan the binary for BTI/NOP at M instructions into the
> patch-site, but a similar approach won't be reliable for the type hash since
> the type hash itself could have the same bit pattern as an instruction.

We could always change the compiler to ensure the hash doesn't match
specific instructions. For example, if the hash can never be a NOP,
you could just skip any non-NOP instructions after the initial prefix
NOPs, right?

> > If there is motivation using M>0, I'd like to know the concrete code
> > sequence for `-fpatchable-function-entry=N,M` and how the runtime code
> > detects the NOPs with optional hash and optional BTI.
>
> For the BTI case alone, I have code at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/ftrace/per-callsite-ops&id=272a580fd5b7acc31747505d71530cee7cc2837d
>
> ... the gist being that it checks the instruction M insns after the start of
> the patch site.
>
> For the type hash, I think there are a few options, e.g.
>
> * Restricting the type hash to a set of values that can be identified (e.g.
>   encoding those as a permanently-undefined UDF with a 16-bit immediate).

Which would be quite similar, except instead of restricting hash
values to a specific range, we'd just have a list of unallowed hash
values.

Sami
