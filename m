Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFEF729230
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbjFIIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbjFIIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA203A8C;
        Fri,  9 Jun 2023 01:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 453BD6544B;
        Fri,  9 Jun 2023 08:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F6AC433EF;
        Fri,  9 Jun 2023 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686297844;
        bh=QYP8QPrkZQaHvOXjFSOBnj0TdBlAQQ/6ZBMQi7R2ckM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ipNhHYjRVnuX9ZDNhkzPH2Nk0XfaPrskj6Te1w7hOWiy4eQHU+AOOPQfCgg9bgtuF
         h7DwhLPoPC2WjCD2vbiwRq7dTaS3RfYZWgR1yrQOwdwaLnPmlqYSFivW7+zkBb8/IU
         GVLG2N5DxPpS382jGhXhijLCuiOhlo6qHAi0e8rg3j0rMwJb+/t2f3yiU3jA6WfdaT
         +cCyibDdXhodr0u558yTju02FqeGU9CuxeGBQkP72y9t0vFNJk7tH1K9WD/AONEu1f
         TdQ6fdgr5zzUE086b7aLn/S7vhws9RG85z/2SPKifcf3YBIHs/JQmnCmpvYoAGSZpi
         2336OMoGy8VMQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-55b3b3e2928so994356eaf.2;
        Fri, 09 Jun 2023 01:04:04 -0700 (PDT)
X-Gm-Message-State: AC+VfDyuJtQ70IdiZRqJOThRv1oqB3fXkrq8o46odzy73Rs5xtbjqT+B
        Zf2U1JMJwOvPrvFj/DZ6cEDYaZzJdgZ+qMCEhrw=
X-Google-Smtp-Source: ACHHUZ4iptOI5ZEDzixyfn/DktIYAKmivHwKGF/SNofnutlGZcSNyIT8kW7wind/BIJEoobBLbi0DtvVq/uGveFlf4M=
X-Received: by 2002:a4a:d10c:0:b0:558:b386:7a78 with SMTP id
 k12-20020a4ad10c000000b00558b3867a78mr259903oor.5.1686297843943; Fri, 09 Jun
 2023 01:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <2427604.1686237298@warthog.procyon.org.uk>
In-Reply-To: <2427604.1686237298@warthog.procyon.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Jun 2023 17:03:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS1=RtTTYk=+q2YsGmMNQ6EwhAx=STEj+cXzWkNzT6nWQ@mail.gmail.com>
Message-ID: <CAK7LNAS1=RtTTYk=+q2YsGmMNQ6EwhAx=STEj+cXzWkNzT6nWQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] build: Deal with change in "make --no-print-directory"
 behaviour change
To:     David Howells <dhowells@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 12:15=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Masahiro & the kbuild crew,
>
> Here's a patch to fix a change in make behaviour in make-4.4.  It's almos=
t
> certainly the wrong solution, but it works for me for now.
>
> Note that I tried just adding "--print-directory" to the $(MAKE) line aft=
er
> the line I added, and that does seem to work - but it then prints a lot o=
f
> additional "entering directory" lines (though they all seem to be the sam=
e).
>
> David
> ---
> Emacs (and probably other IDEs) parse the "make: Entering directory" line=
s
> in the build output so that they can correctly resolve relative pathnames
> in messages from the compiler.  However, a change in make has broken this=
.
> I think it might be:
>
>         [/usr/share/doc/make/NEWS]
>         ...
>         Version 4.4 (31 Oct 2022)
>         ...
>         * WARNING: Backward-incompatibility!
>           Previously if --no-print-directory was seen anywhere in the env=
ironment or
>           command line it would take precedence over any --print-director=
y.  Now, the
>           last setting of directory printing options seen will be used, s=
o a command
>           line such as "--no-print-directory -w" _will_ show directory en=
try/exits.

I do not think this is it.




GNU make 4.4 is OK, but 4.4.1 is weird.


git bisect points this one:


commit 8f9e7722ff0f80d9f6ae9aba350ae02c3c6db878
Author: Dmitry Goncharov <dgoncharov@users.sf.net>
Date:   Sun Dec 18 09:49:34 2022 -0500

    [SV 63537] Fix setting -w in makefiles



I will ask in the GNU Make community if this is intentional.





>
> Doing a kernel build now only prints the directory passed to the "-C" fla=
g
> if present and no other directories.  This includes any build directory
> indicated with "O=3D".  So if I do:
>
>         make -C /my/data/linux O=3Dbuild
>
> I see:
>
>         make: Entering directory '/my/data/linux'
>
> and all the path in messages emitted by the compiler are prefixed with ".=
."
> - but then doing "M-x next-error" in emacs will prompt emacs to ask where
> the file is rather than jumping to it because it can't find it.
>
> On the previous version of Fedora with make-4.3, an extra line is emitted
> by make:
>
>         make[1]: Entering directory '/my/data/linux/build'
>
> and that was sufficient for emacs to be able to resolve paths.
>
> Fix this by manually printing the missing line.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Masahiro Yamada <masahiroy@kernel.org>
> cc: Nathan Chancellor <nathan@kernel.org>
> cc: Nick Desaulniers <ndesaulniers@google.com>
> cc: Nicolas Schier <nicolas@fjasle.eu>
> cc: linux-kbuild@vger.kernel.org
> ---
>  Makefile |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 836643eaefee..7f7c75087626 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -223,6 +223,7 @@ $(filter-out $(this-makefile), $(MAKECMDGOALS)) __all=
: __sub-make
>
>  # Invoke a second make in the output directory, passing relevant variabl=
es
>  __sub-make:
> +       @echo "make[1]: Entering directory '$(abs_objtree)'"
>         $(Q)$(MAKE) -C $(abs_objtree) -f $(abs_srctree)/Makefile $(MAKECM=
DGOALS)
>
>  endif # need-sub-make
>


--=20
Best Regards
Masahiro Yamada
