Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5DA6422F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiLEGSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiLEGSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:18:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED511816
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 22:18:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg10so7961411wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 22:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cKvnCaTte6OI41/izSASPW8Y7Q9GHM0eeRl020Krw3w=;
        b=Pe1vVqtsReplTWEgs/ey8TAv8VSYF0u9DIAy3IEFzXUzo8Nfm2Sflnz4/E8rTXRZ6l
         3O4zGA0TnbDHXc6rP+VQ3jUgG2fubqTPJQT5Tb5DM6DmBVJ8cApotp4iojUDy/iwHF8C
         sYosFdQYqpsQPglSsrMSs8NQ17JOohB+W3MAkdZdCgqB1aWB5cV8rfGAoPl62kjn+HFA
         5H8M4av54+hpbhW6DnkMlrN87GQjYWoKIjDLvz4xIopbsIhlmgUUU4rB12/pZJlhE/if
         11qLMZLgWY7b3+Nnx/CEDdmYVL+WFzkJbUyDDeadbZ71i5K/IjUuZ42zhI6Q+Csbg7+P
         vV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKvnCaTte6OI41/izSASPW8Y7Q9GHM0eeRl020Krw3w=;
        b=KdWIDGYr7EERYiXccJ0eHAXtMwCTQ4Bl4zEajQYge01auyu/kBKAzzKG7wo9mzatcA
         Cfv/H+0wihidc3NM2prn4LXF1ZuuKtrteuVA4G/LGBSHUA8Wi3zxPuZD/KRbTzBqBJ7t
         yBjN7pCBS+pExVqNy5Q5qzw74kSsp8osfNSm9ZjG40d4BBHjKolh5hL5zCcs6GROfmr7
         sMKHPifPO01GiYGlUPkRHCGFRbGdiSScyaSN8X7Pn4xd4EP/GpJsVrvOwiWdxFwUXFGB
         21q7ldPAo7H+FwLemqrTct4vMdsJZnntOPKJ/g/4dtCw0rUvkFZz4yl6EQE/9kXSwdDB
         kYUQ==
X-Gm-Message-State: ANoB5plh4MQ3hREBbGvAE6idfy2qp/+b2PP2X74cFj5CP0sZq+n9+Ymt
        AFP5VM9/YGPo/j6Z0X6PlZEUMlqvhZfp7SoTlDyNy4QyFKs=
X-Google-Smtp-Source: AA0mqf7HhzF1CSsS+tJPOPBUOTo+cyDMlH1D0YnVxenxcPXs27/Rahp9DfJ3Dw/P+OGY7LVuK6XGHtEhAsY3uUW0uig=
X-Received: by 2002:a05:600c:22c4:b0:3cf:71b7:7a41 with SMTP id
 4-20020a05600c22c400b003cf71b77a41mr60779636wmg.31.1670221127010; Sun, 04 Dec
 2022 22:18:47 -0800 (PST)
MIME-Version: 1.0
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Mon, 5 Dec 2022 14:18:35 +0800
Message-ID: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
Subject: work item still be scheduled to execute after destroy_workqueue?
To:     Lai Jiangshan <jiangshanlai@gmail.com>
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

Hi Lai and Tejun,

Why can the work still be queued to and executed when queueing it to a
wq has been destroyed, for instance, the below code snippet in a
kernel module:
---------------------->8---------------------

struct workqueue_struct *wq0;
#define MAX_ACTIVE_WORKS        (3)

static void work0_func(struct work_struct *work);
static void work1_func(struct work_struct *work);
static void work2_func(struct work_struct *work);

static DECLARE_WORK(w0, work0_func);
static DECLARE_WORK(w1, work1_func);
static DECLARE_WORK(w2, work2_func);

/* work->func */
static void work0_func(struct work_struct *work)
{
        pr_info("+%s begins to sleep\n", __func__);
        /* sleep for 10s */
        schedule_timeout_interruptible(msecs_to_jiffies(10000));
        pr_info("+%s after sleep, begin to queue another work\n", __func__);
        queue_work_on(1, wq0, &w1);
}

/* work->func */
static void work1_func(struct work_struct *work)
{
        pr_info("+%s scheduled\n", __func__);
}

/* work->func */
static void work2_func(struct work_struct *work)
{
        pr_info("+%s scheduled\n", __func__);
}

static int destroy_init(void)
{
        wq0 = alloc_workqueue("percpu_wq0", 0, MAX_ACTIVE_WORKS);
        if (!wq0) {
                pr_err("alloc_workqueue failed\n");
                return -1;
        }
        queue_work_on(1, wq0, &w0);
        pr_info("Begin to destroy wq0...\n");
        destroy_workqueue(wq0);
        pr_info("queue w2 to the wq0 after destroyed...\n");
        queue_work_on(1, wq0, &w2);

        return 0;
}

The output on my x86_64 box is:

[344702.734480] +destroy_init+
[344702.734499] Begin to destroy wq0...
[344702.734516] +work0_func begins to sleep
[344712.791607] +work0_func after sleep, begin to queue another work
[344712.791620] +work1_func scheduled
[344712.791649] queue w2 to the wq0 after destroyed...
[344712.791663] +work2_func scheduled  <------------- work 2 still be scheduled?
