Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61605FF025
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiJNOSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJNOSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:18:43 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC44E1D5E2F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:18:39 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a18so2545229qko.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afgb50DSDLh8+9UJH2gY7kBbdvjsED29PzHUneW1MHI=;
        b=ArtMPNvogxyC4kRkwQ1cdU09fZI+TkapGIO1mHeByULlAVZjgWuqSe7GHkl2lP5jHV
         4ThGVzc3cmtR6Qywvdb90zwWKlwRygqEehZ26Tn/+2xmixvCwDHRCprZqSi1cS26yw4a
         wz+4psfnfzCqEPK9sY+RIL5CQRLO0AxSLNkgwOThmBPiH9atXSNRSkuUoJAkw+dbhKzW
         2k3qfUuijmKjVXgUt3xA52yhm9P1eBLjbiGdudUpzBQ9II5R1Bess+/aizqpnIiA3VMq
         DHND0f3/4sxknoBT1v8NeVz++f+Wi/668wUSHJ0st0UlQB/BroppnynXSLjIlT9maEww
         sHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afgb50DSDLh8+9UJH2gY7kBbdvjsED29PzHUneW1MHI=;
        b=V+1o+xwpfzfeZXRGfuWxztvrAZwMUtfCoSEKhUCKOUq6s3qJeP/978VyGQ3+EOPttN
         8AFrKh9XgxXoA7rc9XrL9IcougRJ1F+Co3PKG1koBVYtveHi87lM8g4A4LtRk3WBXRGH
         GrKO05YxnmRZT4BXzcmhsokpI3AHqqkSZ2D5AMhghSljPU7Ext9z2Mjv0p8kB3/n6jtI
         DgzWmB6F5bmsYlME3myeRnNzmNfhlhlVfROCTmwsJ+j6CKp+C3gHj7kaNVfcNGgEEr5Z
         YXva+01tJy1WV82+k30RbirTEheQ03U3S9Vh9asfc8B9ReuP2pqoWBtEU1U7Puez1aUt
         lQ6Q==
X-Gm-Message-State: ACrzQf02R24QmHl7jLJdWRnrz/Fa1XloJqiEd9Oe/VOD1gL2Rd478cTW
        7c+YVxNVabtH6FJ58Jcj69O81w==
X-Google-Smtp-Source: AMsMyM66eoE1jYmSkxV0B6mdxyQLxspYqHiTvKdRIvzi9mQcSpk+BTbW9T3pj8tsypgBVqA2hIN+yA==
X-Received: by 2002:a05:620a:1519:b0:6ee:af9e:9048 with SMTP id i25-20020a05620a151900b006eeaf9e9048mr3922455qkk.601.1665757113955;
        Fri, 14 Oct 2022 07:18:33 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id dm48-20020a05620a1d7000b006e99290e83fsm2650942qkb.107.2022.10.14.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:18:33 -0700 (PDT)
Date:   Fri, 14 Oct 2022 10:18:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, quic_pkondeti@quicinc.com, peterz@infradead.org,
        quic_charante@quicinc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Message-ID: <Y0lvuKbrb/pyWQDs@cmpxchg.org>
References: <20221014110551.22695-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014110551.22695-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 07:05:51PM +0800, Chengming Zhou wrote:
> Pavan reported a problem that PSI avgs_work idle shutoff is not
> working at all. Because PSI_NONIDLE condition would be observed in
> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
> only the kworker running avgs_work on the CPU.
> 
> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
> still will always re-arm the avgs_work, so shutoff is not working.
> 
> This patch changes to use PSI_STATE_RESCHEDULE to flag whether to
> re-arm avgs_work in get_recent_times(). For the current CPU, we re-arm
> avgs_work only when (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0),
> for other CPUs we can just check PSI_NONIDLE delta. The new flag
> is only used in psi_avgs_work(), so we check in get_recent_times()
> that current_work() is avgs_work.
> 
> One potential problem is that the brief period of non-idle time
> incurred between the aggregation run and the kworker's dequeue will
> be stranded in the per-cpu buckets until avgs_work run next time.
> The buckets can hold 4s worth of time, and future activity will wake
> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
> behind when shut off the avgs_work. If the kworker run other works after
> avgs_work shut off and doesn't have any scheduler activities for 2s,
> this maybe a problem.
> 
> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
