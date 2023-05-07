Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774526F9527
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEGAUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGAUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:20:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D94F5BBA
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 17:20:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so38237238a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683418809; x=1686010809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+tbr/qjfkFIYbs9yJ9ueiFDyXWldF8JA+EZPAiPZV0=;
        b=O79qBSrstEQVM+rAieQu393MIw/haVSKXTYOQB3pElf89AT8GUX3VKYvMSA/+6GVvn
         HI5YQlwCHwNEu4msQRINV0/afdtaOFh/fnCdwGdPvaFS0Z3Ne72XSjjDLn9MUFutLtkX
         M9gtrm/0IEklRPRxZeehdSlFFPg9VGO20KFgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683418809; x=1686010809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+tbr/qjfkFIYbs9yJ9ueiFDyXWldF8JA+EZPAiPZV0=;
        b=bJaiLDJ6DqQnvHWepGc6VfRWuUP6f58PaYppy1R92ozte40F6RAWsjVfvSkE2rvj4V
         o/ojutB5xVBdrz2byn3Tr/WAgdswM2+S060+e+g3JhhHI2mkBRbqWnWtKxKAai2rVv0f
         krf2XOMlBc16wkMDSK8BgcVze+5Zi5WSpO5gMvJ0uLzzUine5e0otmZS2ndHdhtCgEmE
         +YSGB6fvVdVIVgA8fQ4MvjimecUSAeLd//baT7QVlqFyhhMW6P8nHb+0pmR+oBZU0GW3
         y3O3Yxs71ZjzrTrYR2LHpQCVCbINqRTr2HupBeF+Bz9zEKYqvxvjGORtpPjIFvmFLn9V
         9IdQ==
X-Gm-Message-State: AC+VfDytKofaycHMeDTipbyRRFncrOizpI4YWUWYD2jIN3UuFacghuFu
        Srp/tDyQgifuTKUIY4bUTzUhA4MOcSrrBf2OBJ8diQ==
X-Google-Smtp-Source: ACHHUZ5gx+dKeIbWMGg1F+6QevzwweK4zhbHXHjqU4QY456YnmZfRzwZSOCTGtQfhQz1yRQXO1H3Ww==
X-Received: by 2002:a05:6402:2683:b0:504:77ed:5a33 with SMTP id w3-20020a056402268300b0050477ed5a33mr5773310edd.8.1683418808860;
        Sat, 06 May 2023 17:20:08 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7d68c000000b0050bc863d32asm4550774edr.27.2023.05.06.17.20.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 17:20:07 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so38385528a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 17:20:07 -0700 (PDT)
X-Received: by 2002:a17:907:3ea8:b0:953:37d9:282f with SMTP id
 hs40-20020a1709073ea800b0095337d9282fmr5573033ejc.38.1683418807204; Sat, 06
 May 2023 17:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com> <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <ad5b44e17c1c17ebdc581169fec7e80f7ef2a4d4.camel@intel.com>
In-Reply-To: <ad5b44e17c1c17ebdc581169fec7e80f7ef2a4d4.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 17:19:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZjSu7c9sFYZb3q04108stgHff2wfbokGCCgW7riz+8Q@mail.gmail.com>
Message-ID: <CAHk-=wiZjSu7c9sFYZb3q04108stgHff2wfbokGCCgW7riz+8Q@mail.gmail.com>
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

On Sat, May 6, 2023 at 5:10=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> I think I did try something like your suggestion during development. My
> (maybe misguided) concern was that pte_mkwrite_kernel() might not make
> semantic sense for all architectures since not all architectures were
> using pte_mkwrite() on kernel memory.

Yeah, I agree, it's not a great name.

How about just calling it "pte_mkwrite_novma()" instead?

That makes semantic sense for all architectures: it's basically saying
"this is the version of mkwrite that doesn't take a vma".

And then it also makes complete sense to say

    #define pte_mkwrite(vma,pte) pte_mkwrite_novma(pte)

(or the "inline function" version of the same just to make sure the
'vma' argument is evaluated) on the architectures that really don't
care about the vma.

And it also makes sense for the x86 kernel use that doesn't have a vma...

So I think "novma" is more closely related to what the semantics
actually are, and the "kernel" thing is just a "on x86-64, we have
this special case where we don't have vma's and don't worry about
losing the dirty bit".

Hmm?

           Linus
