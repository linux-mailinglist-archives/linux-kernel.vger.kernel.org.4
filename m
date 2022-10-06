Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA27E5F7208
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJFXpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiJFXph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:45:37 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE3F3BC7E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:45:36 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r186so3816052oie.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0UIpt5qbGLZX+l8DalBZlgk1bfpReda6mkVb7cX8QdQ=;
        b=BnMwoemseLDRkIR1D5narDJJvmaVBsbjSkb5/+vanfF/XVhnkGjsNZ3tWnzkSx4ciX
         E9YMP6WRJuK2MXYcdLHluOmh+v4dNk81NAZt87ZCKlPxa2zamiIZDqjJfDJzqumMTTw3
         guxWdJ6UwoLe88lwygu3LX27x73ahXJjGx/xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UIpt5qbGLZX+l8DalBZlgk1bfpReda6mkVb7cX8QdQ=;
        b=WZTMCN4YbSYzc+AzEhGzZzXX2RvXMNniqgF27VKuAPPyVdNgeDL6vogEGU4EvkD6Ix
         2t3dMNnNgcTiw4xJVagxONmnzcYR8NZ66ksbzywTagYCxWmjwlHXgd5lWTdhGINt0TC6
         vYRvdRJjt1WxuzL+IYQuJsWSpupMbAMak+DDbX4+9cS74MqSE/wjdM3i/sJPw2A/BS1Z
         V9E2M8Tt1bHQg4K13Xp/JkY4ftcNwekoSAgWum/22UBbCw43b7UVl/0X98w1QUKdn6bE
         VIibAPpqzB7GMoKJC3Apbnc5lBIg93EqfXsyPfiu8R1SrBInJBcaaBqmFjUOXm0ciuK0
         4W1Q==
X-Gm-Message-State: ACrzQf3XPsTKJs3gUGxVLdxYlmpXmPj8/Sl/etyWHBT0JWf8Nb9Dj85q
        P+Z2zxjDIw/G+M2+mJfQNRkX5C37vAT+AA==
X-Google-Smtp-Source: AMsMyM4IsMUgKXRzTTGmS4V1fqPY6pXFFUcTqcAxLjt4KglRWckiwv8mJ4EnJOWhK9Ddzy85HaEsTg==
X-Received: by 2002:a05:6808:14cf:b0:350:b76b:cf9a with SMTP id f15-20020a05680814cf00b00350b76bcf9amr1012259oiw.249.1665099934596;
        Thu, 06 Oct 2022 16:45:34 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id c15-20020a9d67cf000000b0065c477a9db9sm481379otn.1.2022.10.06.16.45.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 16:45:32 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id w70so3829286oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:45:31 -0700 (PDT)
X-Received: by 2002:a05:6808:2123:b0:354:2823:f542 with SMTP id
 r35-20020a056808212300b003542823f542mr1084598oiw.229.1665099931487; Thu, 06
 Oct 2022 16:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
 <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com>
 <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com>
 <CADnq5_N0Ef+1VUoDLdpHfJXqZFuPYbx5Lq+94NWciHcQC+VrMg@mail.gmail.com> <CAPM=9tyAOnzwXyyPuoceZ1mimAkzxR-63YmKfVtcQX=swywNvg@mail.gmail.com>
In-Reply-To: <CAPM=9tyAOnzwXyyPuoceZ1mimAkzxR-63YmKfVtcQX=swywNvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Oct 2022 16:45:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgghR4N-4XWjoK18NDkvjBL7i00ab8+otQg955pNGG_dQ@mail.gmail.com>
Message-ID: <CAHk-=wgghR4N-4XWjoK18NDkvjBL7i00ab8+otQg955pNGG_dQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

On Thu, Oct 6, 2022 at 1:25 PM Dave Airlie <airlied@gmail.com> wrote:
>
>
> [ 1234.778760] BUG: kernel NULL pointer dereference, address: 0000000000000088
> [ 1234.778813] RIP: 0010:drm_sched_job_done.isra.0+0xc/0x140 [gpu_sched]

As far as I can tell, that's the line

        struct drm_gpu_scheduler *sched = s_fence->sched;

where 's_fence' is NULL. The code is

   0: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
   5: 41 54                push   %r12
   7: 55                    push   %rbp
   8: 53                    push   %rbx
   9: 48 89 fb              mov    %rdi,%rbx
   c:* 48 8b af 88 00 00 00 mov    0x88(%rdi),%rbp <-- trapping instruction
  13: f0 ff 8d f0 00 00 00 lock decl 0xf0(%rbp)
  1a: 48 8b 85 80 01 00 00 mov    0x180(%rbp),%rax

and that next 'lock decl' instruction would have been the

        atomic_dec(&sched->hw_rq_count);

at the top of drm_sched_job_done().

Now, as to *why* you'd have a NULL s_fence, it would seem that
drm_sched_job_cleanup() was called with an active job. Looking at that
code, it does

        if (kref_read(&job->s_fence->finished.refcount)) {
                /* drm_sched_job_arm() has been called */
                dma_fence_put(&job->s_fence->finished);
        ...

but then it does

        job->s_fence = NULL;

anyway, despite the job still being active. The logic of that kind of
"fake refcount" escapes me. The above looks fundamentally racy, not to
say pointless and wrong (a refcount is a _count_, not a flag, so there
could be multiple references to it, what says that you can just
decrement one of them and say "I'm done").

Now, _why_ any of that happens, I have no idea. I'm just looking at
the immediate "that pointer is NULL" thing, and reacting to what looks
like a completely bogus refcount pattern.

But that odd refcount pattern isn't new, so it's presumably some user
on the amd gpu side that changed.

The problem hasn't happened again for me, but that's not saying a lot,
since it was very random to begin with.

                 Linus
