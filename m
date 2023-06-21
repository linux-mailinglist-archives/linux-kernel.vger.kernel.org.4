Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FA8737A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 07:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFUFBE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 01:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFUFBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:01:00 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E5F171C;
        Tue, 20 Jun 2023 22:00:59 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so5299190276.2;
        Tue, 20 Jun 2023 22:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687323658; x=1689915658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvLN9PtbiTUSbSQsnuGVxECcHq53WHbsUowdBzLPKG8=;
        b=FNMAHxMCFkEFZfzU5JDK2zaM0M8wHhqj/O530lVerxkQQLUY2g/ITanX7fNjfy1MRb
         huOgqEpTZDNvqPTpyeFMKDL8FePykzGmE4bOvj9/4vJ4x8ALQchBhvespu0IDBYwtBUQ
         qaU4WE/JCpoo6LyKmTF5vsS+h34et5Yr9ra333zViUC/Sddalmqk4UI33ph2wBn4MTs/
         a8rGBzgkqkcd6fI7WUUHMNndsNod7nqjvbIRAEDEYcc+cbNC/AAKcvqO5PAg4GPo3kpC
         OZRYh5th27YYlBaELjBNYfkpEEohJd3T+dwB0/hYYBsk6ice+12uolImvvzHoQlTECNK
         lcKQ==
X-Gm-Message-State: AC+VfDzua82hrk/1N1P0l6QI9/ndB9lB2JMlWP5ZVK7ocbYvtOuVeCMR
        BpYEgHss6sHRyUcWOx41pzoI9Zax+sGPNZRNQog=
X-Google-Smtp-Source: ACHHUZ6x1N5ygWt4onDzX+OKuKUYvDVOM3m+S18jMK/OK0OU/hrMkFIXwOK9Jx/xBy30YTzzwLWD3VgMyv6/N7Eb9UM=
X-Received: by 2002:a25:b195:0:b0:b8e:cb88:1b69 with SMTP id
 h21-20020a25b195000000b00b8ecb881b69mr11344555ybj.34.1687323658551; Tue, 20
 Jun 2023 22:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAM9d7cj3v58m8NcsEK4sYsk_dbQDAq71hYo7DV=xaQa_rZyPYg@mail.gmail.com> <a5486c58-32b6-2d5e-e623-d7844c51474c@linux.alibaba.com>
In-Reply-To: <a5486c58-32b6-2d5e-e623-d7844c51474c@linux.alibaba.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 22:00:46 -0700
Message-ID: <CAM9d7chxMpUUouHsVTEvVEy8RyZ6tNzYbVD=a0Toao=n6cau-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add JSON metrics for Yitian710 DDR
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.g.garry@oracle.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
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

On Tue, Jun 20, 2023 at 8:08 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>
>
>
> 在 2023/6/21 上午3:04, Namhyung Kim 写道:
> > Hello,
> >
> > On Tue, Jun 20, 2023 at 12:17 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
> >>
> >> Hi all,
> >>
> >> I add an identifier sysfs file for the yitian710 SoC DDR to allow
> >> userspace to identify the specific implementation of the device,
> >> so that the perf tool can match the corresponding uncore events and
> >> metrics through the identifier. Then added yitian710 SoC DDR
> >> metrics and events alias.
> >>
> >> Change since v3:
> >> - Split the CMN and ali_drw patches. This patchset only contains
> >>   ali_drw PMU related patches. The CMN metric related patches will
> >>   be in another patchset.
> >> - Link: https://lore.kernel.org/all/1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com/
> >>
> >> $perf list:
> >> ...
> >> ali_drw:
> >>   chi_rxdat
> >>        [A packet at CHI RXDAT interface (write data). Unit: ali_drw]
> >>   chi_rxrsp
> >>        [A packet at CHI RXRSP interface. Unit: ali_drw]
> >>   chi_txdat
> >>        [A packet at CHI TXDAT interface (read data). Unit: ali_drw]
> >>   chi_txreq
> >>        [A packet at CHI TXREQ interface (request). Unit: ali_drw]
> >>   cycle
> >>        [The ddr cycle. Unit: ali_drw]
> >> ...
> >> ali_drw:
> >>   ddr_read_bandwidth.all
> >>        [The ddr read bandwidth(MB/s). Unit: ali_drw ]
> >>   ddr_write_bandwidth.all
> >>        [The ddr write bandwidth(MB/s). Unit: ali_drw ]
> >> ...
> >>
> >> $perf stat -M ddr_read_bandwidth.all ./test
> >>
> >> Performance counter stats for 'system wide':
> >>
> >>             38,150      hif_rd        #  2.4 MB/s  ddr_read_bandwidth.all
> >>      1,000,957,941 ns   duration_time
> >>
> >>        1.000957941 seconds time elapsed
> >>
> >> Jing Zhang (4):
> >>   driver/perf: Add identifier sysfs file for Yitian 710 DDR
> >>   perf jevents: Add support for Yitian 710 DDR PMU aliasing
> >>   perf vendor events: Add JSON metrics for Yitian 710 DDR
> >>   docs: perf: Update metric usage for Alibaba's T-Head PMU driver
> >
> > So patch 1 is for the kernel, and patch 2-4 depend on it, right?
> >
>
> Hi Namhyung,
>
> Yes, patch 2-4 depend on patch 1.
>
> > I'm curious why the first patch is needed, presumably the PMU
> > should have 'ali_drw' in the name already.  Do we use substring
> > match for the compat name in the JSON metric?
> >
>
> The main purpose of patch 1 is to add an identifier so that the Compat
> field can match the corresponding event when defining aliases or metrics
> for events.
>
> For example, "Unit" can match "ali_drw" in the name and different SoCs may
> be able to match ali_drw, but they may have different events, and even if
> the events are the same, the meanings may be different. Therefore, the
> Compat field is needed to match the Identifier to confirm which type and
> revision of PMU the current SoC has. Therefore, both "Unit" and "Compat"
> need to be matched at the same time. Although it seems that ali_drw is
> redundantly matched currently, it is meaningful for future expansion.

I see, thanks for the explanation.

I think you need to route the kernel patch differently.  I can apply the tools
part once the kernel patch gets Acks from others.

Thanks,
Namhyung
