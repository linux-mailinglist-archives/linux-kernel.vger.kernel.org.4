Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C21B60C0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiJYBVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiJYBVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:21:06 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4A2E68A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:46:57 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id hh9so6652830qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5USzXCD8ydVVtwymTuo7PJDHRttASeG8NWRI0ljGGI=;
        b=c6BaUm8ONlBvSVUP6huj6udfvdy4GVIndXFh48bE1hep2dZUkhPlMQsq64JOww88Ds
         FMOFr5KQ3Q+HOYB/0aMjiAFY6nc/lFVAcoKY4Fys05AKulNZX0Vj6YdSw4KA0qY4RXIq
         2r4h3yKH85xnEAAvJ9TaXidDnTjghKSwn4BAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5USzXCD8ydVVtwymTuo7PJDHRttASeG8NWRI0ljGGI=;
        b=vkHMJLFpr6GZRnsI6AAsK46fxWq32NFofea90O3vm0KjrzMcWRlpcrjlRUCPbkB834
         IhkfCmkv95FVkvihnDA/cG/R/QLiaErBuqwsMXRUOzssWSKwDY847eHHWwx6uB5LRd2m
         +u0/uq5ZDfVuYan/yz921HKiko7gZXzUKr0MZqoWWSLNaegp5qUuqx70q/w07TZaP+kT
         8kvYq3jrizKPsYW882MVeOZpSRVrpBnfS8H69TM3o36e7f9UaAUxCtM/yhzzzT7h+kjK
         6aZ/tDQDE+rTRFUiFha0GWb0lrVR790QZog4clu7fzdEmv7SuzHvONzU8KLx7rXvZt3W
         VmLw==
X-Gm-Message-State: ACrzQf17u79IumS67jMeSK/CCgWNQpTnxvo4kS06kYVnzD7UT6R36Lg+
        NSR85kXeG6qxcW0TxbZw/Fie6J4aiAdiJw==
X-Google-Smtp-Source: AMsMyM4GjfC2PE5jO2bEQI5ZHXq+ZzMaIIVHhOoKLPQu9voelkXg9AzEDYV+F8VHAAloncYE5ew+tg==
X-Received: by 2002:a05:622a:289:b0:39c:b9f0:cb5a with SMTP id z9-20020a05622a028900b0039cb9f0cb5amr30210803qtw.154.1666658816853;
        Mon, 24 Oct 2022 17:46:56 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id y14-20020a05620a44ce00b006ce76811a07sm1054207qkp.75.2022.10.24.17.46.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:46:55 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id j130so12837387ybj.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:46:55 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr30411927ybk.501.1666658815304; Mon, 24
 Oct 2022 17:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221024182545.78d638a9@gandalf.local.home> <CAHk-=wj-j6Lntr84Qssq1gcsUKtNU8Y=RP+0+fnLT4y38zrsPw@mail.gmail.com>
 <20221024202407.44a3611b@gandalf.local.home>
In-Reply-To: <20221024202407.44a3611b@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 17:46:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOm7=wvu-HR6xj1XtXx=7V4VMaGfSmByDDj3rBMDnHTQ@mail.gmail.com>
Message-ID: <CAHk-=wjOm7=wvu-HR6xj1XtXx=7V4VMaGfSmByDDj3rBMDnHTQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/mm: Do not verify W^X at boot up on ftrace trampolines
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 5:24 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But anyway, I'll just let anyone take the v1 patch. I'll add it to my tests
> so that I can at least get my tests to finish.

Yeah, the v1 patch is the best option for now, and I'll just apply it
to my tree too.

I really hope that poking_mm creation can be cleaned up.

                  Linus
