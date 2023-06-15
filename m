Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7E7323F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjFOX6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjFOX6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:58:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6442707
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:58:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so2699775a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686873489; x=1689465489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsldixVoPkFu+sgLKcb7381mh1dpFejnHhZ3xNKtZcQ=;
        b=n8PCX3kXLm6H3l19sc/u529LfXwDjnAMgO68h3K/w/KEVnoo2OZfWBgb6laG/bCtRL
         neTMaBJYJf27dn4xIYGy+ng9pm68btbX2cb1tYHZWGm9vPckpg6xBKXJxnnaT4ZBfZ+F
         EGH5/TyGK7p1BPW6tl5thLq8OVyuZVHqUIbxGVo3XZuBHsXljMaqlU399ZER4oUlZsNM
         6L8VmVaiDmE3hFzH0NyPZ/srVlTcYtimcF5KQEFOptm1eotB575wYPLKCMDaBg97Kc8a
         KT/a5C5wVzXQbi6XJzsv+AQDBy6rtnnPtU2HId4htWaBvu0I64qnH5il6eE0gITBDtg7
         mhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686873489; x=1689465489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsldixVoPkFu+sgLKcb7381mh1dpFejnHhZ3xNKtZcQ=;
        b=iXMeMxSGYBsSmOQ2/Vw14QTvfLkXxN7KGd6Oxql6GhpGWkMIG3YO4o7RestzzpWyKw
         g+OwHPScpAWUT6UINF3ohyI/MflETR78kXEAKQu80Pjnpm91K66oxsDHznyFlhpmPIqk
         CSaEj2VapRjKyks7glGCuiCNGLXiQGCr3FDmwEhsiulbtUlpS4GygAbYo8Cwour797G0
         YvN1HxjIFlsMC5gwhRUUudoWv3lGyFHpwLAHwt3/gUXbwXAtXDMRqKc8nkiLqMKjSDwz
         kCfMmzmkN90fJpSW3WZF6S1x8NmPjijSGH4smwlN/e1qTkIVtY+B5zHha4Y7pDNzM46l
         bbwA==
X-Gm-Message-State: AC+VfDyMaQ5lj8jJbAfvstxQv8fy3pa8jj64ZL3eEbSi3aU6p45V4zjV
        symKLws5nlda6O9URILXsD+LSicXl4Eq24MAec3eGfmK5VD3MFn/7x4=
X-Google-Smtp-Source: ACHHUZ4QsuHjhAitOniaTHjnM44zbN1Ghan/CjtEQSQ6qzjTXG666XLScBY720A7tP4JQAj9EIOOTyhpb85UqOxqu7Q=
X-Received: by 2002:a17:907:802:b0:974:fb94:8067 with SMTP id
 wv2-20020a170907080200b00974fb948067mr6126517ejb.23.1686873489622; Thu, 15
 Jun 2023 16:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230605004334.1930091-1-mizhang@google.com> <CALMp9eSQgcKd=SN4q2QRYbveKoayKzuYEQPM0Xu+FgQ_Mja8-g@mail.gmail.com>
 <CAL715WJowYL=W40SWmtPoz1F9WVBFDG7TQwbsV2Bwf9-cS77=Q@mail.gmail.com>
 <ZH4ofuj0qvKNO9Bz@google.com> <CAL715WKtsC=93Nqr7QJZxspWzF04_CLqN3FUxUaqTHWFRUrwBA@mail.gmail.com>
 <ZH+8GafaNLYPvTJI@google.com> <CAL715WJ1rHS9ORR2ttyAw+idqbaLnOhLveUhW8f4tB9o+ZsuiQ@mail.gmail.com>
 <ZH/PKMmWWgJQdcJQ@google.com>
In-Reply-To: <ZH/PKMmWWgJQdcJQ@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Thu, 15 Jun 2023 16:57:33 -0700
Message-ID: <CAL715W+KSgNMk+kTt3=B-CgxTkToH6xmvHWvVmm3V+hir-jE=g@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Remove KVM MMU write lock when accessing indirect_shadow_pages
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 5:28=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Jun 06, 2023, Mingwei Zhang wrote:
> > > > Hmm. I agree with both points above, but below, the change seems to=
o
> > > > heavyweight. smp_wb() is a mfence(), i.e., serializing all
> > > > loads/stores before the instruction. Doing that for every shadow pa=
ge
> > > > creation and destruction seems a lot.
> > >
> > > No, the smp_*b() variants are just compiler barriers on x86.
> >
> > hmm, it is a "lock addl" now for smp_mb(). Check this: 450cbdd0125c
> > ("locking/x86: Use LOCK ADD for smp_mb() instead of MFENCE")
> >
> > So this means smp_mb() is not a free lunch and we need to be a little
> > bit careful.
>
> Oh, those sneaky macros.  x86 #defines __smp_mb(), not the outer helper. =
 I'll
> take a closer look before posting to see if there's a way to avoid the ru=
ntime
> barrier.

Checked again, I think using smp_wmb() and smp_rmb() should be fine as
those are just compiler barriers. We don't need a full barrier here.

Thanks.
-Mingwei
