Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92C604919
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiJSOVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiJSOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:21:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D63DBCC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:04:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pb15so91748pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kSywqTaeBFCSrBJK62YFMOGjIue9VCaMx6UeNmePcMs=;
        b=iiK3FLvRmHJDioEVPTP2ct13V9hY9l1zdExtFWQ8tA5yt5Qxz3Vt+VfkjDC9nO6iKY
         lko+MNepEkYQIFubXygNugFfKEhpLiAeevEwIfOkselLWX0YPWSY954Jh6TTQK35eWE1
         dAl2/YMF6OtbLup00Di4lADkEQoGHT7tD0GgCTHrS6n5NfWoIFJ7BZ8QcTNkPBLf7Rhv
         kUAycgP1QX10GolpBvvntWIbaXd0YqAWLqMiqBwY4lS8Dlq1I2nAj2LhJlyF0L/8KE40
         OgVOC5zRx73y24R0Y9wvQqy7KxLNXVwi59w5X1WgwXItcuI9t1+j1ZBlKyL7229TciQ3
         iFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSywqTaeBFCSrBJK62YFMOGjIue9VCaMx6UeNmePcMs=;
        b=7top7rwq3B6xR0Yy1gja0O6AxXuh+EnLSGg/S9CBqAP7NWMf/Lz7qkuiX8Ww8TtJeo
         JSh/fSpQdfWIRZVg1Y3ZimwwsVAJ8SEwM64Q2Kf5FZUTxxU9M6KgVP2Z2TUIT4/BaSn6
         p8qe97+80+Ez3t570y+tIoB9IZDy64l2S6bAmME0tHHNs1KpujPO9DrOeQIkimPc+Ed9
         yWZmaCU00PkJuytUAe3/ixQBz8R0mxo+8Ut2RFgB75qodLulOjv/Ji7zynr2U0NDMJ8Q
         MW4AIGdkgHV5xx2kwfpjRUtXNTr+JTez0e9Ebp260a2/UGkEm93GU0E93OZE4/7Y4qh6
         eYIQ==
X-Gm-Message-State: ACrzQf28yUvLof78vBveU0Lq7OyOMUFIQanUDPbgO/lFe9ISsWw3++lG
        8z18qxQWkKYR/zxMaEhv7+aVBmB+LGYQKrTl+XQobNKQaBw=
X-Google-Smtp-Source: AMsMyM7a/mDmv4BOUIEZLatbl1VVl+gK5ZFYsovOjC5vrCr3NKiTjFqBrylJVD6Dvv9B3G49ek2Ho+1Hmr34ftYZ5S8=
X-Received: by 2002:a17:903:2449:b0:186:1269:929c with SMTP id
 l9-20020a170903244900b001861269929cmr8778448pls.37.1666187618901; Wed, 19 Oct
 2022 06:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221005131452.1506328-1-james.clark@arm.com>
In-Reply-To: <20221005131452.1506328-1-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 19 Oct 2022 14:53:27 +0100
Message-ID: <CAJ9a7VjQb2MLpTLPuFRTqqkpg-xC6T66DbsMzq_vQNiAcQ9FDA@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: Fix hang in cti_disable_hw()
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        Sudeep.Holla@arm.com, Aishwarya TCV <Aishwarya.TCV@arm.com>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on DB410c + kernel 6.0.0

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Tested-by: Mike Leach <mike.leach@linaro.org>

