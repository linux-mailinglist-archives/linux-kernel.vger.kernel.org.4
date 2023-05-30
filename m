Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588FD717097
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjE3WSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjE3WSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B972F7;
        Tue, 30 May 2023 15:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1891262B56;
        Tue, 30 May 2023 22:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8004CC433D2;
        Tue, 30 May 2023 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685485078;
        bh=vwr9tE3ULZdPtzpgzZTuHeLSDDR84zGhTfDyYJPjnSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fLCGOeyboGq6gIGvofqZ5WDyOW98JxPfwTr+uyWyM73WcXiwynFGa4LDsO8qL5pQS
         j752G6FJ6BjWWRlFSVHv118tIL0zSpkTKtWR7a+PLtYvefXELySPl2u6XwCpTkjA8A
         zXE4nL3f43hEMKUc0R1EiAdlhkGQ9nHYfldsTZkAImKW2beS4wVJcXSD7G4EMrDbZ6
         jajXkuEHIKg3cuoafq3ia2emhVf8MvWPMnYP5oXtLA5RpZvqFoMR+zxEvi7kO6Zng6
         TH2OEJM+O+zJQmtX8utkIy1KD+iiUrAwi/O+BiRe4fxJVp6S6mKC1L3Nn+gJNYZP5/
         vF4Tb1wTY8aTw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4eed764a10cso5466132e87.0;
        Tue, 30 May 2023 15:17:58 -0700 (PDT)
X-Gm-Message-State: AC+VfDypPeEg+anyKT3vFsLNEwmVKEmEefFZr2eWur7rqThqRvSSM6U6
        q7LinVovNYjHd72O0TaVvCw8TC4a5qsD2IuFqIc=
X-Google-Smtp-Source: ACHHUZ5Z5t1XHChQB/389XcSx9RH5xlqsIdfhb6CdgJ8CiSTjFX/w+2hAq9iTDkK9wSdAl36NcHZMHKmQjM8jU5BxCQ=
X-Received: by 2002:a2e:b1d1:0:b0:2a8:ea26:607f with SMTP id
 e17-20020a2eb1d1000000b002a8ea26607fmr1640618lja.31.1685485076499; Tue, 30
 May 2023 15:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230527092007.3008856-1-linan666@huaweicloud.com>
 <45ee7cb9-6651-46a5-87a2-dd66532084d7@huaweicloud.com> <e7b9a1ae-3dd9-84a1-561f-88d1cf3bf117@huaweicloud.com>
In-Reply-To: <e7b9a1ae-3dd9-84a1-561f-88d1cf3bf117@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 30 May 2023 15:17:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW45QLffWFsR1Fh=B2axCzSzu8qBDhN6c4TG66vyWL67=Q@mail.gmail.com>
Message-ID: <CAPhsuW45QLffWFsR1Fh=B2axCzSzu8qBDhN6c4TG66vyWL67=Q@mail.gmail.com>
Subject: Re: [PATCH] md/raid10: prioritize adding disk to 'removed' mirror
To:     Li Nan <linan666@huaweicloud.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 6:14=E2=80=AFAM Li Nan <linan666@huaweicloud.com> w=
rote:
>
>
>
> =E5=9C=A8 2023/5/29 21:00, Yu Kuai =E5=86=99=E9=81=93:
> > Hi,
> >
> > =E5=9C=A8 2023/05/27 17:20, linan666@huaweicloud.com =E5=86=99=E9=81=93=
:
> >> From: Li Nan <linan122@huawei.com>
> >>
> >> When add a new disk to raid10, it will traverse conf->mirror from star=
t
> >> and find one of the following mirror to add:
> >>    1. mirror->rdev is set to WantReplacement and it have no replacemen=
t,
> >>       set new disk to mirror->replacement.
> >>    2. no mirror->rdev, set new disk to mirror->rdev.
> >>
> >> There is a array as below (sda is set to WantReplacement):
> >>
> >>      Number   Major   Minor   RaidDevice State
> >>         0       8        0        0      active sync set-A   /dev/sda
> >>         -       0        0        1      removed
> >>         2       8       32        2      active sync set-A   /dev/sdc
> >>         3       8       48        3      active sync set-B   /dev/sdd
> >>
> >> Use 'mdadm --add' to add a new disk to this array, the new disk will
> >> become sda's replacement instead of add to removed position, which is
> >> confusing for users. Meanwhile, after new disk recovery success, sda
> >> will be set to Faulty.
> >>
> >> Prioritize adding disk to 'removed' mirror is a better choice. In the
> >> above scenario, the behavior is the same as before, except sda will no=
t
> >> be deleted. Before other disks are added, continued use sda is more
> >> reliable.
> >>
> >
> > I think this change make sense, however, it's better to do this for all
> > personality instead of just for raid10.
> >
> > Thanks,
> > Kuai
>
> raid5 is currently like this. If others are OK with this changes to
> raid10, I will modify raid1 later.

This change looks reasonable. Could you please add a mdadm test
to cover this case?

Applied to md-next.

Thanks,
Song
