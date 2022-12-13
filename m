Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400DA64BDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiLMUOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbiLMUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:14:35 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EB7220CA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:14:33 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id pp21so10361972qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fKMoGrNnuOijjqdWvmZKOjtUthKrCgRAryxHWgKTvTI=;
        b=aBrYrRL2ar8mCkjH5k3/E9EPWTrWLDai93bT53U4cmelzM+QccMJRV/sHCAwQtsWX2
         YP9rN38/TYWaaEgUr6x4g1dHK27Wamedi2WQuzttxWDpjhtLhul8RxzdW6ihBkoX+7uy
         7EaTaoM8+GYmKmjTjefxq9yBpCoB52EvJjsOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKMoGrNnuOijjqdWvmZKOjtUthKrCgRAryxHWgKTvTI=;
        b=DvUc4jp+1tPY/jyYMTGq1ydGT7sTYy3wm1L8b4zaxysrjuUl/9DRNUqbbYmJjKOZ/a
         r1RhKRzvCUPyXVHrE8hueN4GJnccFCmm4kWDpwZVjyNmlvBIA5SneSb3hvdR9VP77mvQ
         ZhvzLnzCv2F1vayN1dQQKidzMr6rLFLGzGScrkz++4SVfvhmYSvLHX/Jdz1ceUkhGp2G
         ceijMZ3SY/6xHeia0szhUWdhAetp6Pc42EcQEcafyRahheW4BzFkc8Ex44JVFss+L1u1
         bw6KqybS9ANUW/WcuwSb6cjJtHUEd0kFUm2iE/xix43K+LxUbhzwUk0713oJclTfuQ1p
         V1IA==
X-Gm-Message-State: ANoB5pnUDTza8nxkg87y742g8Xxu+MkD4+shGfBChiurqm0Qx0ofjkwo
        FoME43dgb6pJGaRS8daJFQWClrThskxnz4kX
X-Google-Smtp-Source: AA0mqf4UYSWCApwac537wEVQV0QBgEGOPCLjb0uBn7DnAVifgkHDBk1AUuBElsVTqXj/wpj3X3yHgA==
X-Received: by 2002:a0c:ee42:0:b0:4c6:9271:a037 with SMTP id m2-20020a0cee42000000b004c69271a037mr26000304qvs.30.1670962472212;
        Tue, 13 Dec 2022 12:14:32 -0800 (PST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006cfc01b4461sm8446426qki.118.2022.12.13.12.14.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 12:14:31 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id fu10so893211qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:14:31 -0800 (PST)
X-Received: by 2002:a05:622a:5a87:b0:3a5:47de:a214 with SMTP id
 fz7-20020a05622a5a8700b003a547dea214mr71128740qtb.304.1670962470979; Tue, 13
 Dec 2022 12:14:30 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txGCMqyriq_xiwgFCUBa-PpHvSuRQuptAHusHcjpH+zqA@mail.gmail.com>
In-Reply-To: <CAPM=9txGCMqyriq_xiwgFCUBa-PpHvSuRQuptAHusHcjpH+zqA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 12:14:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVsxgtwvnK2=WRvs_i+miknfB2R7dQ4U8oooBFJZYH6w@mail.gmail.com>
Message-ID: <CAHk-=whVsxgtwvnK2=WRvs_i+miknfB2R7dQ4U8oooBFJZYH6w@mail.gmail.com>
Subject: Re: [git pull] drm for 6.2-rc1
To:     Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 6:56 PM Dave Airlie <airlied@gmail.com> wrote:
>
> There are a bunch of conflicts, one in amdgpu is a bit nasty, I've
> cc'ed Christian/Alex to make sure they know to check whatever
> resolution you find. The one I have is what we have in drm-tip tree.

Hmm. My merge resolution is slightly different from yours.

You seem to have basically dropped commit b09d6acba1d9 ("drm/amdgpu:
handle gang submit before VMID").

Now, there are other fence changes in the drm tree that may mean that
that commit *should* be dropped, so it's entirely possible that my
resolution which kept that ordering change might be wrong and your
resolution that just took the drm tip code is the right one.

Christian? Alex? Can you please double-check what I just pushed out?

            Linus
