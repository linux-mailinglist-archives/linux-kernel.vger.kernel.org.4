Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B640E63BAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiK2Hji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2Hjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:39:36 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C0D49B63
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:39:35 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3bf4ade3364so80302757b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2uE27wZBYUmbjYRRdmIErO64UjNOYGILNAfn5DaLwQw=;
        b=EEenj/OqfjE4/fDoCbT05POwpd7FIodjXiZmbhNCTdgXUAzL24A0THU3oHnVMzJ72o
         Cx17Pee4kXRrLi4yguuZftqJHHOcPf4s5NtxidGBCXO00yMpFt1yFxU0xzeHJDbNsNkO
         ViVpNz4hd6oJUQteGTbXPEzjIbJy14sbAX0VbIdX08jYLPhU1ig2Vw/Sf+ZoxIFmZ/Vt
         HxB03Q2RwG0/u+u8GMXhxo/G0OR2But458Qbf1Cid+oJpsA3aNkCByuDb+edvPxWI4l7
         aQNDHwGrMzTk3y9SBbDBFjxqcPsfKt/vP3d2/HHyam9YEXuis0JrvUrc6PDyE0sVexci
         XzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uE27wZBYUmbjYRRdmIErO64UjNOYGILNAfn5DaLwQw=;
        b=IEv0qf9AA3cc7gz/Ea24lHrDDIxfypbxxQm0jWj0cyum/dMlvnRPmcXOBFdCgNLHxj
         8BSMU58z81DKgy/R1q6Dlxez2ef7itMjFOJxxtctbsgI67M/lnqN5tROWUslHVVPxMqu
         /XYG+Z4qg8zR0ULhu91pTni1qx3iB0H3J4xLp8ZgD2lwRPi921fbXOqlRU4YG7LDOlZO
         rbwIAwlWq3k21PJDTaeWvpErDaNt32BRwjdxkiJRZKmmYirP2kjznD/METZAxIHykPSB
         936Fb2wxho9GW42+57d4hHDO/Ipgcxq2QU0DjTOdNxGoi13gQ9IKhKgAlHgIxXVnwH/8
         0P+g==
X-Gm-Message-State: ANoB5pnG4S8i6tY4K/vax2gmCsgztmSZ6UUolhIz5sQkzEkf2A7vM39e
        dzhGh6j27DCVLpmtBLK2zUx1d/7iEudEnvfeAZw=
X-Google-Smtp-Source: AA0mqf4J3GvWSkLtPUpWi+c8fyitg01hXkEqmgo9HbxrrpwgDBvxlST1+XhWDerT2lYoZiTOQaGu7fLq9GKHhKW4hso=
X-Received: by 2002:a81:700f:0:b0:38e:8263:755a with SMTP id
 l15-20020a81700f000000b0038e8263755amr52075160ywc.480.1669707574998; Mon, 28
 Nov 2022 23:39:34 -0800 (PST)
MIME-Version: 1.0
References: <20221104124546.196077-1-ubizjak@gmail.com> <Y4U0GwlLgAuxu3WF@zn.tnic>
In-Reply-To: <Y4U0GwlLgAuxu3WF@zn.tnic>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 29 Nov 2022 08:39:23 +0100
Message-ID: <CAFULd4Yjp+sNqZrt9kq2orodNckQOWAGi84ZZeXRFPLyE65HPQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:20 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 04, 2022 at 01:45:46PM +0100, Uros Bizjak wrote:
> > Current minimum required version of GCC is version 5.1 which allows
> > reuse of PIC hard register on x86/x86-64 targets [1]. Remove
> > obsolete workaround that was needed for earlier GCC versions.
> >
> > [1] https://gcc.gnu.org/gcc-5/changes.html
>
> Thanks for the doc pointer.
>
> Lemme see if I understand this commit message correctly:
>
> SysV i386 ABI says that %ebx is used as the base reg in PIC. gcc 5 and
> newer can handle all possible cases properly where inline asm could
> clobber the PIC reg. I.e., it is able to deal with the "=b" constraint
> where an insn can overwrite %ebx and it'll push and pop around that
> statement.

gcc-5 considers PIC register as a pseudo-register and reloads it
before instruction that requires the value in %ebx. This way, PIC
register is no more special and does not need any special handling.
This includes inline asm which can clobber %ebx.
>
> So far so good.
>
> Why then does this matter for x86-64 where PIC addressing is done
> rip-relative so %rbx is normal reg there?

x86_64 does not use PIC register for small code models. Also, it uses
%r15 instead of %rbx for PIC register, so the removed workaround
applies only to x86_32.

Uros.
