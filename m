Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42E76DE6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDKVqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDKVqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:46:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911B5269
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:46:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p8so9288347plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681249569; x=1683841569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zejEY/r4Tfq5XbhV7cIEeG2i14mVKUoGXnXZCvl+x7Q=;
        b=JR7AbifGvum1/spLQ4gbBxoXTDJFbeqZS0i/NcRbMfRXymryrRUwE2AlNViLCIL0yk
         TK5vobsACwctOi92h20ARZXoHbc9lntb5ojtDAA86UVgkQ2aAAzs4yI2Ppqut09EX+jI
         rPkYLg6i19ex9xi5unVGzXuKv5tnXxZpZuFr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681249569; x=1683841569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zejEY/r4Tfq5XbhV7cIEeG2i14mVKUoGXnXZCvl+x7Q=;
        b=P/itwQ4zs1hemNHAROs28vIbokJBIsit+JkbVg6eY6ROtJBaNTLvKqq/BYkmlsbfcF
         T+l/umg9OOF/TJZ/U1CORNHKdsKeeSKXSVEZUZHzY3u80oo6iaShoQbCwRldeCKcaW+e
         T0kmX9Gju07rsnpqSQjFXq/neLs2nvEBd08DoMFl6LogDzbzCD7EI798rkFXwvkioW22
         76M0s7Xz2wL9YyWfKNXWOfJ+xZj2OrEvCicVkMKzCuAASWVQO+v2b/WyI99/QC0rJK2r
         CAoPw3ZtUxYBpWgGHsAMN9C/sboI0eDD0O24pXLLJNLc+eOEx3vO4A22izsdBadpf/ms
         36Bw==
X-Gm-Message-State: AAQBX9fPxkKdtpU5inLVNkjOqs9kKuN53w4bF6/Umdj2OvLQD8lHiaXC
        PeZcu33o7jL9z4QjfJW6moeR9kunSKbqLG/ReuY=
X-Google-Smtp-Source: AKy350ZQvtbyz/a75H4xo74YR+e6pRoxeGZ2MBD0NOR/uPeGk/jip6UwGRxu9PDVfo6zDgqK4RZNEg==
X-Received: by 2002:a17:90b:4d05:b0:234:384f:79c with SMTP id mw5-20020a17090b4d0500b00234384f079cmr16222856pjb.33.1681249569318;
        Tue, 11 Apr 2023 14:46:09 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id gj22-20020a17090b109600b00246f76e8c04sm50130pjb.40.2023.04.11.14.46.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 14:46:08 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id h24so9377844plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:46:08 -0700 (PDT)
X-Received: by 2002:a17:90b:384f:b0:23f:9d83:ad76 with SMTP id
 nl15-20020a17090b384f00b0023f9d83ad76mr15506588pjb.23.1681249567905; Tue, 11
 Apr 2023 14:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org> <20230330111523.4b98c8ce@gandalf.local.home>
 <20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local> <20230330113127.3011e021@gandalf.local.home>
 <20230330160017.GEZCWyEXQVQZRBbYif@fat_crate.local> <CAKwvOdkULKxoifiVO4H4yomt1DHQxw0ntdO6QgMXk2BpM-urRg@mail.gmail.com>
In-Reply-To: <CAKwvOdkULKxoifiVO4H4yomt1DHQxw0ntdO6QgMXk2BpM-urRg@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 11 Apr 2023 23:45:56 +0200
X-Gmail-Original-Message-ID: <CANiDSCvSDcQi2Qbwu8ddpPDAYehu2VoOB6x-v_PaMkWnwAGxYQ@mail.gmail.com>
Message-ID: <CANiDSCvSDcQi2Qbwu8ddpPDAYehu2VoOB6x-v_PaMkWnwAGxYQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Simon Horman <horms@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick

On Sat, 8 Apr 2023 at 01:22, Nick Desaulniers <ndesaulniers@google.com> wro=
te:
>
> Hi Ricardo,
> Thanks for the patch!  Please make sure to cc our mailing list
> <llvm@lists.linux.dev> for llvm specific issues.
> scripts/get_maintainer.pl should recommend it, or you can find it from
> clangbuiltlinux.github.io.  You can also ping me internally for
> toolchain related issues.
>
> Start of thread.
> https://lore.kernel.org/lkml/20230321-kexec_clang16-v5-0-5563bf7c4173@chr=
omium.org/
>
> On Thu, Mar 30, 2023 at 9:00=E2=80=AFAM Borislav Petkov <bp@alien8.de> wr=
ote:
> >
> > On Thu, Mar 30, 2023 at 11:31:27AM -0400, Steven Rostedt wrote:
> > > On Thu, 30 Mar 2023 17:18:26 +0200
> > > Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > > On Thu, Mar 30, 2023 at 11:15:23AM -0400, Steven Rostedt wrote:
> > > > > > Make sure that the .text section is not divided in multiple ove=
rlapping
> > > > > > sections. This is not supported by kexec_file.
>
> Perhaps this is related to CrOS' use of AutoFDO creating .text.hot?
> If so, it's probably more straightforward to straight up disable PGO
> for kexec. See also:
>
> commit bde971a83bbf ("KVM: arm64: nvhe: Fix build with profile optimizati=
on")

It was indeed due to the AutoFDO, adding

KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-use=3D%,
$(KBUILD_CFLAGS))

to arch/x86/purgatory/Makefile

It is definitely simpler than adding a linker script, but I am not
sure if it is the correct way to fix this... Seems like splitting
.text in multiple sections is an implementation detail of the compiler
and the only way to force it is with a linker script... Or am I
missing something?

Shall I send a new version with the KBUILD_CFLAGS ?

Thanks!

>
> > > >
> > > > And?
> > > >
> > > > What is the failure scenario? Why are you fixing it? Why do we care=
?
> > > >
> > > > This is way too laconic.
> > > >
> > >
> > > Yeah, I think the change log in patch 1 needs to be in this patch too=
,
> > > which gives better context.
> >
> > Just read it.
> >
> > Why did it work with clang version < 16?
>
> I'll bet if we bisect llvm, we can spot what might have changed, which
> may give us a clue on how to get the old behavior back; maybe without
> the need for a linker script.
>
> Ricardo, how did you verify that your fix was correct? Surely we can
> check using command line utilities without needing a full blown kexec
> setup? If you can share more info, I can bisect llvm quickly.  If it
> requires profile data, you'll need to share it, since CrOS engineers
> still have not posted public documentation on AutoFDO as I have
> repeatedly asked for.

The simplest test is to run:

$readelf -S arch/x86/purgatory/purgatory.ro | grep "] \.text"
[ 3] .text             PROGBITS         0000000000000000  000002a0

If there is only one .text section then that kernel will be load
properly via kexec_file().



>
> >
> > + toolchains ML.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--
Ricardo Ribalda
