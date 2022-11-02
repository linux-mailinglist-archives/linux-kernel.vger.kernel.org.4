Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4266160E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKBKfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKBKft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:35:49 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654E528E1F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 03:35:48 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id l15so306616qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 03:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2O1PKU8il9JO55wPK5nB5RoP7xPMplKzeMbq6mlhNZ8=;
        b=dMMZ/3n5LDVgMhxL8egs7WW2Q+mCdfOt78wcqKXv+qZUS7IxVIKsl7tm0A43dtvW5S
         r2Q1cCBkrpVurZGGu8rLkZ8bTIRhQ96ZiykjSZBwHK0/jYjMqGFeKdpMcemeLwsUN94e
         +dYIW42T2t4R/Liqi976B6RIeD2N+yCiRJ3EX2jkUnq12V3me2zBArgdiO3FzSxz9kQl
         J70O37+O1BAqwNSCzJKi14/gX5Wl5kzOudu38HwrcrQmgZgbm6HZhDMZ4xWSXZX7l0U8
         Y2/6h+OQkKbnRj0GeaEe2EHGF3afkBLQ+cNnSvByRV6nXYZ2KEnI+wZJdnJ2/tBH2o2z
         92og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2O1PKU8il9JO55wPK5nB5RoP7xPMplKzeMbq6mlhNZ8=;
        b=HMlO9C31iPvZBUpY2yow3B37Kwt7gV9Xsp1l6fWIudQe08ZTHHtPimElTOt99VA9Ho
         HOgaFno8Acig03SgCuoPKSS7RcqqJpQiVriszJVhRd8ALskT1GfnxtO4IoQHHSIYJ5y8
         Eew/xqwwPjiaCRhkWicR+Deawmr12VzwpiqW6ab5UethOc/39uHKjGVLlfr3YTuPz5XW
         WfYzlJzoI9GQW7bIIsMRsay7qt2Y4Oh0paI9e0t2aNcCZNhw9F+FQl23uMUyh6bIJF1u
         TBhnQMbZVVGdtVniIoV0XJi2IMXuVdk1tvpAYyt9+HaigDn4gU5rlG2KrEAzW7h4tcjl
         wj4g==
X-Gm-Message-State: ACrzQf2gctYvkINIm894mRq9Tl2oSRsB5KyQCzoTz8u4GBPZ5JRJmoJA
        CnMJzHri+yYHBWnKVp9ybgcTzWnbwX8fuqH9KrA=
X-Google-Smtp-Source: AMsMyM6X2qS0IzZn4VsJsNj7mkd7jHkm9WQyaw345XzWZADbYoZl/LD0DzpFlTgEfY7sdPZrhUlBhD7SgBpd35UhjdU=
X-Received: by 2002:ac8:7f48:0:b0:3a5:4234:8a18 with SMTP id
 g8-20020ac87f48000000b003a542348a18mr3529724qtk.340.1667385347479; Wed, 02
 Nov 2022 03:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221029074654.203153-1-zyytlz.wz@163.com>
In-Reply-To: <20221029074654.203153-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 2 Nov 2022 18:35:36 +0800
Message-ID: <CAJedcCy5dxYPALk3Hib8J7ONLipXELpbehJHs58v8vuHk7ZupQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/mmu: fix use-after-free bug in nvkm_vmm_pfn_map
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        alex000young@gmail.com, security@kernel.org, daniel@ffwll.ch,
        Julia.Lawall@inria.fr, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly Ping :)
