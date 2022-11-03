Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D307617FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiKCOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKCOsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:48:24 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7992E0D;
        Thu,  3 Nov 2022 07:48:22 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2A3Elfk5019027;
        Thu, 3 Nov 2022 23:47:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2A3Elfk5019027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1667486862;
        bh=TuNM2rHD3sRB+ox8RBaC7f6+XLb7VfNR657ErBE+mys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WsDBF+vxaUubH4L3pg4hCsLNJRA2ad7z+JyxDAwDCsnw4WCfmlGz/IsiJx4dCwBWU
         O0mwmUErZC029A8CUSnlaYrCQ2Q2iQf1VRwm48D+Cr38ir0LYnt6YLlUnkI825ec+6
         SaZj34joRpg76JodABZ/KHzlVUdZGEHMCwiWoYr1Nub3FmDWeZhUZQobHEsG4SuMnw
         q1II9bTPghm7f7aoiU5ABjjekGT7Grpy9layb533jmWrCUzLdGLgHgKUhWDIwhxsT4
         kWbdPixcXDHsfDm6JIxuymEmCTBpRWoXGYd0KSH8AZ9ah2wHt4nRJZzobKWXztZLeP
         5dIMv8WEFt3ng==
X-Nifty-SrcIP: [209.85.167.175]
Received: by mail-oi1-f175.google.com with SMTP id p127so2155204oih.9;
        Thu, 03 Nov 2022 07:47:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf0OFVOe2U5L+6vSeWKU1VwDR3B3ULiAPivxFgFbT6WJ2re22eff
        3g+FNEXz/P+hg6V5B4MDQkWrETnPcORkZ2YoxNw=
X-Google-Smtp-Source: AMsMyM7JPIjX/GXktALqdrTv58HUSxC8FEw2P+dSoycFrGz43w7u0MQy2EthH5eypKbvFbnD5sDyGCVe0p+a3820dXE=
X-Received: by 2002:a05:6808:1893:b0:359:f7c7:1caf with SMTP id
 bi19-20020a056808189300b00359f7c71cafmr13748303oib.194.1667486860713; Thu, 03
 Nov 2022 07:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221102091308.11568-1-masahiroy@kernel.org> <CAMj1kXGzFEnUGkoD_JV6=mrKQ+eXLo=SYU8823mPezHZfY_FRQ@mail.gmail.com>
 <CAK7LNASjBm=WWpkSaL1+QuLokhnepUucvhYyP3CCeZYx6nOTHA@mail.gmail.com> <9fe8615c-fe31-ebf7-09bd-453fae189666@kernel.org>
In-Reply-To: <9fe8615c-fe31-ebf7-09bd-453fae189666@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Nov 2022 23:47:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATBuERrR4QvLzDNOw1TVmMP+2J=sJviihBdy8gF=CfA=w@mail.gmail.com>
Message-ID: <CAK7LNATBuERrR4QvLzDNOw1TVmMP+2J=sJviihBdy8gF=CfA=w@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: pass objects instead of archives to linker
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kbuild@vger.kernel.org,
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

On Thu, Nov 3, 2022 at 4:22 PM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 02. 11. 22, 10:44, Masahiro Yamada wrote:
> > Jiri Slaby reported that the (not-upstreamed) GCC-LTO tree got broken
> > due to 321648455061 ("kbuild: use obj-y instead extra-y for objects
> > placed at the head")
> >
> > https://lore.kernel.org/linux-kbuild/ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org/
> >
> >
> > I am not pretty sure because I did not check the downstream code.
> >
> >
> > If I understood his report correctly, the reason for the breakage is
> > because I put all objects into the thin archive, expecting
> > the linker would preserve the object order in the archive.
> >
> > By specifying the object order directly in the command line,
> > GCC-LTO should get back working again.
>
> ...
>
> > I think my patch is unneeded (hence RFC), but I just wanted to know
> > if linkers (gnu ld and lld) see any difference.
>
> Yes, including your patch (instead of vmlinux.S and /compressed/*
> changes) also fixes the issue. So the linker (gcc-ld) indeed respects
> command line, but not order of objects in .a.
>


Can I see your LTO implementation somewhere in public?


I know Andy Kleen's GCC-LTO, the latest version is 5.13-ish.

https://github.com/andikleen/linux-misc.git





> thanks,
> --
> js
> suse labs
>


-- 
Best Regards
Masahiro Yamada
