Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC26FEBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbjEKGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjEKGjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:39:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4110D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:38:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f315735514so271109905e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683787117; x=1686379117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYtaRcshlY3QmxEEqVJsJU+0bmCyXLBCJqkTVjmG1hA=;
        b=d0SnZ+pjyye00WmokuVRn85o0hU1sSEe2pqirea4ZcrpkfnFfRYD5NIGNnwLArYw3e
         iv64Az5W7Mu6DGr5zAJF0G8CcBCqF+sF384FS8jxP5axqWOpR9v+E5hN6C+C43h/hTNT
         0Yx7lFxm3QbgqJZg7f+9vk4JZk/9f4SujuFsWm4dfd9cVPLYUwMwbnjJFjr+VvzXVno/
         jRtlFY3mjWUXLzS3+M7/j9KC/kW7xmujUlxKN60lZpZQNRCgUXJwiyhSzBdtnmEbV+u8
         spumpdd5/+/4H/V5/yepOz9LH8iOQZNj3AK2Py3JcECSr0I5tTJe9mQ7GWgdn6jT/Psc
         i6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683787117; x=1686379117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYtaRcshlY3QmxEEqVJsJU+0bmCyXLBCJqkTVjmG1hA=;
        b=XLpuU1wh1ammbX/9XWq8eKzz4SOqCGHT2tmRlSbraPrkOCW3tDhVX034Jenbu9Nr6I
         KTA4QPcFp8QLVE4j6+PUwD40ukHV/OZqfAbLwiwHh7lPHMy/44ODffVwEsX/cECErsek
         IawF43Ih0+KsGjWkEjuytJ3v5rcxe2/iDsgKDRHS5pFWEhlopXrvHkOF6yCHwbzLV7EL
         H0ew2ZvhSzV2rsb6M4kU1yGgrBQ/IKZUmmHyXiauEKd7kwg+TSOs1ANILG2mEeg3hHyF
         B3ySFHzFNgaqHOdaaQR6cl6R/DUPthYsBZbz2GIrOsHpkJ7yU2EcVM+qfIUcwspDdeSn
         agDA==
X-Gm-Message-State: AC+VfDzHQZvvHSQ1gfabGGgaCHM9dN44lZUbqirramwf7oG1Babj/SbQ
        9jRzv//OMQBErIfZj9fcDeWxXR3QbvyRxIV4nKUGCg==
X-Google-Smtp-Source: ACHHUZ4kMqG2j46JtpC5lVFA0riYENxtdmocRCjtPNiT5Crk6IarsSkll1FlC54MFGtjV1Y8xDM1espHli3Dl27emSY=
X-Received: by 2002:a05:600c:468e:b0:3ee:93d2:c915 with SMTP id
 p14-20020a05600c468e00b003ee93d2c915mr13695155wmo.6.1683787117430; Wed, 10
 May 2023 23:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230507170631.89607-1-hanjinke.666@bytedance.com>
In-Reply-To: <20230507170631.89607-1-hanjinke.666@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 May 2023 14:38:00 +0800
Message-ID: <CAMZfGtV8FUoBzhPjFu8V5=e=dQ3wRm+qK7S0HHCB22cjKDLAdQ@mail.gmail.com>
Subject: Re: [PATCH v3] blk-throttle: Fix io statistics for cgroup v1
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrea.righi@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 1:07=E2=80=AFAM Jinke Han <hanjinke.666@bytedance.co=
m> wrote:
>
> From: Jinke Han <hanjinke.666@bytedance.com>
>
> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
> the only stable io stats interface of cgroup v1, and these statistics
> are done in the blk-throttle code. But the current code only counts the
> bios that are actually throttled. When the user does not add the throttle
> limit, the io stats for cgroup v1 has nothing. I fix it according to the
> statistical method of v2, and made it count all ios accurately.
>
> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Good catch.

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
