Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2DB6E66CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjDROLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDROLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:11:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42148146C5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:11:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so13620739wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1681827090; x=1684419090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WE+IDjNLmYXyAL5RgYEYkpXIxD65+3kxB5fg3jMT7Z8=;
        b=dprNceqvHv7ehj1AFyq6IVZuyA050VxzOgnpjffjlO0ZTrtbaukOxmEs6ZwMyph6DF
         F/S8P85T1AvENM5C6pZFvN7Z0PNWVxad+nEtZZBhxHYLj39ZchKFYYXEoBvPG3wOZuTp
         pgja402GMS0SJvQwxvnk3iSldEhFdUttDgOKnjLRNUX448+VVk/fUiHEbl+Z8/uEmvlm
         Oof8NAaozlK6EX/U9LAROF5sy5j74fSWC08pHqswc0eg6oqwrWCbZ0vtRQZb5+0kY7ov
         A20xhQ1MrM9+VMW1q6b6ypOU1eP1gwMu71zfJF11JCrA/zGZF4r0MA/5mhiAdSZEkWLi
         nQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681827090; x=1684419090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE+IDjNLmYXyAL5RgYEYkpXIxD65+3kxB5fg3jMT7Z8=;
        b=A+g6Fj3D7LYoDydn5EgwCIAtvSpg3T0H0t70jtDYwslWhA/7B0PDAkVBJxPzNaRzAM
         eGqJ17jB7HqzwYwVWJJg/+dimtqssGp6EAHLa0ogrES9C8RrsVqHwWT9stPguykEb4k9
         55ga2ibdHw7w1q0biu7ej/U2INb+ri5tMtIt0BtovNM0rInJ7AR09yMIO8Yq0Zy7PO3X
         kP+QynTSGqRJsB6DPRkUgvebWRrITbhfcebcveXi7JuT+5lpCw7LkDrUaqdHLf/x0HR2
         5+URd2wn9WZwBWjKEjNsSA7t64/YnBw2AyZfBH/XUXz3wE8fXzhCxxyDuHXFgz6NlnfH
         narA==
X-Gm-Message-State: AAQBX9fKnX6bex+Eegtr6NDTx8sHI9ndsna9y+znhlOH2Q58KAS72o1F
        FDkadamOXrju4Thru8eIyJ1cfuVAZXZWKuxq7Xo=
X-Google-Smtp-Source: AKy350ajzjOuf3arxENo4exaQjQnAw/S1q2RJh78GqT856IO2LFlhTXvpLQPIXl+yESeB2+GEmDxHw==
X-Received: by 2002:a1c:f719:0:b0:3f0:a9b1:81e0 with SMTP id v25-20020a1cf719000000b003f0a9b181e0mr13419456wmh.19.1681827089702;
        Tue, 18 Apr 2023 07:11:29 -0700 (PDT)
Received: from airbuntu ([104.132.45.106])
        by smtp.gmail.com with ESMTPSA id iw1-20020a05600c54c100b003f174cafcdasm5048524wmb.7.2023.04.18.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:11:29 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:11:27 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth
 restoration
Message-ID: <20230418141127.zbvsf7lwk27zvipt@airbuntu>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329125558.255239-1-juri.lelli@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/23 14:55, Juri Lelli wrote:
> Qais reported [1] that iterating over all tasks when rebuilding root
> domains for finding out which ones are DEADLINE and need their bandwidth
> correctly restored on such root domains can be a costly operation (10+
> ms delays on suspend-resume). He proposed we skip rebuilding root
> domains for certain operations, but that approach seemed arch specific
> and possibly prone to errors, as paths that ultimately trigger a rebuild
> might be quite convoluted (thanks Qais for spending time on this!).
> 
> To fix the problem
> 
>  01/06 - Rename functions deadline with DEADLINE accounting (cleanup
>          suggested by Qais) - no functional change
>  02/06 - Bring back cpuset_mutex (so that we have write access to cpusets
>          from scheduler operations - and we also fix some problems
>          associated to percpu_cpuset_rwsem)
>  03/06 - Keep track of the number of DEADLINE tasks belonging to each cpuset
>  04/06 - Create DL BW alloc, free & check overflow interface for bulk
>          bandwidth allocation/removal - no functional change 
>  05/06 - Fix bandwidth allocation handling for cgroup operation
>          involving multiple tasks
>  06/06 - Use this information to only perform the costly iteration if
>          DEADLINE tasks are actually present in the cpuset for which a
>          corresponding root domain is being rebuilt
> 
> With respect to the RFC posting [2]
> 
>  1 - rename DEADLINE bandwidth accounting functions - Qais
>  2 - call inc/dec_dl_tasks_cs from switched_{to,from}_dl - Qais
>  3 - fix DEADLINE bandwidth allocation with multiple tasks - Waiman,
>      contributed by Dietmar
> 
> This set is also available from
> 
> https://github.com/jlelli/linux.git deadline/rework-cpusets

Is this just waiting to be picked up or still there's something to be addressed
still?


Thanks!

--
Qais Yousef