On Wed, 5 Oct 2022 at 14:16, James Clark <james.clark@arm.com> wrote:
>
> cti_enable_hw() and cti_disable_hw() are called from an atomic context
> so shouldn't use runtime PM because it can result in a sleep when
> communicating with firmware.
>
> Since commit 3c6656337852 ("Revert "firmware: arm_scmi: Add clock
> management to the SCMI power domain""), this causes a hang on Juno when
> running the Perf Coresight tests or running this command:
>
>   perf record -e cs_etm//u -- ls
>
> This was also missed until the revert commit because pm_runtime_put()
> was called with the wrong device until commit 692c9a499b28 ("coresight:
> cti: Correct the parameter for pm_runtime_put")
>
> With lock and scheduler debugging enabled the following is output:
>
>    coresight cti_sys0: cti_enable_hw -- dev:cti_sys0  parent: 20020000.cti
>    BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1151
>    in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 330, name: perf-exec
>    preempt_count: 2, expected: 0
>    RCU nest depth: 0, expected: 0
>    INFO: lockdep is turned off.
>    irq event stamp: 0
>    hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>    hardirqs last disabled at (0): [<ffff80000822b394>] copy_process+0xa0c/0x1948
>    softirqs last  enabled at (0): [<ffff80000822b394>] copy_process+0xa0c/0x1948
>    softirqs last disabled at (0): [<0000000000000000>] 0x0
>    CPU: 3 PID: 330 Comm: perf-exec Not tainted 6.0.0-00053-g042116d99298 #7
>    Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Sep 13 2022
>    Call trace:
>     dump_backtrace+0x134/0x140
>     show_stack+0x20/0x58
>     dump_stack_lvl+0x8c/0xb8
>     dump_stack+0x18/0x34
>     __might_resched+0x180/0x228
>     __might_sleep+0x50/0x88
>     __pm_runtime_resume+0xac/0xb0
>     cti_enable+0x44/0x120
>     coresight_control_assoc_ectdev+0xc0/0x150
>     coresight_enable_path+0xb4/0x288
>     etm_event_start+0x138/0x170
>     etm_event_add+0x48/0x70
>     event_sched_in.isra.122+0xb4/0x280
>     merge_sched_in+0x1fc/0x3d0
>     visit_groups_merge.constprop.137+0x16c/0x4b0
>     ctx_sched_in+0x114/0x1f0
>     perf_event_sched_in+0x60/0x90
>     ctx_resched+0x68/0xb0
>     perf_event_exec+0x138/0x508
>     begin_new_exec+0x52c/0xd40
>     load_elf_binary+0x6b8/0x17d0
>     bprm_execve+0x360/0x7f8
>     do_execveat_common.isra.47+0x218/0x238
>     __arm64_sys_execve+0x48/0x60
>     invoke_syscall+0x4c/0x110
>     el0_svc_common.constprop.4+0xfc/0x120
>     do_el0_svc+0x34/0xc0
>     el0_svc+0x40/0x98
>     el0t_64_sync_handler+0x98/0xc0
>     el0t_64_sync+0x170/0x174
>
> Fix the issue by removing the runtime PM calls completely. They are not
> needed here because it must have already been done when building the
> path for a trace.
>
> Fixes: 835d722ba10a ("coresight: cti: Initial CoreSight CTI Driver")
> Reported-by: Aishwarya TCV <Aishwarya.TCV@arm.com>
> Reported-by: Cristian Marussi <Cristian.Marussi@arm.com>
> Signed-off-by: Suzuki Poulose <Suzuki.Poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-cti-core.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 8988b2ed2ea6..c5f7fc4e2552 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -94,7 +94,6 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>         unsigned long flags;
>         int rc = 0;
>
> -       pm_runtime_get_sync(dev->parent);
>         spin_lock_irqsave(&drvdata->spinlock, flags);
>
>         /* no need to do anything if enabled or unpowered*/
> @@ -119,7 +118,6 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>         /* cannot enable due to error */
>  cti_err_not_enabled:
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -       pm_runtime_put(dev->parent);
>         return rc;
>  }
>
> @@ -175,7 +173,6 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>         coresight_disclaim_device_unlocked(csdev);
>         CS_LOCK(drvdata->base);
>         spin_unlock(&drvdata->spinlock);
> -       pm_runtime_put(dev->parent);
>         return 0;
>
>         /* not disabled this call */
> --
> 2.28.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
