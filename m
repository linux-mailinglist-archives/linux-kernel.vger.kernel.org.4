Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D466EE8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjDYT6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbjDYT6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:58:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7235A13C04
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:58:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94a34a14a54so1160406166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682452710; x=1685044710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmFvEr7UT0kKTHeRCnhl0YaDOUCd72om/F3+jxN9fN8=;
        b=eBZU9icy1IvhZm96iTzUE+oFx80JU5P3k5faPclDa7qJVmMnr5Yl+H35JGAd3hnu3K
         4KOwBPsLrrrDRY8OTdOjYbgCfJUYIUItxy3UXbKtcsMPX8GAldDOUNeefQI0EMopqezD
         Re3Stv+VyTz7YenACdv8yvWi9KtO1JVB8Oa8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682452710; x=1685044710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmFvEr7UT0kKTHeRCnhl0YaDOUCd72om/F3+jxN9fN8=;
        b=bMJjWiDbx8jeGWiqSFPvQcPX1E03ImKAdvkhSYDVBScPL1wUHeIP+i6b6SGulm0Iu4
         YOJRQaxyImsrTvM8b1SjQAxoyfgy2CW8JCeqyJnwBApAMWtOPi4wWLTLn//x+LEbH+PN
         N950Xn5ssOt3G9zOGZFaJsG8fGWGr/9ABDpxtM+0J0OFv78gPmTnGGCHGbdz+oRvaRYf
         n9FcPQ+besWA3BO/b/QxJJxVEm/U/3VUEVNRsSVlT/JquiupjuIzHBxNnJ1HDnEy3J4+
         FG5QV+G8Q2Ks+8+C6rDe9NzEVNNl2j4EClrq+RMqP24DbudP+KGee1UyPFNhLZ0pgpAn
         s2MA==
X-Gm-Message-State: AAQBX9fQ0O4zjWEteFAxfvvGdnxiLeWdXG304y4/3nIXyekFHFXKNTeC
        JLOsfTurOiCfNF2BDObatOrvYFra7BDFhA6U4nCu3w==
X-Google-Smtp-Source: AKy350b7Bj6CBun5qkxjuZRsje9PzutiOPPDuaJd/et54PAnn5dK71cycAL6Zq5O1lP7Lx3Ddqc6Dg==
X-Received: by 2002:a17:906:cf89:b0:94a:6a7a:52d8 with SMTP id um9-20020a170906cf8900b0094a6a7a52d8mr14565261ejb.71.1682452710657;
        Tue, 25 Apr 2023 12:58:30 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id bv7-20020a170907934700b00959c6cb82basm2228768ejc.105.2023.04.25.12.58.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:58:29 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso11104432a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:58:29 -0700 (PDT)
X-Received: by 2002:a50:ee83:0:b0:4fe:19cb:4788 with SMTP id
 f3-20020a50ee83000000b004fe19cb4788mr15857790edr.42.1682452709422; Tue, 25
 Apr 2023 12:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk> <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk> <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
 <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
 <CAHk-=wjSuGTLrmygUSNh==u81iWUtVzJ5GNSz0A-jbr4WGoZyw@mail.gmail.com> <20230425194910.GA1350354@hirez.programming.kicks-ass.net>
In-Reply-To: <20230425194910.GA1350354@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 12:58:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
Message-ID: <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
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

On Tue, Apr 25, 2023 at 12:49=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> The last time this came up I shared your view however Mark argued for
> the READ_ONCE() thusly:
>
>   https://lore.kernel.org/all/Y71LoCIl+IFdy9D8@FVFF77S0Q05N/T/#u

Hmm.

Yes, I think Mark is right. It's not that 'old' might be wrong - that
doesn't matter because cmpxchg will work it out - it's just that 'new'
might not be consistent with the old value we then use.

Ok. I'll try to remember this, but maybe it might be worth documenting.

Jens - I don't think this actually matters for the f_mode value issue,
since the only thing that might change is that FMODE_NOWAIT bit, but I
was clearly wrong on READ_ONCE(). So that loop should have it, just to
have the right pattern after all.

My bad.

             Linus
