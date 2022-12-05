Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1C6428F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiLENHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLENHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:07:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB72FB;
        Mon,  5 Dec 2022 05:07:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28DA6610A2;
        Mon,  5 Dec 2022 13:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482DDC433D6;
        Mon,  5 Dec 2022 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670245659;
        bh=+Cz193U0b3uUSIcs+BNCWjvCYp/tWS5mm3h5uD73XO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcH8JBk2LrNBZWvd17e1fMz7nSeYQuk9OISUT09m3KbYLxCntqDFjs7fzRB54KEfa
         jFltoAZbNN445Y/WbjIJTqjzZgQuPcOBFeL+jGkb2H16aiG06USCk+GrSMyWQoFYoS
         m0X7hpld8q/3fIVu6fpffU4BAG2WU/BIT/fnBKpNyNr+U+Pq77ThLwG/QvGEg905Le
         PtEjZANouSuXw3qqiJAUVbw/4xPOWpx//QYFkrASa6/41Eyif9cGroCC2i9QTPEte8
         OuKCsiEDh52KFF5qjjyUz8W8iBKwG1u01VoqG7TUmsVDyRxAVScaFgC411AWEBukdk
         Y34n0Lkc7jAIA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0169040404; Mon,  5 Dec 2022 10:07:36 -0300 (-03)
Date:   Mon, 5 Dec 2022 10:07:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     James Clark <james.clark@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/2] perf stat: Fix invalid output handle
Message-ID: <Y43tGKg8bEhWglgy@kernel.org>
References: <20221130111521.334152-1-james.clark@arm.com>
 <20221130111521.334152-2-james.clark@arm.com>
 <CAM9d7cj0Zrv32CgJ7jSjCY=CsOcF40zC2kxE+NSixG4qZDpXqQ@mail.gmail.com>
 <a0745ad9-c21e-2c93-9af4-46e60bc301fc@arm.com>
 <E93B2D0E-8862-4873-B49F-F74D83CEEDAD@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E93B2D0E-8862-4873-B49F-F74D83CEEDAD@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 04, 2022 at 10:38:28PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 01-Dec-2022, at 3:36 PM, James Clark <james.clark@arm.com> wrote:
> > 
> > 
> > 
> > On 30/11/2022 18:32, Namhyung Kim wrote:
> >> On Wed, Nov 30, 2022 at 3:15 AM James Clark <james.clark@arm.com> wrote:
> >>> 
> >>> In this context, 'os' is already a pointer so the extra dereference
> >>> isn't required. This fixes the following test failure on aarch64:
> >>> 
> >>>  $ ./perf test "json output" -vvv
> >>>  92: perf stat JSON output linter                                    :
> >>>  --- start ---
> >>>  Checking json output: no args Test failed for input:
> >>>  ...
> >>>  Fatal error: glibc detected an invalid stdio handle
> >>>  ---- end ----
> >>>  perf stat JSON output linter: FAILED!
> >>> 
> >>> Fixes: e7f4da312259 ("perf stat: Pass struct outstate to printout()")
> >>> Signed-off-by: James Clark <james.clark@arm.com>
> >> 
> >> Thanks for fixing this.  I'm not sure how I missed it.. :(
> >> 
> > 
> > It seems to only go down that path on some configuration. At least on
> > x86 the test was passing fine for me.
> > 
> >> Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks for the review!
> 
> Faced same issue on powerpc. Tested with this change and it works with this patch.
> 
> Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo
