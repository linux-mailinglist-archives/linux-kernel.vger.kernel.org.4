Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E086F4E6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjECBRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjECBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:17:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE6130C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 18:17:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-959a626b622so703225766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 18:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683076655; x=1685668655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1mvst6wmhfXbZKFtQwsozw8V27lcIJVMm9zaAEqwsk=;
        b=XtEPGFtSG802VqzMr62iN+MrLEJs3sZ/Wtgmx58tNtCPVnJ3uT/uzMiAdpzaRVEFpV
         l6px9vXqbxoE/9L6fztrnAiqaGPsYSnT3NwW+D9AZuVE4a7raiGBrklfe9/dIjdRLTBV
         EhW7pOrEUEsHlUn8erMotTwMYqTzWobUNrm8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683076655; x=1685668655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1mvst6wmhfXbZKFtQwsozw8V27lcIJVMm9zaAEqwsk=;
        b=jJJCKtxOq2rxLvI//bVt/Xf0YXywbtE0qascixNeH1wWpHE/NeGFsH1OnEFdjL0gHh
         LOei1DEQ30sFwmrxqW7QsKyMM50SjUyRJKGsjjIokzUVhgWckW/cMDkWnOtsm8mvRrbb
         KdiA0hDOm5VIm25o2h8XIj9Ipx1LpSMv/OtMVZA97engJTZhJCcehYoZISJk4CK/q/Oi
         fyVFXWnstFiOsd95yS5cQauH/5EmNFnuJdugIic1ewhXpiaFwkaNZ8IZfBLySzZaJ+AV
         muQxpS7lJMS6wQwfXdp7oP9nPL1MOYiFzXHumJ51Q75DY+bVLqsq+6mBP5lO+a9pwxYT
         BMYA==
X-Gm-Message-State: AC+VfDw64dFRvbixWSWDBQmrbVugQgCHQsMyAS64xeP7cJyOTHCbFj5/
        IQxZbNd8k7HmJljQFEnBCbR9xiT/LAW0pw0ojLrfVg==
X-Google-Smtp-Source: ACHHUZ4qScxaypmF8Cik71v0sw+VBuhLjxLCi01qyTCc+Awy6lhievAJnq2RFJzTNSlpSBkE2ReOjQ==
X-Received: by 2002:a17:907:98b:b0:94e:e30e:7245 with SMTP id bf11-20020a170907098b00b0094ee30e7245mr1440289ejc.8.1683076655139;
        Tue, 02 May 2023 18:17:35 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id z26-20020a170906715a00b0094f0237c32bsm16481388ejj.208.2023.05.02.18.17.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 18:17:33 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-957dbae98b4so700536366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 18:17:33 -0700 (PDT)
X-Received: by 2002:a17:907:72cb:b0:94e:e092:6eda with SMTP id
 du11-20020a17090772cb00b0094ee0926edamr1662253ejc.53.1683076652773; Tue, 02
 May 2023 18:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com> <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com>
In-Reply-To: <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 May 2023 18:17:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
Message-ID: <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
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

On Tue, May 2, 2023 at 5:53=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> The fallout seems limited to (probably) perf and tracing poking at user
> stack frames.  But, yes, it definitely looks broken there.

So I ended up doing more cleanups - moving the 64-bit specific code to
'uaccess_64.h' etc.

And in the process I found another broken
thing:__untagged_addr_remote() is very very buggy.

The reason?

        long sign =3D addr >> 63;

that does *not* do at all what '__untagged_addr()' does, because while
'sign' is a signed long, 'addr' is an *unsigned* long.

So the actual shift ends up being done as an unsigned shift, and then
just the result is assigned to a signed variable.

End result? 'sign' ends up being 0 for user space (intentional) or 1
for kernel space (not intentional)..

It's not 0 or ~0 as the __untagged_addr() is, wh9ch uses a signed
shift in the inline asm ('sar')

That said, while this is all horribly buggy, I'm not actually 100%
sure that we care too much about untagging kernel addresses. So it's
an error case that doesn't get marked as an error.

So I guess in *practice* the horribly buggy code is actually just a
small harmless bug, and causes anybody who passes in an invalid
(kernel) address look like a possibly valid user address after all.

HOWEVER.

Why does it do that "shift-by-63" game there, instead of making
tlbstate_untag_mask just have bit #63 always set?

Untagging a kernel address is not a sensible operation, so the only
thing you want is to *keep* a kernel address as a bad address. You
don't have to actually keep it a *valid* kernel address, it just
should not become a (possibly valid) user address after untagging.

Hmmm? Am I missing something?

                  Linus
