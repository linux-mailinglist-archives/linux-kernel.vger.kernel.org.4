Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4562F72CBAD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjFLQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjFLQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:38:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C2B9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:38:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so5336441e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587913; x=1689179913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkQkCR0zK+G1VvzG47ybOhl6nFuB5nGWY9v59LgjCEc=;
        b=TFz7syu073g1TLL4KeZsNwWe7UtqoiPAh7S+IiXwa07W3+rqjKn/Enyh/XB3TkuP4S
         TqB2x8FBNEMLQj1VpMYL5A0l0usDika4psdZfJU7OzYWtTARLtsTHtsmy1KIWkni4ZRV
         AZVkJOdwOkptzTXP/yS253RHdR8qjkwoAwBik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587913; x=1689179913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkQkCR0zK+G1VvzG47ybOhl6nFuB5nGWY9v59LgjCEc=;
        b=fplaJKaAwOld7bwerlleFrny6zsGN9QSkbeqR6hWWjftPQAUCfObW7bsceFnfyluzo
         4dE0hgXQyxpJhn44wBNq7E433yvYxL6jljFOCi/KkfgFUPec45ThsVrNs2mXxGnR/TZ+
         fFnAnLop+9c/h6rHvFKsLrWbydQeLHFtCHgSkXHPT7Cox1jpuwURHOhQRrhtcYepCbcp
         2LozCytJLF6JwK4XK9dUbOZ6i+iWR5f6++BzQ9CG7xyafiHeJlyzV8LxwX9+i7UHHfAg
         XCvx39l/MlvBLXSQM/GR+sNeFkqAw3OxXXg8J51oIwnFVGhjs2isAPN0TvgzsPwSwkfB
         xNvg==
X-Gm-Message-State: AC+VfDwjuPMM8VjBLdgRPNdwHhu/xA/rYgme6U4xp6e3BUlyBuMPb0w6
        mOGjhUgBtrz4oc0wgVhjK4341iGTAcA46tivfT9oZ0Zi
X-Google-Smtp-Source: ACHHUZ7c9SmMJLbyYQPhggcq8NmEaj8vM/3rOq6XiWfEEUo5JLxHvPOq4MjjTiQN5YSGZFKqshyG+A==
X-Received: by 2002:a05:6512:615:b0:4f2:5d38:2c37 with SMTP id b21-20020a056512061500b004f25d382c37mr4496505lfe.15.1686587913449;
        Mon, 12 Jun 2023 09:38:33 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id q2-20020ac24a62000000b004edd2dc9a09sm1476540lfp.258.2023.06.12.09.38.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:38:33 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso5326895e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:38:32 -0700 (PDT)
X-Received: by 2002:a19:e30c:0:b0:4f6:1779:b1c1 with SMTP id
 a12-20020a19e30c000000b004f61779b1c1mr5015246lfh.48.1686587892415; Mon, 12
 Jun 2023 09:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org>
In-Reply-To: <20230612090713.652690195@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:37:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3jV+v63RA30eVpjHVyrGmmTF7d3ajdV=1wBU=5OHa=A@mail.gmail.com>
Message-ID: <CAHk-=wj3jV+v63RA30eVpjHVyrGmmTF7d3ajdV=1wBU=5OHa=A@mail.gmail.com>
Subject: Re: [PATCH v3 00/57] Scope-based Resource Management
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

On Mon, Jun 12, 2023 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> These are by no means 'complete' convertions, I've mostly focussed on fun=
ctions
> that had 'goto' in them. Since that's a large part of why I started on al=
l this.

So I found what looks like two patches being completely broken because
the conversion was fundamentally misguided.

And honestly, by the end of walking through the patches I was just
scanning so quickly that I might have missed some.

Let's make the rule be that

 - max 10 patches in the series so that I think they were actually
thought about, and people can actually review them

 - only clear "goto out of scope" conversions. When you see a
"continue" or a "goto repeat", you TAKE A BIG STEP BACK.

Because this is all clever, and I am now happy with the syntax, but I
am *not* happy with that 60-patch monster series with what looks like
horrible bugs.

             Linus
