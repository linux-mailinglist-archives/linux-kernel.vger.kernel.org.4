Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF316E96CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjDTOQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjDTOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294033C33
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682000141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AM2iS5p+M5vdfcO5gATf9U1kgTLr8hfoHFhkOm5c9I4=;
        b=bTpVacGhvEuoJASEa3RtOMrfr+dkuSRuRNT0MwWJ6WvLwu7qt8UcNbtHV7m21wVp/ENBPE
        4RyD46qxBiB3bN0jLnN0J7AO2qGfRTmyHn/gtqy6zJikh902FTvlj9WR6b7Wza9FiodOqe
        9yrpZ70e/BJzuSf3qk3WAnVNMPAjl2o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-ou3wF1RDO7SRRGZg73c14g-1; Thu, 20 Apr 2023 10:15:38 -0400
X-MC-Unique: ou3wF1RDO7SRRGZg73c14g-1
Received: by mail-wr1-f70.google.com with SMTP id d30-20020adfa35e000000b002f53b0a3377so108009wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000137; x=1684592137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM2iS5p+M5vdfcO5gATf9U1kgTLr8hfoHFhkOm5c9I4=;
        b=IVQMBpMRXm04jOG3MqOiFDZuFRRpGj4Qc97luvcCPGaSu/cwzHut8uwPR35UYlU/eT
         aTfs8G5/wAptkcwwzrYxODhyMf9Hk98w1RI9hRH8P2G65t8oX7LcjvwvSHEpO0bMRLwx
         a5gw0zNkf+ZB5VtguYcBy1Pznhud2j9dgNzP5kk+ycF+MDsv7Hid+09SxTBhxz6h/2eZ
         Qt5HPaJlP0OyDssA7en/9qyd2kPbsGFgZBwwbAq2f7woKeCadhQqwPGaWOixMea4SlSq
         IiAAoxnwFY5tYR7ZZvOxmAdRlGsYoOirNRd7wVkw0jKDRYL0ZAOJlZuObPROVlnjGTYE
         SFrw==
X-Gm-Message-State: AAQBX9f8yPKInst1k9tsv5GXa7i3DkfV4KgpU2qHJU7y7wMD7zHB104A
        cW8BMFMRMAFMuvqQegw3sCeFADqi6JOPc3XczuA04Flj0pnExPbHFVwBGPxVb+15SQXWypEU3oS
        gVL+1Gs5Ma8TYOSQC9aJeFdpb
X-Received: by 2002:a1c:7718:0:b0:3f0:9564:f4f6 with SMTP id t24-20020a1c7718000000b003f09564f4f6mr1454715wmi.1.1682000137304;
        Thu, 20 Apr 2023 07:15:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350bexWh9GsofWlY2L7rzUG6HZt1GpBCHEqybhfhvg9zt9iYQCWxHqXR1i3tXmNAfY1fMzB+3ow==
X-Received: by 2002:a1c:7718:0:b0:3f0:9564:f4f6 with SMTP id t24-20020a1c7718000000b003f09564f4f6mr1454680wmi.1.1682000136897;
        Thu, 20 Apr 2023 07:15:36 -0700 (PDT)
Received: from localhost.localdomain ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c0b5200b003edf2dc7ca3sm2111619wmr.34.2023.04.20.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:15:36 -0700 (PDT)
Date:   Thu, 20 Apr 2023 16:15:33 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <ZEFJBXrXWXKH0xlc@localhost.localdomain>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230418141127.zbvsf7lwk27zvipt@airbuntu>
 <eda74c03-bde2-bb51-2b0d-df2097215696@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda74c03-bde2-bb51-2b0d-df2097215696@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/23 10:31, Waiman Long wrote:
> On 4/18/23 10:11, Qais Yousef wrote:
> > On 03/29/23 14:55, Juri Lelli wrote:
> > > Qais reported [1] that iterating over all tasks when rebuilding root
> > > domains for finding out which ones are DEADLINE and need their bandwidth
> > > correctly restored on such root domains can be a costly operation (10+
> > > ms delays on suspend-resume). He proposed we skip rebuilding root
> > > domains for certain operations, but that approach seemed arch specific
> > > and possibly prone to errors, as paths that ultimately trigger a rebuild
> > > might be quite convoluted (thanks Qais for spending time on this!).
> > > 
> > > To fix the problem
> > > 
> > >   01/06 - Rename functions deadline with DEADLINE accounting (cleanup
> > >           suggested by Qais) - no functional change
> > >   02/06 - Bring back cpuset_mutex (so that we have write access to cpusets
> > >           from scheduler operations - and we also fix some problems
> > >           associated to percpu_cpuset_rwsem)
> > >   03/06 - Keep track of the number of DEADLINE tasks belonging to each cpuset
> > >   04/06 - Create DL BW alloc, free & check overflow interface for bulk
> > >           bandwidth allocation/removal - no functional change
> > >   05/06 - Fix bandwidth allocation handling for cgroup operation
> > >           involving multiple tasks
> > >   06/06 - Use this information to only perform the costly iteration if
> > >           DEADLINE tasks are actually present in the cpuset for which a
> > >           corresponding root domain is being rebuilt
> > > 
> > > With respect to the RFC posting [2]
> > > 
> > >   1 - rename DEADLINE bandwidth accounting functions - Qais
> > >   2 - call inc/dec_dl_tasks_cs from switched_{to,from}_dl - Qais
> > >   3 - fix DEADLINE bandwidth allocation with multiple tasks - Waiman,
> > >       contributed by Dietmar
> > > 
> > > This set is also available from
> > > 
> > > https://github.com/jlelli/linux.git deadline/rework-cpusets
> > Is this just waiting to be picked up or still there's something to be addressed
> > still?
> 
> There are some changes to cpuset code recently and so I believe that this
> patch series may need to be refreshed to reconcile the changes.

Yeah, will soon take a look.

Thanks!
Juri

