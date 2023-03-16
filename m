Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6316BD85F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCPSxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCPSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:53:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCFED3098
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:53:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u20so1286345pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678992790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1W/YlEcuttY3U+vH0Zvi8N5CN0MRI21GzH8QWAyVcI=;
        b=Lat+lKQfUS8qaHdbgQZoN+LZJ35jZBofHf93jeA469v8V8xyILhxZ+ts9CUZjkmXG4
         BbOsppMk1ngvHvYqHcCR8mIv1Ai6oqZ0J82FEJaLC7Jw5+YnuB86WMQq76w5MdLh/hsV
         xnUwyu2dXI2LCGJXqS424ufkp3xGGJAbtKYKOQmSQhDwW1JAqJt3Rpg+EzFHFkPZXFdH
         cqVf30QcR/9JUr0XM1+OT4Z0QBBo7OV8m+HCyQGbdr/t+5TGOKhEooqc26/y6FP1R0pw
         k7g9H+qG/GeBUhVNf9fAqrS8yCyfH/ZH7aVRbTPn2QIPARVF3t6WP7325CEJl5rRB9Ek
         nGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678992790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1W/YlEcuttY3U+vH0Zvi8N5CN0MRI21GzH8QWAyVcI=;
        b=sfgJ10P5A2FylHiIVkfwXh2UgEgaLLyKcj3be9m9aUlwckigsH87JfAYSC67udBror
         h3lkdLr5VRAHEg5g+EEYvgyPQRuMQWRQoFS1cHJUvZthCdGczGXU8t03ljmIDKiJpAtd
         GoTUi3h8O02VsrCNzVzP/zHvBAv7RxUv2ftyd/YOwVN1FQJ1EbsTGjN/Kc7JxNSC8cwz
         55+c6SYm9+lUeVRSWmXulfgyJd9HXf893D5LeJHrnVoq/7NafUrTW4Y697o7EUJ6s1y0
         Ma9POSDT1+rF5/dQ17jjRFfi8cb0BaqYQjYGzAoJV/eFbQMuDFp/heNgArS7E6DbUdoU
         JbJw==
X-Gm-Message-State: AO0yUKV5xQ2ynSUZ19FQvGkF68GgGkipBrp2J7HcwctNCylmCMhK4r7v
        Emolooqnd6zYJTj4m+ImunE8UB5N8Bb1tdvRAymKLQ==
X-Google-Smtp-Source: AK7set8calzpmt4TbvcPrwDLOE09bCWglEjTwqJL2dcv5Oh96AwzuzFYFuH3zOn+uAZGWnv7FxksYI8VP/RxjpVrANE=
X-Received: by 2002:a65:6d96:0:b0:503:2583:effb with SMTP id
 bc22-20020a656d96000000b005032583effbmr1174594pgb.9.1678992790072; Thu, 16
 Mar 2023 11:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230315214029.899573-1-joshdon@google.com> <bfbdef64-1b8c-4168-2576-f6d4a112686b@redhat.com>
In-Reply-To: <bfbdef64-1b8c-4168-2576-f6d4a112686b@redhat.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 16 Mar 2023 11:52:58 -0700
Message-ID: <CABk29NuKPJAVFCJ=i2Qh4=UqPoj5aia01-mCiF3p8vebV3uPWg@mail.gmail.com>
Subject: Re: [PATCH] cgroup: fix display of forceidle time at root
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 7:19=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> How about adding the following fixes tag?
>
> Fixes: 1fcf54deb767 ("sched/core: add forced idle accounting for cgroups"=
)

SGTM, thanks Waiman!
