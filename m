Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42960ECC9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiJ0ABr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJ0ABo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:01:44 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0577541
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:01:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c8so12454028qvn.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkwZ9UxpN+5RxXBDncw8vjIe3FN4zBnz7PIpORGodgk=;
        b=L+ls/p56gxCBnUoTOXLMhaJrLQP4elffDyoQ0czc7jiwGsskA2eBQWdSdSM1RCM671
         LiE+oqHzfTVRkUrQFSYeMhm90/q/n82tfhhD9jz+q+3E0/SFtGUszLGtcY9MlU4C+oMZ
         +QOaK6TVd+urVYbx8XhY02d/hfQxktKdKfWA2ontJoaZP+pX+DgIe6BPuIkNSeTHczu6
         g+aJb9kkOKWzr7gPcL7Tb+V9UCdgKKKi2UstB1q6E5gsOZtL5AUny2DyazrfqKO1Ao5m
         StqvE8NBitzqh9EjfO5/+WvdpUGV30tqFHuLtOaMiwC2AW7MmH4EpfaM3MR7imTpv7If
         t1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkwZ9UxpN+5RxXBDncw8vjIe3FN4zBnz7PIpORGodgk=;
        b=lRiV/P6u8ExfypTH4zJ5i7VR6z0AjjU4YWDKeGALuQH9h0swctu8TKuu03ErTCAwaY
         BOgotRIwlOwSKHrDgnCyjtbQ6oq9Qw6iMq3tvWqD20a9nzrdqLdpFvuJQ+ZSsydaNI7t
         FPZ0YIduFb9lTGOOv2wKnNH5aGU7YB6b37qDyhS4VU497zNybeMDrItiMi3NBQ/Sib4F
         u2E8Q3s8tR/HtsoL3UMLu4GvK0IV8ILZ4N6OTtytr3fM0HJtN/RxDkJpql3SxqHwmkuo
         1kh7WJBYcXKg8YeIHG6T+VSTDSLruYEP9aicrJ3he33sWGREV3IW1sMwoNHdReR88QsK
         g9PA==
X-Gm-Message-State: ACrzQf3Gf4p0KEQQz6U6wMpRaT+D5XZa3UPi7O9Iro6EzTdPWn+pTk97
        jNnSWmEP0Rwe2iJ2h+jck+ICAC/q3+U2WK1WmQnuH3Gx
X-Google-Smtp-Source: AMsMyM5X6/DItFtEw8gerGA8EOPWVc1cdntBBIEg6j5m/MxyYILJROR7Z0V2lBB7ubwrqBBfs2fFRB0gMWW3DN3WnLE=
X-Received: by 2002:a05:6214:21e9:b0:4bb:65c5:c989 with SMTP id
 p9-20020a05621421e900b004bb65c5c989mr18148818qvj.97.1666828902245; Wed, 26
 Oct 2022 17:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8rIxV7bVCcfZb0@kroah.com> <20221007013708.1946061-1-zyytlz.wz@163.com>
In-Reply-To: <20221007013708.1946061-1-zyytlz.wz@163.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 27 Oct 2022 10:01:29 +1000
Message-ID: <CAPM=9ty0+ouf+rQWhM=9XSKFOA2zxKfa00MsNBvwrQGPQm2uPQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     gregkh@linuxfoundation.org, alex000young@gmail.com,
        security@kernel.org, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, hackerzheng666@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        1002992920@qq.com
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

On Fri, 7 Oct 2022 at 11:38, Zheng Wang <zyytlz.wz@163.com> wrote:
>
> If intel_gvt_dma_map_guest_page failed, it will call
> ppgtt_invalidate_spt, which will finally free the spt.
> But the caller does not notice that, it will free spt again in error path.
>
> Fix this by spliting invalidate and free in ppgtt_invalidate_spt.
> Only free spt when in good case.
>
> Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>

Has this landed in a tree yet, since it's a possible CVE, might be
good to merge it somewhere.

Dave.

> ---
> v3:
> - correct spelling mistake and remove unused variable suggested by Greg
>
> v2: https://lore.kernel.org/all/20221006165845.1735393-1-zyytlz.wz@163.com/
>
> v1: https://lore.kernel.org/all/20220928033340.1063949-1-zyytlz.wz@163.com/
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index ce0eb03709c3..865d33762e45 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -959,6 +959,7 @@ static inline int ppgtt_put_spt(struct intel_vgpu_ppgtt_spt *spt)
>         return atomic_dec_return(&spt->refcount);
>  }
>
> +static int ppgtt_invalidate_and_free_spt(struct intel_vgpu_ppgtt_spt *spt);
>  static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
>
>  static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
> @@ -995,7 +996,7 @@ static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
>                                 ops->get_pfn(e));
>                 return -ENXIO;
>         }
> -       return ppgtt_invalidate_spt(s);
> +       return ppgtt_invalidate_and_free_spt(s);
>  }
>
>  static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_spt *spt,
> @@ -1016,18 +1017,30 @@ static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_spt *spt,
>         intel_gvt_dma_unmap_guest_page(vgpu, pfn << PAGE_SHIFT);
>  }
>
> -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
> +static int ppgtt_invalidate_and_free_spt(struct intel_vgpu_ppgtt_spt *spt)
>  {
> -       struct intel_vgpu *vgpu = spt->vgpu;
> -       struct intel_gvt_gtt_entry e;
> -       unsigned long index;
>         int ret;
>
>         trace_spt_change(spt->vgpu->id, "die", spt,
> -                       spt->guest_page.gfn, spt->shadow_page.type);
> -
> +               spt->guest_page.gfn, spt->shadow_page.type);
>         if (ppgtt_put_spt(spt) > 0)
>                 return 0;
> +       ret = ppgtt_invalidate_spt(spt);
> +       if (!ret) {
> +               trace_spt_change(spt->vgpu->id, "release", spt,
> +                        spt->guest_page.gfn, spt->shadow_page.type);
> +               ppgtt_free_spt(spt);
> +       }
> +
> +       return ret;
> +}
> +
> +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
> +{
> +       struct intel_vgpu *vgpu = spt->vgpu;
> +       struct intel_gvt_gtt_entry e;
> +       unsigned long index;
> +       int ret;
>
>         for_each_present_shadow_entry(spt, &e, index) {
>                 switch (e.type) {
> @@ -1059,9 +1072,6 @@ static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
>                 }
>         }
>
> -       trace_spt_change(spt->vgpu->id, "release", spt,
> -                        spt->guest_page.gfn, spt->shadow_page.type);
> -       ppgtt_free_spt(spt);
>         return 0;
>  fail:
>         gvt_vgpu_err("fail: shadow page %p shadow entry 0x%llx type %d\n",
> @@ -1393,7 +1403,7 @@ static int ppgtt_handle_guest_entry_removal(struct intel_vgpu_ppgtt_spt *spt,
>                         ret = -ENXIO;
>                         goto fail;
>                 }
> -               ret = ppgtt_invalidate_spt(s);
> +               ret = ppgtt_invalidate_and_free_spt(s);
>                 if (ret)
>                         goto fail;
>         } else {
> --
> 2.25.1
>
