Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE3607E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJUSEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJUSEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:04:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E233E284877
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:04:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ez6so3098945pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzELkpjdHbj30qakI/Atn3Cr100bvEom5zJPbjfl8JY=;
        b=G5QpKv2SHWtedNEIZDXWVPB1jMh+OtFqodnIjyZicIrNLja6VluHXqMwIEfOUyRpJh
         byqdno+kUekoCDnMhgsymEsI+QR1DFK3eauS4H6H4M/wojdSICovl0G5iBKkRUjfrmck
         58aQvqPrixjfPDPm8FF0Y2WNUwrdR091G2B0WjRYS0ZX58sMsNXI4IAf8lUCpdZe0FZ+
         qi6d/p8Av81XxqNdCRw7oyR1UNEuZ2VqoTzhOUDxOAe2wSgrhh1gk9mQqF78KV7SH2A+
         uoH/9bqIJwQTkli0Y9Mg5HdfRlncYtL7/cK+ki3LF8tX6LhyKPgfAIAfQEmxELiN1sYu
         yh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzELkpjdHbj30qakI/Atn3Cr100bvEom5zJPbjfl8JY=;
        b=DkttIYMihUO9x6J4VKe7d5MvGCSpXq/EYfCMnbdYN/Ye5e4Ng1n2Y00iERrLEQhEOc
         ix0zkQdXbDixRQbW/m9ee6XALgzKjd1kErORSzCLvZjpdlU6Ne/elm4a3SAuwfOPr5WD
         Uuciu+cSrn8cZ3E+35b+TOYOegsNFLhvvke9IM6aUcOmfyoyQ9oxX83AAP+16+weSfMC
         qJgrKiFbA3ERKiRsNY2FV1JV4cEi1yLuX6mLYgcxKmm0Q62Wx3VKkEa+CLVqJZcxK7Tk
         gy43UkCL0mkeFB+TBfpvpy/0fM+1A3DDMf5gKlTv16sHC4gEk3iEIItC1f15i9ttOuSs
         lggQ==
X-Gm-Message-State: ACrzQf3L7lov4MM8i0aaNSTahPk4NycoSZGXv51+rKOqThWTaVKUwjdT
        vwn2bZahTrAmOXu82CdQSuQ=
X-Google-Smtp-Source: AMsMyM7A+cFh5l7zBJokdc/xpw5U7h59m3dWMGLOjsi/kuDkNRNKWAchGUog0ccSOP13Vm0hP6fdsw==
X-Received: by 2002:a17:902:aa42:b0:17e:b779:dadb with SMTP id c2-20020a170902aa4200b0017eb779dadbmr20903541plr.11.1666375455167;
        Fri, 21 Oct 2022 11:04:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0053e62b6fd22sm15348507pfh.126.2022.10.21.11.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:04:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Oct 2022 08:04:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, htejun@gmail.com,
        lizefan.x@bytedance.com, vschneid@redhat.com, bsegall@google.com,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: Re: [RESEND] sched/fair: Add min_ratio for cfs bandwidth_control
Message-ID: <Y1LfHVENWB8ZDFyr@slm.duckdns.org>
References: <20221019031551.24312-1-zhouchuyi@bytedance.com>
 <Y1BqT59ovFitahJa@slm.duckdns.org>
 <Y1GAffm4aHCpvoBB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1GAffm4aHCpvoBB@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Oct 20, 2022 at 07:08:13PM +0200, Peter Zijlstra wrote:
> > This is a bit of a bandaid. I think what we really need to do is only
> > throttling when running in userspace. In kernel space, it should just keep
> > accumulating used cycles as debt which should be paid back before userspace
> > code can run again so that we don't throttle at random places in the kernel.
> 
> That's just moving the problem. But yeah; perhaps. Starving random
> userspace is less of a problem I suppose.

Given that our primary mean of guaranteeing forward progress is the fact
that the system runs out of other things to do when there are severe
priority inversions, I don't think we can safely give control of throttling
something running in the kernel to userspace.

IO control takes a similar approach with shared IOs which can have
system-wide impacts and it's been working out pretty well. While some may go
over the limit briefly, it's not that difficult to remain true to the
intended configuration over time.

The only problem is the cases where userspace can cause a large amount of
forced consumptions (e.g. for IOs, creating a lot of metadata updates
without doing anything else), but even in the unlikely case similar problem
exists for CPU, it's pretty easy to add specific control mechanisms around
those (e.g. sth along the style of might_resched()).

So, yeah, I think this is the actual solution.

Thanks.

-- 
tejun
