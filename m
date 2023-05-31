Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A697176A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjEaGHb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 02:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjEaGHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:07:22 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF712B;
        Tue, 30 May 2023 23:07:21 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ba8a0500f4aso4531081276.3;
        Tue, 30 May 2023 23:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685513240; x=1688105240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGAFsENMxYrhxYj1uUMDHzCM9FHKp+CT1MSPohEI99A=;
        b=df7noEEcB4E5ttSjsFbVIIgkMVpI5nnbnWelAxZNzYOPbInpNIvg1TMFUuggNUK/Vr
         lJdX2C2StMKd0IxmGT49Isp6aBr8FhQfhePfseGtNOPLHsy6F0tqGuOL7rFVk9/0bXdY
         DBHA5zZp1AJ23HifHFPMBjvU5ZMT9hBrc/ioyrVo4RHtHRzc1Y8NBEnDhaR1aDxHCMlN
         Tdxj2mY52ycCudBpDVDNMKX6GrSxnm15CsGpgelDfbx+tngqfLph6H0A7yjJ9JRXHPkI
         shAEVlkX7RjhNV1u3BUUBDTR3CqApQ8nebL2UDMWYjLJPa+qIZK4lTPX6+3Z2uGiMNqe
         sr+A==
X-Gm-Message-State: AC+VfDzdaJyJJMOdlkSjY11Ud2d5f9aipLKo6QtINIJ88oIxLC6D63gU
        sBHPr6wjWSNfwq9JmQD/45dSkIJfxCsdfFRzahk=
X-Google-Smtp-Source: ACHHUZ63lP1QyMnZoPKTqaKWdGrNbZSzHzLvF6o5BbUWjwtKnR4QgCy2i3jVSx6r1/nuhRDHv0vzrFTgOlhXuaEWuL8=
X-Received: by 2002:a25:264b:0:b0:ba8:1732:e334 with SMTP id
 m72-20020a25264b000000b00ba81732e334mr5221414ybm.56.1685513240201; Tue, 30
 May 2023 23:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230526095824.16336-1-Jonathan.Cameron@huawei.com>
 <20230526095824.16336-5-Jonathan.Cameron@huawei.com> <CAM9d7cgYZs4DqLmjPZCYDVrp-KVYoZYDyJHLwB1fOM7ZdzM2Pg@mail.gmail.com>
 <20230530145001.00002560@Huawei.com>
In-Reply-To: <20230530145001.00002560@Huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 30 May 2023 23:07:09 -0700
Message-ID: <CAM9d7ciiVrHEKTMCUFLwDq7uvpLb4U2uvLn+uVoQbfqDeAuh9Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] perf: CXL Performance Monitoring Unit driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Liang Kan <kan.liang@linux.intel.com>, linux-cxl@vger.kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, will@kernel.org,
        dan.j.williams@intel.com, mingo@redhat.com, acme@kernel.org,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Stephane Eranian <eranian@google.com>
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

On Tue, May 30, 2023 at 6:50 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
>
> Hi,
>
> Tidied up the typos. Thanks,
>
> > > +static int cxl_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> > > +{
> > > +       struct cxl_pmu_info *info = hlist_entry_safe(node, struct cxl_pmu_info, node);
> > > +       unsigned int target;
> > > +
> > > +       if (info->on_cpu != cpu)
> > > +               return 0;
> > > +
> > > +       info->on_cpu = -1;
> > > +       target = cpumask_any_but(cpu_online_mask, cpu);
> > > +       if (target >= nr_cpu_ids) {
> > > +               dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
> > > +               return 0;
> > > +       }
> > > +
> > > +       perf_pmu_migrate_context(&info->pmu, cpu, target);
> > > +       info->on_cpu = target;
> > > +       /*
> > > +        * CPU HP lock is held so we should be guaranteed that this CPU hasn't yet
> > > +        * gone away.
> > > +        */
> > > +       WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
> > > +
> > > +       return 0;
> > > +}
> >
> > IIUC a CXL PMU hardware (say cxl_pmu_mem0.0) is shared across
> > all CPUs and it would return the same value when read from any CPU,
> > right?
>
> Correct, it will return the same value when used from any CPU.
> I'm not sure what issue you are indicating.
>
> My understanding is that, even for such cases, perf uses percpu
> variables that mean we still have to ensure that the interrupt
> handling occurs on the CPU we have migrated the context to.
>
> There are a lot of similar driver in perf already from a quick
> git grep cpumask_any_but\(cpu_online_mask,
>
> It might be nice to enable perf to operate for these devices without
> the percpu context though. I haven't looked into whether that
> is worth doing.

I was thinking if we could avoid IPIs for read from other
CPUs.  It has PERF_EV_CAP_READ_ACTIVE_PKG for some uncore events
which can be shared among CPUs in the same package
to skip the IPI and to read it from the local CPU.

But I think this can be a separate step.

Thanks,
Namhyung
