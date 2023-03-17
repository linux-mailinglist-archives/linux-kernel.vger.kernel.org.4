Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A906BEF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjCQRWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCQRWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:22:43 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B035EDC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:22:10 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b5so2627661iow.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679073725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yieuB07RXsRpgLR6n15FdRIxUfXhtg7ChhJcPd+fr8c=;
        b=VbatxW0HW7qexAUUlZAqZnYTUyDsuc2x0Yih95dYePd2KKUMJO2MtjT5RucUo6LjPs
         8pDvWzdDL0y9y4qIoH9tFxY06QJvwqFCbtXM6X8oLz/wvB4WZu+VBR6+VvqVGRcCS/aZ
         jn+O4lQjBcdv6AHIH/c+ADrb7sfTROFrxFTT4Zup88iY8GtJLeHDk2yvViJhsTYvHE4X
         h8gmRzrcbk4cSBixtX8QFxdy3nd9wbf7e8+UF7p7OpHY5RG56KvJ6X/3Z8Y3aoQcrJmz
         6MmyT5wbPSrdkBt30zXnDXvHg9SDmgrraBuXM+KJwn/pdiGWCF97B6F8aV0uAgLmHKR8
         N1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679073725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yieuB07RXsRpgLR6n15FdRIxUfXhtg7ChhJcPd+fr8c=;
        b=X9d1z9MEvPZZyBajSQnY/eDPbD46UqI17X2JUHKzMR3MkvgzcvZ11dRlgs1gCNWC9d
         WZikT4wdiRRL3ZtSk6JGdKnB1LFz0iBboy/ZmCMf/UEJgrcBBr/UrkjqvywnUx5ieaFd
         LzUBZgLzGrtwGWI3RyjPUePEqfgmvqNlGTBax5JF/maiD6XH3VOV/VDeCeki/M8So+X8
         ha5Rf0AaRXYP3d4QtsMUsSFyo3oObt/VKpxYaVANMviigOhh5fFoNrmFymSj3j3SkouB
         bdNpLGZ7mmL8pRl3RDc7uB/y00iFw8A2sFlkIqt7I0KDken+dmR+38kN6nA2dyCuSuP5
         y+7Q==
X-Gm-Message-State: AO0yUKXke59yBi4myqCCTren/8+Zz9YSF9CccWESQc9+Czb4Hv+rsfZx
        mwx8jPIkukcapuuokLCDeHtfwvCXC2V/VHnt4Hjq3g==
X-Google-Smtp-Source: AK7set9oVNJY0vYTB5ZfbSOlWqH+5+fu77atXt0iDLmyJgaHKY0ltw8/0Jl4aEWSfbfjS7HFEH2jF+qXGU1xARTaumE=
X-Received: by 2002:a5d:8ad0:0:b0:752:a213:2573 with SMTP id
 e16-20020a5d8ad0000000b00752a2132573mr147232iot.18.1679073724912; Fri, 17 Mar
 2023 10:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com> <CAG_fn=UHz93odccvRFo5H2yKq9URTcQs2jWWc5Yehioq-QC8hA@mail.gmail.com>
In-Reply-To: <CAG_fn=UHz93odccvRFo5H2yKq9URTcQs2jWWc5Yehioq-QC8hA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 Mar 2023 18:21:28 +0100
Message-ID: <CAG_fn=XE-iDrPEB=bsnAqxYkRi+nFvTSbywOz56W_xQWLHeCAQ@mail.gmail.com>
Subject: Re: [PATCHv16 00/17] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 6:18=E2=80=AFPM Alexander Potapenko <glider@google.=
com> wrote:
>
> Dear x86 maintainers,
>
> the series looks pretty mature now, any chance it can be considered
> for upstream?
>
(Adding the maintainers just to be sure)
