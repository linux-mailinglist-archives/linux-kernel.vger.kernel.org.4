Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3258A6F4FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 07:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjECFnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 01:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjECFnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 01:43:07 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F502736
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 22:43:06 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-77d53b41462so142565241.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 22:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683092586; x=1685684586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsAmWnHYdqf8PxIDTx7JVpNph88uEqYsba4Oi5M9pys=;
        b=ERzOwCN8Snpnb6R6BMPDcCWmrygLOdCFBKCPjPfmNrRa9r/Bde491tD+EBUO98Pr0p
         PcYay5OeQR1WNpFBwkdiaJIM3+7iqCOlKWMHHMJye7Atdu9Zb1AXDB2Npq44wRmcUwya
         fT9UCI9jNpd5nzKnTAiA4RiZ5eQKjVAkYXREU/mWQP0b6z00COHDWedWjnAIFXF1mG2g
         jVQTFpY3OSTck2RfgXgOJYWJFuIRizX2uecYY6kr6Rg/WxtYCl4mc669GUNBZa33AZM1
         BV8zqOBEt5IvAUNRKH1DuV38cIW5jEK3tCOuqPoQYxu82LJovSQ7MCSld2eA2GwZEAMP
         P8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683092586; x=1685684586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsAmWnHYdqf8PxIDTx7JVpNph88uEqYsba4Oi5M9pys=;
        b=MhIevZbEgAjwW8fL8igXDSHxfRyBVlW3XYFUk1tk/vnesybc9TEgG2+CmQbMwV0L7T
         2t+n48TsFyXyei4OpHh4830kwU9l46iJkcAiZGkKJLfiLTRvlLr+OBDR7SFEl2qf/c9j
         htAMeNyeEGBHu1EpBnF1WjNK6TtxjfXSvDJntOWkhTsvlQkuVIsHgqOfE+kWEmpP/+GJ
         soo7kDeRckrDzBc+Q5hNw87smqnGORinzoOq7tl2gqEPxvfiKksILX3pzQWBCi7Nki7/
         YHXLrozM+9G6OXPJpYZyP78sFnh/z5eAWwXliR7o2ZVp/LWxUMUP0PVgHYppbyWg10qV
         boZA==
X-Gm-Message-State: AC+VfDyyr7FE4Bg0kqdAsmhtIvt+3WE6knArZpllNRV60zTBTKOMQ26r
        saF8jJHRhvi09vm2o8UumgRBKBEmGqmd2weGjfiMAieIf3k=
X-Google-Smtp-Source: ACHHUZ7ykK9Pomy4WV89OB6bwk9/UoxMqZtNJrFwUkc6HainGydy65lfIkZPMMydRIzSTL7GURxd1oHI9zPRV9FHxyI=
X-Received: by 2002:a67:fb11:0:b0:42e:38c1:8a54 with SMTP id
 d17-20020a67fb11000000b0042e38c18a54mr942121vsr.0.1683092585868; Tue, 02 May
 2023 22:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9B4avbDtIXOu4O@debian.me> <87r0s0pnim.wl-tiwai@suse.de>
 <CAAJw_ZsDdiB=b2PZydQWF2fjSULit3NWE-Bf1icBEryN-GuqUw@mail.gmail.com>
 <87fs8gp0i7.wl-tiwai@suse.de> <CAAJw_ZveoPfnBsSkHZqmLiVWATcOosR--6Ds4cdekdi=t1yV7A@mail.gmail.com>
 <b449cbf6-8286-e22d-ca87-b1bc3dce29d7@gmail.com>
In-Reply-To: <b449cbf6-8286-e22d-ca87-b1bc3dce29d7@gmail.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Wed, 3 May 2023 13:42:55 +0800
Message-ID: <CAAJw_Zur2fz7FnO-qyzd_mSoCcroCREcvHKo8sOMrrMDGxXv2g@mail.gmail.com>
Subject: Re: linux-6.4 alsa sound broken
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, lkml <linux-kernel@vger.kernel.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Linux ALSA Subsystem Development 
        <alsa-devel@alsa-project.org>,
        Linux Regressions <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 12:40=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On 5/1/23 22:03, Jeff Chua wrote:
> >> There was no description about which sound backend is used.  Is it
> >> PulseAudio, pipewire or dmix/dsnoop?
> >
> > Just pure alsautils.
> >
> > arecord -D hw:1,0,0 -f S16_LE -r 48000 recorded.wav
> > aplay -D hw:1,1,0 /local/share/sounds/alsa/Side_Right.wav
> >
> > [recorded.wav] attached.
> > [Side_Right.wav] attached.
> > aplay: version 1.2.8 by Jaroslav Kysela <perex@perex.cz>
> > arecord: version 1.2.8 by Jaroslav Kysela <perex@perex.cz>
> >
> > alsautils, alsaplugins alsalibs all using latest git pull.
>
> Are you sure you build alsa tools straight from the git repo?
> Can you also reproduce with latest stable version of these?
> Otherwise it's anyone's guess due to moving parts...


All cloned from ...
https://github.com/alsa-project/alsa-lib.git
https://github.com/alsa-project/alsa-utils.git
https://github.com/alsa-project/alsa-plugins.git

arecord is symbolic link to aplay.

I just recompiled all the alsa-lib, utils and plugins, and retest and
it's the same issue.

GNU C Library (GNU libc) development release version 2.37.9000.
gcc version 11.3.1 20230315 (GCC)
binutils-2.40

Linux kernel is ...
commit 348551ddaf311c76b01cdcbaf61b6fef06a49144 (HEAD -> master,
origin/master, origin/HEAD)
Merge: 7df047b3f0aa b7badd752de0
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue May 2 15:40:41 2023 -0700


Thanks,
Jeff
