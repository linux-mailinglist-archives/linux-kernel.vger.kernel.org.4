Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C756DBB94
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjDHOaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDHOaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1FCD331;
        Sat,  8 Apr 2023 07:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87BC160F11;
        Sat,  8 Apr 2023 14:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75D1C433D2;
        Sat,  8 Apr 2023 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680964211;
        bh=dWco55L+uZvkyNv3mbeG7fRYJrJTAfpWmDPlkv7JF4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kMXzmvuREPFtwCfQQIiHV2JCleJgH717G4Oskj5YVtgGFhLAx6ApwcwBEUEc466xK
         gc862YNfOcDY9UI9ZdzFc6lbMTmOh2NhQeoT+LaUBLfcElldA4b7YT9PG/oR2VxXO6
         D+mK4PMWGxYcnz/Awv+168HGrYhv1MttxkMw3ZrlkvsLFi/V6F4g2fH6QqsEk5Wf7Q
         UaZPabrViSOr+uNPb35rHkBPOPc5oRnrzAfM4P+btwhR75tI55e4BFzo4IXdXBxPKg
         XoxazSzh9B5klWGRIVcMr+0gzS/pu50tutbI2oGCNlIHy0F4s7Grt9nqjUlkXDkTCt
         /R3Dak+MaO8eg==
Received: by mail-ot1-f53.google.com with SMTP id cp25-20020a056830661900b00693ce5a2f3eso576075otb.8;
        Sat, 08 Apr 2023 07:30:11 -0700 (PDT)
X-Gm-Message-State: AAQBX9dcvudhYXbLk4hrVfQKrYzykSqIJ3F6+OZpcl6XkC2ns9vrLs4K
        AiEIxmS87J46Fxsz0l4BHwsaZbkI7eTgYcsicVg=
X-Google-Smtp-Source: AKy350Zk5Dy4/NNeR3Nk3LnYN87WPq1SZJ63SxnCe9maa96G0oOC11qkkyIXdppEkTKARrPfWTVy5Z/hlx06H5XgoIo=
X-Received: by 2002:a05:6830:1641:b0:69a:2eb2:e11b with SMTP id
 h1-20020a056830164100b0069a2eb2e11bmr490529otr.1.1680964211202; Sat, 08 Apr
 2023 07:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230308115243.82592-1-masahiroy@kernel.org> <20230308115243.82592-3-masahiroy@kernel.org>
 <CAKwvOdnmiL_wDgzepYb+ZGgWt2xnsp48-awn0Cd0c4RDR43t_Q@mail.gmail.com>
In-Reply-To: <CAKwvOdnmiL_wDgzepYb+ZGgWt2xnsp48-awn0Cd0c4RDR43t_Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 8 Apr 2023 23:29:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQr+y2y5vCKSpA0THyakRUcRcS9X+X9i3mbhTYvnh1wHg@mail.gmail.com>
Message-ID: <CAK7LNAQr+y2y5vCKSpA0THyakRUcRcS9X+X9i3mbhTYvnh1wHg@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/mksysmap: use sed with in-line comments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023 at 4:00=E2=80=AFAM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Wed, Mar 8, 2023 at 3:53=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > Move comments close to the code.
>
> Consider adding to the commit message why you switch from grep to sed;
> that's currently unclear.



I just thought "Move comments close to the code"
explained my motivation.,


I want to insert in-line comments.
Something like the following.
Apparently, it does not work.


$NM -n $1 | grep -v             \
         # comment1
        -e ' [aNUw] '           \
         # comment2
        -e ' \$'                \
         # comment3
        -e ' \.L'               \
         # comment4
        -e ' __crc_'            \
         # comment5
        -e ' __kstrtab_'        \
         # comment6
        -e ' __kstrtabns_'      \
         # comment7
        -e ' L0$'               \
> $2






> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Orthogonal to this patch, don't .L prefixed local symbols not have
> entries in the symbol table? If they're not printed with nm, why
> filter them out (since they're impossible).


Sorry, I could not understand your question, but
you may get something from d4c858643263cfde13f7d937eaff95c2ed87cdf1
(you reviewed it)




--=20
Best Regards
Masahiro Yamada
