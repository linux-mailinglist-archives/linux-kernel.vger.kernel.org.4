Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E08164CE84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiLNQ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiLNQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:57:32 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634F52A415
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:57:21 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id z12so2953765qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agVDFFKJFuVbFCeaUoWdnFDXYV/1IHy12toe/hpOLu0=;
        b=EPMA72F12RqVSbESZuY4zDHMwGmAhtgdnQrZBEqlSxQqpM4M43NRMoXyT7MrSEq6ZQ
         gPnS1j+39ZREYQF4hSyiy7NUROLJX0cAULmFC7FmKNW+aml7e0EFDxAKdHajk514q5/a
         +kyKfiSWjF5opd9BrR6Do2kfOf4sVXNKPlszM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agVDFFKJFuVbFCeaUoWdnFDXYV/1IHy12toe/hpOLu0=;
        b=Eu00Crp0pOqpIaU0vRj2+wAbE1SFuh6JIcmcmHFWZUNWN2vcDdhs55RVURAyyMC8PB
         IU2yovd9nmTBBkEL64B9VtasHeQNAPNIhNDuYPSjP1sXDdAs/61Bm1UUrUYetP5TjDFI
         dAVXDE1Cl5aBkomQw2LPzvUvLCAYMV2AyVdXcXASPA9FPkl0v9N0/5A4Gy6RR05LAb+J
         yL8XoHka9E/HuNqwCvtF+GC1n2OO/d0tA+VIEa1fddhhsG3gphv0QQe83V73Xy/IrCeB
         E3sKupvrf61QwxVkHsxAuU9mtCwNUVGEbTGH7Y/XYy5Qflxgo58o/VK/t8pSr5pGcLHL
         tU3A==
X-Gm-Message-State: ANoB5pnaQdlR09xWxOHKKR//jNeBXqA562968zst7eku1vjybEWOq+xY
        5etjqsDLkb27PLSj31nrVvzxJlkVgLyuK53d
X-Google-Smtp-Source: AA0mqf43OqRWNX0Go5PfQnCBy+88ena5KxoAHG3DltvuD1qy94Uv00jmbchzHhxT9+OMAUhqQCM5IA==
X-Received: by 2002:a05:622a:1244:b0:3a4:efd9:3159 with SMTP id z4-20020a05622a124400b003a4efd93159mr33763576qtx.3.1671037040177;
        Wed, 14 Dec 2022 08:57:20 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a240600b006fcb4e01345sm10538404qkn.24.2022.12.14.08.57.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:57:19 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id d13so184130qvj.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:57:19 -0800 (PST)
X-Received: by 2002:a05:6214:a45:b0:4c7:20e7:a580 with SMTP id
 ee5-20020a0562140a4500b004c720e7a580mr32561826qvb.43.1671037039015; Wed, 14
 Dec 2022 08:57:19 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txGCMqyriq_xiwgFCUBa-PpHvSuRQuptAHusHcjpH+zqA@mail.gmail.com>
 <CAHk-=whVsxgtwvnK2=WRvs_i+miknfB2R7dQ4U8oooBFJZYH6w@mail.gmail.com> <4b1f104f-3b2a-532d-3354-11c68c5b9aa6@amd.com>
In-Reply-To: <4b1f104f-3b2a-532d-3354-11c68c5b9aa6@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Dec 2022 08:57:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whnOofeSoLu2wWN7H0GZQmdj6R_T0b8MavC1zLvgCUapA@mail.gmail.com>
Message-ID: <CAHk-=whnOofeSoLu2wWN7H0GZQmdj6R_T0b8MavC1zLvgCUapA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.2-rc1
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 12:05 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Anyway we need to re-apply b09d6acba1d9 which should be trivial.

Note that my resolution did exactly that (*), it's just that when I
double-checked against Dave's suggested merge that I noticed I'd done
things differently than he did.

(*) Well, when I say "did exactly that" I don't actually know some of
the other fencing changes that happened, so there may be a reason why
something further should still be done.  So I can only point to my
merge commit a594533df0f6 and ask people to verify.

It does all at least work for me. Knock wood.

                  Linus
