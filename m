Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985DB643C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiLFENh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLFENb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:13:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32B63AE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 20:13:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso467863pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 20:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MfWaYRkehk0dajmy4ZRMhDfZ32fusmILon8L0KL43DA=;
        b=ZeYwIHAYNlVwmgGWbAgxyTI3XjKFdfuKev4lhffJyJseMlBCWZk9H4byibAJgp5YQK
         AB5gXMFFQl1aPv/C+E1KI7tOPwXzswAaO6cleq17HOfHPUnAb3bxsa5AH96a/U7nMzVN
         gI8uGElq0LwcmT36pfgRgN0+CeD3d5/OhQegWghAn0V8UR7hZbAwRq/YHhhH3KuspWm0
         vmi3Zv8tH9yDtWNyIagRRFXbM4cAsmLj+CC+J1XQ+h6bpLZxn3JS5IjqzqEXIBwZIVkQ
         zoi8kOEWY9DhQ1qyxx+pCDbR2XS/MWTd7DPULlfph0euqrOBReJjpXKYkHwnnBCazky+
         QIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfWaYRkehk0dajmy4ZRMhDfZ32fusmILon8L0KL43DA=;
        b=XJcRJSLbflZHOG0WDZ9geZUn8Hi2VxQ+2dLZQ7ZFO9KLr5yWeXTVggmxqI/04GEIk9
         kTTcIWXU8pDqvHKkWG8E65uA5igEUP0nzymvbrSpq/e/IrU986asm/+qXsglybryWiWs
         p4EM2pEdwgPhUtk68AZerO/xQD9NgAeQp3g8qInZM2kA6kIgveOiv7QdNgfNQOTD7PTH
         UuGldsuZecz6jOe6kbCcoYpO0Bp1XQenNXJtN/8YF5pWqK/dQXhOQBu0RDPmGJHJWVHg
         5Bsa/4e/rJtzGQoZQif6uWbHmSXHA/DjdZVbpK+YrGazqVakY7v25slw67xvT4YyHqhZ
         zFQg==
X-Gm-Message-State: ANoB5pk5r52StjDXo+JXmvkdU5PTYJSXX2f6+Ol9bomzFPSRdOc09xy/
        KwDK8ct90TyExMouy05tr4KfAAJUgIS+HsSBaSRdkp/IuAU=
X-Google-Smtp-Source: AA0mqf7LAkszvToroH9JfZ/JsDSMOclXxalItR41OkEVypRSa08I0v7Sscb4Dj+QDFp7mXz/qpSIcD+cVWl+NTfQn7g=
X-Received: by 2002:a17:902:d510:b0:186:b137:4b42 with SMTP id
 b16-20020a170902d51000b00186b1374b42mr24557969plg.98.1670300009941; Mon, 05
 Dec 2022 20:13:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
In-Reply-To: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 6 Dec 2022 12:13:18 +0800
Message-ID: <CAJhGHyD+oR8SeYeObJ2DSKfudqBtBOiL14jCsST3L5OG8WjT_g@mail.gmail.com>
Subject: Re: work item still be scheduled to execute after destroy_workqueue?
To:     richard clark <richard.xnu.clark@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 5, 2022 at 2:18 PM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> Hi Lai and Tejun,
>
> Why can the work still be queued to and executed when queueing it to a
> wq has been destroyed, for instance, the below code snippet in a
> kernel module:
> ---------------------->8---------------------
>
> struct workqueue_struct *wq0;
> #define MAX_ACTIVE_WORKS        (3)
>
> static void work0_func(struct work_struct *work);
> static void work1_func(struct work_struct *work);
> static void work2_func(struct work_struct *work);
>
> static DECLARE_WORK(w0, work0_func);
> static DECLARE_WORK(w1, work1_func);
> static DECLARE_WORK(w2, work2_func);
>
> /* work->func */
> static void work0_func(struct work_struct *work)
> {
>         pr_info("+%s begins to sleep\n", __func__);
>         /* sleep for 10s */
>         schedule_timeout_interruptible(msecs_to_jiffies(10000));
>         pr_info("+%s after sleep, begin to queue another work\n", __func__);
>         queue_work_on(1, wq0, &w1);
> }
>
> /* work->func */
> static void work1_func(struct work_struct *work)
> {
>         pr_info("+%s scheduled\n", __func__);
> }
>
> /* work->func */
> static void work2_func(struct work_struct *work)
> {
>         pr_info("+%s scheduled\n", __func__);
> }
>
> static int destroy_init(void)
> {
>         wq0 = alloc_workqueue("percpu_wq0", 0, MAX_ACTIVE_WORKS);
>         if (!wq0) {
>                 pr_err("alloc_workqueue failed\n");
>                 return -1;
>         }
>         queue_work_on(1, wq0, &w0);
>         pr_info("Begin to destroy wq0...\n");
>         destroy_workqueue(wq0);
>         pr_info("queue w2 to the wq0 after destroyed...\n");
>         queue_work_on(1, wq0, &w2);

Hello, Richard.

Nice spot.

It is illegal to use a destroyed structure in the view of any API.

A destroyed workqueue might be directly freed or kept for a while,
which is up to the code of workqueue.c

Before e2dca7adff8f(workqueue: make the workqueues list RCU walkable),
the workqueue is directly totally freed when destroyed.
After the said commit, the workqueue is held for an RCU grace before
totally freed.  And it is a per-cpu workqueue, and the base ref is
never dropped on per-cpu pwqs, which means it is referencable and
able to be queued items during the period by accident.

Albeit it is illegal to use a destroyed workqueue, it is definitely bad
for workqueue code not to complain noisily about the behavior, so I am
going to set __WQ_DRAINING permanently for the destroyed workqueue, so
the illegal usage of the destroyed workqueue can result WARN().

Thank you for the report.
Lai

>
>         return 0;
> }
>
> The output on my x86_64 box is:
>
> [344702.734480] +destroy_init+
> [344702.734499] Begin to destroy wq0...
> [344702.734516] +work0_func begins to sleep
> [344712.791607] +work0_func after sleep, begin to queue another work
> [344712.791620] +work1_func scheduled
> [344712.791649] queue w2 to the wq0 after destroyed...
> [344712.791663] +work2_func scheduled  <------------- work 2 still be scheduled?
