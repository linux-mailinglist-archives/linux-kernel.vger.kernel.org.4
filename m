Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DBB724822
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbjFFPqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjFFPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:46:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F410CB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:46:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977c89c47bdso591858166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686066368; x=1688658368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UOet92MpBdONuA5jgW7v4DmIoemYaVmbXnKM9EiZ2I=;
        b=GMqqXC7kD2aFZAL+Xqxn3hVYBW9rs8u24yj/MxEls44TnbxkDLKZmMVBkOZM46oKuj
         RwPcoDFo7Hhe38Nj1RxdYDlR99f1QSsX29lcby12JtMX/hSnika4+pI9WtiT34mEEHGN
         kyLdMVso1Ps0GNFhhn8dvZdhrM2C1Rlgr9MOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066368; x=1688658368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UOet92MpBdONuA5jgW7v4DmIoemYaVmbXnKM9EiZ2I=;
        b=E1wteSHNV/QoLuO4nEPXH76NN6OBN1I7aoDb3Fl6p7DnY+/HM3oyb5PJcODNV6Nu2N
         rIBLMjKQBfORFn2rqA87Ol9VaypAHswnEcPf96uQ679rYT9Cl6GiUHPqFr/Wbhs/KF7b
         f6ElT7PjRM+hIHPelkQ/pNz2drYWVexKpO7sw/OpZ8mRneCeggP3N1hrd1PMWzYcUNwz
         +C/ajSM5A4bWpiP7IYCc91EI4BcnsbNXn3cI7bqkeyMtiY8Qi1cx1WsyN7DdFN5LvpL6
         +unAK5alE0TDwMJ7seWnAKLReNQywSKY039HkHrAth91GYb4MInNfGfAg35OSPDqThG+
         p1AQ==
X-Gm-Message-State: AC+VfDzsPIcgzn9ziA3Y2/f44WNKW1yVLFj+d/elWMMs9RzqcvgSSujQ
        XbyLmsg2fZbiwHZDhFyNGjiPBEnkB6SHqTMLXHfB8UyV
X-Google-Smtp-Source: ACHHUZ5x76ODsZr3fKtJaH+3t4rW8q1t4aogO0eOtVeEnVwWbvryfs1/0UMY5Y3M9yDzXC1ruQnYhA==
X-Received: by 2002:a17:907:8a08:b0:973:ad8f:ef9b with SMTP id sc8-20020a1709078a0800b00973ad8fef9bmr3140250ejc.5.1686066368384;
        Tue, 06 Jun 2023 08:46:08 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id bv26-20020a170906b1da00b0096f78953b77sm5780875ejb.147.2023.06.06.08.46.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:46:07 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so9688333a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:46:06 -0700 (PDT)
X-Received: by 2002:a17:906:7950:b0:974:1c90:b3d3 with SMTP id
 l16-20020a170906795000b009741c90b3d3mr3220341ejo.12.1686066366310; Tue, 06
 Jun 2023 08:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <202306060829.C2FD998CF@keescook>
In-Reply-To: <202306060829.C2FD998CF@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jun 2023 08:45:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=vs298o0gewFH725pQAYQ57CAQzj05FOx_VZubZ3jiA@mail.gmail.com>
Message-ID: <CAHk-=wh=vs298o0gewFH725pQAYQ57CAQzj05FOx_VZubZ3jiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
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

On Tue, Jun 6, 2023 at 8:31=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> nit: Linus's example was "(void *)8" (instead of 1) because we've had
> issues in the past with alignment warnings on archs that are sensitive
> to it. (e.g. see the __is_constexpr() macro which is doing NULL/!NULL
> comparisons.)

Note that I don't think we ever saw such a warning, it was just a
theoretical observation that depending on type, the compiler might
warn about known mis-aligned pointer bits.

So I'm not sure the 1-vs-8 actually matters. We do other things that
assume that low bits in a pointer are retained and valid, even if in
theory the C type system might have issues with it.

But maybe I mis-remember - if you did get an actual warning, maybe we
should document that warning just to keep the memory alive.

            Linus
