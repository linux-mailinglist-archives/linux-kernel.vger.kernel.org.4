Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D711724F12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbjFFVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjFFVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA18C1702;
        Tue,  6 Jun 2023 14:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 572D3631D6;
        Tue,  6 Jun 2023 21:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49B3C433A1;
        Tue,  6 Jun 2023 21:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686088482;
        bh=00fM4J5ExwsLDa6lKHnMAvuGz2WILyMJmqh4sSd5tZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hU4YD8fSMEEIv/3O5ulQBbPnvopYIGcOnKJRz52BRTzR8Du3T4F9wnWI0kS2PqgFz
         cdysNo3A8miheZBViUfVBb1mG1gAtms5bwy13AFjaR5S0hCjFX63Ee8+1jdoWnj9g0
         /Xb0UlMzcNrZluToeg7P7oSIcaTVc3MOc2RyVlwHqMO7zgll5FZiI3oMQv1/d0e8YP
         8cSQujH6+oOo+TDDhnpnnr/NfsOVBt/ed7oJEOKoGJTJWqED/0mEJuIxHczGiRg5WS
         xhJ/8F0NIXxjehFLIpgI9TW+60uP0CO4nkbqVs1RLD3Of7zJoHQ430GqNw0lHvOHul
         yHiE/crx1U8xg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f620583bc2so4400167e87.1;
        Tue, 06 Jun 2023 14:54:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDyoRPOJ9VVeEMJtTVAxr24XJ9bQxvzZrusH2XBpTAHt8ketFFOg
        Jxl0EM5WJq/hz7qc2rOr0v+Jx0/UUdG7oiUa20A=
X-Google-Smtp-Source: ACHHUZ6oZumzzmmHdIlrBHRT8Ao9id4ZWjpLD91eyRoPXeEEJ78Q8sr3NmHL7eW444bRJlnXQq9//v8+AqCaqYWA+K8=
X-Received: by 2002:a2e:9f04:0:b0:2b1:a874:34c9 with SMTP id
 u4-20020a2e9f04000000b002b1a87434c9mr1787047ljk.22.1686088480677; Tue, 06 Jun
 2023 14:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Jun 2023 14:54:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7u95vMc2KB7HJkNNmEgn6XyGdJPnvstL1-qvK64h=uBA@mail.gmail.com>
Message-ID: <CAPhsuW7u95vMc2KB7HJkNNmEgn6XyGdJPnvstL1-qvK64h=uBA@mail.gmail.com>
Subject: Re: [PATCH -next v3 0/7] limit the number of plugged bio
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, akpm@osdl.org, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Mon, May 29, 2023 at 6:14=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v3:
>  - prefix function with 'raid1_' instead of 'md_'
>  - use a globle workequeue instead of per bitmap in patch 5
> Changes in v2:
>  - remove the patch to rename raid1-10.c
>
> Yu Kuai (7):
>   md/raid10: prevent soft lockup while flush writes
>   md/raid1-10: factor out a helper to add bio to plug
>   md/raid1-10: factor out a helper to submit normal write
>   md/raid1-10: submit write io directly if bitmap is not enabled
>   md/md-bitmap: add a new helper to unplug bitmap asynchrously
>   md/raid1-10: don't handle pluged bio by daemon thread
>   md/raid1-10: limit the number of plugged bio

With the fix on 5/7, applied to md-next.

Thanks,
Song


>
>  drivers/md/md-bitmap.c | 33 ++++++++++++++++++++--
>  drivers/md/md-bitmap.h |  8 ++++++
>  drivers/md/md.c        |  9 ++++++
>  drivers/md/md.h        |  1 +
>  drivers/md/raid1-10.c  | 63 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/md/raid1.c     | 29 ++++---------------
>  drivers/md/raid10.c    | 47 +++++++------------------------
>  7 files changed, 126 insertions(+), 64 deletions(-)
>
> --
> 2.39.2
>
