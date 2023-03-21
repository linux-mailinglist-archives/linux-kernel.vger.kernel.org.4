Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B56C31F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCUMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjCUMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FCB9EC9;
        Tue, 21 Mar 2023 05:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690D461B77;
        Tue, 21 Mar 2023 12:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38BCC433EF;
        Tue, 21 Mar 2023 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679402598;
        bh=xcJkoQTIIOmCXDoY8pP/8Jt34/V+tPqbIw1wqfFT8H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INWXDDFDvGVVzzZg4su/goP/n0OeZ2zbnBlOx3kOlFJQ3w1WhpP61mWbS3JQgnc9t
         ZVttUFWOeeNF3i3tSDAAAlv9ei1Iq4ab09f/9n2wohMk/6DLkZxeKMg0ZXAh5WAdiL
         qcY9sF9NxJEaI9B+xN8F2HvgjKz8Ej2beSUiW6Nb5qJUFm82e0Wve4/BU+/mjpKsAT
         4QIphehdf2N9PLin360UE6E3Huq+YZp69qWG1C9FrRHpGC5eD2I+cBXcjRNt5XmnKi
         S3XoOxdnPIA9EZ+/BBrd0NCnT4mkGnP7Mf+agDljUxjppYjLgCGrF/KB5ln1n2oY/X
         6cke/v5Dj1lOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FE4E4052D; Tue, 21 Mar 2023 09:43:16 -0300 (-03)
Date:   Tue, 21 Mar 2023 09:43:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf tools: Sync perf_event_attr::config3 addition
Message-ID: <ZBmmZGhodcpefjRu@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v5-0-2cf5210b2f77@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v5-1-2cf5210b2f77@kernel.org>
 <Y/DQ7Y+FD4cMn29J@kernel.org>
 <CAL_JsqLD_P1X1+vKODgZP1vaie2+c__X_HM8kWWzSb7PxZqZew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLD_P1X1+vKODgZP1vaie2+c__X_HM8kWWzSb7PxZqZew@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 20, 2023 at 01:21:10PM -0500, Rob Herring escreveu:
> On Sat, Feb 18, 2023 at 7:21 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Feb 17, 2023 at 04:32:10PM -0600, Rob Herring escreveu:
> > > Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> > > existing perf_event_attr::configN fields are all used up for SPE PMU, an
> > > additional field is needed. Add a new 'config3' field.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > This matches commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
> > > for the kernel queued in linux-next.
> >
> > When you mention linux-next where was it that it picked this from?
> >
> > For me to get this merged into the perf tools "next" (perf/core) it must
> > already have been merged in the kernel counterpart (tip/perf/core).
> >
> > Ok so it is not in tip/perf/core, but got in next yesterday, and PeterZ
> > acked it, good, will process it soon.
> 
> Hi Arnaldo, Are you going to apply this or are you expecting something from me?

Sorry for the delay, applied.

- Arnaldo
