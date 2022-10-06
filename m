Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE425F60DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJFGEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJFGD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:03:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA4C65653
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:03:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g28so1136256pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 23:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DEqRZ2IvuTFUmaLNDrgeN3CNfdJlG+PEVP1OpVAF0xg=;
        b=rihYL5KgKNb5gt0yZVZtIjV28AJ+R0Ibe1Idf8i1/OYitmpvjoU3mgkvpbK0D9vr4U
         X6C9vU87J8SthIrQozAFqo0X6bKt7gzwefkTQgHE9Ytcg/rG4DhuOLKeA/225jzXRcg+
         lr32b4XWwq3vF3I4IcSR58/yDc2Hx4KxqIH0EmT7c1seOkO8es02Vpd0wcV4y0Saajny
         6e8ZCdZCV6aQDWKpenlYx9EVQiNNmRPExQBXa/RfAXaEKEYCTVAUJKPLjwXqDTHOvtWx
         415vIiH4+hrS/i9+cbD/IJXupef5wfNi+CQ0RMJV+/NbXvRaWwn2yOjs3v9uDtADUNQd
         QMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DEqRZ2IvuTFUmaLNDrgeN3CNfdJlG+PEVP1OpVAF0xg=;
        b=Xjk+lEnQfTxXM9/8JCHBJUxLZgH/fkuVR09aPuMeWCoBMg+0gEIXJl9nCtU8lf09r0
         mnRQNwEpZdDEb2/v/1qZtFIzYT5G5abWqWYGsQrmEf+oVGYMDHuyTXUt4eUQy4NcLQVj
         tLWBJFrcpPflH8tjAYgKGf4z6R0kMX3/vF6EWXk5KOoRTd+nhHhBPmuHIAtkP9BVjMZ2
         WI1QmlASVnGEnrVy5syvPCs03R7JNEx4oY5skIwaO7TKo1kUp8lQinT5wd5bed7i5tA3
         J+bdEAwaRQPKf6vDKsRA+MWL9RIHIZK8mLOSNfJraWamWgdm2z9urGwYkwMkWT0j8gWF
         atrg==
X-Gm-Message-State: ACrzQf03Roc4yvtxoCvI7wlGtZ5y5XyAvt9nNNNgq6dldIReA49Kr8AC
        Cz2wGzX802V3XuL72CfHu0Naud0Wz+vK3PY5
X-Google-Smtp-Source: AMsMyM6IXvxW5baTgeHHr1CHE3FvSeDdo91Ochc8/SAuhNLoa5O9LtOjGDJ7+V0FWuWc3X6pZOTzZw==
X-Received: by 2002:a63:5d48:0:b0:43a:390b:2183 with SMTP id o8-20020a635d48000000b0043a390b2183mr3030751pgm.29.1665036237721;
        Wed, 05 Oct 2022 23:03:57 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.17.119.16clouds.com. [45.78.17.119])
        by smtp.gmail.com with ESMTPSA id x184-20020a6231c1000000b0053e4baecc14sm11975633pfx.108.2022.10.05.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:03:56 -0700 (PDT)
Date:   Thu, 6 Oct 2022 14:03:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v4] perf test: Introduce script for data symbol testing
Message-ID: <Yz5vx9hyAEnB1Sfl@leoy-yangtze.lan>
References: <20220930120939.353315-1-leo.yan@linaro.org>
 <CAM9d7cibbdOb04qhKkfyRmwtHvttb6-bOu_uAN6D8ke-EJUWZw@mail.gmail.com>
 <c75ba6c3-938d-14a5-2fc8-3e846eeba23f@amd.com>
 <CAM9d7cg7dLNyH=dYuie=HF=yfxH7dNaEe5vs+r0E_PJLYs1Msw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg7dLNyH=dYuie=HF=yfxH7dNaEe5vs+r0E_PJLYs1Msw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:34:45AM -0700, Namhyung Kim wrote:
> On Fri, Sep 30, 2022 at 10:13 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >
> > >> +# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
> > >> +# user/kernel filtering and per-process monitoring, spin program on
> > >> +# specific CPU and test in per-CPU mode.
> > >> +is_amd=$(egrep -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
> > >> +if (($is_amd >= 1)); then
> > >> +       perf mem record -o ${PERF_DATA} -- -C 0 -- taskset -c 0 $TEST_PROGRAM &
> > >
> > > I'm curious why it has "--" before "-C 0"..
> >
> > IIRC, any command line options placed after -- will be carry forwarded
> > as is to perf record.
> >
> > perf mem record [options] does not support -C option. Which means -C 0
> > will be ignored if user run `perf mem record -C 0`. Ex:
> >
> >   $ sudo ./perf --debug perf-event-open mem record -C 0
> >   [...]
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 = 5
> >   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 = 6
> >   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0 = 7
> >   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0 = 8
> >
> > OTOH, if I place -C 0 after -- then perf opens event only on cpu0:
> >
> >   $ sudo ./perf --debug perf-event-open mem record -- -C 0
> >   [...]
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 = 7
> >
> > Now, perf mem [options] supports -C options but I don't know why
> > it's not working for me:
> 
> Thanks for checking this!
> 
> It seems -C works only for perf mem report and eats it for record.
> I think we need to fix the option handling.

Thanks for digging into the issue and fixing, Ravi & Namhyung.

I will send a new patch to drop "--" for CPU list.

Thanks,
Leo
