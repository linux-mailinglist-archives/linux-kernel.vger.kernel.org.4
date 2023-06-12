Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3672CB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbjFLQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbjFLQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:27:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4764171E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:27:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5185f8e1067so686457a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587267; x=1689179267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ64AB6vFE2gCnLICKj93uVfxKBboA+BfLd8wCYY+0E=;
        b=S0A+NkHjvdH5G+GEUHL3y9sjh4epzGSlRiWSPt1UKAqdmUGrRi6Pl1eA7UWWmL7sN0
         sfb7pnds99JgZX2Qd/oViy04bbTW8554vYeAras2T/hVfVpkw2QlhDBJeqkiX7dFQGq3
         5OVGAKFTDlIlFcruCcuGP7b7NzjIPD1T++od8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587267; x=1689179267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQ64AB6vFE2gCnLICKj93uVfxKBboA+BfLd8wCYY+0E=;
        b=X6KAnSNpJ137xmJdavyoPSnpDFINnw5fFT9rooZjqXDFHLx+M3rAsUXgPdRAfrNkMM
         DxaqZycoFXiVYqoAPSyMaVR8RuIdlsVErYPHoRNEtLgj4RHx75ixyxWEu3ni1msGCWdB
         Dozhl1U5YO6PrGd+v4N5JqCawPDvnB22SmcJRdBfWeKB4Mwcwz6qHo/+DgQZTYV38SkM
         eMCobNIorFUK6n+KaBKtdpPcY3+y97iwKG0A2K1msobsubdlSvtxW7kLDlZ4j5ngPH4r
         9GWp/hzaAbIYhMnntXSgAEbTZrmuEbkreKIiIaBEJSOHv1KqY9E21R7Ua9l30Mld/F/d
         zEPw==
X-Gm-Message-State: AC+VfDwAYTyvkZ50XNPYcHf6/JiN5no/3cPj+c5YP/I1SpbkAnVib43z
        wXWIwflE471WNkOmZn/kFBeA1IfhG0BmamGegfvp9sg8
X-Google-Smtp-Source: ACHHUZ5cK2oHFdOLfXVEV2CoSedzG13d1iOMnu8yXUtpsQgmJoODbY23y3MXQzgsfQtl4cYZ2NFD2w==
X-Received: by 2002:a17:906:7945:b0:978:8e58:e1b9 with SMTP id l5-20020a170906794500b009788e58e1b9mr11093852ejo.74.1686587266996;
        Mon, 12 Jun 2023 09:27:46 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id m17-20020a170906259100b00969f44bbef3sm5543332ejb.11.2023.06.12.09.27.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:27:46 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso7701379a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:27:46 -0700 (PDT)
X-Received: by 2002:a05:6402:6d3:b0:514:93b2:f3b1 with SMTP id
 n19-20020a05640206d300b0051493b2f3b1mr5343956edy.40.1686587246075; Mon, 12
 Jun 2023 09:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093539.895253662@infradead.org>
In-Reply-To: <20230612093539.895253662@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:27:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
Message-ID: <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have the same pattern that I *think* it's entirely
broken, ie you are doing that

                guard(perf_pmu_disable)(event->pmu);

inside a loop, and then you are randomly just removing the

               perf_pmu_enable(event->pmu);

at the end of the loop, or when you do a "continue"./

That's not right.

The thing does not not go out of scope when the loop *iterates*.

It only goes out of scope when the loop *ends*.

Big difference as far as cleanup goes.

So you have not "simplified" the unlocking code, you've broken it. Now
it no longer locks and unlocks for each iteration, it tries to re-lock
every time.

Or have I mis-understood something completely?

               Linus
