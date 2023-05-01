Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4087F6F3519
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEARhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEARhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:37:03 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8DE125
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:37:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-38e3228d120so1709920b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682962622; x=1685554622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+RNUTojqcUPndVpyqWpOuSnVDmC59OYTbJVhd//Jx0=;
        b=GYL5XLwkDZzXY+VQg5bm6uM19iSjeNRk2Da2qvHDtAme4uHcxzCq6z+H2D3uLIhsxM
         wE1DPbM1ZHuyYTSHFkc/4zCo97595k7l/RO4BllrJ6QH7XWpc+h9JLdrivS1Z6niwRP2
         yy5T0F5vmetnzIT7n5v69qeYMgSeczZl84Rhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962622; x=1685554622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+RNUTojqcUPndVpyqWpOuSnVDmC59OYTbJVhd//Jx0=;
        b=jXNe+mbglN2i2tc/ZxMU3zwGli4zjOxIQ1XXeYPKJVPvI3GLE8yskFSBO+dGDxvAVG
         ZN1L97cK+vAs0bamnpI96yWSM4DhRmybpDkGrHRCefpQHyW39vMTAXQcFSTJ3l2KtbAv
         Jn0VDBKnsc9GAen0GaKJ6KxcmxhkzB8IR2SjaMPMf9dcX/t5Mqgo3WgKMKAKD44aDdph
         MO9eD7HqowI8V7DsAdO2L6xjQvaJCZjYc3BGWYZWwhAh5dLjnBURwzMTHgSEp+EqJF6c
         jFj/e6YS4xThfBF7bYJcyMugjQIC2tQJh66WaAuHEpT0QPZi/J4PLZDNtUcRDh4sBvC9
         yiAA==
X-Gm-Message-State: AC+VfDwYS3txUDEevvs7rYhRtwR+TmrxBh+o4kxKCdm9BV8/wrHgzlKz
        ppb1RM5yyqV5HWFGSLWrPJQXOybGBkYCVFxjEk389A==
X-Google-Smtp-Source: ACHHUZ4nFVvqKronZC/MlbVARXSea4NPt/YCyEWY2ZIKuVAc+13gBMZNgIJqtottKJHdHd9Sxtq/Cg==
X-Received: by 2002:a05:6808:1487:b0:392:18e2:55fb with SMTP id e7-20020a056808148700b0039218e255fbmr3829178oiw.23.1682962621999;
        Mon, 01 May 2023 10:37:01 -0700 (PDT)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com. [209.85.160.42])
        by smtp.gmail.com with ESMTPSA id a1-20020a544e01000000b003896f132821sm6344154oiy.41.2023.05.01.10.37.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 10:37:01 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-187af4a5437so2388028fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:37:01 -0700 (PDT)
X-Received: by 2002:a17:90a:1543:b0:24b:2f97:9208 with SMTP id
 y3-20020a17090a154300b0024b2f979208mr14865070pja.0.1682962600487; Mon, 01 May
 2023 10:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org> <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
 <CANiDSCtDfPffUQTuH3JiPWC+87FBtpog7kT954PSoiTbB_fmJQ@mail.gmail.com> <20230501-griminess-defiling-73b367bb2e47@spud>
In-Reply-To: <20230501-griminess-defiling-73b367bb2e47@spud>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 1 May 2023 19:36:29 +0200
X-Gmail-Original-Message-ID: <CANiDSCsKKh7pSbYRu6=EbF4PL5UXk5gYpDTk3KzjzW9ni5Hc2g@mail.gmail.com>
Message-ID: <CANiDSCsKKh7pSbYRu6=EbF4PL5UXk5gYpDTk3KzjzW9ni5Hc2g@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To:     Conor Dooley <conor@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Eric Biederman <ebiederm@xmission.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor

Fixed on my branch
https://git.kernel.org/pub/scm/linux/kernel/git/ribalda/linux.git/commit/?h=
=3Db4/kexec_clang16&id=3D1e9cda9fa638cc72581986f60b490cc069a38f75


Will submit a new version after a while :)

Thanks!

On Mon, 1 May 2023 at 19:28, Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, May 01, 2023 at 07:18:12PM +0200, Ricardo Ribalda wrote:
> > On Mon, 1 May 2023 at 18:19, Nick Desaulniers <ndesaulniers@google.com>=
 wrote:
> > >
> > > On Mon, May 1, 2023 at 5:39=E2=80=AFAM Ricardo Ribalda <ribalda@chrom=
ium.org> wrote:
> > > >
> > > > If PGO is enabled, the purgatory ends up with multiple .text sectio=
ns.
> > > > This is not supported by kexec and crashes the system.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_pu=
ragory")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > >
> > > Hi Ricardo,
> > > Thanks for the series.  Does this patch 4/4 need a new online commit
> > > description? It's not adding a linker script (maybe an earlier versio=
n
> > > was).
>
> > Thanks for catching this. It should have said
> >
> > risc/purgatory: Remove profile optimization flags
>      ^^
> Perhaps with the omitted v added too?
>
> Also while playing the $subject nitpicking game, is it not called
> "profile**-guided** optimisation" (and ditto in the comments)?
>
> Cheers,
> Conor.
>
> > Will fix it on my local branch in case there is a next version of the
> > series. Otherwise, please the maintainer fix the subject.
>
> > > > ---
> > > >  arch/riscv/purgatory/Makefile | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/M=
akefile
> > > > index 5730797a6b40..cf3a44121a90 100644
> > > > --- a/arch/riscv/purgatory/Makefile
> > > > +++ b/arch/riscv/purgatory/Makefile
> > > > @@ -35,6 +35,11 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
> > > >  CFLAGS_string.o :=3D -D__DISABLE_EXPORTS
> > > >  CFLAGS_ctype.o :=3D -D__DISABLE_EXPORTS
> > > >
> > > > +# When profile optimization is enabled, llvm emits two different o=
verlapping
> > > > +# text sections, which is not supported by kexec. Remove profile o=
ptimization
> > > > +# flags.
> > > > +KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile=
-use=3D%,$(KBUILD_CFLAGS))
> > > > +
> > > >  # When linking purgatory.ro with -r unresolved symbols are not che=
cked,
> > > >  # also link a purgatory.chk binary without -r to check for unresol=
ved symbols.
> > > >  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
> > > >
> > > > --
> > > > 2.40.1.495.gc816e09b53d-goog
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> >
> >
> >
> > --
> > Ricardo Ribalda
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Ricardo Ribalda
