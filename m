Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F5F70C599
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjEVS65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEVS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:58:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08175DB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:58:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51190fd46c3so5844017a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684781931; x=1687373931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr44La27+mz8n+82Zo9X1oKc2Ak0g3wj0ym86181XGQ=;
        b=d6wu2CS/ecLYXBnJBfDH1lUT5tTEOEzfCr5tOvBDmpNQsOkpSvI70tpEjPz8LkymtN
         hljLXHExNHKPt5q95akj52UpRDs45iwOy/KmLHZvAN5EeVJNsxXHopj5zAW6y9nclMuP
         53cSo3rM1RThCAQqDfsp101httIx/DUYg71Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684781931; x=1687373931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr44La27+mz8n+82Zo9X1oKc2Ak0g3wj0ym86181XGQ=;
        b=ggdYWvetO8cHLM3/R+PHoOKg42Xvufsl2ThRoxc9CGIF/jEZCXo1CZ2qcYlq/X63Gj
         Ci7oXNSyopnpeL59KHYuWExA9r/SVCaSpgPGnGtkhtv87Eniu6qTkM126Av/F0E2orFQ
         PTpzVfMCz0yPmETBjyRtNoiUuiz+cMRzagXqIMAWis5stI6uD/oBRBMSVmkXtqMEghEw
         xm2kQSeeYieioKPCVehr26JiLjBN9K8IjGb+ed5g1UcFeDnsKHfYOZz78N+/q6C98sCn
         QASM6mOTd2MAfY8o6BIA1Ej2V9foI4XOLKusK9tCtCsYEG4K9G9hkp5SOSje5oYRD2qm
         2SdQ==
X-Gm-Message-State: AC+VfDzRRbAZrTX3mTiF1UB2pZXBBYLj4jwuTwxSolK6WtbIPvyYdJMx
        yCDWfr8Q+7sUQ2uhIcOup28e00w/odaV9dXq7j3SxeAy
X-Google-Smtp-Source: ACHHUZ6PAgYlsdfxPvOfK7/spZcsAQVtE6kDBssJHgM0+cMlji0Pkx5klWvTLF9LSw+p1cFwfVwE0w==
X-Received: by 2002:aa7:d4c3:0:b0:50b:c584:527b with SMTP id t3-20020aa7d4c3000000b0050bc584527bmr8516425edr.29.1684781931200;
        Mon, 22 May 2023 11:58:51 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id l4-20020a50d6c4000000b00510de087302sm3398248edj.47.2023.05.22.11.58.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 11:58:50 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-970056276acso161051166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:58:50 -0700 (PDT)
X-Received: by 2002:a17:907:628c:b0:96a:6e42:712b with SMTP id
 nd12-20020a170907628c00b0096a6e42712bmr11877487ejc.18.1684781929922; Mon, 22
 May 2023 11:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230522171314.1953699-1-kent.overstreet@linux.dev>
In-Reply-To: <20230522171314.1953699-1-kent.overstreet@linux.dev>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 11:58:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3vkmsiEDF=kYSAV2f1e1B6J6L-oikmdik6p_kBq_dhg@mail.gmail.com>
Message-ID: <CAHk-=wi3vkmsiEDF=kYSAV2f1e1B6J6L-oikmdik6p_kBq_dhg@mail.gmail.com>
Subject: Re: [PATCH v2] locking: SIX locks (shared/intent/exclusive)
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
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

On Mon, May 22, 2023 at 10:13=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>

> +static inline unsigned u32_mask_to_ulong_bitnr(u32 mask)
> +{
> +       union ulong_u32 {
> +               u32     v32;
> +               ulong   vlong;
> +       } v =3D { .v32 =3D mask };
> +
> +       return ilog2(v.vlong);

No, this is still wrong.

The above is actively undefined - the high bits of 'vlong' can contain
random garbage. And you can't even fix it anyway, because even if you
add a second 32-bit word and zero it, on big-endian architectures
you'll get a result that is bigger than 32, and then when you do
this:L

> +static inline void six_set_bitmask(struct six_lock *lock, u32 mask)
> +{
> +       unsigned bitnr =3D u32_mask_to_ulong_bitnr(mask);
> +
> +       if (!test_bit(bitnr, (unsigned long *) &lock->state))
> +               set_bit(bitnr, (unsigned long *) &lock->state);

you're back to basically just undefined behaviour.

You *cannot* do "set_bit()" on a u32. It's that simple. Stop trying to
do it with these wrappers that happen to work on x86 but are
fundamentally broken.

We don't do locking by playing games like this. It's wrong.

You clearly don't even want the return value, so you're actually much
better off just using an atomic_t and "atomic_or()", I suspect.

But these broken games with casting pointers to invalid types MUST END.

Locking is subtle enough without doing clearly bogus things that
depend on byte order and word size, and that aren't defined for the
type you want to use.

            Linus
