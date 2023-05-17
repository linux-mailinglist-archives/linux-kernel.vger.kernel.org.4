Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEA3705DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjEQDEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjEQDD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:03:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18949FC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:03:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso450654a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684292608; x=1686884608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQC84bjg5veEkaq5Nnh/MZ6+IOv+WPa/0t9irvzCFqA=;
        b=gj4J4tXNFizhNQB/HoengzmVIQXJSFw4abMjN/yA0HJfTXudNTk3BX/b7D2efAx9ZJ
         Gdaz4BmOqUYa/csf1ugtVdGcRRFUI/kSpTe7Caq0rwhwBhzRG0vIjMA09uEaDIvx7j2h
         pBR5EEvj8SHJoQGU9cKoodwuUaxVvRy7vby6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292608; x=1686884608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQC84bjg5veEkaq5Nnh/MZ6+IOv+WPa/0t9irvzCFqA=;
        b=hcLOAeQ3iV7bG8wkRXXTfwYVVrSCJAvtfBUjD/ptiHXk91FS2m7yzLIj3WiKtqeaE2
         LiZSGw7SUr5KqXU6Ujf3zGEOXEBROQSLeLHD/+k9Vg4dut/ojSRlwh6b9hgRDFS1UwaW
         rnK3TATCy3xmyPlVvtPhKkEZ+h3vgeblUyMdofxqGS2pLY/fdPPryoVgZo/D9TbjkHa7
         A/eMNhqLzGJGvAYh7DvF5uI7tdisaYX9UjTbOvxwaJrL+DhEGvPgvhTsgrM2lC/TdivN
         QaD2j3q+FSmauQFgA2kzSDtVH9y0ZqD6yzJDYb83Obl5url6zOk4SYQsRH3xDTFYGN+A
         C0sA==
X-Gm-Message-State: AC+VfDxBmhRWe4x+rP3aWoKJ7IsXc+GnQ6p2ngYdKxOuflIRU/sbBs4C
        OLZigfvKMys1IalPSSU4u7CcU5ZyZ0TwN0VFC86VK/Nb
X-Google-Smtp-Source: ACHHUZ4pwkHO7SKRHngBtG2fBI0+1saLRB6GA+tmDFi2o8/AKjO6oZaiD2v86g1Ad8jJKKagvnperQ==
X-Received: by 2002:a17:906:9b8f:b0:96a:6c3:5e72 with SMTP id dd15-20020a1709069b8f00b0096a06c35e72mr25824245ejc.10.1684292607865;
        Tue, 16 May 2023 20:03:27 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id y10-20020a170906914a00b009663cf5dc3bsm11510502ejw.53.2023.05.16.20.03.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 20:03:27 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-965a68abfd4so31577066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:03:26 -0700 (PDT)
X-Received: by 2002:a17:907:6d15:b0:96a:bfc:7335 with SMTP id
 sa21-20020a1709076d1500b0096a0bfc7335mr23923089ejc.53.1684292606486; Tue, 16
 May 2023 20:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com> <20230516222919.79bba667@rorschach.local.home>
In-Reply-To: <20230516222919.79bba667@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2023 20:03:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
Message-ID: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 7:29=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> So this code path is very much in user context (called directly by a
> write system call). The issue that Alexei had was that it's also in an
> rcu_read_lock() section.
>
> I wonder if this all goes away if we switch to SRCU?

Yes, SRCU context would work.

That said, how critical is this code? Because honestly, the *sanest*
thing to do is to just hold the lock that actually protects the list,
not try to walk the list in any RCU mode.

And as far as I can tell, that's the 'event_mutex', which is already held.

RCU walking of a list is only meaningful when the walk doesn't need
the lock that guarantees the list integrity.

But *modification* of a RCU-protected list still requires locking, and
from a very cursory look, it really looks like 'event_mutex' is
already the lock that protects the list.

So the whole use of RCU during the list walking there in
user_event_enabler_update() _seems_ pointless. You hold event_mutex -
user_event_enabler_write() that is called in the loop already has a
lockdep assert to that effect.

So what is it that could even race and change the list that is the
cause of that rcu-ness?

Other code in that file happily just does

        mutex_lock(&event_mutex);

        list_for_each_entry_safe(enabler, next, &mm->enablers, link)

with no RCU anywhere. Why does user_event_enabler_update() not do that?

Oh, and even those other loops are a bit strange. Why do they use the
"_safe" variant, even when they just traverse the list without
changing it? Look at user_event_enabler_exists(), for example.

I must really be missing something. That code is confusing. Or I am
very confused.

            Linus
