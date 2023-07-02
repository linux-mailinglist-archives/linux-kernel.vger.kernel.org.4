Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B99744BF1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 03:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGBBCt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Jul 2023 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGBBCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 21:02:48 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9C1172B;
        Sat,  1 Jul 2023 18:02:47 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so2967026276.3;
        Sat, 01 Jul 2023 18:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688259767; x=1690851767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kANjNnclVCsfgygTcdj+03tBXimKIyR8Ds3CCIEhaFY=;
        b=F5IpATF7vFhMvQ6mBpAlHc7JP64GtwDZWBTCNMgq23iU3lWE4GudbOHgBK6RRgvTAb
         rVKJFzxlcUAYijANIadqdAv8OteX39xPOs1ZWm7eaDG/QgGQa6yoJx0hA0+Rd/kpEHfr
         PFv6TBA8+EKTVFqY0T2Q7P5W8aHTo9ku1fvTCXupYYiHkXSwCFsDidyzSQAX298hKCdd
         OjXuWLtjy87hfdNhrKCNlgeakQbltZbBSyOBskkbAJNMAUwx6W7/vNsSA0aIml7xvgi6
         L6LRpLiL/zFVQu8LYyQuucW6mAUVtB/bGEC5wZd1WbmqQmAl10gGlE6AAaZLTvkd8t0V
         F81w==
X-Gm-Message-State: ABy/qLYT0mBDrIuIPBaxgPerAt7foCQTZOcfM4vMtz1gW6uPOJtRLH44
        RTtCbHgfWCNV2m1QakHrcEY3ObhP0FrsV5UxdHA=
X-Google-Smtp-Source: APBJJlGhunK8g8oACRYiiwUe8l3UZfj6iA8veJOSvmqQlAy6GORRMqy6ZjwcJoiyA1ARxgkZ9d23V3EAGOWi8HiX9uA=
X-Received: by 2002:a25:2144:0:b0:bff:7eb7:c275 with SMTP id
 h65-20020a252144000000b00bff7eb7c275mr5050789ybh.52.1688259766660; Sat, 01
 Jul 2023 18:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230628200141.2739587-1-namhyung@kernel.org>
In-Reply-To: <20230628200141.2739587-1-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 1 Jul 2023 18:02:35 -0700
Message-ID: <CAM9d7ci8n=u_rSp4JHLxmZT2hDb26XFS=hEnX3oT2_=3dqD8Xg@mail.gmail.com>
Subject: Re: [PATCHSET 0/4] perf lock contention: Add CSV style output support (v2)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 1:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> This is v2 of perf lock contention CSV output change.
> I've added --output option and a test case according to Ian's feedback.
>
> Sometimes we want to process the output by external programs.  Let's add
> the -x option to specify the field separator like perf stat.
>
>   $ sudo ./perf lock con -ab -x, sleep 1
>   # output: contended, total wait, max wait, avg wait, type, caller
>   19, 194232, 21415, 10222, spinlock, process_one_work+0x1f0
>   15, 162748, 23843, 10849, rwsem:R, do_user_addr_fault+0x40e
>   4, 86740, 23415, 21685, rwlock:R, ep_poll_callback+0x2d
>   1, 84281, 84281, 84281, mutex, iwl_mvm_async_handlers_wk+0x135
>   8, 67608, 27404, 8451, spinlock, __queue_work+0x174
>   3, 58616, 31125, 19538, rwsem:W, do_mprotect_pkey+0xff
>   3, 52953, 21172, 17651, rwlock:W, do_epoll_wait+0x248
>   2, 30324, 19704, 15162, rwsem:R, do_madvise+0x3ad
>   1, 24619, 24619, 24619, spinlock, rcu_core+0xd4
>
> The first line is a comment that shows the output format.  Each line is
> separated by the given string ("," in this case).  The time is printed
> in nsec without the unit so that it can be parsed easily.
>
> The code is available at 'perf/lock-con-csv-v2' branch in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf lock: Remove stale comments
>   perf lock contention: Add -x option for CSV style output
>   perf lock contention: Add --output option
>   perf test: Test perf lock contention CSV output

Applied to perf-tools-next, thanks!
