Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78A6F3502
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjEARTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjEARTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:19:11 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004671BF3
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:18:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9a7e639656so4802679276.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682961525; x=1685553525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDAy0yw2Hl6Xad3kepfPR0FriSjDMaQH5Y0jnLgi2V4=;
        b=oDAyKLSdxWeDf2Rr539YuGPN8WIpEGf8MZUyaYq5jr+2u5r+cTYAw2jASoneiiCznU
         2SvyyFMMDnvtDUHjWd0FR1VXwxNkJF1Db2fr3bNgMpEqVPMJ7oTUtw4hQgx3+k8EZndj
         FscTv8obyqztv1iAv4Pz/neD2LiCUt46YSdAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961525; x=1685553525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDAy0yw2Hl6Xad3kepfPR0FriSjDMaQH5Y0jnLgi2V4=;
        b=FQYVlO3s5RhiOOaanPHQn2HfmF8pxwifesQFpiQ8cn+b6YhDBjdrNiTpVxEvaDsVJX
         62h9Ux382ueeVlzUII9lcc+1noBPnPDTcsRc85pNhQNbXOYlGzCWNY7jOf/oQTaGzEHl
         0jE+EgtnMULUxX7UuYddF6KmqlV5DDXFWCqBXQ1lRqVPA5UmFVmdL9ZL0vsr0NenzwxP
         DsBGP/1DG/S5CHWucqYBaqT6dawdbhYyzoaGm9L02cInRzhnu+ciRm68lkM9fetWniiA
         l6oiYbvI69toMK0vlGmogkTlv2FdRT5+u2d6/+EdDpjRrw76Q0CKI2CCgLGzf9vterM9
         /dmg==
X-Gm-Message-State: AC+VfDwxP60iE9p/Pr+gCADxWnfNWzWSSCVtU6bLNXOJ0oezeGdJnR7t
        7QN3R8VKw+8U0ZQoaOdPq7075DJiT2zaXHpB2Oz3Rg==
X-Google-Smtp-Source: ACHHUZ5z/sgAP8gyhtdLCDBjebbm46pNGGst7mujzb2BzokX3/F4pIfNKLRJOsskDWnG5pfivj40/g==
X-Received: by 2002:a25:2507:0:b0:b9d:9500:9d29 with SMTP id l7-20020a252507000000b00b9d95009d29mr9584876ybl.45.1682961524947;
        Mon, 01 May 2023 10:18:44 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id z12-20020a5b020c000000b00b7767ca7485sm6135803ybl.34.2023.05.01.10.18.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 10:18:44 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-b9a7e639656so4802648276.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:18:44 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:1a8:1c9a:f68 with SMTP id
 h15-20020a170902f70f00b001a81c9a0f68mr17818554plo.36.1682961504069; Mon, 01
 May 2023 10:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org> <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
In-Reply-To: <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 1 May 2023 19:18:12 +0200
X-Gmail-Original-Message-ID: <CANiDSCtDfPffUQTuH3JiPWC+87FBtpog7kT954PSoiTbB_fmJQ@mail.gmail.com>
Message-ID: <CANiDSCtDfPffUQTuH3JiPWC+87FBtpog7kT954PSoiTbB_fmJQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>, llvm@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick

Thanks for catching this. It should have said

risc/purgatory: Remove profile optimization flags

Will fix it on my local branch in case there is a next version of the
series. Otherwise, please the maintainer fix the subject.

Thanks!

On Mon, 1 May 2023 at 18:19, Nick Desaulniers <ndesaulniers@google.com> wro=
te:
>
> On Mon, May 1, 2023 at 5:39=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.=
org> wrote:
> >
> > If PGO is enabled, the purgatory ends up with multiple .text sections.
> > This is not supported by kexec and crashes the system.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_purago=
ry")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Hi Ricardo,
> Thanks for the series.  Does this patch 4/4 need a new online commit
> description? It's not adding a linker script (maybe an earlier version
> was).
>
> > ---
> >  arch/riscv/purgatory/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makef=
ile
> > index 5730797a6b40..cf3a44121a90 100644
> > --- a/arch/riscv/purgatory/Makefile
> > +++ b/arch/riscv/purgatory/Makefile
> > @@ -35,6 +35,11 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
> >  CFLAGS_string.o :=3D -D__DISABLE_EXPORTS
> >  CFLAGS_ctype.o :=3D -D__DISABLE_EXPORTS
> >
> > +# When profile optimization is enabled, llvm emits two different overl=
apping
> > +# text sections, which is not supported by kexec. Remove profile optim=
ization
> > +# flags.
> > +KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-use=
=3D%,$(KBUILD_CFLAGS))
> > +
> >  # When linking purgatory.ro with -r unresolved symbols are not checked=
,
> >  # also link a purgatory.chk binary without -r to check for unresolved =
symbols.
> >  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
> >
> > --
> > 2.40.1.495.gc816e09b53d-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Ricardo Ribalda
