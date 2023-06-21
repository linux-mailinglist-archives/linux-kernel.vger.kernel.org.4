Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA7738FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFUTYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFUTY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:24:28 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA91DE41
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:24:27 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39ecf031271so3054136b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687375467; x=1689967467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3U/QVAcqafkSNVhY1lWQzZCl4SRVhE5bPBjfKlpQ8Pk=;
        b=ohqyLjyj3sePxyXy1PsG7sE32dVzhextzF1VCRFgF9hi6WmLhRM7JxacUR2oArMILn
         1UNZ8ufLZ2uyUoKHdIFxhhl7j1sSfdvAEtccccgKimWbvfdZQbtrLMZKcrP3gAd/nlO+
         zPVVB+cKijH3DYkEDWnsyCSXyNF9iRj0L2lubKyMyr8b6vfTQCm7/mkQlixLPe8S2B5V
         ey3Ahmo9UeqQi4c42wQyFTPhSKbf26RzGbX3Nr8GZnIYDcC4iG8zv1FLFK9y7vsboLbo
         drN5YjmK6Kkgo+1tsNrD5QYgDaOCzq85c0qOA+PVBpocfAtG6jvvCyI4Fe1Jk4erzZL5
         2x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687375467; x=1689967467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3U/QVAcqafkSNVhY1lWQzZCl4SRVhE5bPBjfKlpQ8Pk=;
        b=ZvXdt0wm8oyRFGvlmHn3ld0Z5vJAOtBym+NqxNK94NDB2xUwvwAyQ52DSU1vY+Mv9n
         2A39qQBu89o3RvGARaISZ0zdR9xrVQ1ufgx+rO9KxHG691+YuxAutNVdYkMoqxFoJtMu
         zHG6tTZi4CVLJJiRIFZSxqkDZJ5Oc5xvkxn1I9cmp6LS4Ybr4gc7nNvLVPC8FJXJ95s8
         1q2iCO5TUrRyAQS9qRkkZhlOpLXWd4G45IYNMlX6PDBUVWXDV4bbD2DNwxKPmewCQHNJ
         WqDLYDBiIrYKqjgFGIoi85F7/s1xjeoGssR7sUqhjnEaq1YfySAZGKitMmh+x0q25ZEp
         fAUA==
X-Gm-Message-State: AC+VfDwk2OyCZQwMpHgZ2Iuz7oACoXv0Jy1JNvM/2hiToFnc5h/82VZU
        A3rLp+kJCu9ZmWKHDqNU9CbvoPb4L6tx+1A8XdKwXA==
X-Google-Smtp-Source: ACHHUZ63c9VKGQPwrxlmnGSKM+PWQK9x+DysUQbbBYaDfelOmNODcRzkOZdsEmMV5VhtSDgSqYOgfcdGJy5fkttcu2g=
X-Received: by 2002:a05:6359:a26:b0:12c:9960:ec1e with SMTP id
 el38-20020a0563590a2600b0012c9960ec1emr10367224rwb.19.1687375466725; Wed, 21
 Jun 2023 12:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
 <20230529223935.2672495-3-dmitry.osipenko@collabora.com> <CABdmKX2RU2iYyUssBpwS17zA1dfegjzdo4pxp0r8cOCWcY9=kg@mail.gmail.com>
 <106bc72b-9358-de06-6f3f-06fdfa3859cd@collabora.com>
In-Reply-To: <106bc72b-9358-de06-6f3f-06fdfa3859cd@collabora.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 21 Jun 2023 12:24:15 -0700
Message-ID: <CABdmKX0SJvW30PEriUhW9kmKQuhrEHHPiVbyUYPbgYCyh40hFg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dma-buf/heaps: Don't assert held reservation lock
 for dma-buf mmapping
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        kernel@collabora.com, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:16=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi,
>
> On 6/21/23 20:21, T.J. Mercier wrote:
> > On Mon, May 29, 2023 at 3:46=E2=80=AFPM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> Don't assert held dma-buf reservation lock on memory mapping of export=
ed
> >> buffer.
> >>
> >> We're going to change dma-buf mmap() locking policy such that exporter=
s
> >> will have to handle the lock. The previous locking policy caused deadl=
ock
> >> problem for DRM drivers in a case of self-imported dma-bufs once these
> >> drivers are moved to use reservation lock universally. The problem
> >> solved by moving the lock down to exporters. This patch prepares dma-b=
uf
> >> heaps for the locking policy update.
> >>
> > Hi Dmitry,
> >
> > I see that in patch 6 of this series calls to
> > dma_resv_lock/dma_resv_unlock have been added to the
> > drm_gem_shmem_helper functions and some exporters. But I'm curious why
> > no dma_resv_lock/dma_resv_unlock calls were added to these two dma-buf
> > heap exporters for mmap?
>
> DMA-buf heaps are exporters, drm_gem_shmem_helper is importer. Locking
> rules are different for importers and exporters.
>
> DMA-heaps use own locking, they can be moved to resv lock in the future.
>
> DMA-heaps don't protect internal data in theirs mmap() implementations,
> nothing to protect there.
>
Thanks.
