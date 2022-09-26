Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6902F5EB168
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiIZTgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIZTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:36:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F916CF64
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33040B80BD1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9354C433D6;
        Mon, 26 Sep 2022 19:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664220996;
        bh=m/Iu0JpTyO1sic7wYkJr9x8ukk6kvYL6sQMHaG/qKoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1/Y8a9Kgc63ieXJ4l7RtsOyd3osje2d5/GKxf0LAYZTmD4FOB5US45NkFxuGFpP/
         cqKPF/QxGZReMivypSBqpzeZ22eebDqGTA2XOaKov45+0vWsATl1MChu4QGDCpaczP
         zIfqSg9Yq+L6jDF/zVCyeyIlP0PtTNZWgpsX9O+Q1PMH9lZOGPQI3q9vQuoeJ79sQB
         WyxmSI2s0qwCJxB88GuEUZxxmw9zEI8qchaSEfU3oAPos2Hkanbj/JtdCJJ7AfH6Be
         6QOr6mpbdLS2sUIwB72ct0nR/X3xqD7QINldnGt5P2+L0E3s9lsWQ492/A9fMyPGnp
         q1/il4RRwPsgg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33553403B0; Mon, 26 Sep 2022 20:36:33 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:36:33 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] perf test: Add tests/shell/lib/waiting.sh
Message-ID: <YzH/QTdo5eGoYTvi@kernel.org>
References: <20220914080150.5888-1-adrian.hunter@intel.com>
 <CAM9d7cjq0rDKgpGTnrTiJy9Ew282BTZ1SQZMM1-CawLqKMOP6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjq0rDKgpGTnrTiJy9Ew282BTZ1SQZMM1-CawLqKMOP6w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 14, 2022 at 09:41:09AM -0700, Namhyung Kim escreveu:
> On Wed, Sep 14, 2022 at 1:02 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Hi
> >
> > As requested by Namhyung, move functions from test_intel_pt.sh
> > to tests/shell/lib/waiting.sh, and parameterize timeouts.
> >
> >
> > Adrian Hunter (2):
> >       perf test: test_intel_pt.sh: Move helper functions for waiting
> >       perf test: waiting.sh: Parameterize timeouts
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> >
> >  tools/perf/tests/shell/lib/waiting.sh   | 77 +++++++++++++++++++++++++++++++++
> >  tools/perf/tests/shell/test_intel_pt.sh | 68 ++---------------------------
> >  2 files changed, 81 insertions(+), 64 deletions(-)
> >  create mode 100644 tools/perf/tests/shell/lib/waiting.sh
> >
> >
> > Regards
> > Adrian

-- 

- Arnaldo
