Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF47076E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjERAXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjERAXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:23:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3991BDA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:23:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so212679166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684369416; x=1686961416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT8xYYCjH6ggOvHhW6+9I5mhGuzNhDu/1pBE5VbcuBw=;
        b=gTZFVsElP150YAlaodxcujBHIj75XOb7QFcVy8eQfBGiyz9WyiVG4JNgr80YtrYelb
         2tSCpR6WtnXBEuUlu8U7V/lsTASyGGuEEppfFsGbXBf+IsPmOztCszCQh49Fs0UCbcvJ
         CHy7eRX74HXf0TWKJbutYbfpbMOM3XA5sUzwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684369416; x=1686961416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT8xYYCjH6ggOvHhW6+9I5mhGuzNhDu/1pBE5VbcuBw=;
        b=e07mj4toLugL5PyA6uGSgOELBOxUTIaRBI1NoPVlTQGZObO7TASnuO9/FjXe45i+M/
         PoZaYeVh4DVbPq66HHGERxF0mtEZz0tgiaWAS5XuoCtucxFMJ2aCGkzzRBOG6sQ0aLu6
         y/h8oNOEpQXmVaEuwmZb+OtdlzDMy9xEzHxJz5dEBX0qwb6IwIrHyhr66Bl0axn+hlEi
         j6gxHujze/ope7DYQ3IktyS3vGJyWc2U7cX0vfPV39L749oJHYIu4TBImYv43cp0cE9W
         M0LiFc/IlUCR8ljpgZUiTooVZjUhDrB8k650PBPQkGil/jXLvWFTff6Is3hIupmcAkts
         ZZ9Q==
X-Gm-Message-State: AC+VfDx6uo71vm2OjtkB/n/x+TsfEyYkyJOqrd4I/i+1i1fxiAglNyO7
        bHShI2NtbYO+jbE9021XcMfhsSv/jOVZCgQYgMJBzBvs
X-Google-Smtp-Source: ACHHUZ4AuI9yGQj2aCXu04GRYC6B3Zfd3ZTynpPKxWDfOVyYKi9No7Pc0mRc4ekhvUnW/ckBHg7AAw==
X-Received: by 2002:a17:906:fe42:b0:957:28b2:560a with SMTP id wz2-20020a170906fe4200b0095728b2560amr36830109ejb.46.1684369415936;
        Wed, 17 May 2023 17:23:35 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709064a4700b00965ac8f8a3dsm212708ejv.173.2023.05.17.17.23.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 17:23:34 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so2190635a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:23:34 -0700 (PDT)
X-Received: by 2002:a17:907:7dab:b0:967:a127:7e79 with SMTP id
 oz43-20020a1709077dab00b00967a1277e79mr31504240ejc.28.1684369414251; Wed, 17
 May 2023 17:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
 <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
 <20230517230054.GA195@W11-BEAU-MD.localdomain> <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
 <20230517192528.043adc7a@gandalf.local.home> <20230518001422.GA254@W11-BEAU-MD.localdomain>
In-Reply-To: <20230518001422.GA254@W11-BEAU-MD.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 17:23:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjU0vq8aL_VmUDqwh9_fo8nXYt65PBjihNetTMq4s8OsA@mail.gmail.com>
Message-ID: <CAHk-=wjU0vq8aL_VmUDqwh9_fo8nXYt65PBjihNetTMq4s8OsA@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 5:14=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> Do you run with CONFIG_DEBUG_ATOMIC_SLEEP? It will not splat with just
> CONFIG_PROVE_LOCKING and CONFIG_PROVE_RCU, which bit me here. I'm now
> running all three now that I know better.

I wonder if we should just make PROVE_LOCKING select DEBUG_ATOMIC_SLEEP..

PROVE_LOCKING is the expensive and complicated one. In contrast,
DEBUG_ATOMIC_SLEEP is the "we've had this simplistic check for some
very basic requirements for a long time".

So DEBUG_ATOMIC_SLEEP is really just a minimal debugging thing, it
feels a bit silly to have all the expensive "prove locking with
lockdep and all our lock debugging", and then not test the trivial
basics.

           Linus
