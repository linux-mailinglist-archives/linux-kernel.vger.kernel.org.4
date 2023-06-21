Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7370E7392E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjFUXLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1931BE4;
        Wed, 21 Jun 2023 16:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA968616FB;
        Wed, 21 Jun 2023 23:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476A0C433C9;
        Wed, 21 Jun 2023 23:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687389081;
        bh=MXd+ysMQSxosQwi/fOsmNzE2p7+1D7huOkrOaZM+5q4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nU1BToblH8kFEJyfism/CavNX0QRyjV10wMcIIBUdSN+NoaAsBg6hQjBTsnlyQakg
         V6V2BAmtClCIxvmgR4/3BO+Uydd0y68BZND36yrl41/FtJKBUktEZ25GmG/AsjpWSU
         CXKifkm11uaFimusjZolWy1CwlfKQhJXwg4gKS9zKuQcw0eFOeCijtfkJ6C1677FKa
         0e8CrxhH0qYKnuOHrmpaaSriBVTii+jqieZpzxSzxSyIOryvkRgrsezAhGq5U1hCME
         3ZYw1nZEbaOzmTkqV7o0e9osL7dYBmmqAvWdGtg+Ig1ZGkH4qJF+2A+12Ky5DpuSPw
         u4h9+rCqMddTw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f8775126d3so4562219e87.1;
        Wed, 21 Jun 2023 16:11:21 -0700 (PDT)
X-Gm-Message-State: AC+VfDzV9j4eimMM6fL/TwNQoZ0hj+VVh/p+5eHJztTcjuSswVGYZVIu
        tsUqmYcuNusDupVcofg0R6Dp+lZd17mAoMO+1+o=
X-Google-Smtp-Source: ACHHUZ5iWFwUvqwbbSZCxWUCg2uxl9kxhfsCToTqTPHUErms1tR9YYanjFRbPi2lx7ZbWesT4OeesU1x5C5+WcCg1PI=
X-Received: by 2002:a05:6512:b8c:b0:4f9:5efd:f462 with SMTP id
 b12-20020a0565120b8c00b004f95efdf462mr1962537lfv.6.1687389079313; Wed, 21 Jun
 2023 16:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 21 Jun 2023 16:11:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW44DcovKzuQeiT3kjU_SHJ+v2QHowxqo+Vbvwum=v=NOg@mail.gmail.com>
Message-ID: <CAPhsuW44DcovKzuQeiT3kjU_SHJ+v2QHowxqo+Vbvwum=v=NOg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] md: fix and refactor io accounting and 'active_io'
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, pmenzel@molgen.mpg.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Wed, Jun 21, 2023 at 1:52=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v2:
>  - fix some typos;
>  - add review tag;
>
> This patchset do following things:
>  - make io accounting for all raid levels consistent, patch 1, 3-5;
>  - enable io accounting for all raid levels, patch 6-8;
>  - hold 'active_io' before io start to dispatch, and release 'active_io'
>  when io is done, make mddev_suspend() will wait for io to be done, patch=
 2
>
> This patch set also prepare to synchronize io and raid configuration, mak=
e
> it possible to use 'active_io' in common layer to judge if normal io is
> in flight.
>
> Yu Kuai (8):
>   md: move initialization and destruction of 'io_acct_set' to md.c
>   md: also clone new io if io accounting is disabled
>   raid5: fix missing io accounting in raid5_align_endio()
>   md/raid1: switch to use md_account_bio() for io accounting
>   md/raid10: switch to use md_account_bio() for io accounting
>   md/md-multipath: enable io accounting
>   md/md-linear: enable io accounting
>   md/md-faulty: enable io accounting

Applied to md-next.

Thanks,
Song

>
>  drivers/md/md-faulty.c    |  2 +
>  drivers/md/md-linear.c    |  1 +
>  drivers/md/md-multipath.c |  1 +
>  drivers/md/md.c           | 78 +++++++++++++++++++--------------------
>  drivers/md/md.h           |  6 +--
>  drivers/md/raid0.c        | 16 +-------
>  drivers/md/raid1.c        | 14 +++----
>  drivers/md/raid1.h        |  1 -
>  drivers/md/raid10.c       | 20 +++++-----
>  drivers/md/raid10.h       |  1 -
>  drivers/md/raid5.c        | 70 ++++++++++-------------------------
>  11 files changed, 79 insertions(+), 131 deletions(-)
>
> --
> 2.39.2
>
