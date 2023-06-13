Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15C772EA84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjFMSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFMSH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:07:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB219A8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:07:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977c8423dccso1410582066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686679675; x=1689271675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU2BO0gcHFt44DuEFTAO2c7xYdpyPStn/nzoWP1HBD4=;
        b=Z5sP+QZ71FBX3/tK+KshnZukL+WEok4WwOnViMn1wPHls9l5Yf3T3jg9POJJpz9LZ2
         tfjAWU3JQKDiY+0a9d2OR8bNL9DL82/7jPJQzpi/n8TLYZoZgtjDvEsUDEPH9XvQuz0E
         7NoNaICSfC9SIZPAGLJsFqsk6AFNvDHw1PYzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679675; x=1689271675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU2BO0gcHFt44DuEFTAO2c7xYdpyPStn/nzoWP1HBD4=;
        b=JVKJ9SbxQk+21xuwCbr6DdhlFByMZvzELTnMrUIoEBRgIm1URRfxBwlnHoKrrpSTl2
         gu2xfz8KGNhQSR0fQi6JlduoW7mMGVJogWC5i/YFGvzmXHyD2FleDbfUfOJtNwvlc9Kr
         g0vm1IaEW9RI+xJQCa26q7E789e3pjauoeQqNo5i4jxES1jHoN9vA90s6A7LlpI4kVPD
         S17dcUxZMvhdvDjGaovF9NjwZaMg5DDqEFmGS8hh7RJtBMTG+dElgy574U6b9qSUlVeu
         +k9KD3OpkX0eARxYkVvzcAWLOa3tYWsF9oKVttvU7obpCqwtKz72lW1kvKCZeXnv6lO7
         0D2Q==
X-Gm-Message-State: AC+VfDxZoAvNcQIkCJIVktzAYFm0F72beCe/tv8gYiM+KOSS4mOcEkwX
        AXYyG1G0fcI1gDWHgysWebKiVujAvzuhxca8GC0+RRNI
X-Google-Smtp-Source: ACHHUZ4KdKpiyNCM+Z2LLjnfRyxIq2wQ7ivx8eFOvnewYvt8A1fG+ior9ffG1Rkpu/hKzEA59EHISA==
X-Received: by 2002:a17:907:8a17:b0:94e:4b26:233c with SMTP id sc23-20020a1709078a1700b0094e4b26233cmr13034197ejc.16.1686679675059;
        Tue, 13 Jun 2023 11:07:55 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id dc22-20020a170906c7d600b009823dfab592sm1173097ejb.137.2023.06.13.11.07.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:07:54 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5169f920a9dso11910496a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:07:54 -0700 (PDT)
X-Received: by 2002:a17:907:7d92:b0:969:9c0c:4c97 with SMTP id
 oz18-20020a1709077d9200b009699c0c4c97mr13719822ejc.1.1686679279617; Tue, 13
 Jun 2023 11:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com> <20230613001108.3040476-12-rick.p.edgecombe@intel.com>
In-Reply-To: <20230613001108.3040476-12-rick.p.edgecombe@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 11:01:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-PfXhVb7Atk+G8SNjFSvqDWu37KPFR-ssuM-j_o93Kg@mail.gmail.com>
Message-ID: <CAHk-=wh-PfXhVb7Atk+G8SNjFSvqDWu37KPFR-ssuM-j_o93Kg@mail.gmail.com>
Subject: Re: [PATCH v9 11/42] x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        broonie@kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
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

On Mon, Jun 12, 2023 at 5:14=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1189,7 +1189,17 @@ static inline pte_t ptep_get_and_clear_full(struct=
 mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>                                       unsigned long addr, pte_t *ptep)
>  {
> -       clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> +       /*
> +        * Avoid accidentally creating shadow stack PTEs
> +        * (Write=3D0,Dirty=3D1).  Use cmpxchg() to prevent races with
> +        * the hardware setting Dirty=3D1.
> +        */
> +       pte_t old_pte, new_pte;
> +
> +       old_pte =3D READ_ONCE(*ptep);
> +       do {
> +               new_pte =3D pte_wrprotect(old_pte);
> +       } while (!try_cmpxchg((long *)&ptep->pte, (long *)&old_pte, *(lon=
g *)&new_pte));
>  }

Thanks. Much nicer with this all being done just one way and no need
for ifdeffery on config options and runtime static branches.

                  Linus
