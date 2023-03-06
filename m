Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B91F6ACB47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCFRvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCFRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:51:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523366A06F;
        Mon,  6 Mar 2023 09:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF3766108D;
        Mon,  6 Mar 2023 17:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244E6C433A0;
        Mon,  6 Mar 2023 17:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678124929;
        bh=p+285oYfxGT6oBTqHONjb6ZZM55PJciuUnjkNQRO/l8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mLukCiu6l58LxMHAFOYSqQ4tDWy7q06yDh7VqDDp6QPQEu+lL8E2cmYL2RViflJMl
         HBscU23mm//Dr/O3xDo/uCvbaCP1w2RRDHfiQaKnvYBPn24+sQeWtLkGA6kYYrQZC8
         420Av6Crf12BbjSeH5z/C99Q20K6JTHpOgAwaeYLG1EeASUMNePxPHzOcs3dLfZ6xe
         Cjf5beR8XB3IgiqtB4IX6LpDWjnhnUVWQRGtZspfftRWxUbgOeo81ecwU7LKEZNTiD
         29ZYgnmooHENwAexUIstb8rtfNEjvSTZ3lp7ai8Rt+fZ0oFF6Wa0Rh5JQxgVGPC36Y
         ZY4benJ/1LLBQ==
Received: by mail-lf1-f42.google.com with SMTP id k14so13858269lfj.7;
        Mon, 06 Mar 2023 09:48:49 -0800 (PST)
X-Gm-Message-State: AO0yUKWeQBU/XCS59KOf0/JflZA73iJfy3c3AnLqlllLvbt36v1t+C8E
        DLdXjnA3w0Nk3VylKDyM7upMfN72d79eZby96So=
X-Google-Smtp-Source: AK7set96s98VtUg4tvq8jDeVcoN4cW8Y4Vt0icc1TFcZ9YMAnc7rz9TIMDGuN7rDsHZUSneArEil7nQkSsY+3mQdkcE=
X-Received: by 2002:ac2:5ece:0:b0:4dd:a74d:aca3 with SMTP id
 d14-20020ac25ece000000b004dda74daca3mr3592321lfq.3.1678124927094; Mon, 06 Mar
 2023 09:48:47 -0800 (PST)
MIME-Version: 1.0
References: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>
 <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com> <167805126796.8008.3635368722810568057@noble.neil.brown.name>
In-Reply-To: <167805126796.8008.3635368722810568057@noble.neil.brown.name>
From:   Song Liu <song@kernel.org>
Date:   Mon, 6 Mar 2023 09:48:34 -0800
X-Gmail-Original-Message-ID: <CAPhsuW64R2ze1AYZhEmQcGf0cKBjjX=4EZZowD+=Cr=VPg1QYg@mail.gmail.com>
Message-ID: <CAPhsuW64R2ze1AYZhEmQcGf0cKBjjX=4EZZowD+=Cr=VPg1QYg@mail.gmail.com>
Subject: Re: [regression] Bug 217074 - upgrading to kernel 6.1.12 from 5.15.x
 can no longer assemble software raid0
To:     NeilBrown <neilb@suse.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jes.Sorensen@gmail.com, linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nikolay Kichukov <hijacker@oldum.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 5, 2023 at 1:21=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Sat, 04 Mar 2023, Song Liu wrote:
> > + Jes.
> >
> > It appeared to me that we can assemble the array if we have any of the
> > following:
> > 1. Enable CONFIG_BLOCK_LEGACY_AUTOLOAD;
> > 2. Have a valid /etc/mdadm.conf;
> > 3. Update mdadm to handle this case. (I tried some ugly hacks, which wo=
rked but
> >     weren't clean).
> >
> > Since we eventually would like to get rid of CONFIG_BLOCK_LEGACY_AUTOLO=
AD, I
> > think we need mdadm to handle this properly. But the logistics might
> > be complicated, as
> > mdadm are shipped separately.
> >
> > Jes, what do you think about this? AFAICT, we need to update the logic =
in
> > mdopen.c:create_mddev().
>
> mdadm already handles this, but only if
>    CREATE names=3Dyes
> is present in /etc/mdadm.conf
>
> Maybe we should flip the default for the next mdadm release, and patch
> the kernel (with a stable backport) to select BLOCK_LEGACY_AUTOLOAD if
> BLK_DEV_MD=3Dm
> Then revert that - say - 6 months after the new mdadm is released.

I like this idea. I guess we also need to select BLOCK_LEGACY_AUTOLOAD
if BLK_DEV_MD=3Dy?

Thanks,
Song
