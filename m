Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A346EE911
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjDYU3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjDYU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:29:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45877146C1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:29:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f7a7a3351so1178881666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682454583; x=1685046583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OoYLtgXDECRIcYzlRafhWyTnCuP0UwAEGivrVP3VPE=;
        b=T4rl6c9hcqkyEw6xTUeEuUj2PmjQ3ZvQCtyBg8II39A6yyuB8H7zRZ5Mp35nYlU1Vr
         t/bd7hoSsem7i4X0IRnL7ZbuPiNgi5Sd4lXJE0QPp3tBJhdVTSMcca5p5rXmZrCbi4ED
         fHzylIxiqVluhUXLDwYPlDSml/QLuuicAVHHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682454583; x=1685046583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OoYLtgXDECRIcYzlRafhWyTnCuP0UwAEGivrVP3VPE=;
        b=jQakaE9Vw9Wr/1AzclopdAcpO0MG5PFNGLQITUBpUdE1HpH41MVocaxDumuVfO1NR2
         yxVRUi8Ekno5jSCeGVuvi3RPxmeo/AS5oZCu5N0CV5OTLQX8vH8J/N7ReIAG6EjMjO8v
         y3v/BzMCwACTivZM9O1sx6H6h7TTbDKpxju3x6idZR4iXBAq/8Jocw4To7EkNibWOMbj
         vNUVhmAnJsyeOEv+TO1vGs9YzNcFTKptDAhh6s0TTe4nHhGvyWuEL/AyhLTKFHnYtRZy
         pGt8MtdOqANmowvsy/GFmvy3Mzd+LaRA0bgesS0Fee9tJ2+6K9gdTmAVlZQp9QppPOFt
         6jHA==
X-Gm-Message-State: AAQBX9dFJypTicJ6WivB6XeNmHjFHVrQKhOkClxRoBNDuiw4d8nG9B2a
        JullPQTzAv6FIEt4Me+YQ+W+KNGkjY2uwIuvfEQ/zw==
X-Google-Smtp-Source: AKy350YH3ch4sx5zP9g3p/kYfVfU5i2wUclek5I3hrMUa+y/ZgvFtFWUSsLlWZIlDlKA+WLmEH3KvQ==
X-Received: by 2002:a17:906:4fca:b0:958:4870:8d09 with SMTP id i10-20020a1709064fca00b0095848708d09mr11911846ejw.37.1682454583500;
        Tue, 25 Apr 2023 13:29:43 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id fh22-20020a1709073a9600b0094efc389980sm7137111ejc.58.2023.04.25.13.29.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 13:29:43 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-506bfe81303so10578778a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:29:42 -0700 (PDT)
X-Received: by 2002:aa7:da41:0:b0:506:8660:77a3 with SMTP id
 w1-20020aa7da41000000b00506866077a3mr17103894eds.37.1682454582655; Tue, 25
 Apr 2023 13:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk> <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk> <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
 <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
 <CAHk-=wjSuGTLrmygUSNh==u81iWUtVzJ5GNSz0A-jbr4WGoZyw@mail.gmail.com>
 <20230425194910.GA1350354@hirez.programming.kicks-ass.net> <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
In-Reply-To: <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 13:29:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVi5U_DF2Y+fnBuy=RH9OKfK7-MRmpnuZP2wmCdNCqYw@mail.gmail.com>
Message-ID: <CAHk-=wjVi5U_DF2Y+fnBuy=RH9OKfK7-MRmpnuZP2wmCdNCqYw@mail.gmail.com>
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

On Tue, Apr 25, 2023 at 12:58=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok. I'll try to remember this, but maybe it might be worth documenting.

We might document it by just making it clear that it's not that we
want to read it "once", it's that we want to have a stable value.

There might be other situations where that is all we want.

IOW, maybe we could have something like

  #define READ_STABLE(x) \
      ({ __auto_type __val =3D (x); OPTIMIZER_HIDE_VAR(__val); __val; })

instead - although from a quick look, the code generation is pretty
much exactly the same.

I dunno. Just throwing that idea out there as a "if reading _once_
isn't the issue, maybe we shouldn't make the code look like it is"...

                Linus
