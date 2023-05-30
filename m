Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA8715284
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 02:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjE3AN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 20:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE3AN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 20:13:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBED8D2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 17:13:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f5685f902so577119766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 17:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685405604; x=1687997604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suYdpofyVku3nNo6ZHkNcqAvkTrrn87SaHmt4Im5vn8=;
        b=VtR/InsXTlu/J2YTZ2ZzEd1jvo7mJJsRueFqUA4F1DRDNmo0nKvJC2DqbDXqhWWg/B
         XdflfH2FqX2SwiHaUpw9wI2Mq/moQ2Euu9RCf6/yjURGyXhB3XFLondG5oZbDPwErcS3
         6dUxfYZtH0aMGELfh253x8ABdApF9Q1hnCxjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685405604; x=1687997604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suYdpofyVku3nNo6ZHkNcqAvkTrrn87SaHmt4Im5vn8=;
        b=hvV+8gS179sjjB2n1pF/Q6USxVsW48Mn8KASLTldoS6JUqp0ahYqJreh/wkaBtZTQx
         /FhwxBP6Z+B5IbDT0SjnggdWyHf1+C/TwoB4wmz/9K0Xs8epiiHGyNgGb8Rs0weIsXSL
         zw34fLyCjcluZEtNw7PtWLhSqejuKYr8AyJkJREk/UfCJvhfRhDPWi61pNDGtLK8i9e5
         wxS8MPXAQHfn+5yeO22wifXVPaHhuwuVVzwBXibdeLJorL9xFDupXQQxFq820fnv3fFV
         /Cp+Ap0UwOTmGyZEJC7XAeHXdE+pRLTI3xZxZj3Nw8JhxAV9WXyJX9SAxYAR/4zozZth
         hDRg==
X-Gm-Message-State: AC+VfDxt04uOrfxelKoya4n//I5HCCcX4NZKQ1DT/dGM+gP7XSZ2xdmv
        t9l7DbQBOKOfCMxsB6+UoyIKzAL43Bw1vEx47k54q7Tl
X-Google-Smtp-Source: ACHHUZ7Kgxg58PugA3GEPKYT0aRyr0voZFaJFVDnQ49vfWc6WQ9uFM0gtMosgshrabgDyICrDo7bBA==
X-Received: by 2002:a17:907:5c3:b0:973:d076:67ab with SMTP id wg3-20020a17090705c300b00973d07667abmr626215ejb.42.1685405604254;
        Mon, 29 May 2023 17:13:24 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906150c00b0097381fe7aaasm6505228ejd.180.2023.05.29.17.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 17:13:24 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so39389145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 17:13:23 -0700 (PDT)
X-Received: by 2002:a17:907:7f16:b0:96f:65db:d6d2 with SMTP id
 qf22-20020a1709077f1600b0096f65dbd6d2mr646581ejc.14.1685405209906; Mon, 29
 May 2023 17:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <CABgObfbhvOnqKQs9r2+3apg0UK3ub03Nf2SfGpe1=NcL9ewSSg@mail.gmail.com>
 <CAHk-=wjF4n=bEk-MDCWmOzyrm_zGsjP4RVkK72S3m4Oppg7F3Q@mail.gmail.com> <CAKOQZ8w_X8GyqE6xg2oY31hYkDWCPnVjLpdOK5Xo4E+ZMdJ9nA@mail.gmail.com>
In-Reply-To: <CAKOQZ8w_X8GyqE6xg2oY31hYkDWCPnVjLpdOK5Xo4E+ZMdJ9nA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 May 2023 20:06:33 -0400
X-Gmail-Original-Message-ID: <CAHk-=whEsr6fuVSdsoNPokLR2fZiGuo_hCLyrS-LCw7hT_N7cQ@mail.gmail.com>
Message-ID: <CAHk-=whEsr6fuVSdsoNPokLR2fZiGuo_hCLyrS-LCw7hT_N7cQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Ian Lance Taylor <iant@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
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

On Mon, May 29, 2023 at 5:27=E2=80=AFPM Ian Lance Taylor <iant@google.com> =
wrote:
>
> It was a while ago, but I expect that I was just thinking of the
> implementation.  I agree that the documentation could be clearer.  I
> filed https://gcc.gnu.org/PR110029.

Thanks. I think we can proceed with the assumption that it's all
clearly ordered. Even when the scopes are explicit (ie actual separate
block scopes for the variables and no shared scope), doing a 'return'
(or break out of a loop) will obviously exit multiple scopes at once,
so it would be good to have it documented that the cleanup is always
in that reverse order by scope and declaration order within a scope.

I guess I should check with the clang people too.

              Linus
