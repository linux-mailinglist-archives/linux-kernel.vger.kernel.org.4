Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960D964A85D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiLLUEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiLLUD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:03:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D71788A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:03:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED96E611F4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2597CC433EF;
        Mon, 12 Dec 2022 20:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670875436;
        bh=EuYLEghf1J8rhDvtRiUx/+JoeIqrtKK9uQdngSsw0eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cdf7yNbT3zhrbF9ZqO9cn5PuXfsCbAhUG1eVcR0CleXGokBvlPFosbszXVdhypEp+
         kVQd86Q5/GSOMvqOvb2vEz475IrBfys+1HmxMulbfL5eW+RwFVsWfOSohP4cTOPGdw
         mCqG3FlFb/qeWvpKITkw/L/H347cSS6M+rHcXqA9Ip6laeLWqjnHMGzjq1EClwzKYW
         zg3FUgSaBgLlV8b6J9cEgTVaiwLFoQ57sTrHLmJGQlnh/5ekb0jHawQHinn9yQ5PSO
         2A8fu6wlQn0eePWT8VNkNvNMUgDuwKAkP9EkwRYLmGn4N8nTWpsdI1yyGnt5QFVmlk
         DTxmzhUv+hbjw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BDABC40483; Mon, 12 Dec 2022 17:03:53 -0300 (-03)
Date:   Mon, 12 Dec 2022 17:03:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Petar Gligoric <petar.gligor@gmail.com>,
        linux-kernel@vger.kernel.org,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: [PATCH v2 0/3] perf: introduce perf based task analyzer
Message-ID: <Y5eJKbvCxzSUUIvO@kernel.org>
References: <20221206154406.41941-1-petar.gligor@gmail.com>
 <CAM9d7cizPC3p0-Z1oYsDPofwNfZHyKYiJR5JXEcS31Q=mgzcLg@mail.gmail.com>
 <Y4/AfA2OYtlTkKwo@debian>
 <CAM9d7chLZVDg_-tnUh_qFYzchnpis-e7HYNDVM_OPjj_QXMeKQ@mail.gmail.com>
 <Y5HVdS3mlDruNyrl@debian>
 <CAM9d7ciX9ULwSy5G3cFZi7mMXrt_A52hwwk7L1m-oV_0P07_vw@mail.gmail.com>
 <Y5JE/ci+1nN9RrJQ@debian>
 <CAM9d7chSj_p8KzqRdOUZaFMyVVXHLoW+Ra5ZR4FY60bpvzUSMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chSj_p8KzqRdOUZaFMyVVXHLoW+Ra5ZR4FY60bpvzUSMA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 08, 2022 at 12:15:13PM -0800, Namhyung Kim escreveu:
> On Thu, Dec 8, 2022 at 12:11 PM Petar Gligoric <petar.gligor@gmail.com> wrote:
> >
> > >On Thu, Dec 08, 2022 at 11:10:58AM -0800, Namhyung Kim wrote:
> > >
> > > Then I have no problem with python.  Please take a look at the
> > > scripts/python/bin directory to provide shortcuts for record/report.
> >
> > Great that we could resolve it! Regarding wrapper: I thought I added
> > them or did you mean something else?
> >
> > .../scripts/python/bin/tasks-analyzer-record |  2 +
> > .../scripts/python/bin/tasks-analyzer-report |  3 +
> 
> Right, that's what I meant.  You got it already! :)

I don't see any objection to merging this, comes with a set of 'perf
test' to make sure we don't regress, I see no reason not to merge, done.

- Arnaldo
