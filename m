Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3116BFF12
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 03:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCSCT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 22:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCSCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 22:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E06C196A0;
        Sat, 18 Mar 2023 19:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B78C660F0C;
        Sun, 19 Mar 2023 02:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC92C433A0;
        Sun, 19 Mar 2023 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679192394;
        bh=tgbb3CmTQiuoeoPlYu4Ouy4YeijzJxzWfdlmgt78n5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jrmNenPf+99pa023+NwFqk9D6oUy+PWc08b7r5HIlGw7zn4QDm6yj+EpthMKAYmdB
         /DmfMrRnaCqalx/6pp/VgVZTjfV3Iq/uKIAoTYru9LWTUZWyNeplxUmUuht//93y2g
         +EHlkm3RZRUU947NxxmB0xDMz+JJJuU3YOzcSwENiPq32QsnzMvJUazQVT/IhNmJLQ
         ogwvx8eDsbT6AvPVikmsXeVo2WAtdnAFtuPBInvLEHAH8wCacRl2O9GAhHWpPXH1+A
         3HLMPGWAawpM1LEnMuShc9yADseQkc0GXwIaCwRL/jAjRWfWIGn9utG5qaGPu0oDAd
         WvnMO9NZwtoYg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-17786581fe1so9727967fac.10;
        Sat, 18 Mar 2023 19:19:54 -0700 (PDT)
X-Gm-Message-State: AO0yUKVUNrKMNuAk8kBqpcxVtxSv7S21Fd15JmpZu9fq4RqW4dsDVilv
        +SSNqYpoljsEy2FpqGYAMHR+9KIC7uFeQlcxsNo=
X-Google-Smtp-Source: AK7set+UL/ogUlHcQ2ZZ/QB+yFHtkbrji/rWyGw5D2KYYDR+inXmAQOIg55PCaKiozzvDGVf714ekiGWCPOlgijIgpU=
X-Received: by 2002:a05:6870:df82:b0:17a:ad5d:c977 with SMTP id
 us2-20020a056870df8200b0017aad5dc977mr1070633oab.11.1679192393269; Sat, 18
 Mar 2023 19:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATXqPy6F+gB8-1Zqh8hooXh3U_5+3xeMFZDZwYsUi=aeg@mail.gmail.com>
 <20230312200731.599706-1-masahiroy@kernel.org> <20230319011217.147183-1-steev@kali.org>
In-Reply-To: <20230319011217.147183-1-steev@kali.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Mar 2023 11:19:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNATrzAWiu36=-JXXjSt48O12OAQG4ZAtLABd_PyiE2f_VQ@mail.gmail.com>
Message-ID: <CAK7LNATrzAWiu36=-JXXjSt48O12OAQG4ZAtLABd_PyiE2f_VQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
To:     Steev Klimaszewski <steev@kali.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        terrelln@fb.com
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

On Sun, Mar 19, 2023 at 10:12=E2=80=AFAM Steev Klimaszewski <steev@kali.org=
> wrote:
>
> Hi Masahiro,
>
> On Sun, Mar 12, 2023 at 1:07=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > This series fixes some bugs, then switch to 'git archive'
> > for source package creation as suggested by Linus.
>
> I apologize if this is a stupid question, but it's not immediately appare=
nt to
> me...
>
> Previously, I was overriding the deb file output name by the setting of
> LOCALVERSION_AUTO; but with this series applied, that seems to be ignored=
?
>
> Now if I pass LOCALVERSION=3D"" I end up with e.g. linux-image-6.3.0-rc2_=
6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb
> whereas previously, I would end up with linux-image-6.3.0-rc2_6.3.0-rc2-1=
00_arm64.deb
>
> How would I restore the old naming behaviour?
>
> -- steev

The same string "6.3.0-rc2" is repeated in the file name.
The first one is what Debian calls the ABI version, and the
second one is the version of the package.
They are usually different on real Debian kernels.

LOCALVERSION affects the former, and KDEB_PKGVERSION
the second.


My recommendation is "just let it be"
because "linux-upstream_6.3.0-rc2.orig.tar.gz"
you would generate is not the real 6.3.0-rc2.


If you want to restore what you previously did,

 make deb-pkg KDEB_PKGVERSION=3D6.3.0-rc2-100

will create such a file name.




--=20
Best Regards
Masahiro Yamada
