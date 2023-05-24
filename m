Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288697101AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbjEXXXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEXXXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:23:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E5EA9
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:23:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso3222871a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684970607; x=1687562607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjfvWGxrDOW5fKfb30oP8LD/BgqVeZF9JPPMTcWyoW0=;
        b=PyGvbXNCuLE00GODAd9mW/JkI8NoPtC2g9w0ueTtjeuZD2mm9FaCKV3JZlWbeMOzRj
         Qw0Je89BQ10M7UBitfu86C6+/W3sI+Oc2k13an9qjrcgqMM+SVUUdrx6aUcZBoIbZHmO
         FEaZidIvvcn5mUKRtaxC8t0Oan8KihIQupnG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684970607; x=1687562607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjfvWGxrDOW5fKfb30oP8LD/BgqVeZF9JPPMTcWyoW0=;
        b=Vf9k8D56S7uo6K5KBnxV/DGmX/hA5Pix4Yn/iMN78oqZ+3lnHNELHlY2xqU8lCyKE3
         Yk/32FHfQHOTcGQqyRQe7Kl8kVaVf9Jwk1bjgegYrtYNVxeNvHBqWrZdTtODP9+lIIR2
         KIs5DzUz39LSdRTKkDyj9RTpfexxHzbDB4+fNpZKxJwr4PuIP6YTAd8KcgMFFpeAmeFW
         F1n6O5rUIU9GHkxhhp8Ha+Eo4MPiGEhUn8eB57zlXBSdixwfHRz0V0Eiv1ZKcVfelhDZ
         H/hpAIapaL58vHn3R5oRyx1XNPFsdDawDixCt5lyJD3SnIZ4JRZmoaRkwiJFihMdxyhL
         eVxQ==
X-Gm-Message-State: AC+VfDx8d9JB9zibhqvKXOGFQ6CwaJCdE4oRSaGuKuM6EuS9NmZctl/+
        gDEJHT312j3sDU550HoYwm6q7SDn9ovBdMO45kRLy0WJ
X-Google-Smtp-Source: ACHHUZ4FlWVpY4g7IwOG8a/akkvxsQOvSLPAUn5wJh47QT81njyztZ2rH77EZPaRgNh2B7LymqZ60Q==
X-Received: by 2002:a17:907:7206:b0:96a:e362:fd8c with SMTP id dr6-20020a170907720600b0096ae362fd8cmr16923760ejc.3.1684970607472;
        Wed, 24 May 2023 16:23:27 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b0097073f1ed84sm31551ejp.4.2023.05.24.16.23.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 16:23:26 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-970028cfb6cso281778266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:23:26 -0700 (PDT)
X-Received: by 2002:a17:906:974b:b0:96f:8b64:c0 with SMTP id
 o11-20020a170906974b00b0096f8b6400c0mr20082278ejy.39.1684970605797; Wed, 24
 May 2023 16:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153239.3036507-1-joel@joelfernandes.org> <20230524153239.3036507-2-joel@joelfernandes.org>
In-Reply-To: <20230524153239.3036507-2-joel@joelfernandes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 May 2023 16:23:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNUe7YjK9fmZk+2ZQhjLH-64WrkwnXO9813_iLuaFXuQ@mail.gmail.com>
Message-ID: <CAHk-=wiNUe7YjK9fmZk+2ZQhjLH-64WrkwnXO9813_iLuaFXuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm/mremap: Optimize the start addresses in move_page_tables()
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
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

Hmm. I'm still quite unhappy about your can_align_down().

On Wed, May 24, 2023 at 8:32=E2=80=AFAM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> +       /* If the masked address is within vma, we cannot align the addre=
ss down. */
> +       if (vma->vm_start <=3D addr_masked)
> +               return false;

I don't think this test is right.

The test should not be "is the mapping still there at the point we
aligned down to".

No, the test should be whether there is any part of the mapping below
the point we're starting with:

        if (vma->vm_start < addr_to_align)
                return false;

because we can do the "expand the move down" *only* if it's the
beginning of the vma (because otherwise we'd be moving part of the vma
that precedes the address!)

(Alternatively, just make that "<" be "!=3D" - we're basically saying
that we can expand moving ptes to a pmd boundary *only* if this vma
starts at that point. No?).

> +       cur =3D find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
> +       if (!cur || cur !=3D vma || !prev)
> +               return false;

I've mentioned this test before, and I still find it actively misleading.

First off, the "!cur || cur !=3D vma" test is clearly redundant. We know
'vma' isn't NULL (we just dereferenced it!). So "cur !=3D vma" already
includes the "!cur" test.

So that "!cur" part of the test simply *cannot* be sensible.

And the "!prev" test still makes no sense to me. You tried to explain
it to me earlier, and I clearly didn't get it. It seems actively
wrong. I still think "!prev" should return true.

You seemed to think that "!prev" couldn';t actually happen and would
be a sign of some VM problem, but that doesn't make any sense to me.
Of course !prev can happen - if "vma" is the first vma in the VM and
there is no previous.

It may be *rare*, but I still don't understand why you'd make that
"there is no vma below us" mean "we cannot expand the move below us
because there's something there".

So I continue to think that this test should just be

        if (WARN_ON_ONCE(cur !=3D vma))
                return false;

because if it ever returns something that *isn't* the same as vma,
then we do indeed have serious problems. But that WARN_ON_ONCE() shows
that that's a "cannot happen" thing, not some kind of "if this happens
than don't do it" test.

and then the *real* test  for "can we align down" should just be

        return !prev || prev->vm_end <=3D addr_masked;

Because while I think your code _works_, it really doesn't seem to
make much sense as it stands in your patch. The tests are actively
misleading. No?

                 Linus
