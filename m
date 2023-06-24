Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD573CD74
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFXXit convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 19:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFXXir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:38:47 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C510F4;
        Sat, 24 Jun 2023 16:38:45 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77e3267477cso93915639f.2;
        Sat, 24 Jun 2023 16:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687649925; x=1690241925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kclJXC+Bq2uT41Q+wyyqTLX4Fp+GEJKwJIlMwNfsZ9Q=;
        b=deBRVpa/xMK3YdiaRg7X5oJvJL55GdHDRBev0AEQ0n+BKnpseJ1vwZ/bQIUG6EAy+d
         tbN6olzIyAlKmwiws5wpcYbTUaCKIITPaHB/z1mtSmU+Nq6HhEo/wvwRCJ/vw8FecXIu
         vdWPxL1YUKykX5KCmVIswHxLE4k7bC0iulaSimUD6Plnnvq/ckhXGiOF8Bzs+2EGsDom
         p6ejBK5apllm50ejLeWXzc7AHa19fzY+JRIkPM6peEKzbuvCpS3zK7GwqOmAtsAmD7TZ
         IvousUBHcQjAwCcU5hWCyX5dcO+zMs560i6qLuBZsNHg6vDqDvnJhYT2r9e2qnYyQ2ms
         Wsqg==
X-Gm-Message-State: AC+VfDyvE/Z7p7J+C7Tw2hOEKtj5WDSWgBfUXUMF3VDVm80wsf516e/7
        ih1FY+mV/h2OCTpnesVSSVZeWBGWCohfB0sncLY=
X-Google-Smtp-Source: ACHHUZ7pnUZy1KeNJmMkU4ur+68G7Z7FxF5+bGEkhul/9NgMFksDdJ+YLZrHx5sfBzg0NAXZDV0h2xyLsDpPfTqh2Qg=
X-Received: by 2002:a5e:8909:0:b0:776:f6d7:f5b6 with SMTP id
 k9-20020a5e8909000000b00776f6d7f5b6mr22891794ioj.9.1687649925049; Sat, 24 Jun
 2023 16:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230623054416.160858-1-yangjihong1@huawei.com>
In-Reply-To: <20230623054416.160858-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Jun 2023 16:38:32 -0700
Message-ID: <CAM9d7chA4P8JmABgD=EfruKjTa2dEnFYSYAkeF4RUT=NQKZtMQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] perf tools: Add printing perf_event_attr `config`
 and `id` symbol in perf_event_attr__fprintf()
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        anshuman.khandual@arm.com, jesussanp@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 22, 2023 at 10:46 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Add printing perf_event_attr `config` and `id` symbol to improve the readability of debugging information.
>
> Before:
>
>   # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>   <SNIP>
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             136
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             2
>     size                             136
>     config                           0x143
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             3
>     size                             136
>     config                           0x10005
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             136
>     config                           0x101
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             5
>     size                             136
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>     bp_type                          3
>     { bp_len, config2 }              0x4
>   ------------------------------------------------------------
>   <SNIP>
>
> After:
>
>   # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>   <SNIP>
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     size                             136
>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             2 (PERF_TYPE_TRACEPOINT)
>     size                             136
>     config                           0x143 (sched:sched_switch)
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             3 (PERF_TYPE_HW_CACHE)
>     size                             136
>     config                           0x10005 (PERF_COUNT_HW_CACHE_RESULT_MISS | PERF_COUNT_HW_CACHE_OP_READ | PERF_COUNT_HW_CACHE_BPU)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4 (PERF_TYPE_RAW)
>     size                             136
>     config                           0x101
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             5 (PERF_TYPE_BREAKPOINT)
>     size                             136
>     config                           0
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>     bp_type                          3
>     { bp_len, config2 }              0x4
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0x9 (PERF_COUNT_SW_DUMMY)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     task                             1
>     sample_id_all                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 12
>   <SNIP>
>
> Yang Jihong (4):
>   perf trace-event-info: Add tracepoint_id_to_name() helper
>   perf tools: Extend PRINT_ATTRf to support printing of members with a
>     value of 0
>   perf tools: Add printing perf_event_attr type symbol in
>     perf_event_attr__fprintf()
>   perf tools: Add printing perf_event_attr config symbol in
>     perf_event_attr__fprintf()

Applied to perf-tools-next after fixing 4/4, thanks!
