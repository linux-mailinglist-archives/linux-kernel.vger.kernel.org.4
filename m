Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DCC72CED0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjFLS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjFLS4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:56:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E98EE7B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:56:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1b66a8fd5so55576341fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686596196; x=1689188196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yhv8xsO6/cG6/37ib7eGERu4MLsFMvugXkXspF4Zlg=;
        b=BQ66SffTkiwLponLu2M0sKvRSdcsOXbamK3UKhI+a7RLU2rMKkthYacV1ugb2b9RiE
         zGUtZDxY8FH/08VJXv2yJYmZ0igHh0gLxENvYJM+EjiA6Rmiqs5C2vXi+fpqNcBdRhJq
         5eguFpArP+NPXWSY0yvkTTh0BeA5ENQBmhw5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596196; x=1689188196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yhv8xsO6/cG6/37ib7eGERu4MLsFMvugXkXspF4Zlg=;
        b=E3sr1dXpSWTGuBOvRmURnkreZHJMZbZrq6fDQI3EjcOcnEgwwb9fhiWug1gY+AyYb7
         RvKS9sYhHU1At5z66mwnODWBaf8eTGPijJ8Cr3vEZiKgMLFBSQRrXeX//9pce+a7JOm0
         H9m79oqw5CPxOjtfcMhBWU0pagv9q6lEdq+SutFhY6rScIV+xtdOB4+fiFxnQgCHV956
         Y9NYUVcuwY2AAzw2cSJd63cc+I3M+S1EUSGBAWo5LM1U4yjxwRqeex/LBSYDriQV5ywA
         zK9B8P4IAUlxvYTjP/hE2gUhgiuDx82xx6BsdEU4rmXtE/B0hkMwG+xy1S72/vmxSewV
         Zkbw==
X-Gm-Message-State: AC+VfDwnGUtLIsiAaEDt8s5uA58ntxIBdZxeUqOEw29eaD4pVCNEt1Yn
        z/v4kleBUfnemo9awDC12eacLEofj75jGi2EPMQgodtY
X-Google-Smtp-Source: ACHHUZ6UiTri6NWeYQXm1Ed1YuXZaZZyFm3WFdY+jtMZKgSZfn967TJB/o6hLBDiRbanikNxnT/iLA==
X-Received: by 2002:a2e:8786:0:b0:2ad:ac93:3c7d with SMTP id n6-20020a2e8786000000b002adac933c7dmr3451761lji.38.1686596196387;
        Mon, 12 Jun 2023 11:56:36 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id m23-20020a2e97d7000000b002ac7b0fc473sm1886450ljj.38.2023.06.12.11.56.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 11:56:35 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so5790066e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:56:35 -0700 (PDT)
X-Received: by 2002:aa7:d841:0:b0:516:b182:4e58 with SMTP id
 f1-20020aa7d841000000b00516b1824e58mr5590497eds.32.1686596174182; Mon, 12 Jun
 2023 11:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093539.895253662@infradead.org>
 <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com> <20230612184403.GE83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230612184403.GE83892@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 11:55:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaSkM4fjdP9dcdXQpLLjxW43ykgLA=FgzyHpyHayz8ww@mail.gmail.com>
Message-ID: <CAHk-=wgaSkM4fjdP9dcdXQpLLjxW43ykgLA=FgzyHpyHayz8ww@mail.gmail.com>
Subject: Re: [PATCH v3 33/57] perf: Simplify perf_adjust_freq_unthr_context()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
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

On Mon, Jun 12, 2023 at 11:44=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> I tried this before I used it and variables inside a for() loop have a
> scope of a single iteration.

Whee. Ok, that surprised me. But I guess that I shouldn't have found
it surprising, since the value doesn't survive from one iteration to
the next.

My mental picture of the scope was just different - and apparently wrong.

But thinking about it, it's not just that the value doesn't survive,
it's also that the "continue" will exit the scope in order to go back
to the "for()" loop.

I guess the "goto repeat" ends up being similar, since - as Ian Lance
Taylor said in one of the earlier discussions - that "__cleanup__"
ends up creating an implicit hidden scope for the variable. So a
'goto' to before the variable was declared implicitly exits the scope.

Ugh. I do really hate how subtle that is, though.

So while it might not be the horrible bug I thought it was, I'd
_really_ like us to not do those things just from a sanity angle.

                 Linus
