Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9266AE53
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 23:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjANWks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 17:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjANWkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 17:40:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01327BB86
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 14:40:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r9so1368246wrw.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 14:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYgARAkWs9iZ0B/4FRwpMpPs9S0XV3huLCtOhLAUC8Y=;
        b=Ds1XNBqgWBP3mtifRGvLh1owkfZbiDW4h5dggRxSHpmJ9J2KOfn/ZCCvW0yQYjw7t2
         BrB0oOoRzRcraQqleGmC+Mfg3hVBklyxNEiR38vK7o35DUoOnVHsDOLoGoetmLvmvGXP
         Dc5qNQRLBi6JMugRudC6hv7Ei7YlQCQ2jVXeYk0xl7KzfmjHgEJDK7n9gIPtgpwbreqi
         2rEySAnXmZ5CT5v6V45TREUuqDoQe3nmLgAb7HvWyPO8LunM1+DlK8f8choZ4DB2FNcO
         OR1PSQ4yGCrITZaDbs495MdLLHG75+cv4jb21A6M966VabvXDlr4+glAmt9yJmEdZbzQ
         fwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYgARAkWs9iZ0B/4FRwpMpPs9S0XV3huLCtOhLAUC8Y=;
        b=5sHLqZsj5gQy5XuFspAqdZUKEyskbV5dqr+MmuFab/llzotiN0mA3ujd4NAzo8a9/P
         VOeNZdNmqjMc+tu2nynEl/XRiXhxnJz2ivsuxKPzIjaT84nYlWLllxC4m7i8ED3v7o36
         T/WzkdPjofcgknGm0qo4xhzKQRx0rGpy70prB76/ZB71c2z02Jeg2WQkm5+6hlhCkd4w
         bNIltJxafFiiDE6M9QYzHNjXYxlRSCbHRVcQxn4KFgiXO9xw8/AVJdTzbxjQ967N8JUQ
         XqpOy7pdbarwu4tf/ERcMTvEhBFQxTHVNU30LvTSVvxYwaSuECJk/X+ZF2DGeOu33a9w
         61Lw==
X-Gm-Message-State: AFqh2kqA0h6D24X2anWT93JsYpe80IzKKNPhDw1X6dn1YYwHn1CImN/m
        j1eqDNbdm+h0b+m8DZwhzRQER4lFxcXx4C19xtR2XA==
X-Google-Smtp-Source: AMrXdXvXNemnyUUfmSCSvj4wkjdakrffiCb1jSHQJNLz46dk53LCwcZ/W7SXiBwaW6CZIwIMd2/h1+8oNAvijZD9DWo=
X-Received: by 2002:a5d:614d:0:b0:2bc:7ed4:cd50 with SMTP id
 y13-20020a5d614d000000b002bc7ed4cd50mr964423wrt.40.1673736042305; Sat, 14 Jan
 2023 14:40:42 -0800 (PST)
MIME-Version: 1.0
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
 <d33086a5-233f-f591-c9da-5f1a2e8aaf54@oracle.com> <7498a6b1-01d0-0e12-82d3-c75250e09161@linux.alibaba.com>
In-Reply-To: <7498a6b1-01d0-0e12-82d3-c75250e09161@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 14 Jan 2023 14:40:30 -0800
Message-ID: <CAP-5=fVQC=cBxN_-23KRRQGpQieMt1CA2N1UL60X9SXobV3x8w@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Add metrics for neoverse-n2-v2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 8:32 AM Jing Zhang <renyu.zj@linux.alibaba.com> wro=
te:
>
>
>
> =E5=9C=A8 2023/1/13 =E4=B8=8B=E5=8D=885:59, John Garry =E5=86=99=E9=81=93=
:
> > On 13/01/2023 09:22, Jing Zhang wrote:
> >> Changes since v6:
> >> - Split patch #1 into 3 smaller patches as suggested by Ian.
> >> - Change perf_pmu__get_slots into perf_pmu__cpu_slots_per_cycle,
> >>    per John's suggestion;
> >> - Return NAN instead of 0 in perf_pmu__cpu_slots_per_cycle weak
> >>    function, per John's suggestion;
> >> - Factor out pmu_core__find_same function, per John's suggestion.
> >> - Link:https://urldefense.com/v3/__https://lore.kernel.org/all/1673017=
529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com/__;!!ACWV5N9M2RV99h=
Q!LhBq67uDCOsz1k7ZF4aQPHF0Bp8FsMr-ZNgCnBSUKF4qJTFODfnkId7lw_NXqB4qZUCpu-jbY=
8z8LTckoqFGz2Q8bA$
> >
> > This looks fine. But for this code:
> >
> > On 13/01/2023 09:22, Jing Zhang wrote:
> >> +double perf_pmu__cpu_slots_per_cycle(void)
> >> +{
> >> +    char path[PATH_MAX];
> >> +    unsigned long long slots =3D 0;
> >
> > I would prefer if this returned NAN (and not 0) for when we can't find =
a pmu or the value from ./caps/slots is zero, but I am not going to get too=
 hung up on that.
> >
>
> Ok, I like this way too.
>
> > For series:
> >
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
>
> Thank you very much indeed!

Aside a naming nit in 1/9 for series:

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
