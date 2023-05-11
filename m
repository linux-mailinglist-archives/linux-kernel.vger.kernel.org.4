Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7CF6FFCED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbjEKXDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbjEKXDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:03:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAE5E74
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:03:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaf2ede38fso89457035ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683846183; x=1686438183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvPN25xK0Za8la+s6QkVMAkGh7HvIjcp+CzihkPnRv4=;
        b=dS2Gs0Nd9LGymO1wsNwhLiq1Faz3drEtOo5p5eOI5pBT+RsCbQ58uECwYpK2zWnsWf
         0QfBJWqHEIsYHqfYot1EAY7z4SL0unBfFTm1VWqkEVi34ZENdrOQ85hN4qAdWS+dgD68
         gvcTTTxmf0HskxIlX3Cfg4w3aqhctjDF84vQBPAfqBgl4Tjh5o1oi6EIcNqIAz6QYeiD
         wDzwFlqRGPRR/bxccT06M02qeX/1eAkwraBCXKGS4cpv+abv68WzbWqlgCCUvu9sv4/b
         kSjog5RBX5yKniQAPd9a/4xF7AVho2BsIj1T+oQSo+K0p+lVV+44jL695T35tJ5sQI2h
         46gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846183; x=1686438183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvPN25xK0Za8la+s6QkVMAkGh7HvIjcp+CzihkPnRv4=;
        b=DungHotWylsJMGHfxdFC/MlKe7Bpt+erIuFgP9dusuDTSq9BTonY66MSnGcpu17lgc
         ENA+DSySQp8dIrvmymDT6Lf5MtyT5Cdk6voEY7IKdDfucoJ+giZdRvNoCsjLT3sRJBMk
         APps2C5s32tCHUgUdGQXp1s+u1L9eyxXsE8g+Ex7zFkTJ9mibtT82I2bYygJ6OH1pAoe
         a2HDywuO9+EfNhDBx+Rn7zAJwKw7uM1AMcV1iiaz+joALGFmLDnGRoM6eT0hK2t43NMu
         mJyaSr4khPvoeul+c79ZTJs8msS/r30mIgNxq2YQ8COZMLfXhhKcxMFl8GrS/BagU0p/
         vDSw==
X-Gm-Message-State: AC+VfDy8/EUW3jJD5o0fEKouVwTNKw5PRMiCzwMflEbffcr8QomLmGhc
        S1kcPMHyykV7xp4VigonVmc=
X-Google-Smtp-Source: ACHHUZ5GrrKmlk35WI6K8vb+W+q2EUXLAj4Na2nM30wXYF+zeBXqujUo1/PsPhWvR416YsxrLTfsiA==
X-Received: by 2002:a17:903:25c2:b0:1a6:a405:f714 with SMTP id jc2-20020a17090325c200b001a6a405f714mr23689734plb.63.1683846182402;
        Thu, 11 May 2023 16:03:02 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001a6db2bef16sm6434614plt.303.2023.05.11.16.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:03:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 11 May 2023 13:03:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 7/7] workqueue: Track and monitor per-workqueue CPU time
 usage
Message-ID: <ZF10JNbflTfojZtA@slm.duckdns.org>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-8-tj@kernel.org>
 <20230511211134.GG2296992@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511211134.GG2296992@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 11, 2023 at 11:11:34PM +0200, Peter Zijlstra wrote:
> On Thu, May 11, 2023 at 08:19:31AM -1000, Tejun Heo wrote:
> > Now that wq_worker_tick() is there, we can easily track the rough CPU time
> > consumption of each workqueue by charging the whole tick whenever a tick
> > hits an active workqueue. While not super accurate, it provides reasonable
> > visibility into the workqueues that consume a lot of CPU cycles.
> > wq_monitor.py is updated to report the per-workqueue CPU times.
> 
> I'm utterly failing to read that dragon thing (or possibly snake, but I
> can typically sorta make out what it intends to do).

Yeah, it's basically gdb in python. It's surprisingly widely useful.

> However, while you don't have preempt-out, you still have sched-out
> through wq_worker_sleeping(), so you should be able to compute the time
> spend on the workqueue by past worker runs -- fully accurate.
> 
> Then you only need to add the time since sched-in of any current worker
> and you have a complete picture of time spend on the workqueue, no
> approximation needed.
> 
> Or am I completely missing the point?

One issue is that sum_exec_runtime isn't necessarily updated when a work
item completes and then the work can go execute other work items without any
scheduling event inbetween. So, no matter what I do, if I wanna account CPU
time accurately per work item, I need to read the current time once more
between work items, which is okay but not really necessary, not preemptively
anyway. If there are use cases that need accurate accounting, we can always
revisit the issue.

Thanks.

-- 
tejun
