Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033B35B5BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiILOKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILOJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:09:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0569FDD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:09:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r12so9157470ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mfq8c150I3kGu6rO3ZTAAfIdEDf7WQxub5tNq7rRvTU=;
        b=H0AQMRXRpk3pNXxtcRoGC9Up38rl/ba0GRrM16r9+CKhsO+jeQLJiF8NzKI2/uUzjp
         5M/3QwA6PW83EPqjqUg9MVdLLjkzm9fNjjjP4lIsu6jkfZZJc/cAXPeAqfbCw3czkFak
         TGmpvnWeRqfDEXeUmmCsZnDQ68s0bJhEVE6tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mfq8c150I3kGu6rO3ZTAAfIdEDf7WQxub5tNq7rRvTU=;
        b=pZY5mkHcr1QTLVHs4AhPlJHA9biZURl5yTOZcqvCZlORRH4dNcbT/FDfESU9CE8rl4
         2ps3NaIQ3JtJBI7YBX1M1474h5d2OhXxVfRlYM40kAjXR+vF/fO+Y+I1Pmar9v0wEAkZ
         SSovLX2iabpXe/wtUwyPYQuva7050I7uSl5qRhxIXTpRHdBkCP7RAMx3EgUGvIIJvFVS
         5ZVnQ9SZtpkrt68SpAz5OV8JCleqTDMemjzd/XnVJbMb7G8RvCdsoliim4G2eLOPObVA
         lbSlc/BN3shOHkERRipoSuPfEj6rHmvX5ehtV3SX49D6/POV1yfrS5Zdv4waW0N6UpUM
         7oNg==
X-Gm-Message-State: ACgBeo0/znzq66n16AlN8RilBGundDlZXnUUfiGJCO3B9/YjmoMoX/Dg
        1dl/JBoPtGYMTSItap5wLcP+fK9fMWlAYy3m
X-Google-Smtp-Source: AA6agR5kuILIL+8RrNwg3iQWTeVaZYZE0E8rByAzEoPgx9lyYjH60TSnGmQgAkBjOliF3P32jk69Vw==
X-Received: by 2002:a2e:5357:0:b0:26a:9a92:86c2 with SMTP id t23-20020a2e5357000000b0026a9a9286c2mr7499480ljd.178.1662991796708;
        Mon, 12 Sep 2022 07:09:56 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id dt6-20020a0565122a8600b004976809d6a7sm1081284lfb.283.2022.09.12.07.09.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 07:09:54 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id f14so14124373lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:09:54 -0700 (PDT)
X-Received: by 2002:a05:6512:10c1:b0:492:a27d:ff44 with SMTP id
 k1-20020a05651210c100b00492a27dff44mr8393482lfg.405.1662991794094; Mon, 12
 Sep 2022 07:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220902130625.217071627@infradead.org> <20220902130947.190618587@infradead.org>
 <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com>
 <YxI+K8Y+f/FHSQCU@hirez.programming.kicks-ass.net> <CAHk-=wjRLehUO=u8HDJGRFv+wz7hakSc=z6eTg547pAmb0UKHg@mail.gmail.com>
 <YxXJswK9QjhCGmPN@hirez.programming.kicks-ass.net>
In-Reply-To: <YxXJswK9QjhCGmPN@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Sep 2022 10:09:38 -0400
X-Gmail-Original-Message-ID: <CAHk-=whRetwx+5Bjiee+T+Nyyi8EiZ17SM3AL8jJnXuA+WjQyQ@mail.gmail.com>
Message-ID: <CAHk-=whRetwx+5Bjiee+T+Nyyi8EiZ17SM3AL8jJnXuA+WjQyQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/59] x86/build: Ensure proper function alignment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 6:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 02, 2022 at 11:08:54AM -0700, Linus Torvalds wrote:
>
> > Let's just do this right.
>
> Something like so then?

Sorry, I dropped this due to travel.

The patch looks sane, the only thing I worry a bit about is

> +config FUNCTION_ALIGNMENT
> +       int
> +       default 64 if FUNCTION_ALIGNMENT_64B
..
> +       default 0

Is '0' even a valid value then for things like

> +#define __ALIGN                        .balign CONFIG_FUNCTION_ALIGNMENT
> +#define __ALIGN_STR            __stringify(__ALIGN)

because it doesn't really seem like a sensible byte alignment.

Maybe "default 4" would be a safer choice?

                   Linus
