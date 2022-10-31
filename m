Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94186133B1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJaKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJaKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:35:25 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D23DFB4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:35:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g127so4632102ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6hSCV5/zFaODw8xlO2fBmNOddS6g/LvAJdXcY5VQxH4=;
        b=LRi7RNqQhYB2Ta4GTZcwRDvy7axOUZpPSPC/NWoeeFCaKxqWdGEVnyLsGrZ5N+Srz2
         6DrU3D7RDvMXdb8Kzd+dgCKC6UOg3MZgMxisipgwPypPo8kWodHY+Lcu0jfifWgnD63D
         NusDX04kleCyUYHRcjq0Q5bQhnf3d+eDJviV53eSSu/bfvbeG6Ce4FCcdNzzso5qs2nf
         qMJ0olpRHfeAnXFLr+NiuYl8mvJzSw4H/JTodAL62aVqPsoojIDrm88WPILSguLD4ufG
         xe39Fcqq/HHL3ppcxmDzP1ZfhRyRVta9RCxj5gefPcdaPEIXa1mVOgR8sZOh2pMAEJNj
         BgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hSCV5/zFaODw8xlO2fBmNOddS6g/LvAJdXcY5VQxH4=;
        b=E9m4H1KlahL9+zxBvtYNvhbu02Xlc0stA6on/vFnJ3yrywC2D6Eh+nQJks5YLn1+v1
         LqmSBlaf9OZRP4gMPRsA8YhJy2y2w66ijY1k/1RqYZKaVGHsWc0FwavH/D1/U9vy+oPN
         xkeOVTygPTGLVFVsIxDKYIWXTs2PGZSOFK2TueWS+Hcf2SX5nK5DCDhYsjtobe4KAK+7
         ymq58NngYJ9fBx3eIbZpJKnjJMifUVbsUAsfjCya7KNReQvALhNicZbz3kaXPmjvKGOH
         LIUmiThvxziHA9oTRnRb6l/XmJk87A8Mp/VSqLmk9sTRaqwNPstmMoutLPND6mJfOff+
         RgYA==
X-Gm-Message-State: ACrzQf3nt2BrsEBFi02o0H6i1pzYGgUFTpQyf2r2JS39cdZevjsWbiwb
        ElLpGZzb280r0qLKOjtU128RL2bmierLCNpxf7Y=
X-Google-Smtp-Source: AMsMyM6HFGZR1Ko6q3OSvFIYUAVvaOeXloKKnOT3I/P00Xzc8VAH73rKaHJkX6DRWxCXoHMKLJEPd2AibVySZmF7nig=
X-Received: by 2002:a05:6902:1023:b0:6ca:9d03:2994 with SMTP id
 x3-20020a056902102300b006ca9d032994mr11617287ybt.92.1667212520593; Mon, 31
 Oct 2022 03:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221027073200.3885839-1-nunes.erico@gmail.com> <20221027080519.lfpduyt7jcwh3b4k@vireshk-i7>
In-Reply-To: <20221027080519.lfpduyt7jcwh3b4k@vireshk-i7>
From:   Erico Nunes <nunes.erico@gmail.com>
Date:   Mon, 31 Oct 2022 11:35:09 +0100
Message-ID: <CAK4VdL2V+Rnpb-rr=ov_81GUTDt=6i+6QRnKaYztZ7xfkvmMzw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/lima: Fix opp clkname setting in case of missing regulator
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Thu, Oct 27, 2022 at 10:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks.

Could someone take a final look and apply this? I don't have drm-misc
commit rights.

Erico
