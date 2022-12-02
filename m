Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A3B640D53
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiLBSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiLBSeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:34:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D01EAB5B;
        Fri,  2 Dec 2022 10:33:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6CEC62396;
        Fri,  2 Dec 2022 18:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1623FC433D6;
        Fri,  2 Dec 2022 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670006038;
        bh=5qgN/0KlobinRAEgvoeGfuKAnSG6v3OxU8LJMnoH+E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQ2DGYWglzVHEkUP2eVpH058hqA3Us8Uf0+qA11160E8sHybY5Q/0eINbByslV88m
         wng+HULdmUZCt+3d9rPc3/4lLG7YzptkCPuykqfZuB50vb1PU7G0sd6Nq4Nx0P9zVY
         y1DIps3rs6xQkNZzqEISISQe+YjrR47hPC2IOg8s0U3rxfzNAa6Ohnhgk6WbTIMwbu
         m7CE0QQ55yARTmAvE/V9FzsQqNenRqjwD/BNquqVxj5b78i3Jp+yC+DowgzOGE5IKO
         f6uruOyfHXQDahQVAbULEnyNBM95qH0tGtNJJ7Mbw5WozMjoL5m3fnFwNGQranVhkU
         WZL9UUreGfY8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B3F844034E; Fri,  2 Dec 2022 15:33:55 -0300 (-03)
Date:   Fri, 2 Dec 2022 15:33:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, sandipan.das@amd.com,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: Fix interpretation of branch records
Message-ID: <Y4pFE1bNObTTLL2+@kernel.org>
References: <20221130165158.517385-1-james.clark@arm.com>
 <8b7606a4-63e4-6d0c-6b83-5ef51c83385c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7606a4-63e4-6d0c-6b83-5ef51c83385c@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 01, 2022 at 09:46:53AM +0530, Anshuman Khandual escreveu:
> 
> 
> On 11/30/22 22:21, James Clark wrote:
> > Commit 93315e46b000 ("perf/core: Add speculation info to branch
> > entries") added a new field in between type and new_type. Perf has
> > its own copy of this struct so update it to match the kernel side.
> > 
> > This doesn't currently cause any issues because new_type is only used
> > by the Arm BRBE driver which isn't merged yet.
> > 
> > Fixes: 93315e46b000 ("perf/core: Add speculation info to branch entries")
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Again, problem from having the same structure in two different places

Indeed, this was my first reaction, how about backward compatibility, is
this really an ABI?

- Arnaldo
 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
 
> > ---
> >  tools/perf/util/branch.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
> > index d6017c9b1872..3ed792db1125 100644
> > --- a/tools/perf/util/branch.h
> > +++ b/tools/perf/util/branch.h
> > @@ -22,9 +22,10 @@ struct branch_flags {
> >  			u64 abort:1;
> >  			u64 cycles:16;
> >  			u64 type:4;
> > +			u64 spec:2;
> >  			u64 new_type:4;
> >  			u64 priv:3;
> > -			u64 reserved:33;
> > +			u64 reserved:31;
> >  		};
> >  	};
> >  };

-- 

- Arnaldo
