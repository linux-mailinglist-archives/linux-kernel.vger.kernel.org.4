Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5A6F89E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjEETzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjEETzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:55:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B2138
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:55:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso3881563a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683316499; x=1685908499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv8lvk1AbBLvhkSN9QZ33lzvEycfnFaITAOJMUFaHQA=;
        b=Hyx+9ZwETWFNgFL2zFcgjp8ZA+6ONl6SfOea54n7JwJeC61ZnZuI2l9VEgChaG2yvq
         eiJRlEXBbkjCD824CDMHW4PbA8N54d12CwnMi1O/79MLRj50vNwCxaiJUxpJi10WHoxJ
         JLUa5PPRZptR1nH/RVIRQuIGx1Lz41SQI2T68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683316499; x=1685908499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv8lvk1AbBLvhkSN9QZ33lzvEycfnFaITAOJMUFaHQA=;
        b=ieq43uUBsUsovhdWFB4YzQTytOJVItFaLjzgMVm7lSDSjCagibH2AmUZoAJ7hmVGrI
         9brTXCeGbStFamw96qmnvXzJoC6m4wDnLv5LDfcx0AcHxQtlRpSpc3kN1KIr6l6XTr0v
         c/LxgyPNiJ4gLpExjB7Ylp8TamYo3zvUggW0uXWjF35xU2kRccROpk1GyAmHXMrrzNVt
         Hdzc0rgrZCxcdqjkLHRRgrH5WyFGvAG76/ZWLMykIwnfAZ7AjfxAh6budYpN2zXgZ5+B
         d+iKUw/IO8e/l/6TYcEegjuP9SBLVAVn/CWTTIV0C23CzUsS9KolSJd+WOKoxcwLP+Bz
         kgfg==
X-Gm-Message-State: AC+VfDyzyYQJxApIWrfYiBF/0bsiEFpM9ex2YdBABtpvheQky7fvSEF/
        Mmyr0X/L9lYAhhqrq8G0vX5xfOALnUJ4eq6nJ9i8bA==
X-Google-Smtp-Source: ACHHUZ5MjmuebtWSXIrblGtbAMwXWF39/XKc9+qM3HXXjFRbfcvxPjqh5FeXBjCztyIU3eQHbau1rA==
X-Received: by 2002:a05:6402:1255:b0:50c:646:cafd with SMTP id l21-20020a056402125500b0050c0646cafdmr2246387edw.7.1683316499259;
        Fri, 05 May 2023 12:54:59 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id bm11-20020a0564020b0b00b00506987c5c71sm3237231edb.70.2023.05.05.12.54.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:54:58 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-965ac4dd11bso432353766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:54:57 -0700 (PDT)
X-Received: by 2002:a17:907:e8e:b0:94f:969e:c52b with SMTP id
 ho14-20020a1709070e8e00b0094f969ec52bmr2399020ejc.74.1683316497433; Fri, 05
 May 2023 12:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
 <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com> <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
 <3cc72a67-d648-0040-6f60-37663797e360@efficios.com>
In-Reply-To: <3cc72a67-d648-0040-6f60-37663797e360@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 12:54:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
Message-ID: <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
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

On Fri, May 5, 2023 at 11:49=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I would add to this list of exceptions cases where the argument is used
> as an expression within brackets, e.g.
>
> #define m(x) myvar[x]

Yeah, that makes sense not because of any operator precedence rules,
but simply because brackets end up syntactically nesting just like
parentheses themselves do.

IOW, while you can mess up that nesting by having non-nested brackets
in the argument, that's equally true of any added parentheses too.

> The other exception I would add is when a parameter is used as an
> lvalue, as:
>
> #define m(x) do { x =3D 2; } while (0)

I really don't understand why you think '=3D' is so special. It's very
much not special.

It happens to have the lowest precedence, sure, but the keyword is "happens=
".

I think you are confused by the non-C languages that make assignment
be not an expression operator, but a statement.

So I think you are technically correct in that the parentheses aren't
_needed_, but the above is still the same case that in many other
situations parentheses aren't technically *needed*, but not having to
think about it is better than having to do so.

           Linus
