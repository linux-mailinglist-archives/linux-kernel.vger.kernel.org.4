Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D875F494F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJDSfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJDSe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:34:59 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307C1A04D;
        Tue,  4 Oct 2022 11:34:57 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id q10so15282835oib.5;
        Tue, 04 Oct 2022 11:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zTLXNMpDg1+UniIzyXYCxtdL8YDiQl3tzokRAsSfSdQ=;
        b=3Q0JsYsPPoL4VrDxda7k6M9I+cQm1M6MbuNTG7FeO/XhxbOataZkDRihI/AtPow1v6
         w4uU07OwxXvMFeu6yvDmaTdMKQfgU4UkOFEmtetXB3m41neLLtnkAIyMvmgRcJ32GYyJ
         yysgDPhWm/WwSwsNDF9aNPQDHNA+JgGJYMqI4h7TqGNwajcMtPQyst16FeOg96a7uL2u
         Lr4nsf+tiNqddR0wto1ld9Cs289x7hn3dfZR+dspQPChwSX6Ax/HxhlXHHezklDKTjtu
         uc6c2wF6oZSI6m1QlnDi6wntF7FSh0Qq/n+ZjWBm/D6MB2767nnVEVCYhR1wBF0BbpOd
         ry4g==
X-Gm-Message-State: ACrzQf2IUnSXpgvMxMSuK7Xcto5HQRkyad4N7BqbIKnJxi/5SKTcvXvz
        GYuPen18+ZdljroNT61JWVByd2RNd3niaTGiPMOnECuh
X-Google-Smtp-Source: AMsMyM7czo0WxlTA8xE9hipWddVrQd4oDO+hkG0qLef/uh0Ia0Th64faNzfeluogY0rdow83yR4/vdAXwCmzKfG9tSo=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr532277oib.218.1664908497053; Tue, 04
 Oct 2022 11:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220930120939.353315-1-leo.yan@linaro.org> <CAM9d7cibbdOb04qhKkfyRmwtHvttb6-bOu_uAN6D8ke-EJUWZw@mail.gmail.com>
 <c75ba6c3-938d-14a5-2fc8-3e846eeba23f@amd.com>
In-Reply-To: <c75ba6c3-938d-14a5-2fc8-3e846eeba23f@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 4 Oct 2022 11:34:45 -0700
Message-ID: <CAM9d7cg7dLNyH=dYuie=HF=yfxH7dNaEe5vs+r0E_PJLYs1Msw@mail.gmail.com>
Subject: Re: [PATCH v4] perf test: Introduce script for data symbol testing
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:13 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> >> +# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
> >> +# user/kernel filtering and per-process monitoring, spin program on
> >> +# specific CPU and test in per-CPU mode.
> >> +is_amd=$(egrep -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
> >> +if (($is_amd >= 1)); then
> >> +       perf mem record -o ${PERF_DATA} -- -C 0 -- taskset -c 0 $TEST_PROGRAM &
> >
> > I'm curious why it has "--" before "-C 0"..
>
> IIRC, any command line options placed after -- will be carry forwarded
> as is to perf record.
>
> perf mem record [options] does not support -C option. Which means -C 0
> will be ignored if user run `perf mem record -C 0`. Ex:
>
>   $ sudo ./perf --debug perf-event-open mem record -C 0
>   [...]
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 = 5
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 = 6
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0 = 7
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0 = 8
>
> OTOH, if I place -C 0 after -- then perf opens event only on cpu0:
>
>   $ sudo ./perf --debug perf-event-open mem record -- -C 0
>   [...]
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 = 7
>
> Now, perf mem [options] supports -C options but I don't know why
> it's not working for me:

Thanks for checking this!

It seems -C works only for perf mem report and eats it for record.
I think we need to fix the option handling.

Thanks,
Namhyung


>
>   $ sudo ./perf --debug perf-event-open mem -C 0 record
>   [...]
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 = 5
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 = 6
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0 = 7
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0 = 8
>
> Thanks,
> Ravi
