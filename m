Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12DF74F2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjGKOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjGKOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:50:10 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B871BD7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:49:47 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56669eb7565so3395078eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689086986; x=1691678986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMtIhbn3UA+P0n4p8aVI0EEx8+c96zu0z2NCe9UtSsY=;
        b=h7kRhfRYWyjaUHm/bnq/FXxP6QWMHxbXz6JHxIEhFhSB3OXPmEuwUCcbXP18QCkZWP
         ctUroRGLJKK9x1nvlse/QNs0OkIc7ROrJLmfInGqX+sPE6etJk2VV08XqjEiJ35eDLRz
         XN3Dn1c+5SnlsJ5qoupTmJaYP6dmsrNEKTU+C4N+dW72AuWc4JsdP+kuHiNcmc6ZqH62
         8+iFA9slpn92EHmEcSD9QR2w1k1Wa6uG2835D0vCE2Qe0dOUBW5LKxiY1LS8UfK9fP7h
         sG2ANpKU01OMn2N5fJ6XwYH23lTzRGwC+60OXb+RG3+kpMAyht+ReoZ0bh3HDxHW2bK3
         ZQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086986; x=1691678986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMtIhbn3UA+P0n4p8aVI0EEx8+c96zu0z2NCe9UtSsY=;
        b=KHAZMSe70Z3qQYbeEarM4hc4VzArnrfkeap4Qkoj4mD3Lcse17XR7aFYVnSXZEAYO0
         DMXJDPSFIm2eI8tKGfd/9KjuWxCSSeHGGyqcsi0lGknsi17xxs17RbswdNw2uEK/yyQV
         McUnxdyoE7+xYac4Nlv2aukZ1OLIEMd/qvMGqv/3Q5n04pH8W7pL8ErdplHFay/FN1LS
         hlLqH1aqC/3QD3k08kpi097/8E11dIkVDN8Mh0cHB0XLo5IhAHv//JrPifTpZZgBc49p
         PEK0WkDgDqQ9P32+XRboTr7CM3X0+Jlj4C7c9VoGEa06kjl1RgFFilJybFxcf/ThjRXv
         C42w==
X-Gm-Message-State: ABy/qLYwH+Ox9XjAQ3cbEuFv0Eh6RncJ8B2/19kympPj5n9pDBwM5td6
        jaGzpRINk5X5h45xxoTMLNZj/K+b6SxLrAUmzxo=
X-Google-Smtp-Source: APBJJlGqUgUKHl2pXxgQ7AZFp7v2PQSXkG79vfvMrnzSDhWsFISQxPhdhI2GlvWqSVaqIId3vulo/B8KFgo/vKoKot4=
X-Received: by 2002:a4a:e0c1:0:b0:563:68e6:3be2 with SMTP id
 e1-20020a4ae0c1000000b0056368e63be2mr8852105oot.1.1689086986179; Tue, 11 Jul
 2023 07:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230710205625.130664-1-robdclark@gmail.com> <3bcebac5-81d8-79a5-cdfb-48db782ec206@amd.com>
 <501a3dd6-d313-a03c-4bd1-74f4d27d0487@amd.com>
