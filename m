Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E432E61602B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKBJpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKBJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:45:06 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A111F9EC;
        Wed,  2 Nov 2022 02:45:04 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2A29igcr007717;
        Wed, 2 Nov 2022 18:44:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2A29igcr007717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1667382283;
        bh=eWj4kt8GZv3xq2bzNaOqy8CxW+aBBU3BEN2MKQyY7sM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h86SQyzV0lGHaoaUpulGiyq8P1EMlOHMA4cNR146Qr2NE87rIjoqfZ0NXcPB5KYgz
         tWtfcpJZjxXsqXeZf7qIt5yVSvn68qfkZz8N5NqkLjK7N8ktH9bFOKOdl7GBA5FFfe
         9wHXRRD0Ua6zyun9XBlWJrOMP8vUHYz7Au51mF48TvlTjExc+KnHOq29QrEntgFGsz
         HT6uEzf0ijNurBXTez8PAs7bcgOWAGskymzHr6tjDOthU+8Ue47E9ALqumw8zQQOLk
         EOYOx+TDlgZtvzas3awEa60/PqwP0PqcZK2Sse6EC/4HmG9szyY0CfLxvDnJaHY3x0
         ud0HKetwCZuUQ==
X-Nifty-SrcIP: [209.85.160.44]
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-13be3ef361dso19699149fac.12;
        Wed, 02 Nov 2022 02:44:42 -0700 (PDT)
X-Gm-Message-State: ACrzQf32Wsil6Isx1hgXERfiR3FN1T2dvHIjpjVRpLqCVNs07L/T7c2w
        Jfs+vbU9gFWoYRSSiFtCCNOSfHOPRKZgoajer20=
X-Google-Smtp-Source: AMsMyM7934BdsCCc4A1uyBEZLyGzL9arUu5xYYjLob7UXe+OY4RkvRPLd74kJlX4hUbY4GFMQT3WMRhAKpwFbFXTjCw=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr14471016oab.287.1667382281911; Wed, 02
 Nov 2022 02:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221102091308.11568-1-masahiroy@kernel.org> <CAMj1kXGzFEnUGkoD_JV6=mrKQ+eXLo=SYU8823mPezHZfY_FRQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGzFEnUGkoD_JV6=mrKQ+eXLo=SYU8823mPezHZfY_FRQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 2 Nov 2022 18:44:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjBm=WWpkSaL1+QuLokhnepUucvhYyP3CCeZYx6nOTHA@mail.gmail.com>
Message-ID: <CAK7LNASjBm=WWpkSaL1+QuLokhnepUucvhYyP3CCeZYx6nOTHA@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: pass objects instead of archives to linker
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Michael Matz <matz@suse.de>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 6:21 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hello Masahiro,
>
> On Wed, 2 Nov 2022 at 10:13, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > This is an experimental patch, driven by the feedback from Jiri Slaby
> > and Michael Matz. [1]
> >
> > Michael Matz says:
> >  "I know of no linker (outside LTO-like modes) that processes
> >   archives in a different order than first-to-last-member (under
> >   whole-archive), but that's not guaranteed anywhere. So relying on
> >   member-order within archives is always brittle."
> >
> > It is pretty easy to pass the list of objects instead of a thin archive
> > because the linker supports the '@file' syntax, where command line
> > arguments are read from 'file'.
> >
>
> Can you explain which problem is solved by doing this?


Jiri Slaby reported that the (not-upstreamed) GCC-LTO tree got broken
due to 321648455061 ("kbuild: use obj-y instead extra-y for objects
placed at the head")

https://lore.kernel.org/linux-kbuild/ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org/


I am not pretty sure because I did not check the downstream code.


If I understood his report correctly, the reason for the breakage is
because I put all objects into the thin archive, expecting
the linker would preserve the object order in the archive.

By specifying the object order directly in the command line,
GCC-LTO should get back working again.






>
> If we can only produce a working kernel if each object is linked in
> the order it appears in the archive, I think we have bigger problems
> that need solving regardless. And for the .head.text objects that need
> to appear at the start of the binary image, I think the reported issue
> with __head annotated C functions on x86 needs to be addressed by
> getting rid of __head entirely (which seems to have been introduced
> without proper justification)


I agree that it is the correct approach.


I think my patch is unneeded (hence RFC), but I just wanted to know
if linkers (gnu ld and lld) see any difference.






--
Best Regards
Masahiro Yamada
