Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1F6A645B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCAAmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCAAmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:42:50 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C4837F32
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:42:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i34so47388669eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677631362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+Y/xqXtM4CeDX2eR0y7F5j30gs0rHpamGJAJph3YVc=;
        b=CdMiaIh1jdrSa3NhEcGHPKfNXNwSPAN48Jyl6SW8d6oehklRZpB0fhRzj/AmxlxDEO
         W2b+KD7YflAcFBIfrl6eLyn+H//LUoW4ZVEbPqD7G0SUzpzFB+m1Po0r0iokQDR5B+JT
         KafFs9EK6Kro44KOeejxmdILNg3vKriOyWW4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677631362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+Y/xqXtM4CeDX2eR0y7F5j30gs0rHpamGJAJph3YVc=;
        b=4uqG3bBSyGEza/VBuvAd1hOdcePXeU57guVdCxGMypKkWW78pXbB/Q2soYOBd8+f1t
         BivdIW0mHKhZ5ZQe2eUPcFEvC/vMRZ6wS+gOO/U6c4wKw7bj9ZgtZ9GEYr4nde5I5qkN
         UixeRluoKyoNaAg48Jjd+n83aeY5Ej23x9ezr9kIR11HvQ19IeMR3JetZIo+xIxh603v
         T1GX1mTBqY7GEUZj7m6xGtbkvCONrsLyPNf/WdYjRkBSbgEWdL8MAtVPfSgAsxp+uMjS
         wajF8Uv+QS5jwKp+MxtxeDvZsY9H49FYCJk+msJ6D7NN3o8Jvyb0IBRltMtXRIiG1aaH
         D0PQ==
X-Gm-Message-State: AO0yUKWKe8mly/YP3+j5FSf9Qd/1RfSsPp/S0UbggqRruNztT/jSrRMV
        MuUgI7h/I084V9WNVZFHW2T1JV7kZSkC6kSxQcw=
X-Google-Smtp-Source: AK7set/3nl3d5RroAx/muY4NvSWJMMheeffpOICR+miZZDF55JLDWb2UQZ5TmCYVaR+hmKCuOw61qg==
X-Received: by 2002:a05:6402:b24:b0:4aa:a4e8:8d5a with SMTP id bo4-20020a0564020b2400b004aaa4e88d5amr4764778edb.33.1677631362672;
        Tue, 28 Feb 2023 16:42:42 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id n15-20020a5099cf000000b004aef147add6sm4911101edb.47.2023.02.28.16.42.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 16:42:41 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id ck15so47667725edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:42:41 -0800 (PST)
X-Received: by 2002:a17:906:5d10:b0:8f5:2e0e:6dc5 with SMTP id
 g16-20020a1709065d1000b008f52e0e6dc5mr4097453ejt.0.1677631361396; Tue, 28 Feb
 2023 16:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20230228132118.978145284@linutronix.de> <20230228132910.991359171@linutronix.de>
In-Reply-To: <20230228132910.991359171@linutronix.de>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 28 Feb 2023 16:42:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjeMbHK61Ee+Ug4w8AGHCSDx94GuLs5bPXhHNhA_+RjzA@mail.gmail.com>
Message-ID: <CAHk-=wjeMbHK61Ee+Ug4w8AGHCSDx94GuLs5bPXhHNhA_+RjzA@mail.gmail.com>
Subject: Re: [patch 2/3] atomics: Provide rcuref - scalable reference counting
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Wangyang Guo <wangyang.guo@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> This unconditional increment avoids the inc_not_zero() problem, but
> requires a more complex implementation on the put() side when the count
> drops from 1 to 0.
>
> When this transition is detected then it is attempted to mark the referen=
ce
> count dead, by setting it to the midpoint of the dead zone with a single
> atomic_cmpxchg_release() operation. This operation can fail due to a
> concurrent rcuref_get() elevating the reference count from 0 to 1.

This looks sane to me, however it does look like the code is not really opt=
imal.

This is supposed to be a critical function, and is inlined:

> +static inline __must_check bool rcuref_get(rcuref_t *ref)
> +{
> +       unsigned int old =3D atomic_fetch_add_relaxed(1, &ref->refcnt);
> +
> +       if (likely(old < RCUREF_MAXREF))
> +               return true;

but that comparison would be much better if RCUREF_MAXREF was
0x80000000 and you'd end up just checking the sign of the result,
instead of checking big numbers.

Also, this optimal value choice ends up being architecture-specific,
since some do the "fetch_add", and others tend to prefer "add_return",
and so the point that is cheapest to check ends up depending on which
architecture it is.

This may seem like nit-picking, but I absolutely *HATE* our current
refcount interface for how absolutely horrid the code generation ends
up being. It's gotten better, but it's still not great.

So if we're introducing yet another refcount interface, and it's done
in the name of efficiency, I would *really* want it to actually be
exactly that: efficient. Not some half-way thing.

And yes, that may mean that it should have some architecture-specific
code (with fallback defaults for the generic case).

               Linus
