Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A5E742A18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjF2P5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjF2P4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95091B2;
        Thu, 29 Jun 2023 08:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE6461595;
        Thu, 29 Jun 2023 15:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404DBC433CC;
        Thu, 29 Jun 2023 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688054205;
        bh=ntaECX/FHsFFGgeyUbNZ1KY0K6UdfCSvUzLiI0C2pt4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YTHh4lPKjfGm4V+jsNOOHqSOmSH8zECnAvx2QGaA5L9B+34BXHfyrjGH2ebNdQSCp
         z24dISt9xo5dLoYDkB/md9Gen4WRvB7jUyHNamjzg0JjHbUZml0kvrBd5M5WCUIm4i
         iuFiYaWkUnqrpFyZHP5qF9hzdBYTKjJwPMUgF82b/P3D+3JkByNBsX29aQG5ByQzin
         x2bV+YblwKYmqqdGxYkre/iSGd2YUcqk+0SBFFgDSkmRRZIZuJGsozxhK2iH/1D0v/
         0cpBza8IBYpPsX1CsOpkJMNCA/+9h1aag81UD8vU898NjppycKbcedMgkpiW/3OpfQ
         HfU4U16uldiLQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fb7589b187so1366417e87.1;
        Thu, 29 Jun 2023 08:56:45 -0700 (PDT)
X-Gm-Message-State: ABy/qLbziwte0jDylUwgp0LxJMgyy90f9CVcCgEpIBo6DyZhRCpGdfcs
        FglC+q7ROD9FXX8pY/ujL4NVWOAuKq4NYN/Ph/k=
X-Google-Smtp-Source: APBJJlFdHyefES6tzfD8ZQrhvwBMBEgAqkQ8eU+Vus2nXzUOKIfYfGjX0nN2GzvafsphwqvMrE3PoOhQ+pDOJnBvQYw=
X-Received: by 2002:ac2:58fb:0:b0:4fb:9772:6639 with SMTP id
 v27-20020ac258fb000000b004fb97726639mr270266lfo.6.1688054203258; Thu, 29 Jun
 2023 08:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <ZJ2H5FWuo9oDMgPm@debian> <be9320b5-7613-be0f-ffcd-4b3041ea5836@huaweicloud.com>
 <13abe42f-2f5f-cbaf-21b8-baa4516963aa@leemhuis.info> <CAPhsuW4Wf+PLDCZ7JpHzVT81ubj1Y6MCyLm-BWcVmB1jRqYEGg@mail.gmail.com>
In-Reply-To: <CAPhsuW4Wf+PLDCZ7JpHzVT81ubj1Y6MCyLm-BWcVmB1jRqYEGg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 29 Jun 2023 08:56:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7VK6O6RKQTAcAVk4XxUzNALUW5nKMnMFkm3pW+4F23yw@mail.gmail.com>
Message-ID: <CAPhsuW7VK6O6RKQTAcAVk4XxUzNALUW5nKMnMFkm3pW+4F23yw@mail.gmail.com>
Subject: Re: mainline build failure due to 8295efbe68c0 ("md/raid1-10: factor
 out a helper to submit normal write")
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Oops, didn't really add Jens in the previous email.

Add Jens now.

On Thu, Jun 29, 2023 at 8:55=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> + Jens,
>
> On Thu, Jun 29, 2023 at 7:10=E2=80=AFAM Linux regression tracking (Thorst=
en
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > On 29.06.23 15:56, Yu Kuai wrote:
> > >
> > > =E5=9C=A8 2023/06/29 21:32, Sudip Mukherjee (Codethink) =E5=86=99=E9=
=81=93:
> > >> The latest mainline kernel branch fails to build x86_64, arm64 and a=
rm
> > >> allmodconfig
> >
> > Thx for the report.
> >
> > > Thanks for the testing, which branch are you testing?
> > >
> > > This problem is already fixed in latest mainline kernel:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?id=3Db5a99602b74bbfa655be509c615181dd95b0719e
>
> Hi Jens,
>
> The fix is in the for-6.5/block-late branch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/com=
mit/?h=3Dfor-6.5/block-late&id=3Db5a99602b74bbfa655be509c615181dd95b0719e
>
> Would you send a pull request with it? Or would you prefer
> some other solution for the issue?
>
> AFAICT, it will fix clang build with RANDSTRUCT.
>
> Thanks,
> Song
>
> >
> > And thx for the reply. :-D
> >
> > FWIW, that fix afaics is still in -next and hasn't reached mainline yet=
.
> > But I guess that will change within a few days.
> >
> > >> #regzbot introduced: 8295efbe68c080047e98d9c0eb5cb933b238a8cb
> >
> > #regzbot fix: b5a99602b74bbfa6
> > #regzbot dup-of: https://lore.kernel.org/all/ZJ2M4yqnOCqqGWH0@debian/
> > #regzbot ignore-activity
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
