Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24AB74AD83
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjGGJG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGGJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E311FED;
        Fri,  7 Jul 2023 02:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98385618A6;
        Fri,  7 Jul 2023 09:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090BBC433C9;
        Fri,  7 Jul 2023 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688720814;
        bh=ElpIwjpZa9Cy906H5ZxmudthuG5AQ3NqRQ9U5q9ON2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xy+XR4N+a7rEHW7AJ+5oa/3qTjrRvL8u/YhGCrn6nocuvUYThjZM6l8E8+F9DiydW
         4rLoFpR/jnTRgHLp2Aq7gzzz1bt/oAJXJFXbvLGEOMjoJ61ByRF3oCOIAR0hoFgr57
         RTJfYinxPlbmNy2+w1GDTfEywgv65ZHSfJee/sRd+axUKgRrw42tgulj848GVe24uM
         gsE2CFA6bWAbmBUlAEnlxt7jtJ3OjcQ0bw24MjTBeUJXS4sYhxpq9D89JM+uEn4OIb
         IWUBwplPJiRCjdQntxu2u+UJb5rIMK2BtRC7YNJFuMqzPxdCyM1zqnSIWU1Rn/ah6U
         wa3IFynN1D9vg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so24263081fa.0;
        Fri, 07 Jul 2023 02:06:53 -0700 (PDT)
X-Gm-Message-State: ABy/qLZEBSqVwfejEo2EdOAMg7QbI62sfNKhr1I2Oh1aUW133ZY843d7
        RCk9kdPHAhz6QkHixRKiDHdBwIfAPuOfXpWYQII=
X-Google-Smtp-Source: APBJJlFH8ifMElYA4Gp9wJYwaeBTIazIExTambkfNaE4klP4pc4kbg2JkuKd2Os1+QUnqeAXio8DcpQ9EdwgO2AbGi0=
X-Received: by 2002:a2e:3317:0:b0:2b6:cb55:72bc with SMTP id
 d23-20020a2e3317000000b002b6cb5572bcmr3500359ljc.1.1688720812072; Fri, 07 Jul
 2023 02:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230628012931.88911-1-yukuai1@huaweicloud.com>
 <20230628012931.88911-2-yukuai1@huaweicloud.com> <10137916-9feb-8ab6-e157-8c66bbad1932@huaweicloud.com>
In-Reply-To: <10137916-9feb-8ab6-e157-8c66bbad1932@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 7 Jul 2023 17:06:39 +0800
X-Gmail-Original-Message-ID: <CAPhsuW4XyaOG29Vg9OaYEhJxqxi+YbEY_16KDdvJ0p868UPxZQ@mail.gmail.com>
Message-ID: <CAPhsuW4XyaOG29Vg9OaYEhJxqxi+YbEY_16KDdvJ0p868UPxZQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] md: don't quiesce in mddev_suspend()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, colyli@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
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

On Wed, Jun 28, 2023 at 2:29=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/28 9:29, Yu Kuai =E5=86=99=E9=81=93:
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > Some levels doesn't implement "pers->quiesce", for example
> > raid0_quiesce() is empty, and now that all levels will drop 'active_io'
> > until io is done, wait for 'active_io' to be 0 is enough to make sure a=
ll
> > normal io is done, and percpu_ref_kill() for 'active_io' will make sure
> > no new normal io can be dispatched. There is no need to call
> > "pers->quiesce" anymore from mddev_suspend().
>
> Just found that this patch actually prevent null_ptr_deref in some cases
> that "pers->quiesce" is NULl for some personalities, and caller of
> mddev_suspend() doesn't check this. For example, suspend_lo_store()
> checks "pers->quiesce" is not NULL before calling mddev_suspend(), while
> suspend_hi_store() doesn't.

Let's refactor the code so that suspend_lo_store() and suspend_hi_store()
share code for this logic.

Thanks,
Song
