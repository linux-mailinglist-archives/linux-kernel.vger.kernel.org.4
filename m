Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D4C627AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiKNKlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiKNKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:41:01 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117C21A062
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:41:00 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k18so1055295ilh.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YSq7cWIB6P+a2k/y/wp/mUypj4MJCRulYoRIkzaE0+8=;
        b=oTD3n6cISrgD9l2tpj7R3yBuSB3R2N01Ovpt82mzXJq0YNotI2tWwYY/ie+a8mT4dj
         gObHSnvcJJjf90IMfWAhccB9ht3q51hMQZn2GWpRR6fspAUDi7iRPNMxm+fVd0X8O09o
         VrIhC6CZhVd8uPyxbkpzHktgOVq+/89AXb0ofxOd8eHohap49AcyT69sMqnG0r/wctGQ
         zf7dXXcOFIEiSuWGAwzjhJJ1/h1DuRu9o82N4nbm4tvd4q/TW1VAbQMeP8/IkA/JAXkx
         iF0RpeNuD6TnkP6Lrpf625Q00meU5Ahw/11dw6XVd8Ta37WS/sNYnQiCGqdZ+Lo/m4ec
         oImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSq7cWIB6P+a2k/y/wp/mUypj4MJCRulYoRIkzaE0+8=;
        b=ucY6RGCiANAORqw7vYLlBMST/Kkwgh3UagMKjYobTt6AJNH3tTyjbXMSBMlbd73wnM
         1U5flt1XqpypSFsDqtLx0EbmwB0c2hwt3uSTKM1gSy3n+Jcktncmhg9gQkIGuezAI+q7
         tOlF5Z/BBz92/IFZ5xx1/1VoV7f2MxziQq93Nrfyw7vytog5Xtt1LuFJwMYhn5CM1Yhq
         gVVdyGI3sBOiBbijgsihDv0kJHvYSeoYohmqpwKL4Mwlk8DOnepAoYazPoMwyIW4oMtz
         WjucLP25uT090wMGyGfnKxX1zWn3B7IAMP5zGrlVxOBR4NHF1Pkb2EKOiuJNj87VnC7f
         4BHA==
X-Gm-Message-State: ANoB5plpcyO8FHc9sU+dc87RVAWC59WJypRllc/Oa+mRktEpuRGPwhAa
        cB4L5OHVFPXcFkAdc81X/nHZK75z4eHQg0Ac7o5/WQ==
X-Google-Smtp-Source: AA0mqf5bmycfAfaoHtsRwsrbTySxXmW0cYgyOPsnIDtLzER2bmqn9aHElP+yMajZEyuPgr5OJzC/zDHvDGC2dsxBsIY=
X-Received: by 2002:a92:ad07:0:b0:2fa:8eb:ffec with SMTP id
 w7-20020a92ad07000000b002fa08ebffecmr6087711ilh.31.1668422459358; Mon, 14 Nov
 2022 02:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org> <78d06985-c31a-cdbf-08ef-5b4772a81a03@linux.vnet.ibm.com>
