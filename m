Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE80473C4F0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjFWXwU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 19:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFWXwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:52:18 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A94510F1;
        Fri, 23 Jun 2023 16:52:17 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-be49e41a3d6so974822276.1;
        Fri, 23 Jun 2023 16:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687564336; x=1690156336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pehld0+Q+I3dGObCtKVPQHnHv57AYakUkX+nfcd4SXE=;
        b=fgroEBoRH5vR74VCzJBFuNz6N9j9Ojt+ZUVmcDaiuDibOm+8s/jp9ilS7fcMHD1W3R
         W0wTQu/FwNcm+rRgRIc6sBzkR5FWn4zkh7H0omdz9jZ84YRqKenhVHlv1KUTANk0A1Fx
         zerrc7Y8sFP3arrNv3YSE7EUOVcs6Tf7wR4nSGUI2V5N3mCrVxA8NffV4kRbGFUpEWq3
         CQLCA9Pm/yneaHe8tms2G5GVmdhRKqQD2aCKTaaIkjAZB1FfTegBgeOrN1726wbn2gtL
         J6HilxIuhnyR51EBqlRAEV4U52sDyxD4zDyiBFwpuqzY41KitgDMwZlbwwtjyIZhGGYL
         YWeQ==
X-Gm-Message-State: AC+VfDzcyLZBqTHG1oo7JyiXp0Zm+6AXPyEJd37VlvFXiMXfEQePJZy7
        Zrw0UEQvrYu2asXcOKE5bJbnRJUANwy7XuxhRTk=
X-Google-Smtp-Source: ACHHUZ5Z6u7uccdeUH87ndvZmYiBDviMr2xRCWRpoFlRu4DxOa2CgxBrP+fOpymJ9vZ7i6k2AzN0fKFsGdJzNsCt4GU=
X-Received: by 2002:a5b:8c7:0:b0:c12:29ac:1d3b with SMTP id
 w7-20020a5b08c7000000b00c1229ac1d3bmr155431ybq.11.1687564336570; Fri, 23 Jun
 2023 16:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com> <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com> <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <ZH452mAFn1uNo4NF@kernel.org> <c8494676-25f8-72de-3279-70d49b74a91c@linux.alibaba.com>
In-Reply-To: <c8494676-25f8-72de-3279-70d49b74a91c@linux.alibaba.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 16:52:04 -0700
Message-ID: <CAM9d7ci2fG0Z=y0E8YBPBY802u30n+ANn3tS16c1_08TjoObng@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
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

Hello,

On Wed, Jun 14, 2023 at 8:42 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>
>
>
> 在 2023/6/6 上午3:39, Arnaldo Carvalho de Melo 写道:
> > Em Mon, Jun 05, 2023 at 10:46:36AM +0800, Jing Zhang escreveu:
> >> 在 2023/6/3 上午12:20, John Garry 写道:
> >>> On 01/06/2023 09:58, Jing Zhang wrote:
> >>>> It can match identifiers "arm_cmn600_{0,1,2..X}" or "arm_cmn650_{0,1,2..X}" or "arm_cmn700_{0,1,2..X}" or "arm_ci700_{ 0,1,2..X}".
> >>>> In other words, it can match all identifiers prefixed with “arm_cmn600” or “arm_cmn650” or “arm_cmn700” or “arm_ci700”.
> >>>>
> >>>> If a new model arm_cmn driver with identifier "arm_cmn750_0", it will not be matched, but if a new revision arm_cmn driver with identifier
> >>>> "arm_cmn700_4", it can be matched.
> >>>
> >>> OK, I see what you mean. My confusion came about though your commit message on this same patch, which did not mention cmn650. I assumed that the example event which you were describing was supported for arm_cmn650 and you intentionally omitted it.
> >>>
> >>
> >> Yes, I didn't write cmn650 in the commit message, just because I omitted it. I will add it in a later version.
> >
> > Ok, will wait for v4 then.
> >
> > - Arnaldo
>
> Hi Arnaldo,
>
> Thank you for following up this patchset, maybe we can merge patch4 to patch7 into your branch first?
> They have all been reviewed/acked and there is no dispute. And patch4-7 does not depend on patch1-3,
> because patch4-7 is about the metric of ali_drw_pmu, and patch1-3 is about the metric of arm_cmn.
> It may take some time for patch1-3 to reach a consensus.

IIUC patch 4 is for the kernel and patch 5-7 semantically depend on it.
So the patch 4 should be picked up by the kernel maintainers first.

Thanks,
Namhyung
