Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B448666A4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjAMVL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjAMVL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:11:26 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC6A10079;
        Fri, 13 Jan 2023 13:11:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso23867191pjl.2;
        Fri, 13 Jan 2023 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2ikjO+GtcxmrulSyBE/PiHbmfzhIbHlX0PL4SbCaTI=;
        b=Hnj9mfGZ6hFxzXvsMWJYDVzho2AqPomHplMaO+bttV6PLWxPZdO/jQ3Kn9aJK7ylE5
         wAqmvQtxIKN75Q11y7aauROIPm9fAqbrzk5Pqk445/0DoGDQX/kbrAY3oqY47xox36Gb
         CMYGNFG3YxD+LffE4rIF7jbJp3YFP2WB48bJ+6reGkMfYLp2Q80zp8TqEF3KvoU169jZ
         b6KZPfDR+NLgmC93iJoGF7ARHKqjo8qYf05hHIqV/B+JQ+MoY55IwPoAUf58RTLS3woO
         8wK1z3LKaAtFxNpZWR3ClaEs2NsvOMxhy80/9XJp0pt5VmfYWtAQ6n8Ocaecnqv5p3bm
         5TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2ikjO+GtcxmrulSyBE/PiHbmfzhIbHlX0PL4SbCaTI=;
        b=dbLpfUuqJegi8zor8zoOTpjdmIlckeeohgwTNZTjTK7QV4MtLTtINIvGJoGYMhEdV/
         hbnmRYL1X2arp55dJT+4rvQHJwg88/z3eVCAgO8YfcHMc3oQiUSthXIYcHseefH8GsAq
         eJ3CKVHoi5iZiYjuD05IFIgr/CLC0bQhrckHWcsOl17aR73ub97pzQLPMUNW46jY8sTr
         u/FJ9HdrGXNf2gVBeHS3isKeoCJZdI7H68IhCLp16brrVZpY+xDqXHgLOILyJj0wp337
         lZ/fKeVx6edUd5U2V/A50XXtlk975PJj3w4weU6od4+fE5C04trVvVhhcRjtXtYZHsvK
         E04Q==
X-Gm-Message-State: AFqh2kp0mvw5T8aKq+qz+Tg57SLjK4r0Jc0B898IycQfHWMhksTFv9CV
        A4Xr9CA7eCUmjpej1LhJdMU=
X-Google-Smtp-Source: AMrXdXstptb8dFf96XhZIrWLmbAvbeLTlqPdmeVXu+eciQajsKEGoy5462IE3ascYUNCTiQfQ3uNiw==
X-Received: by 2002:a17:903:3246:b0:194:52ed:7a18 with SMTP id ji6-20020a170903324600b0019452ed7a18mr9260146plb.44.1673644285100;
        Fri, 13 Jan 2023 13:11:25 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b00187197c499asm14573443plk.164.2023.01.13.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:11:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Jan 2023 11:11:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Sandeep Dhavale <dhavale@google.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Add WQ_SCHED_FIFO
Message-ID: <Y8HI+42TxxlJxT6D@slm.duckdns.org>
References: <20230113210703.62107-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113210703.62107-1-nhuck@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 01:07:02PM -0800, Nathan Huckleberry wrote:
> Add a WQ flag that allows workqueues to use SCHED_FIFO with the least
> imporant RT priority.  This can reduce scheduler latency for IO
> post-processing when the CPU is under load without impacting other RT
> workloads.  This has been shown to improve app startup time on Android
> [1].
> 
> Scheduler latency affects several drivers as evidenced by [1], [2], [3],
> [4].  Some of these drivers have moved post-processing into IRQ context.
> However, this can cause latency spikes for real-time threads and jitter
> related jank on Android.  Using a workqueue with SCHED_FIFO improves
> scheduler latency without causing latency problems for RT threads.
> 
> [1]:
> https://lore.kernel.org/linux-erofs/20230106073502.4017276-1-dhavale@google.com/
> [2]:
> https://lore.kernel.org/linux-f2fs-devel/20220802192437.1895492-1-daeho43@gmail.com/
> [3]:
> https://lore.kernel.org/dm-devel/20220722093823.4158756-4-nhuck@google.com/
> [4]:
> https://lore.kernel.org/dm-crypt/20200706173731.3734-1-ignat@cloudflare.com/
> 
> This change has been tested on dm-verity with the following fio config:
> 
> [global]
> time_based
> runtime=120
> 
> [do-verify]
> ioengine=sync
> filename=/dev/testing
> rw=randread
> direct=1
> 
> [burn_8x90%_qsort]
> ioengine=cpuio
> cpuload=90
> numjobs=8
> cpumode=qsort
> 
> Before:
> clat (usec): min=13, max=23882, avg=29.56, stdev=113.29 READ:
> bw=122MiB/s (128MB/s), 122MiB/s-122MiB/s (128MB/s-128MB/s), io=14.3GiB
> (15.3GB), run=120001-120001msec
> 
> After:
> clat (usec): min=13, max=23137, avg=19.96, stdev=105.71 READ:
> bw=180MiB/s (189MB/s), 180MiB/s-180MiB/s (189MB/s-189MB/s), io=21.1GiB
> (22.7GB), run=120012-120012msec

Given that its use case mostly intersects with WQ_HIGHPRI, would it make
more sense to add a switch to alter its behavior instead? I don't really
like the idea of pushing the decision between WQ_HIGHPRI and WQ_SCHED_FIFO
to each user.

Thanks.

-- 
tejun
