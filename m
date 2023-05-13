Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C5701386
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbjEMAum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbjEMAuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8910FF;
        Fri, 12 May 2023 17:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6207C659B6;
        Sat, 13 May 2023 00:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D31C4339E;
        Sat, 13 May 2023 00:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683939038;
        bh=GbodXPhUDzA2y25RKnC6MEc5TY38yYi8hvS3Ibsjxmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JpzI2vOq+wcrAZIsLQPllxW2EmeEOA4bxR1+OeFcho14sN1i5ayBKGiFrdM9kBnGr
         K/VZTR5EFnVwN7Crlt6jE3TJMycLoZBWEPi1M0k8KWYDOMve+uwZ8eUGloLlZt78WO
         6beQj1ccsJVVTR7AdGeIpDTm1/7h7d/aPABtbapt/OmMaxzQ7CTFupMHSc992EFk6Q
         ePHnQt4CW8qB33yXpji4CWNxpzQIoQUqoe44Z75qhoj97OJjjZMUJ+OhxEhlq9nVqH
         9hSPEU8mgW8eE9y9l5oykfS+caHGcs/YBx94dAiK3GXyM+Ic6UhoUM2gbVigucmmL6
         UhksAuGeGieXw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ac82912a59so113029161fa.3;
        Fri, 12 May 2023 17:50:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDwpsfguHvm8SfEt9fgVXp2nZwK9h+B21vNDWVzuCkevkxRa4Z0J
        sL2brHOXgU0eTGQT5zDx0GRUausDhePX1mn7C7Y=
X-Google-Smtp-Source: ACHHUZ4R1JOuJF5J10lcXTDJ4SLJ9jC9CL8uGfb601uYausGJeCSuvJIAsW4APHLl6hnJ+tXH2NLYawXgNsl5sGE/ko=
X-Received: by 2002:a2e:9590:0:b0:2a8:a859:b5c7 with SMTP id
 w16-20020a2e9590000000b002a8a859b5c7mr4688522ljh.0.1683939036756; Fri, 12 May
 2023 17:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230426082031.1299149-1-yukuai1@huaweicloud.com> <a7246f63-b499-8b26-e27a-3d16abc18ced@huaweicloud.com>
In-Reply-To: <a7246f63-b499-8b26-e27a-3d16abc18ced@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 12 May 2023 17:50:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4ZVs0QbWhHibL4A4LG72Q9bPabjCY7ZZkcshTYf+vhbg@mail.gmail.com>
Message-ID: <CAPhsuW4ZVs0QbWhHibL4A4LG72Q9bPabjCY7ZZkcshTYf+vhbg@mail.gmail.com>
Subject: Re: [PATCH -next v2 0/7] limit the number of plugged bio
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     akpm@osdl.org, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
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

On Fri, May 12, 2023 at 2:43=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/04/26 16:20, Yu Kuai =E5=86=99=E9=81=93:
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > Changes in v2:
> >   - remove the patch to rename raid1-10.c
> >
> > This patchset tries to limit the number of plugged bio for raid1 and
> > raid10, which is done in the last patch, other patches are some refacto=
r
> > and optimizations.
> >
> > This patchset is tested with a new test [1], this test triggers dirty
> > pages writeback for 10s, and in the meantime checks disk inflight.
> >
> > Before this patchset, test will fail because inflight exceed threshold
> > (threshold is set to 4096 in the test, in theory this can be mutch
> >   greater as long as there are enough dirty pages and memory).
> >
> > After this patchset, inflight is within 96 (MAX_PLUG_BIO * copies).
> >
> > [1] https://lore.kernel.org/linux-raid/20230426073447.1294916-1-yukuai1=
@huaweicloud.com/
>
> Friendly ping...

I am sorry for the delay.

The set looks good overall, but I will need some more time to take a closer
look. A few comments/questions:

1. For functions in raid1-10.c, let's prefix them with raid1_ instead of md=
_*.
2. Do we need unplug_wq to be per-bitmap? Would a shared queue work?

Thanks,
Song
