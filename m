Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF36448BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiLFQHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiLFQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:07:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E0F32B98;
        Tue,  6 Dec 2022 08:03:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7572B81AA1;
        Tue,  6 Dec 2022 16:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F16C433D6;
        Tue,  6 Dec 2022 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670342603;
        bh=TqJFgSnbNlhbjhiuX1arn47XcYRFf/kK7R85AOUhw6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpbKpY/4NOt6CZJA27rHP/XauBm8GjJFBjXjFbrxFYlCtR2UObW8fGZXzgnL0GLKX
         HpH9B8529EVizc8sdYoy+5w9IhIOsOMkCNoxhMY/tlKP5a20L+K+wG89EAvVtHmlrx
         2/1KbHQ8r7O+OLf2xKkJ4YnYN+KP7FnRg7NNE2x/HW6A1TENys3b7V7ahhIx3vzISA
         b50IBst8dERdCBlryFxZpzU1w84aKltmNo9+BfIimwsTF2OkKr6ybLbY03U+WOcv7W
         +MtBmUMXPRskumA6wCRMRcU1BzEnkX1cljG0zCqgmLQlYsGlK0kuXLvBEzlVoo5FV4
         ICZd19A/g/y0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4DB1540404; Tue,  6 Dec 2022 13:03:18 -0300 (-03)
Date:   Tue, 6 Dec 2022 13:03:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>, irogers@google.com,
        jolsa@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, carsten.haitzler@arm.com,
        leo.yan@linaro.org, maddy@linux.ibm.com, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, tmricht@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v3 0/2] perf test: Add event group test
Message-ID: <Y49nxv41VMtqUSNk@kernel.org>
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
 <529367b6-e96a-d030-b8a2-bb4ad3d37d90@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529367b6-e96a-d030-b8a2-bb4ad3d37d90@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 06, 2022 at 09:47:57AM -0500, Liang, Kan escreveu:
> On 2022-12-05 11:32 p.m., Ravi Bangoria wrote:
> > Multiple events in a group can belong to one or more pmus, however
> > there are some limitations to it. One of the limitation is, perf
> > doesn't allow creating a group of events from different hw pmus.
> > Write a simple test to create various combinations of hw, sw and
> > uncore pmu events and verify group creation succeeds or fails as
> > expected.
> > 
> > v2: https://lore.kernel.org/r/20221129111946.409-1-ravi.bangoria@amd.com
> > v2->v3:
> >  - Define a set of uncore pmus that supports more than 3 events. This
> >    will prevent false negative results by not picking random uncore
> >    pmu. Test will be skipped if no uncore pmu found.
> > 
> > Ravi Bangoria (2):
> >   perf tool: Move pmus list variable to new a file
> 
> a new file
> 
> Other than the above typo, the patch series looks good to me.
> 
> Acked-by: Kan Liang <kan.liang@linux.intel.com>

Fixed that up, added your Acked-by, thanks.

- Arnaldo
