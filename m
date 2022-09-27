Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4C5EC4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiI0NjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiI0NjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:39:08 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B29DC11E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:39:06 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id y2so5984225qkl.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7gCyUz8tGUngYdmFRNWTPdCGvdUrFoEBtlzOr30DYNY=;
        b=UW2s/qZBxAVBGY+MFSKKB5elf/hxzNdxBsNu20+T2SpgNTk67eMpYqkVugVG8U3ylX
         Dy49yhrWIyG/5IBkTHkiPk+ctwBFvXRLHRxsCVfR7TEksPXPSHOdlu1oDx/AgLViyYXH
         uJ73vl2c9EXmpWHAvRiCoStt8OXSWmgBRRGijYllDfwhoeszoyccGU7fA9EecgvrZDQC
         uAe0PlyDotDavra+zymnGBl0zzPYdwN4911g2e3eyc+J9rvUASGza5w0dA5jRkU9NPmD
         2AUa+Zkkjm255oqJLY073Sp3quQww+2aPFuAhW9KZlCPII/WPaP4LXob958tDx3sVWoI
         I1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7gCyUz8tGUngYdmFRNWTPdCGvdUrFoEBtlzOr30DYNY=;
        b=nAkz+5qV+7RNbMW38n1hSK1P95nG8HpMWeQjtj03E3K/qvun/t24yct27/PvJx0naM
         uHEVqtjl9ALMiu33jFCW9dfeyeel0DDQHNk2Ppc8G5gmN/4FXG6eBME42vhhYWZF7cUv
         C+WtcPVa2+kIT4C3YsD36Z8kaKn0QyvtvsGST5sRkm+36ex7XEklL/Zl9GtYozEzfPii
         oLWW52m8vpqtI/k3Gp9zKuBufKoyVIT8f9iP8NuX2UKmPhxx/vj+X1YZgt0jH4Ly8XHf
         y/3oZtW2pk0ss+w4tOxRzeB8gHgNEFj5BpdKfUJrJuIY4wLTk4rZAF8LqMyZBz7OrvXY
         AxDQ==
X-Gm-Message-State: ACrzQf0GwIwi5EYf0KO9tydAQUVgKQU8m0nBrYhDp8LOSkETpFJ1p+1q
        du1s0ERT6NQdeZsydqDfYxbPOA==
X-Google-Smtp-Source: AMsMyM4UFI6XUGb2S7KeUgW4ghFCq/EoVD2Yi7kZTqkQpaU5YhIiejAWGxx+Fazj0ux45S8DzCncvw==
X-Received: by 2002:a05:620a:2043:b0:6ce:6035:9f51 with SMTP id d3-20020a05620a204300b006ce60359f51mr18004440qka.18.1664285945538;
        Tue, 27 Sep 2022 06:39:05 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id bp12-20020a05620a458c00b006b9c9b7db8bsm955223qkb.82.2022.09.27.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:39:04 -0700 (PDT)
Date:   Tue, 27 Sep 2022 09:39:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/psi: Use task->psi_flags to clear in CPU migration
Message-ID: <YzL89wKVbIn8y/QF@cmpxchg.org>
References: <20220926081931.45420-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926081931.45420-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:19:31PM +0800, Chengming Zhou wrote:
> The commit d583d360a620 ("psi: Fix psi state corruption when schedule()
> races with cgroup move") fixed a race problem by making cgroup_move_task()
> use task->psi_flags instead of looking at the scheduler state.
> 
> We can extend task->psi_flags usage to CPU migration, which should be
> a minor optimization for performance and code simplicity.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Nice one!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
