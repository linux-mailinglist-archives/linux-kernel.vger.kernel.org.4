Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B541A652619
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiLTSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTSRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:17:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF01CE07;
        Tue, 20 Dec 2022 10:17:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5114B8169E;
        Tue, 20 Dec 2022 18:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F88FC433EF;
        Tue, 20 Dec 2022 18:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671560258;
        bh=tCcCyQjvXJTLP1/+poEFAXufnkYSId0E8S1P4iv/fg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7JRsv4mvJHXxAPDiCFhvqRIx+Q260FI72CCbuiwmM9M2GoH2HlOwf0yZjuqQHGwJ
         tLz0mdGE7sHVSA/lRePJb5Zw64Ynb8kf+q7DrFLn5L6VGjSHoXRfk93shbScSQGv7u
         QVk23qTH4w731VsRCYJlzIbEWdVUilek1RAFkko++cSqt9I6aJnX732eyEoKngmlBX
         /dl14vcTmxsOwq9kV4LkZej/XcVvt85Ja+S12BqLlDru4bAJaua+KWAIfC00aqWniU
         t4QP3CA1IrCT1lS7sU+ODfHOAkXxD+LMpVTZvss3sUjmDaVIUAr1SlRCk8a84AWSkI
         GQkTYXwDdEYfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D272940367; Tue, 20 Dec 2022 15:17:30 -0300 (-03)
Date:   Tue, 20 Dec 2022 15:17:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, carsten.haitzler@arm.com,
        leo.yan@linaro.org, ravi.bangoria@amd.com, martin.lau@kernel.org,
        ak@linux.intel.com, masami.hiramatsu.pt@hitachi.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf tools: Set debug_peo_args and
 redirect_to_stderr to correct values in perf_quiet_option
Message-ID: <Y6H8OvGkTuhtUbSH@kernel.org>
References: <20221220035702.188413-1-yangjihong1@huawei.com>
 <20221220035702.188413-2-yangjihong1@huawei.com>
 <e2c01688-d27d-51df-65eb-f7bdd26c99d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c01688-d27d-51df-65eb-f7bdd26c99d0@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 20, 2022 at 09:35:36AM +0200, Adrian Hunter escreveu:
> On 20/12/22 05:57, Yang Jihong wrote:
> > When perf uses quiet mode, perf_quiet_option sets debug_peo_args to -1,
> > and display_attr incorrectly determines the value of debug_peo_args.
> > As a result, unexpected information is displayed.
> > 
> > Before:
> >   # perf record --quiet -- ls > /dev/null
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     size                             128
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|PERIOD
> >     read_format                      ID|LOST
> >     disabled                         1
> >     inherit                          1
> >     mmap                             1
> >     comm                             1
> >     freq                             1
> >     enable_on_exec                   1
> >     task                             1
> >     precise_ip                       3
> >     sample_id_all                    1
> >     exclude_guest                    1
> >     mmap2                            1
> >     comm_exec                        1
> >     ksymbol                          1
> >     bpf_event                        1
> >   ------------------------------------------------------------
> >   ...
> > 
> > After:
> >   # perf record --quiet -- ls > /dev/null
> >   #
> > 
> > redirect_to_stderr is a similar problem.
> > 
> > Fixes: f78eaef0e049 ("perf tools: Allow to force redirect pr_debug to stderr.")
> > Fixes: ccd26741f5e6 ("perf tool: Provide an option to print perf_event_open args and return value")
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied all patches in this series.

- Arnaldo

