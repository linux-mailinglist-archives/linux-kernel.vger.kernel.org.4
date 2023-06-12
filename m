Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF872C863
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjFLO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbjFLO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:26:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB71982;
        Mon, 12 Jun 2023 07:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901BA6152C;
        Mon, 12 Jun 2023 14:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0B2C433D2;
        Mon, 12 Jun 2023 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579869;
        bh=8sAZD+hAvXQWVLROaSM5UrvaEx3cSXS0jloJ1FKhXDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbFAttbCT8XewMJnnbiDzVJvX5bcVvUfZK6SKm4RNZjwsX8j53ejjOM9jVluUtQ33
         le43aa7pI99xCGft+eRu54DKT3UeNaeABuUEsQs2zSfUikoxLrm6ROr8Ru+D14BVoB
         S56sAEvCIJpxsRa+GA5j5kN3eA1d2lE2+O1EdkQ1FxFhLod4C9fbUvJ+WNtWCcVIwE
         h0Mtbd3IIpacz30Esx9LwYuWereyudzBpBxDKlALt9CSTpUxNttZs2YSy3tcPdY6wy
         LZmWtIkr8JTet4EZIBKXIO0glQTBds1dmaQfejQbzAAY9X5eV8vP3hl+FhjGNVFz7X
         H8XY5BcoBFJAg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4ACEA40692; Mon, 12 Jun 2023 11:24:26 -0300 (-03)
Date:   Mon, 12 Jun 2023 11:24:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Adding support for setting the affinity of the recording
 process
Message-ID: <ZIcqmlHIfBbyZFDl@kernel.org>
References: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 12, 2023 at 06:26:10PM +0800, Yang Jihong escreveu:
> Hello everyone,
> 
> Currently, perf-record supports profiling an existing process, thread, or a
> specified command.
> 
> Sometimes we may need to set CPU affinity of the target process before
> recording:
> 
>   # taskset -pc <cpus> <pid>
>   # perf record -p <pid> -- sleep 10
> 
> or:
> 
>   # perf record -- `taskset -c <cpus> COMMAND`
> 
> I'm thinking about getting perf to support setting the affinity of the
> recording process, for example:

not of the 'recording process' but the 'observed process', right?
 
> 1. set the CPU affinity of the <pid1> process to <cpus1>, <pid2> process to
> <cpus2>,  and record:
> 
>   # perf record -p <pid1>/<cpus1>:<pid2>/<cpus2> -- sleep 10

but what would be the semantic for what is being observed? Would this
result in it recording events on that CPU or just for that process (that
now runs just on that CPU)?

Without affinity setting that could mean: observe just that process when
it runs on that CPU.

But could you please spell out the use case, why do you need this, is
this so common (for you) that you repeatedly need to first taskset, then
perf, etc?
 
> and
> 
> 2. set CPU affinity of the COMMAND and record:
> 
>   # perf record --taskset-command <cpus> COMMAND
> 
> In doing so, perf, as an observer, actually changes some of the properties
> of the target process, which may be contrary to the purpose of perf tool.

Up for discussion, but I don't think this is that much a problem if it
streamlines common observability sessions/experimentations.

> Will we consider accepting this approach?

- Arnaldo
