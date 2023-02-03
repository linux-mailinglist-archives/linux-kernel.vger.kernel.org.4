Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4964868A166
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjBCSQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjBCSP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:15:59 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF86E27995
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:15:58 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id r28so4858631oiw.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3t3H+aA2KgB4EAc83s9ir4SliyMLQWPAeErskn177Q=;
        b=oEu2PRhO+MVkx90VLgdYyS9aKsEXIZcUQajibKOHHouCYkjo8/w5jghE1UOfnH+Sem
         hyCOjkNLKNz/q7UQDjUY1fIAWdGB6XXnlQQVwEq1JnKJOqLVeub/ZJi5piL33q9ActHZ
         ppzwpetCs3HninK06SkZqIf165gB70O5HKXvU8Tb9+hdlpEgDxVUeWO+YhK7n7Spf7KG
         ZkYI5QDBXzJdImFn6zrHtKwTXQpTvoyisIPpAJIyPfi8auKXFrAeXBvcCZxRY2rv+EmH
         Jj3AFPQtaS/0CpQC6sl2WqW15gw4ObSo9RqA2DMl0TPnJxBzQh4dU0JqC3Eexy2BM4KW
         iLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3t3H+aA2KgB4EAc83s9ir4SliyMLQWPAeErskn177Q=;
        b=nSQ3o13lRsf7s2ui8bKNe0asgGSo5w0/T6u46mMs7OKs/xE/R78s6pf25Jfp0uIPOK
         vLutcYrCAqn2NHy9XyQcRUJFp+AQAQhDtYvlPUkzEskZtvUI1q5S9mEO9Se1fmomO8kJ
         mr0ingpTHH8bx+Hl40MDW/fH/tdBvTUdPDJ6P5zxGwAwucqb9DahbaIRkzJ2XoZBEnns
         gXHyDp/Elv7twX9e6Tzb2oASJRCZ2VHVcwagXDXXCtPm15MrRQksb3JMPZNVseTAiGtD
         y9UocBb7pdS7aAcFBSf3OqOxKbShfNvTFEt8An7sh984j60TEPBwlm8dU+BmD8uFSt7F
         SV0Q==
X-Gm-Message-State: AO0yUKXrvj2YFhTMaprytq9sQOxoewc7Uj2LmM1uHqNau3YycTRCsPzi
        pXtZowQkKf/FnpK9xxem9tBINd/pPOuRxRlMexg=
X-Google-Smtp-Source: AK7set9vjkE7o//vYuc1JhS77XzL5YZeTi+iclQY94ulHq8v4hgWcin4xF42ng4qxsn8v4qpvaGu0IC+ydiJ3PrDsw0=
X-Received: by 2002:a05:6808:280e:b0:360:ffcc:3685 with SMTP id
 et14-20020a056808280e00b00360ffcc3685mr385441oib.183.1675448158043; Fri, 03
 Feb 2023 10:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20230203164937.4035503-1-robdclark@gmail.com>
In-Reply-To: <20230203164937.4035503-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 3 Feb 2023 10:15:56 -0800
Message-ID: <CAF6AEGvanLri-+Z5KgmgSFX2ShB09T7X7wxcSQk_0JV7PKGRng@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Move fd_install after last use of fence
To:     dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        jason.ekstrand@collabora.com
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

On Fri, Feb 3, 2023 at 8:49 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Because eb_composite_fence_create() drops the fence_array reference
> after creation of the sync_file, only the sync_file holds a ref to the
> fence.  But fd_install() makes that reference visable to userspace, so
> it must be the last thing we do with the fence.
>

Fixes: 00dae4d3d35d ("drm/i915: Implement SINGLE_TIMELINE with a syncobj (v4)")

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index f266b68cf012..0f2e056c02dd 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -3476,38 +3476,38 @@ i915_gem_do_execbuffer(struct drm_device *dev,
>
>  err_request:
>         eb_requests_get(&eb);
>         err = eb_requests_add(&eb, err);
>
>         if (eb.fences)
>                 signal_fence_array(&eb, eb.composite_fence ?
>                                    eb.composite_fence :
>                                    &eb.requests[0]->fence);
>
> +       if (unlikely(eb.gem_context->syncobj)) {
> +               drm_syncobj_replace_fence(eb.gem_context->syncobj,
> +                                         eb.composite_fence ?
> +                                         eb.composite_fence :
> +                                         &eb.requests[0]->fence);
> +       }
> +
>         if (out_fence) {
>                 if (err == 0) {
>                         fd_install(out_fence_fd, out_fence->file);
>                         args->rsvd2 &= GENMASK_ULL(31, 0); /* keep in-fence */
>                         args->rsvd2 |= (u64)out_fence_fd << 32;
>                         out_fence_fd = -1;
>                 } else {
>                         fput(out_fence->file);
>                 }
>         }
>
> -       if (unlikely(eb.gem_context->syncobj)) {
> -               drm_syncobj_replace_fence(eb.gem_context->syncobj,
> -                                         eb.composite_fence ?
> -                                         eb.composite_fence :
> -                                         &eb.requests[0]->fence);
> -       }
> -
>         if (!out_fence && eb.composite_fence)
>                 dma_fence_put(eb.composite_fence);
>
>         eb_requests_put(&eb);
>
>  err_vma:
>         eb_release_vmas(&eb, true);
>         WARN_ON(err == -EDEADLK);
>         i915_gem_ww_ctx_fini(&eb.ww);
>
> --
> 2.38.1
>
