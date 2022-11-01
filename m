Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B329615211
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiKATPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKATPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:15:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484801EC59
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:15:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso2057871pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7uizm+oURVHURBJUhhwvkQc5dtB/zBCulyqvyF6/Y8=;
        b=VbWea86l26+5oMoKhy7n5YDJY6whrAOE5UKO7ynw6dFqyspALqzppx/ZjyygQ473MV
         u4rDukBU9R0eL2HNuBdGV7acEYY2PeYg0WnxkWaahrOIs8lGtFG9PSwpdkrylbwg8hnQ
         ze0+5XUbJZjzKYxaASQ6mDkM7wcyuS54FByaI40KXHomwMLiiOs8bk6VSfwBpxjfKT6i
         uQVhdWPe9ZFPsj79oh1tMBnc4fgcOv+D1Tz3BhNy+YHpeUbKoV67S8JXPCB5NSTUWShb
         QAY3ZZvTksmBuagf0LbG1kgse3Lt8OMW2NF1jaF8oSg6gO7PaV7jKQ+ALv/2vv68E0PA
         R10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7uizm+oURVHURBJUhhwvkQc5dtB/zBCulyqvyF6/Y8=;
        b=HfZP4TvnuNhlKXxqi5a4MRDJGOfm7ZOSLkPTWJW9MauHbxR2RoaoJs+zsjTqsJPX/u
         iT4utCQ2Zus6uoAEzYiWG+cCNDoSBOmN+CyNkE+CRFBfqaXesnmC7fIHz/qHgFFR6kmv
         eAXKHs375sbNSE444WisTXvsUeibhlkR+mfIamM5UClsJ0Fnd8so/LB+4yfpbcwUJcLl
         LDv8YEcu3QbJ5oBQcTHOpDUIhwQZ0ttGrNTqatllfuYlhS09af7oT/3NvyVmR/pzdkbx
         tmQ1EwLrV4rPGJK8La+XKCUdXFfkdMmEoRBFcxqUHj5DkuIufrtl5UUXeKNf1Ura4OQ+
         IS1A==
X-Gm-Message-State: ACrzQf2TGWPxR+dAuPxClIJuIXuGj5/1PlqwovtPlw/7LbeORsqd6SAY
        +AvFtT76/8CNKL8X4rCSgFM=
X-Google-Smtp-Source: AMsMyM54DpQd/Ccn7cTQvmWnSzabznSFXFhnJHQLMHewIFHnqg2ZEYeiSYy3yrm1hil1Nf+MrtgGqA==
X-Received: by 2002:a17:902:ea02:b0:187:2164:89b with SMTP id s2-20020a170902ea0200b001872164089bmr11990656plg.99.1667330135535;
        Tue, 01 Nov 2022 12:15:35 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f37f])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902e1cd00b001754e086eb3sm6699540pla.302.2022.11.01.12.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 12:15:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Nov 2022 09:15:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <Y2FwVX42LIKXSTz3@slm.duckdns.org>
References: <20221026224449.214839-1-joshdon@google.com>
 <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
 <Y2BDFNpkSawKnE9S@slm.duckdns.org>
 <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
 <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org>
 <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
 <Y2B6V1PPuCcTXGp6@slm.duckdns.org>
 <CABk29Ns1VWEVRYENud4CW3JQPrcr79i_F2PBTANqt3t-LaYCfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ns1VWEVRYENud4CW3JQPrcr79i_F2PBTANqt3t-LaYCfQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 01, 2022 at 12:11:30PM -0700, Josh Don wrote:
> > Just to better understand the situation, can you give some more details on
> > the scenarios where cgroup_mutex was in the middle of a shitshow?
> 
> There have been a couple, I think one of the main ones has been writes
> to cgroup.procs. cpuset modifications also show up since there's a
> mutex there.

If you can, I'd really like to learn more about the details. We've had some
issues with the threadgroup_rwsem because it's such a big hammer but not
necessarily with cgroup_mutex because they are only used in maintenance
operations and never from any hot paths.

Regarding threadgroup_rwsem, w/ CLONE_INTO_CGROUP (userspace support is
still missing unfortunately), the usual worfklow of creating a cgroup,
seeding it with a process and then later shutting it down doesn't involve
threadgroup_rwsem at all, so most of the problems should go away in the
hopefully near future.

Thanks.

-- 
tejun
