Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EE66B7747
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCMMO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCMMO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:14:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930F2B2A4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:14:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h31so6758422pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678709666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEQoyNriMJeJ4EU4gkSZqe8loY1NyZvw+jZ3N5Z4ois=;
        b=aO/CuDa1fBgcy2czOWarVp5KtBVJq/f/rsOQZy36Wyc4SxvXh6rOiTn7Nlwb2sfshn
         9zyvPQfMY6VcUIlFML/YIqLdEs6J+TB+5lgKWOn7csBxGl76t+l5QbgOFhEvjKU0b3b8
         nqVaTFMFeHEsBJkm0FFLk2qts3erFUzfPs4zQrR61wzbEubtymhrVhomn0eHbfVDqSiO
         qnTN0gdDU0RMjhwUabaYAR0CDMh2aYGu1KBSHG/MHetybJHZQW2tJHdZKuh6QW6dbLHf
         D9xeymY6ZlGbGHtRuyUeMkY42rT24QED5KxfhqkJghuexa2oeali14/bM4XwmaTtb5J2
         xSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678709666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEQoyNriMJeJ4EU4gkSZqe8loY1NyZvw+jZ3N5Z4ois=;
        b=PjLY6LX9QAAH+pn4Dzb8j7J1TcEZrKFOQyznOfWEIbjrDgOPL+FhF0Ia4RP0bt7egO
         nnRoKTax6EXj9wLTz29J3eEsljSWwsdBindenVJSYL9qZVpSguRoR06yyYiEb7QRa6V6
         vnp2IuP5+K8ZVWEzPXO0bkieYYHiguOMBCHQWsgAuRkL/Ez/0mBvN/F2eDGEM5HQJMK8
         WbHBJ1uVsTOytr3MENMJrXhFg8sKn1K/9kFJZTXxluk/2QHnV0beL8ckR1hKjglBX0o6
         KacKUh0Q3LUYLnHR4GMVEbW2b+8v8U+Y2DScqfpD6YiToJvE37GSEbe4IvoLfnaePO9j
         Y16w==
X-Gm-Message-State: AO0yUKUpiJk6N/rBsLs7ZS7b5Z+MmjTih/FywsBF8V/ZY9ImwgiQ13B9
        HdF/Jsg5T7isb/k1VHeinuz0Bb2Y5bVfKmOu5X0eNpwx
X-Google-Smtp-Source: AK7set8ukf6Y64neOmLwbgEC/yWtUHBdc4ykr/rEJ4KBI22fzl5FtG0Zpq+5XqwHlnoEaLKpn3L2+Q==
X-Received: by 2002:a62:1b13:0:b0:622:944f:ccb0 with SMTP id b19-20020a621b13000000b00622944fccb0mr5242013pfb.34.1678709666359;
        Mon, 13 Mar 2023 05:14:26 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7870e000000b005a8f1187112sm2544738pfo.58.2023.03.13.05.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 05:14:25 -0700 (PDT)
Date:   Mon, 13 Mar 2023 20:14:20 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mathieu.poirier@linaro.org, adrian.hunter@intel.com,
        Jiri Olsa <jolsa@kernel.org>, acme@redhat.com,
        mike.leach@linaro.org, Will Deacon <will@kernel.org>,
        suzuki.poulose@arm.com
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
Message-ID: <20230313121420.GB2426758@leoy-yangtze.lan>
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com>
 <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan>
 <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:06:41AM -0800, Yang Shi wrote:

[...]

> > I reviewed your shared dump, the bad and good perf data both contain the
> > dummy event with 'text_poke = 1'.  Could you confirm the shared dump in
> > your previous email is correct or not?
> 
> Oops, sorry. I pasted the wrong log. The good one looks like
> (generated by v5.19):
> 
> # captured on    : Wed Mar  8 18:02:58 2023
> # header version : 1
> # data offset    : 408
> # data size      : 22640
> # feat offset    : 23048
> # hostname : fedora
> # os release : 6.2.0-coresight+
> # perf version : 5.19.g3d7cb6b04c3f
> # arch : aarch64
> # nrcpus online : 128
> # nrcpus avail : 128
> # cpuid : 0x00000000c00fac30
> # total memory : 2108862504 kB
> # cmdline : /home/yshi/linux/tools/perf/perf record -e
> cs_etm/@tmc_etf63/k --kcore --per-thread -- taskset --cpu-list 1 uname
> # event : name = cs_etm/@tmc_etf63/k, , id = { 3832 }, type = 9, size
> = 128, { sample_period, sample_freq } = 1, sample_type =
> IP|TID|IDENTIFIER, read_format = ID, d
> isabled = 1, exclude_user = 1, exclude_hv = 1, enable_on_exec = 1,
> sample_id_all = 1, { bp_len, config2 } = 0x12792918
> # event : name = dummy:u, , id = { 3833 }, type = 1, size = 128,
> config = 0x9, { sample_period, sample_freq } = 1, sample_type =
> IP|TID|IDENTIFIER, read_format = ID,
>  disabled = 1, exclude_kernel = 1, exclude_hv = 1, mmap = 1, comm = 1,
> enable_on_exec = 1, task = 1, sample_id_all = 1, exclude_guest = 1,
> mmap2 = 1, comm_exec = 1,
> context_switch = 1, ksymbol = 1, bpf_event = 1
> # CPU_TOPOLOGY info available, use -I to display
> # NUMA_TOPOLOGY info available, use -I to display
> # pmu mappings: armv8_pmuv3_0 = 8, software = 1, arm_cmn_0 = 10,
> uprobe = 7, cs_etm = 9, breakpoint = 5, tracepoint = 2, arm_cmn_1 =
> 11, kprobe = 6
> # contains AUX area data (e.g. instruction trace)
> # CACHE info available, use -I to display
> # time of first sample : 18446744073.709551
> # time of last sample : 18446744073.709551
> # sample duration :      0.000 ms
> # MEM_TOPOLOGY info available, use -I to display
> # missing features: TRACING_DATA CPUDESC BRANCH_STACK GROUP_DESC STAT
> CLOCKID DIR_FORMAT COMPRESSED CPU_PMU_CAPS CLOCK_DATA HYBRID_TOPOLOGY
> HYBRID_CPU_PMU_CAPS

Thanks for confirmation.

Just a quick summary, here we have two issues:

- With command:
  perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
  -- taskset --cpu-list 1 uname",

  perf doesn't enable "text poke" attribution.

- With command:
  perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
  -- taskset --cpu-list 1 true (in your previous email), or ...
  perf record --kcore -e cs_etm/@tmc_etf63/k --per-thread \
  -- taskset --cpu-list 1 uname (in your shared perf data file),

  perf enables "text poke" attribution, in this case, perf fails to decode
  Arm CoreSight trace data.

[...]

> > Do you mind to share the bad perf.data file with James and me?
> 
> Please check the attachment out. Thanks for looking into this problem.

Thank you for sharing the data.  We will look into it.

Leo