In-Reply-To: <501a3dd6-d313-a03c-4bd1-74f4d27d0487@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 11 Jul 2023 07:49:34 -0700
Message-ID: <CAF6AEGsBeEMyT2+Dj1AH_KoZTxmig4tkxPadAP77Eavy7UXgJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/scheduler: Add missing RCU flag to fence slab
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.07.23 um 23:15 schrieb Luben Tuikov:
> > On 2023-07-10 16:56, Rob Clark wrote:
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >> Fixes the KASAN splat:
> >>
> >>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>     BUG: KASAN: use-after-free in msm_ioctl_wait_fence+0x31c/0x7b0
> >>     Read of size 4 at addr ffffff808cb7c2f8 by task syz-executor/12236
> >>     CPU: 6 PID: 12236 Comm: syz-executor Tainted: G        W         5=
.15.119-lockdep-19932-g4a017c53fe63 #1 b15455e5b94c63032dd99eb0190c27e582b3=
57ed
> >>     Hardware name: Google Homestar (rev3) (DT)
> >>     Call trace:
> >>      dump_backtrace+0x0/0x4e8
> >>      show_stack+0x34/0x50
> >>      dump_stack_lvl+0xdc/0x11c
> >>      print_address_description+0x30/0x2d8
> >>      kasan_report+0x178/0x1e4
> >>      kasan_check_range+0x1b0/0x1b8
> >>      __kasan_check_read+0x44/0x54
> >>      msm_ioctl_wait_fence+0x31c/0x7b0
> >>      drm_ioctl_kernel+0x214/0x418
> >>      drm_ioctl+0x524/0xbe8
> >>      __arm64_sys_ioctl+0x154/0x1d0
> >>      invoke_syscall+0x98/0x278
> >>      el0_svc_common+0x214/0x274
> >>      do_el0_svc+0x9c/0x19c
> >>      el0_svc+0x5c/0xc0
> >>      el0t_64_sync_handler+0x78/0x108
> >>      el0t_64_sync+0x1a4/0x1a8
> >>     Allocated by task 12224:
> >>      kasan_save_stack+0x38/0x68
> >>      __kasan_slab_alloc+0x6c/0x88
> >>      kmem_cache_alloc+0x1b8/0x428
> >>      drm_sched_fence_alloc+0x30/0x94
> >>      drm_sched_job_init+0x7c/0x178
> >>      msm_ioctl_gem_submit+0x2b8/0x5ac4
> >>      drm_ioctl_kernel+0x214/0x418
> >>      drm_ioctl+0x524/0xbe8
> >>      __arm64_sys_ioctl+0x154/0x1d0
> >>      invoke_syscall+0x98/0x278
> >>      el0_svc_common+0x214/0x274
> >>      do_el0_svc+0x9c/0x19c
> >>      el0_svc+0x5c/0xc0
> >>      el0t_64_sync_handler+0x78/0x108
> >>      el0t_64_sync+0x1a4/0x1a8
> >>     Freed by task 32:
> >>      kasan_save_stack+0x38/0x68
> >>      kasan_set_track+0x28/0x3c
> >>      kasan_set_free_info+0x28/0x4c
> >>      ____kasan_slab_free+0x110/0x164
> >>      __kasan_slab_free+0x18/0x28
> >>      kmem_cache_free+0x1e0/0x904
> >>      drm_sched_fence_free_rcu+0x80/0x9c
> >>      rcu_do_batch+0x318/0xcf0
> >>      rcu_nocb_cb_kthread+0x1a0/0xc4c
> >>      kthread+0x2e4/0x3a0
> >>      ret_from_fork+0x10/0x20
> >>     Last potentially related work creation:
> >>      kasan_save_stack+0x38/0x68
> >>      kasan_record_aux_stack+0xd4/0x114
> >>      __call_rcu_common+0xd4/0x1478
> >>      call_rcu+0x1c/0x28
> >>      drm_sched_fence_release_scheduled+0x108/0x158
> >>      dma_fence_release+0x178/0x564
> >>      drm_sched_fence_release_finished+0xb4/0x124
> >>      dma_fence_release+0x178/0x564
> >>      __msm_gem_submit_destroy+0x150/0x488
> >>      msm_job_free+0x9c/0xdc
> >>      drm_sched_main+0xec/0x9ac
> >>      kthread+0x2e4/0x3a0
> >>      ret_from_fork+0x10/0x20
> >>     Second to last potentially related work creation:
> >>      kasan_save_stack+0x38/0x68
> >>      kasan_record_aux_stack+0xd4/0x114
> >>      __call_rcu_common+0xd4/0x1478
> >>      call_rcu+0x1c/0x28
> >>      drm_sched_fence_release_scheduled+0x108/0x158
> >>      dma_fence_release+0x178/0x564
> >>      drm_sched_fence_release_finished+0xb4/0x124
> >>      dma_fence_release+0x178/0x564
> >>      drm_sched_entity_fini+0x170/0x238
> >>      drm_sched_entity_destroy+0x34/0x44
> >>      __msm_file_private_destroy+0x60/0x118
> >>      msm_submitqueue_destroy+0xd0/0x110
> >>      __msm_gem_submit_destroy+0x384/0x488
> >>      retire_submits+0x6a8/0xa14
> >>      recover_worker+0x764/0xa50
> >>      kthread_worker_fn+0x3f4/0x9ec
> >>      kthread+0x2e4/0x3a0
> >>      ret_from_fork+0x10/0x20
> >>     The buggy address belongs to the object at ffffff808cb7c280
> >>     The buggy address is located 120 bytes inside of
> >>     The buggy address belongs to the page:
> >>     page:000000008b01d27d refcount:1 mapcount:0 mapping:00000000000000=
00 index:0x0 pfn:0x10cb7c
> >>     head:000000008b01d27d order:1 compound_mapcount:0
> >>     flags: 0x8000000000010200(slab|head|zone=3D2)
> >>     raw: 8000000000010200 fffffffe06844d80 0000000300000003 ffffff8086=
0dca00
> >>     raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000=
000000
> >>     page dumped because: kasan: bad access detected
> >>     Memory state around the buggy address:
> >>      ffffff808cb7c180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>      ffffff808cb7c200: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> >>     >ffffff808cb7c280: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>                                                                     ^
> >>      ffffff808cb7c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
> >>      ffffff808cb7c380: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
> >>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Suggested-by: Alexander Potapenko <glider@google.com>
> >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >> ---
> >>   drivers/gpu/drm/scheduler/sched_fence.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm=
/scheduler/sched_fence.c
> >> index ef120475e7c6..b624711c6e03 100644
> >> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> >> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> >> @@ -35,7 +35,7 @@ static int __init drm_sched_fence_slab_init(void)
> >>   {
> >>      sched_fence_slab =3D kmem_cache_create(
> >>              "drm_sched_fence", sizeof(struct drm_sched_fence), 0,
> >> -            SLAB_HWCACHE_ALIGN, NULL);
> >> +            SLAB_HWCACHE_ALIGN | SLAB_TYPESAFE_BY_RCU, NULL);
> >>      if (!sched_fence_slab)
> >>              return -ENOMEM;
> >>
> > Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> >
> > But let it simmer for 24 hours so Christian can see it too (CC-ed).
>
> Well that won't work like this, using the the SLAB_TYPESAFE_BY_RCU flag
> was suggested before and is not allowed for dma_fence objects.
>
> The flag SLAB_TYPESAFE_BY_RCU can only be used if the objects in the
> slab can't be reused within an RCU time period or if that reuse doesn't
> matter for the logic. And exactly that is not guaranteed for dma_fence
> objects.

I think that is only true because of the drm_sched_fence_free() path?
But that could also use call_rcu().  (It looks like it is only an
error path.)

> It should also not be necessary because the scheduler fences are
> released using call_rcu:
>
> static void drm_sched_fence_release_scheduled(struct dma_fence *f)
> {
>          struct drm_sched_fence *fence =3D to_drm_sched_fence(f);
>
>          dma_fence_put(fence->parent);
>          call_rcu(&fence->finished.rcu, drm_sched_fence_free_rcu);
> }
>
> That looks more like you have a reference count problem in MSM.

Possibly I need to use rcu_read_lock()?  But I think the idr_lock
which protected dma_fence_get_rcu() (and is held until the fence is
removed from fence_idr, before it's reference is dropped in
__msm_gem_submit_destroy()) makes that unnecessary.

BR,
-R

> Regards,
> Christian.
