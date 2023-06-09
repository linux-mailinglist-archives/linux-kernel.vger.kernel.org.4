Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949A5728E09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbjFICcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjFICcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:32:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22CA1993
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:32:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f6454a21a9so1564316e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686277927; x=1688869927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0dr2RCR8de9AHgGFM/BsL//DnL2oGg8Z2a/flMORU8=;
        b=cMTFvoqUVQ9p1eoibPIKsrYwUpbFHBpds+nB87abGuKmei79zCBFxO97bVJkpCNfKk
         3E4n/FDS3SSRTBnX1jaSBdd2PksEZ8SPN2j7zaySDThjXb5/EGGRiiMaD9ZPvOh/LLw6
         7VqD9bouyhcuFdIRIsZ16aAOE4Wfagxr/0GjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277927; x=1688869927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0dr2RCR8de9AHgGFM/BsL//DnL2oGg8Z2a/flMORU8=;
        b=U/MHvlvLPXdEnUZubDM+rb4xL6gYPwHcKvLi74FFO3zJ21bYYlJbvs+8etRkF6valm
         Vy5vcJ7idOvoohgnJkwUHZHHna8+Kv2BiCiu/NXI0HlVkFizfD61kNFxc/SVDfBu9s4+
         Ytn9QERcLHVMmpmjQZBKPwpwB5YhhSMVgJBUyhhpUhJI3SBvqHFyOPnkMI++Yp91EDNQ
         XR5Dhzv11rHyZKZjTgobFa9croQHmKWnVwtoqsfwm3rIbCw7nsXR/lfwYDbkc8UGCtlg
         PyM/vB69WG+nK0IYJe6MZCVYvlnpfshO+edvpYf6R9S20nj6Su83Icak9SX74yo9guNG
         EItg==
X-Gm-Message-State: AC+VfDzQfbXIj8gMeYz3Mw2pupLxi9N86abN0A4+EK/PkY55jfW7Bckj
        HgJW1pp0rH6HZ+yFAT2qR7yBDHgnyKnxzCeG6/cxopig
X-Google-Smtp-Source: ACHHUZ4ad59vqVMl3ghsNfl/i2VZjvFVfbPuqgCJjs7p37hr8J/LOtudC7pLYEzX9TL4ZvPCpDdKbg==
X-Received: by 2002:a19:5619:0:b0:4f1:4d66:ac96 with SMTP id k25-20020a195619000000b004f14d66ac96mr44588lfb.19.1686277926781;
        Thu, 08 Jun 2023 19:32:06 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t12-20020ac2548c000000b004efae490c51sm373033lfk.240.2023.06.08.19.32.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 19:32:06 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f642a24568so1567559e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:32:06 -0700 (PDT)
X-Received: by 2002:a17:907:728b:b0:969:9fd0:7cf2 with SMTP id
 dt11-20020a170907728b00b009699fd07cf2mr271573ejc.10.1686277544358; Thu, 08
 Jun 2023 19:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net> <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com> <20230608200618.GA1020752@hirez.programming.kicks-ass.net>
In-Reply-To: <20230608200618.GA1020752@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Jun 2023 19:25:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcXuZ91WkKv0fuBcm+w7y=y=fNzW9EXfnYYSCFvuyhdA@mail.gmail.com>
Message-ID: <CAHk-=wjcXuZ91WkKv0fuBcm+w7y=y=fNzW9EXfnYYSCFvuyhdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
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

On Thu, Jun 8, 2023 at 1:06=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
>         struct obj *p __free(kfree) =3D kmalloc(...);

Yeah, the above actually looks really good to me - I like the naming
here, and the use looks very logical to me.

Of course, maybe once I see the patches that use this I go "uhh", but
at least for now I think you've hit on a rather legible syntax.

I'm still a bit unsure of the "no_free_ptr(p)" naming, but at least
it's pretty clear about what it does.

So my only worry is that it's not pretty and to the point like your
"__free(kfree)" syntax.

But it feels workable and not misleading, so unless somebody can come
up with a better name, I think it's ok.

           Linus
