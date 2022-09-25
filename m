Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB225E938E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiIYOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIYOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:02:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF06725594
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:02:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso4470164pjm.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zWgUGM/JTFTwLtZo+7BxbsDySLaY5hFmmAqfaepFGCs=;
        b=ft+4GDXYKoIE7aQZAlGuHYutee1Z+zqC3UE+3bR6emon/0nAyDo52cDGApr9lAM9gc
         gsb4AlSigFnAizXHShMjkXs1Yb7Eefi09Be/VDIOh+dt/aBS9eHv4j9qOCZu6tP15ztr
         Kjshhl29lmohCRGXMxbWUlO+EGGg64hGVP191BuLUlOHDS5ritCG9eHsX+g5o9hUA2GP
         2SxN9ckJ3TH4HMSQr7p4QBjVjOZF8ILxG+ms64DGWQqbV1p5H/3JpHAsSqKDtgKGIyPr
         VzP2ItJwsdrlp0bC2Fs7xeZnp5vQVMS3Q8CWUnPYcKIHgYvMojK5WjyNjBGMClqzi3L8
         oqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zWgUGM/JTFTwLtZo+7BxbsDySLaY5hFmmAqfaepFGCs=;
        b=WU4SgxrbofIUxPKRAycGZVf5QwFbNOhbgVomVgC4WGvcq+MG4LLj/JMMPvYNRMNVmy
         yedlS6qdvHy1/SQIQr+t0d6kb8hdtY8FX2mFVqNm0mGP1K3pU5qnPyWz22wr+4COQAAN
         BmmucH06dua+r1rw535ZGsmccYAazucJpYGABKe2bzPwLXx3Jvm2nSNEBUOX8d7hug0W
         uQwqtG7SCfiKth9cr8nKQIFnlEiT7nJK0jc9lkWN0G9TdgR531Im+ZYJ4sRWIVbZDcFf
         FIZ80Tvg71vXLKQCkvwWyeERUsf2Fp18nXJldTQgUuc2I48GTCuMduGgimEXnZcyVGzW
         ZNMA==
X-Gm-Message-State: ACrzQf0tCwCP1Z7eaS8K/tSESsnb+BbN4LtsD7XcOMmo0NHuEbnDvpKs
        eE2jgK1gzVMYTdVbVo9UJQuoqP/ZMEd3DWIPdpBj5rtntfHM5EhM
X-Google-Smtp-Source: AMsMyM7HVJ6EjMszIw6DN7PzcTx8SRNT6xgxOzCIVQ1BW3qPdQ4oEGYjvN/Leu2Ze6hmBC4AyojzGm/exFCnccPWeQU=
X-Received: by 2002:a17:902:ccc2:b0:178:29e1:899e with SMTP id
 z2-20020a170902ccc200b0017829e1899emr17465309ple.114.1664114571251; Sun, 25
 Sep 2022 07:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN8LHqz7=OSvBpKCqKdV4L_4FPXtQ32bgYveA9yP2_xiQ@mail.gmail.com>
 <20220925042031.GA9845@1wt.eu>
In-Reply-To: <20220925042031.GA9845@1wt.eu>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 25 Sep 2022 19:02:39 +0500
Message-ID: <CABXGCsOsm_QtFjd9KCYOc3E_4Tn_EVDhWifOPMU7_PZ7MC2big@mail.gmail.com>
Subject: Re: Unable bisect issue because kernel not building from old commits
To:     Willy Tarreau <w@1wt.eu>
Cc:     ast@kernel.org, yhs@fb.com, sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Note that this looks more related to binutils here. Regardless, there
> are pre-built toolchains including compiler+binutils for various gcc
> versions from 4.9 and up here, for all supported architectures:
>
>    https://mirrors.edge.kernel.org/pub/tools/crosstool/
>
> These ones are sufficient to build a kernel and are likely easier to
> deal with than trying to port a patch over a bisect session. For example
> you could have luck with 7.5 which has been supported for a very long
> time and still is supported.

I don't quite understand how to switch to the downloaded binutils
without breaking the distribution.
I am building the kernel with the following command:
$ make clean && make -j32 bzImage && make -j32 modules

Thanks.

-- 
Best Regards,
Mike Gavrilov.
