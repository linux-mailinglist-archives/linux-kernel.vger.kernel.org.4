Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B549D73DFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjFZMqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjFZMqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49392942;
        Mon, 26 Jun 2023 05:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5292160E9B;
        Mon, 26 Jun 2023 12:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74D4C433C8;
        Mon, 26 Jun 2023 12:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687783479;
        bh=zybkaKmO2rq8ExZfzHUmP4+U7WBCst4SsJhXQatkp/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCaYeKgR7cpxf3FJj1ApaF+cDf3BQWX4+ctqU0OLRRBja2IVSkgwgUW18kLel4THd
         JivMpVLL1+0o/vjgGN+qiZfvL0+SCTd6YUzcKnxFCyS64Xbey0jmw/qrMy7MDCUF4A
         9wywLBAPZZKr2V77R9Dhv+VTTFRSEvugBf6kVzglEMZuv5GNi/0NW/YyIJ3Ydyps+i
         honsMly0qBOAN/erO6dD+/Ku/qrEiW1X/6ITnlB6ANyhW03fij5GpxwmmbwbprPFYH
         /lfDMZ9LabmUaAZKseb0sLWhWx1oKVJta2wHtXSOZ/f/i418+QiEScI2Dp0MJovzCf
         gCOpnC8dcu37w==
Date:   Mon, 26 Jun 2023 13:44:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v4 0/4] Add JSON metrics for Yitian710 DDR
Message-ID: <20230626124431.GB20045@willie-the-truck>
References: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAM9d7cj3v58m8NcsEK4sYsk_dbQDAq71hYo7DV=xaQa_rZyPYg@mail.gmail.com>
 <a5486c58-32b6-2d5e-e623-d7844c51474c@linux.alibaba.com>
 <CAM9d7chxMpUUouHsVTEvVEy8RyZ6tNzYbVD=a0Toao=n6cau-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chxMpUUouHsVTEvVEy8RyZ6tNzYbVD=a0Toao=n6cau-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:00:46PM -0700, Namhyung Kim wrote:
> On Tue, Jun 20, 2023 at 8:08 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
> > 在 2023/6/21 上午3:04, Namhyung Kim 写道:
> > > I'm curious why the first patch is needed, presumably the PMU
> > > should have 'ali_drw' in the name already.  Do we use substring
> > > match for the compat name in the JSON metric?
> > >
> >
> > The main purpose of patch 1 is to add an identifier so that the Compat
> > field can match the corresponding event when defining aliases or metrics
> > for events.
> >
> > For example, "Unit" can match "ali_drw" in the name and different SoCs may
> > be able to match ali_drw, but they may have different events, and even if
> > the events are the same, the meanings may be different. Therefore, the
> > Compat field is needed to match the Identifier to confirm which type and
> > revision of PMU the current SoC has. Therefore, both "Unit" and "Compat"
> > need to be matched at the same time. Although it seems that ali_drw is
> > redundantly matched currently, it is meaningful for future expansion.
> 
> I see, thanks for the explanation.
> 
> I think you need to route the kernel patch differently.  I can apply the tools
> part once the kernel patch gets Acks from others.

Sorry, I missed this initially as I didn't realise there were kernel changes
hidden in this series (I saw "JSON" and ignored it...). Given that the 6.5
merge window is now open, I'll pick the kernel change up for 6.6 when I
start queueing patches in a few weeks.

Will
