Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2339C6F964E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjEGAok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjEGAoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:44:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C532ABD9
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 17:39:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so6166042a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 17:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683419919; x=1686011919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oefhNWACgbXm60OpHlDQ3iOhZA3LWhd0ouQCK/fPjo=;
        b=bOH9N5ucrIgjyq9SGDKf7JSrvIlZAzP3jzq2lj/HxJZlk9C83NUy4oRcY6BCV9Ykhv
         ABJHGffn89ueoDxyP0c9MHByE73rE+Haf6JhvXDSlEhlPTeu5jn0jjAJ+abKLuPffuhd
         ilFK1tfFbRIklQ3cxXPM1VlLOVcNwJxfmFG2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683419919; x=1686011919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oefhNWACgbXm60OpHlDQ3iOhZA3LWhd0ouQCK/fPjo=;
        b=BPd0/2pKusV39wVPN2bw3TxqvTYpQBtYbYhezeuez4Nl2wKjZ8rZAkzKULYor22num
         ZBUiACRSuIRwHpZxtD7mx4p4XZ5EIoHwD0Z5HRjN7PsFaA4t6ItwfcW1rcEfl1gEM+SA
         mAZrSuov3e6Bz8ttFuZGyocMDgmAXtKeq+ju1QtlB6bGs5PZIZJS5i3/JXH6Bf9S/P2c
         MN890MH0gTSFY//mT696kNEVjmTFFubSK+jAwJi/ebOPHPWVMsTDxhuZ7c4OU/5Qo1wZ
         Wlfg4k8eCSsc8kU3SQatjcaYo6945mMGSP0jBOwE/YK4fQfPUK4nmUTjErExn9tnGVaf
         dt3Q==
X-Gm-Message-State: AC+VfDxGQ7goUwHITYjC9tOQVZmMODV4yLQrRcTjFrfWe4ylVb5wDfAZ
        xpNYbQaf6DULyHsjzA8iCjqghZWDrjBuz0LR9d7njg==
X-Google-Smtp-Source: ACHHUZ5UO8AVgO2mZkzqDnu2dumLvQMbf0F2tj1SWwmpfnzeQpnKOr6Mr5ZoalcO/0+ZgjfOmbnAtw==
X-Received: by 2002:aa7:c059:0:b0:50d:9b57:842a with SMTP id k25-20020aa7c059000000b0050d9b57842amr77588edo.9.1683419919310;
        Sat, 06 May 2023 17:38:39 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402014300b0050d83a39e6fsm1658198edu.4.2023.05.06.17.38.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 17:38:38 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-956ff2399c9so592862966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 17:38:38 -0700 (PDT)
X-Received: by 2002:a17:907:94d1:b0:959:9d8d:e992 with SMTP id
 dn17-20020a17090794d100b009599d8de992mr5804253ejc.8.1683419917753; Sat, 06
 May 2023 17:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com> <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com> <085834410eb66433c414f2b81589d45edf1eaf3b.camel@intel.com>
In-Reply-To: <085834410eb66433c414f2b81589d45edf1eaf3b.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 17:38:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCM+o1vm4pS_9=1E9XkOn6c1jiiKLJS2710ncEL+43tQ@mail.gmail.com>
Message-ID: <CAHk-=wgCM+o1vm4pS_9=1E9XkOn6c1jiiKLJS2710ncEL+43tQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
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

On Sat, May 6, 2023 at 5:18=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Sat, 2023-05-06 at 13:09 -0700, Linus Torvalds wrote:
> > >
> > >  (b) "pte_dirty()" isn't even the right thing to use, since it
> > > includes the SW dirty bit.
>
> pte_dirty() actually doesn't check the the SW dirty bit

It really does.

See commit "x86/mm: Start actually marking _PAGE_SAVED_DIRTY", where
the patch is:

  -static inline int pte_dirty(pte_t pte)
  +static inline bool pte_dirty(pte_t pte)
   {
  -     return pte_flags(pte) & _PAGE_DIRTY;
  +     return pte_flags(pte) & _PAGE_DIRTY_BITS;
   }

and that  _PAGE_DIRTY_BITS is a combination of _PAGE_DIRTY | _PAGE_SAVED_DI=
RTY.

So that means that the

        if (pte_dirty(pte))
                pte =3D pte_mksaveddirty(pte);

in pte_wrprotect() is just nonsensical, and basically says "if either
the real dirty or the SW dirty bit is set, set the SW dirty bit". But
that's entirely redundant wrt the old state of the dirty bit.

It reality should just 'or' the HW dirty bit into the SW dirty bit and
be done with it.

Of course, maybe I confused the issue by talking about HW dirty and SW
dirty, because we *also* have that entirely *other* legacy
"SOFT_DIRTY" bit that is different from the new SW dirty bit
("SAVED_DIRTY").

Which certainly doesn't make things clearer.  The "soft" in the soft
dirty bit isn't about software, (although it's obviously done *in*
software), it's literally "soft" not as in software, but as in just
"not a hard bit": you can clear it for tracking which pages people
write to.

So we end up with two bits that are maintained by software: SOFT and
SAVED, and then it's really easy to just call the "SAVED" bit the "SW
dirty" bit as I did as opposed to the "HW dirty" bit, because it
really is a secondary very of the *hard* HW dirty bit.

I have this fleeting suspicion that we could actually merge the SOFT
and SAVED bits, in that the "SOFT" bit doesn't make much sense if the
pte is read-only, and the SAVED bit in turn doesn't matter if the pte
is RW.

But that's a separate headache, not worth worrying about now.

           Linus