In-Reply-To: <78d06985-c31a-cdbf-08ef-5b4772a81a03@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Nov 2022 11:40:47 +0100
Message-ID: <CAKfTPtASHg-KP1aN6C5hg-RjUXjXoorwvHQonrt7eggMkXow4w@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Add latency priority for CFS class
To:     shrikanth suresh hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2022 at 09:51, shrikanth suresh hegde
<sshegde@linux.vnet.ibm.com> wrote:
>
>
> > This patchset restarts the work about adding a latency priority to describe
> > the latency tolerance of cfs tasks.
>
> Hi Vincent.
>
> Tested the patches on the power10 machine. It is 80 core system with SMT=8. i.e
> total of 640 cpus. on the large workload which mainly interacts with the
> database there is minor improvement of 3-5%.
>
> the method followed is creating a cgroup, assigning a latency nice value of -20,
> -10, 0 and adding the tasks to procs of the cgroup. outside of cgroup, stress-ng
> load is running and it is not set any latency value. stress-ng --cpu=768 -l 50
>
> with microbenchmarks, hackbench the values are more or less the same. for large
> process pool of 60, there is 10% improvement. schbench tail latencies show
> significant improvement with low and medium load upto 256 groups. only 512
> groups shows a slight decline.
>
> Hackbench (Iterations or N=50)
> Process             6.1_Base        6.1_Latency_Nice
> 10                      0.13            0.14
> 20                      0.18            0.18
> 30                      0.24            0.25
> 40                      0.34            0.33
> 50                      0.40            0.41
> 60                      0.53            0.49
>
> schbench (Iterations or N=5)
>
> Groups: 1
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:                 10.8             9.8
> 75.0th:                 12.4            11.4
> 90.0th:                 14.2            13.2
> 95.0th:                 15.6            14.6
> 99.0th:                 27.8            19.0
> 99.5th:                 38.0            21.6
> 99.9th:                 66.2            25.4
>
> Groups: 2
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:                 11.2            10.8
> 75.0th:                 13.2            12.4
> 90.0th:                 15.0            15.0
> 95.0th:                 16.6            16.6
> 99.0th:                 22.4            22.8
> 99.5th:                 23.8            27.8
> 99.9th:                 30.2            45.6
>
> Groups: 4
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:                 13.8            11.2
> 75.0th:                 16.0            13.2
> 90.0th:                 18.6            15.2
> 95.0th:                 20.4            16.6
> 99.0th:                 28.8            21.6
> 99.5th:                 48.8            25.2
> 99.9th:                900.2            47.0
>
> Groups: 8
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:                 17.8            14.4
> 75.0th:                 21.8            17.2
> 90.0th:                 25.4            20.4
> 95.0th:                 28.0            22.4
> 99.0th:                 52.8            28.4
> 99.5th:                156.4            32.6
> 99.9th:               1990.2            52.0
>
> Groups: 16
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:                 26.0            21.0
> 75.0th:                 33.0            27.8
> 90.0th:                 39.6            34.4
> 95.0th:                 43.4            38.6
> 99.0th:                 66.8            48.8
> 99.5th:                170.6            60.6
> 99.9th:               3308.8           201.6
>
> Groups: 32
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:                 40.8            38.6
> 75.0th:                 55.4            52.8
> 90.0th:                 67.0            64.2
> 95.0th:                 74.2            71.6
> 99.0th:                106.0            90.0
> 99.5th:                323.8           133.0
> 99.9th:               4789.6           459.2
>
> Groups: 64
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:                 72.6            68.2
> 75.0th:                103.4            97.8
> 90.0th:                127.6           120.0
> 95.0th:                141.2           132.0
> 99.0th:                343.4           158.4
> 99.5th:               1609.0           180.8
> 99.9th:               6571.2           686.6
>
> Groups: 128
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:                147.2           147.2
> 75.0th:                216.4           217.2
> 90.0th:                268.4           268.2
> 95.0th:                300.6           294.8
> 99.0th:               3500.0           638.6
> 99.5th:               5995.2          2522.8
> 99.9th:              10390.4          9451.2
>
> Groups: 256
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:                340.8           333.2
> 75.0th:                551.8           530.2
> 90.0th:               3528.4          1919.2
> 95.0th:               7312.8          5558.4
> 99.0th:              14630.4         12912.0
> 99.5th:              17955.2         14950.4
> 99.9th:              23059.2         20230.4
>
> Groups: 512
>                      6.1_Base        6.1_Latency_Nice
> 50.0th:               1021.8           990.6
> 75.0th:               9545.6         10044.8
> 90.0th:              20972.8         21638.4
> 95.0th:              29971.2         30291.2
> 99.0th:              42355.2         46707.2
> 99.5th:              48550.4         52057.6
> 99.9th:              58867.2         60147.2
>
> Tested-by: shrikanth Hegde <sshegde@linux.vnet.ibm.com>

Thanks for the tests and the results


>
