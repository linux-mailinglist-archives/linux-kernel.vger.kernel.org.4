Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36336BB9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjCOQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjCOQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:38:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3190081;
        Wed, 15 Mar 2023 09:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C82AB81E8B;
        Wed, 15 Mar 2023 16:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE84C433EF;
        Wed, 15 Mar 2023 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678898237;
        bh=G4+EqBXCxApFoT6pBpn98QWNXICt1XkRAKg8kFPnOw8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=La61M4N+n1xPrep63xCNlvde51lQp6caVEBkVvcCdcsynWCG96GKHGlT1VCORvlkP
         eHC1Pm0kOldfjf/GNAmXGpXICdcFoAL2uLeNNhECn35ag6HOfOO4o8TXULiATaEr36
         rsEQkaE+uEkTEgLxl4mjPbf9E1lvX+hhPoiQ1+XoAecsHI19PWZtxdVYRLkUybltXa
         VZsa6e3JHwdOXact47uZOM5xiTEEazfaCyL2yPhUQ0n7SuinVLdfFOlF/t0wOUz5/6
         7+64R00xzqxZCpQzrzX2bzaHfZWJrEeG+omVrmKS8rKRhNNI9SwYKk9wkqfp41M0wA
         MQbkv5vvwU1MA==
Received: by mail-ot1-f44.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so10480634otp.6;
        Wed, 15 Mar 2023 09:37:17 -0700 (PDT)
X-Gm-Message-State: AO0yUKX0c7rGgPZ3sZkpgcF8ROXHBPGEKTdpMe5IU9d1ddrfw0E/YClr
        vqnKw9Boh4pn+HrNTHnivBL1pYjA2mBR4puHmFo=
X-Google-Smtp-Source: AK7set/G3Xqz/h4ue67wp/XVtLRpSeA2/NNzqqtju/VBVd5LWI8aWJU+uHmCbjpba55fc6LklceJ6XdVcMObHJ1PzR8=
X-Received: by 2002:a9d:4708:0:b0:698:9eff:4330 with SMTP id
 a8-20020a9d4708000000b006989eff4330mr1681756otf.1.1678898237071; Wed, 15 Mar
 2023 09:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230313171036.268407-1-bage@linutronix.de> <20230313171036.268407-2-bage@linutronix.de>
 <CAK7LNARd8rQdwauAvgSo-+wxv=rU-4tTCtrzRJ2uhgWRrt6Xxw@mail.gmail.com>
 <63232be8-59f6-8b93-96be-730f5126f60c@linutronix.de> <CAK7LNAQ_EhN+6PhcStp8xEOuyLT77t4OJ=E33xTvqVZM-7+Z7A@mail.gmail.com>
 <31f4e939-39b2-7177-39e5-718518f349f7@linutronix.de>
In-Reply-To: <31f4e939-39b2-7177-39e5-718518f349f7@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Mar 2023 01:36:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATtzbCEAPWeDDZOwOsbcODzbe8C+CEwWdacaZS1pBvjdQ@mail.gmail.com>
Message-ID: <CAK7LNATtzbCEAPWeDDZOwOsbcODzbe8C+CEwWdacaZS1pBvjdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: Allow parallel build
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:51=E2=80=AFAM Bastian Germann <bage@linutronix.d=
e> wrote:
>
> Am 15.03.23 um 15:18 schrieb Masahiro Yamada:
> > "dpkb-buildpackage -j<N>" sets not only DEB_BUILD_OPTIONS
> > but also MAKEFLAGS.
> >
> >
> > This is clearly explained in "man dpkb-buildpackage".
> >
> >
> >   -j, --jobs[=3Djobs|auto]
> >     ...
> >    Will add itself to the MAKEFLAGS environment variable, which should
> >    cause all subsequent make invocations to inherit the option, thus
> >    forcing the parallel setting on the packaging ...
>
> I see. The testing/unstable dpkg-buildpackage version changed the -j beha=
viour.
> -j only sets DEB_BUILD_OPTIONS=3Dparallel=3D now.
>
> The man page now says:
>
>         --jobs-force[=3Djobs|auto]
>         This option (since dpkg 1.21.10) is equivalent to the --jobs opti=
on except that
>         it will enable forced parallel mode, by adding the make -j option=
 with the computed
>         number of parallel jobs to the MAKEFLAGS environment variable.
>
> > Your statement sounds like
> >
> >   'MAKEFLAGS=3D-j<N> dpkg-buildpackage'
> >
> > is the only way to build packages in parallel.
>
> It is in v1.21.10 or later (or using --jobs-force which does the same thi=
ng).
>
> > Apparently, dpkg-buildpackage provides a much shorter way
> > and invokes internal Make in parallel.
> >
> >
> >
> >
> >>
> >> So it is not used to run the actual build, just the top level `make -f=
 debian/rules` invocation.
> >> You can set --jobs-force=3D16, which ends up in MAKEFLAGS but the poin=
t of the patch is that one can use
> >> the usual way of parallelizing.
> >
> >
> > What is the "usual" way in this context?
>
> The usual way is dpkg-buildpackage -jN but that does not work with later =
versions.
>
> > Do you mean
> > 'DEB_BUILD_OPTIONS=3Dparallel=3D16 dpkg-buildpackage -b'
> > is the usual way for parallel building?
> >
> > If so, I agree. This patch caters to this case.
> >
> >
> > But, I think your code should go to debian/rules
> > instead of scripts/package/deb-build-option.
> > Kbuild's "make clean" works much faster with the parallel option.
> >
> >
> > Also, the commit description should explain the
> > benefit of this patch.
>
> I will clarify the dpkg-buildpackage behaviour change and will move the s=
tuff to debian/rules
> in v2.


Please do so.


Now I understand the point of this patch.
Indeed, my dpkg-buildpackage is old.
(v1.21.1 on Ubuntu 22.04)

Thanks.





--
Best Regards
Masahiro Yamada
