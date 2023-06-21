Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9998C73909F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjFUUPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFUUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:14:56 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AB9199D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:14:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77e324816dbso199886739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687378492; x=1689970492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xv4lzHFsGu568/y6hToLhxYR1n4VFTc+xymT31r9IBo=;
        b=Y1LID2OdGJhJJoZJjc7OgcAyrW2ZfNPJ3dZuJ5rPfwRvLlKa7Z3JFtezhx6xvSXlqf
         VPCm/l9xp3mLcT4Ltqo5y3oOyH4DFEXQjTz2VCDcchw2+v9E5G28znXrg2fHmoMKwsW1
         AWkyLtiwxy0zWHAMCI6iROE2Sl3aMsF4fn1YFTKEHNkhjwuCm/it9b47OSiGPG7SJFzn
         LQ+eC4NchTaqsbSzyxPGp0EFuK4oMMvOfcsW3Ia2qnUSClGN1widmJBIyeC64w9okbTA
         z77gvY/bQCozLq1mRmb7QuzFGPSyZNCeQk7XRtgIRNsXpmMgCS8BcPWi5yyk8hb4R4fk
         AkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378492; x=1689970492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv4lzHFsGu568/y6hToLhxYR1n4VFTc+xymT31r9IBo=;
        b=jYlTuRNKH2EY8H9Fjsg8uupWADfvXtjN8XuOIXZweUn7yoN0GV89M0gijuoWeJN/zS
         pcNHf0mH53NKgIPW8nkYcXJQ1h/0V2teBdB7XzFg7du6wnntdh3ekL1hTQwTd7+31W/5
         +fX2yGsXCTWRMrcWFG6jsoZSLRplkfs94PEhl/OZ9Np6+pl2GHKGJLpp9iptIlj0JUdH
         W6DRMz05W3OlkL3+aGjh6OMFe5P80nf3IXCVwJ0QRHXMx/zeSOSsONa2iDm1zS1yoDYY
         UgGYMgRDOTCm2DeyoIq0sAorGpP8M4mcj0LIhxiRAkfkPB2ppJD+mtMYxn0rLWbzmzc5
         GEOg==
X-Gm-Message-State: AC+VfDxSv2s3n4feAT7m1pmzKdsAooG5pmTS27U33GepoEOeu14YEGYX
        QyOtR/If3ckERzhnIkqaHW0=
X-Google-Smtp-Source: ACHHUZ4lsZTPxKdqOrJ7rDdlZRr6+ng2K+fXie6G3ixxcPBtKkx1qs4+P7tobMWHmZEI/TNSjUrLsg==
X-Received: by 2002:a6b:ec0c:0:b0:780:a8bb:8f09 with SMTP id c12-20020a6bec0c000000b00780a8bb8f09mr4954261ioh.3.1687378492370;
        Wed, 21 Jun 2023 13:14:52 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id w12-20020a6b4a0c000000b0077e2637f897sm1624425iob.13.2023.06.21.13.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:14:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 10:14:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com, kernel-team@android.com,
        Swapnil Sapkal <swapnil.sapkal@amd.com>, kprateek.nayak@amd.com
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Message-ID: <ZJNaOumMiGSqK2-2@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
 <ZIEBB-A1arYKSK2P@slm.duckdns.org>
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
 <ZIJbMQOu_k07jkFf@slm.duckdns.org>
 <fd5a27de-c8a9-892c-f413-66ea41221fdd@amd.com>
 <CAB=BE-QaNBn1cVK6c7LM2cLpH_Ck_9SYw-YDYEnNrtwfoyu81Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=BE-QaNBn1cVK6c7LM2cLpH_Ck_9SYw-YDYEnNrtwfoyu81Q@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 11:49:53AM -0700, Sandeep Dhavale wrote:
> Thank you for your patches! I tested the affinity-scopes-v2 with app launch
> benchmarks. The numbers below are total scheduling latency for erofs kworkers
> and last column is with percpu highpri kthreads that is
> CONFIG_EROFS_FS_PCPU_KTHREAD=y
> CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI=y
> 
> Scheduling latency is the latency between when the task became eligible to run
> to when it actually started running. The test does 50 cold app launches for each
> and aggregates the numbers.
> 
> | Table        | Upstream | Cache nostrict | CPU nostrict | PCPU hpri |
> |--------------+----------+----------------+--------------+-----------|
> | Average (us) | 12286    | 7440           | 4435         | 2717      |
> | Median (us)  | 12528    | 3901           | 3258         | 2476      |
> | Minimum (us) | 287      | 555            | 638          | 357       |
> | Maximum (us) | 35600    | 35911          | 13364        | 6874      |
> | Stdev (us)   | 7918     | 7503           | 3323         | 1918      |
> |--------------+----------+----------------+--------------+-----------|
> 
> We see here that with affinity-scopes-v2 (which defaults to cache nostrict),
> there is a good improvement when compared to the current codebase.
> Affinity scope "CPU nostrict" for erofs workqueue has even better numbers
> for my test launches and it resembles logically to percpu highpri kthreads
> approach. Percpu highpri kthreads has the lowest latency and variation,
> probably down to running at higher priority as those threads are set to
> sched_set_fifo_low().

If you set workqueue to CPU strict and set its nice value to -19 in the
sysfs interface, it should behave simliar to the hardcoded PCPU hpri. I'd
also love to see the comparison between strict and nostrict too if possible.

> At high level, the app launch numbers itself improved with your series as
> entire workqueue subsystem improved across the board.

Glad to hear.

Thanks.

-- 
tejun
