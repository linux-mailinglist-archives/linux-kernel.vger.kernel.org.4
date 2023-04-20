Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F196E9475
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjDTMdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjDTMcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B4524E;
        Thu, 20 Apr 2023 05:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A02C64894;
        Thu, 20 Apr 2023 12:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E6CC4339E;
        Thu, 20 Apr 2023 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681993955;
        bh=tiIf8xShGMy5YmQneQeNGTSNOauc/Dske3qGt5FpTP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vzxxm55d5jmtbIy6WA0A45FLM7DahIZxqJBvueyagQFyvrLEV2pkEnZkxH35Y0fCo
         6bHPbmmDQ/JD3oMAVf0gjV48M69Y7KcKjRiWFPkAywT/tnyrSx++XuWS/P52Qq5tVV
         nAc2wnUglj++kKNQI1+RtpkF2RgE2FcTwb0WtkO9LdDrJRLNM+0OaUtSFOYaO8SOtu
         OxCBGjKyNM6AK49yWhpYZusTkONaVNKRggUUdr1rLBKIbSu9DrgB7ZH6Bqvpwh5PTx
         OSjIM3kaiE2rQeBiaJvEIB0WVaKYTOnrkoDm/m7nKNq6X7o8Ffy3UhjDdt7fNZ+ZGd
         yNbUaR7Sq8LJg==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6a604259983so712856a34.2;
        Thu, 20 Apr 2023 05:32:35 -0700 (PDT)
X-Gm-Message-State: AAQBX9foOiH2nGld91bqQBbW6SLPGfDtyekWlQQGmqFuKToOYYMHuCDA
        C7IEATYSsl48PzbwOCg99uIcmX31s1m8AaA+XdY=
X-Google-Smtp-Source: AKy350YmKghsS0yBgOo82Vu1Oz3++Mi8rtvZaumgjDx5e1ruGJTyi3XPbgHEVjdnbntRElO8REkEnC63Dxf3eSBsN/0=
X-Received: by 2002:a05:6870:e40b:b0:184:5608:eb2d with SMTP id
 n11-20020a056870e40b00b001845608eb2dmr860331oag.21.1681993955041; Thu, 20 Apr
 2023 05:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230407101629.1298051-1-masahiroy@kernel.org>
 <20230407101629.1298051-3-masahiroy@kernel.org> <20230407181223.GD1018455@dev-arch.thelio-3990X>
 <a42a2dc4-bcbc-7a19-b036-8722606a5eaf@gmail.com> <ZEEAfkOGyVs1KD5Z@buildd.core.avm.de>
 <20230420091903.GB4423@unreal>
In-Reply-To: <20230420091903.GB4423@unreal>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 20 Apr 2023 21:31:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZ-V4Q8eh7_d-vU1_yXYZMkOTokQ-+S8P0g7xMaYfPnw@mail.gmail.com>
Message-ID: <CAK7LNAQZ-V4Q8eh7_d-vU1_yXYZMkOTokQ-+S8P0g7xMaYfPnw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: do not create intermediate *.tar for tar packages
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Tariq Toukan <ttoukan.linux@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>, dalevi@nvidia.com,
        Gal Pressman <gal@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 6:19=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Apr 20, 2023 at 11:06:06AM +0200, Nicolas Schier wrote:
> > On Thu, Apr 20, 2023 at 11:54:34AM +0300, Tariq Toukan wrote:
> > >
> > >
> > > On 07/04/2023 21:12, Nathan Chancellor wrote:
> > > > On Fri, Apr 07, 2023 at 07:16:29PM +0900, Masahiro Yamada wrote:
> > > > > Commit 05e96e96a315 ("kbuild: use git-archive for source package
> > > > > creation") split the compression as a separate step to factor out
> > > > > the common build rules.
> > > > >
> > > > > With the previous commit, we got back to the situation where
> > > > > compressed source tarballs are created by a single rule.
> > > > > There is no reason to keep the separate compression rules.
> > > > >
> > > > > Generate the comressed tar packages directly.
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > >
> > > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > >
> > >
> > > Hi,
> > >
> > > We started seeing the failure below in rc7.
> > > We narrowed it down to your patches:
> > >
> > > 3c65a2704cdd kbuild: do not create intermediate *.tar for tar package=
s
> > > f8d94c4e403c kbuild: do not create intermediate *.tar for source tarb=
alls
> > > f6d8283549bc kbuild: merge cmd_archive_linux and cmd_archive_perf


Strictly speaking, these are not bugs,
but gave a bad user experience.
(build slowness and extra disk space consumed).


I got a complaint about the intermediate *.tar file.

https://lore.kernel.org/linux-kbuild/20230406152540.8207-1-youling257@gmail=
.com/



I noticed fixing it was not difficult, so I merged.
(but, apparently I introduced another regression, sorry about that)








> > > aa7d233f45b4 kbuild: give up untracked files for source package build=
s
>
> <...>
>
> > > RPM build errors:
> > >     Bad exit status from /var/tmp/rpm-tmp.yDFEga (%prep)
> > > make[1]: *** [scripts/Makefile.package:69: rpm-pkg] Error 1
> > > make: *** [Makefile:1656: rpm-pkg] Error 2
> >
> > Thanks for the report.  It should/will be fixed with
> > https://lore.kernel.org/linux-kbuild/20230419170424.78688-1-masahiroy@k=
ernel.org/
>
> Thanks for the prompt response.
>
> I have a general question, why commits listed by Tariq were not delayed t=
o merge window?
>
> Only one of them has Fixes line, but even that patch doesn't talk about
> error, but code refactoring "To simplify the code, ...".
>
> Thanks
>
> >
> > Kind regards,
> > Nicolas



--=20
Best Regards
Masahiro Yamada
