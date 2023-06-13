Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7448C72EA3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjFMRwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFMRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:52:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE97AA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:52:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977d6aa3758so1027778966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686678731; x=1689270731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcOW2YayMm3xjw1cJ1qlGpr/UGWPmxOrQJ2QJLZKMzE=;
        b=dP5DXlDYSrraxxFtQyF+hVZ1fmEi81oJkvt7PhTgPnLwMsbYHfwMgend+XfBg4MKfU
         zN56wIuL6cCPFmEYsc1fjn73I/lAva+dOIIiZHwNT8hAm2gqdLSnQ1eF+UJIIc7do710
         MhpjqQcMzLhl1Sp+ii1rFRNgLQ8f7kUsOBV6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678731; x=1689270731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcOW2YayMm3xjw1cJ1qlGpr/UGWPmxOrQJ2QJLZKMzE=;
        b=BgTCPbT9JSdYWGBjYDcAVy0f2jYzWWLp9M+gtc01axbFbmwMwMQc9RmcahoX3tImQR
         tHADWMZ9u8vdtXabaE3yzCopcwJjEbrJI7mLln+qpSD+9Lj0pb4b+1JE3RgzP/PHWubq
         XSWIScZiea0UVvfMixd14+zBKmdb2S3YVlF/eLR15HVl3IPw98DP4GQxZ0u9rFvr2yCx
         C5+KBQ6TzWIiUwlG1LccTorf8y48VcxQ1yi1MwZ3udFn9wFQT45he/Z7+l/15rtyqqp0
         ++edKdHkRe2xIbXgXYS9TD8LnB010mjNcFPi2zDtPikZcSxOQ6spEdUPhJGGtCQ4Msb3
         199w==
X-Gm-Message-State: AC+VfDzDncwgxaW+6Gp0ircR1NtZW235y1+8mH5Pl2ZZEzGSfTORr9Ts
        VNanugfKfTKxT35sMum4Ta2wYUT9KO03FcBEifzz2Zxt
X-Google-Smtp-Source: ACHHUZ60yxv1uB88Y8zLPAPNp0Hrpm0XkWvvLp9ovYowII9aB2b14+xyTIlB4QwhKI3lbAeQzSVqkQ==
X-Received: by 2002:a17:906:d54b:b0:978:94b1:25ac with SMTP id cr11-20020a170906d54b00b0097894b125acmr16344366ejc.40.1686678731358;
        Tue, 13 Jun 2023 10:52:11 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id q13-20020a1709064c8d00b0095fbb1b72c2sm6989087eju.63.2023.06.13.10.52.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:52:11 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-970028cfb6cso1027337366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:52:10 -0700 (PDT)
X-Received: by 2002:a05:6512:548:b0:4ef:ec6a:198c with SMTP id
 h8-20020a056512054800b004efec6a198cmr6103911lfl.26.1686678301549; Tue, 13 Jun
 2023 10:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com> <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com>
In-Reply-To: <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 10:44:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
Message-ID: <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/42] Shadow stacks for userspace
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
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

On Mon, Jun 12, 2023 at 8:12=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> Sure. I probably should have included that upfront. Here is a github
> repo:
> https://github.com/rpedgeco/linux/tree/user_shstk_v9
>
> I went ahead and included the tags[0] from last time in case that's
> useful, but unfortunately the github web interface is not very
> conducive to viewing the tag-based segmentation of the series. If
> having it in a korg repo would be useful, please let me know.

Oh, kernel.org vs github doesn't matter. I'm not actually merging this
yet, I'm just doing a fetch to then easily be able to look at it
locally in different formats.

I tend to like seeing small things in my MUA just because then I don't
switch back-and-forth between reading email and some gitk workflow,
and it is easy to just scan through the series and reply all inthe
MUA.

But when it's some bigger piece, just doing a "git fetch" and then
being able to dissect it locally is really convenient.

Having worked with patches for three decades, I can read diffs in my
sleep - but it's still quite useful to say "give me the patches just
for *this* file" to just see how some specific area changed without
having to look at the other parts.

Or for example, that whole pte_mkwrite -> pte_mkwrite_novma patch is
much denser and more legible with color-coding and the --word-diff.

Anyway, I'm scanning through it right now. No comments yet, I only
just got started.

              Linus
