Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92B6384C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiKYHvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiKYHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:51:12 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EBE1BEBB;
        Thu, 24 Nov 2022 23:51:11 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id 11so2599497iou.0;
        Thu, 24 Nov 2022 23:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfaGZmFo/MDCDKQ3wQ47WkoM+4SN4aUEhpjFPo+PB1w=;
        b=x5rFfWw51CF8Ei64TKl0CtyDO1/JQdpHXFIaWoteOoX0D7Z5KDQsXhb7kd/HUVILoP
         ejR6yPa4U2fnIOW8GZAQu4vM3wqOHDyTDFhh59Gk+JRN7LCZGyczmZFmDWEQUA8PxYjD
         o3h9ilpr3ZJyPPXL7d43VqLmJTELiojUbZL8yPedwVLIoBt3EkDgHDqI5XcaPh93CdpV
         HrUMVIzexrDFme7LAY8nhFnvnQFVvMIwv0GQZy64VzSDi6PmMJDvGUyKyFTjNT0pIHDt
         IpW7dzoLTRHPDu/h8nm57AcTKcmH3wobo7Pmew2Tzx/EqcHVYr35mJ1VGLF2Qzi3siZ7
         0T6g==
X-Gm-Message-State: ANoB5plEJe8MKdM/057LLVCUi/gSlfmQdyOjVg/QUyVQb/H1Zg8kSWaO
        LIC9zPv/WYcCfK6HOJOMD0FNl3SeRDElgj1nIoa+zlxr
X-Google-Smtp-Source: AA0mqf7XOzlkSC/Q9QKsCA1I6cAvJG7ZQpjehqaSXcKitkWud4VvMWWBSyfSAw7CZ/4sgTLmlnS+1hjgIE9b6ixJ9lM=
X-Received: by 2002:a02:7409:0:b0:375:4727:8625 with SMTP id
 o9-20020a027409000000b0037547278625mr7900162jac.300.1669362670212; Thu, 24
 Nov 2022 23:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-15-namhyung@kernel.org>
 <CAP-5=fVJjPXk2hmWc6xqDxe06Arq-nOB51CwihAuuVFAoaKJ4g@mail.gmail.com>
In-Reply-To: <CAP-5=fVJjPXk2hmWc6xqDxe06Arq-nOB51CwihAuuVFAoaKJ4g@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Nov 2022 23:50:58 -0800
Message-ID: <CAM9d7ciARxBRKpwf-8eQr-x5kR8n0Wv3RmycVFdO4ikeYhDVwg@mail.gmail.com>
Subject: Re: [PATCH 14/15] perf stat: Rename "aggregate-number" to "cpu-count"
 in JSON
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
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

Hi Ian,

On Wed, Nov 23, 2022 at 3:31 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > As the JSON output has been broken for a little while, I guess there are
> > not many users.  Let's rename the field to more intuitive one. :)
>
> I'm not sure cpu-count is accurate. For example, an uncore counter in
> a dual socket machine may have a CPU mask of "0, 36", ie one event per
> socket. The aggregate-number in this case I believe is 2.

You're right.  In case of uncore events, it can be confusing.  But in some
sense it could be thought as cpu count as well since it aggregates the
result from two cpus anyway. :)

Note that the aggregate-number (or cpu-count) is only printed if users
requested one of aggregation options like --per-socket or --per-core.
In your example, then it could print 1 for each socket.

But I think uncore events are different from core events, and hopefully
they have separate instances for different sockets or something already.
That means it doesn't need to use those aggregation options for them.

Also the CSV output uses "cpus" for the same information.  It'd be nice
we could have consistency.

Thanks,
Namhyung
