Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8956F4C12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjEBVVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEBVVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:21:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E6D19AD
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:21:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9619095f479so499669266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683062469; x=1685654469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzcMzqLnc5vNL8n9f33rayTWsgoEsdQ3LWpXeai0x68=;
        b=L6GWhipoouv400oFasis646RDfDksMeWYa6MWc4l/P5HCkcxY+oYOIBoT3b4/YqDS4
         416f1ec2Bpkjb6SIXQ/KYtEKTPJgvC5RLSbGNwrQKXOol0gfHnJvQje2SJ1xRPAWTR/1
         KqHvgX3/ofniDRw1NCL5oOdAoNBIQnK2dQ0xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062469; x=1685654469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzcMzqLnc5vNL8n9f33rayTWsgoEsdQ3LWpXeai0x68=;
        b=c9W/StdOrA4aQ8N4bFMTuTUQb2RUvv6G9hwD8Pdsz4Bf812EW0SCrlDLOYsHNblQOk
         i8fGCWRhYMrhKtJoa82tWAShW+3Z4d5/4v8fu6IW8ErQu8uhiQw1Kpv34rBptYmanqyp
         SBezTBSlBrwYVZD9qThOT/4Y78d0MEQdcjr/+YbNEHvhX54F6JgeJO0EDKaFQ8bzvesD
         Ap/4PNAPJWS5B0VN1FldqM4XrG/W/XgNjiSDKoM8av//sm8VqD726kj/5YOShpqfl7Dy
         kq3lRsEV7hzt6SqTxe+EGlDcfM0CO+jY/bsRiHC6Lrjkry4++9DoNqh5IjuC+dMw1tdV
         TTBg==
X-Gm-Message-State: AC+VfDyiThlus0NNnl4JLxsjuwtU+VjnyNYt/p8XrigniQcNEoVUFniw
        fp2tKmU9q5ero4/Axn/+GA0tBBCF2YttjSzLZsqPrQ==
X-Google-Smtp-Source: ACHHUZ6ZCh59tscPFHz6x0cSL2A04xxAHGlt0aRCowP1lcrLsi5n7pDMHfZ0Xb6xv1cG5aiEDDQ9hw==
X-Received: by 2002:a17:907:31c3:b0:94f:788:6bc with SMTP id xf3-20020a17090731c300b0094f078806bcmr1820001ejb.37.1683062469236;
        Tue, 02 May 2023 14:21:09 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id ia1-20020a170907a06100b009614fea69e8sm4448563ejc.74.2023.05.02.14.21.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 14:21:07 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f256b84f14so59895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 14:21:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1e20:b0:3f1:70d1:21a6 with SMTP id
 ay32-20020a05600c1e2000b003f170d121a6mr66599wmb.0.1683062466606; Tue, 02 May
 2023 14:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230428135414.v3.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <20230430085300.3173-1-hdanton@sina.com>
In-Reply-To: <20230430085300.3173-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 May 2023 14:20:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLHZfNN5cGMUEnvv17obVK-MLmWHJHx=MV55Q1YxczOA@mail.gmail.com>
Message-ID: <CAD=FV=WLHZfNN5cGMUEnvv17obVK-MLmWHJHx=MV55Q1YxczOA@mail.gmail.com>
Subject: Re: [PATCH v3] migrate_pages: Avoid blocking for IO in MIGRATE_SYNC_LIGHT
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 30, 2023 at 1:53=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On 28 Apr 2023 13:54:38 -0700 Douglas Anderson <dianders@chromium.org>
> > The MIGRATE_SYNC_LIGHT mode is intended to block for things that will
> > finish quickly but not for things that will take a long time. Exactly
> > how long is too long is not well defined, but waits of tens of
> > milliseconds is likely non-ideal.
> >
> > When putting a Chromebook under memory pressure (opening over 90 tabs
> > on a 4GB machine) it was fairly easy to see delays waiting for some
> > locks in the kcompactd code path of > 100 ms. While the laptop wasn't
> > amazingly usable in this state, it was still limping along and this
> > state isn't something artificial. Sometimes we simply end up with a
> > lot of memory pressure.
>
> Given longer than 100ms stall, this can not be a correct fix if the
> hardware fails to do more than ten IOs a second.
>
> OTOH given some pages reclaimed for compaction to make forward progress
> before kswapd wakes kcompactd up, this can not be a fix without spotting
> the cause of the stall.

Right that the system is in pretty bad shape when this happens and
it's not very effective at doing IO or much of anything because it's
under bad memory pressure.

I guess my first thought is that, when this happens then a process
holding the lock gets preempted and doesn't get scheduled back in for
a while. That _should_ be possible, right? In the case where I'm
reproducing this then all the CPUs would be super busy madly trying to
compress / decompress zram, so it doesn't surprise me that a process
could get context switched out for a while.

-Doug
