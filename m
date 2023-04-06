Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102916D9BDF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbjDFPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDFPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE84C20;
        Thu,  6 Apr 2023 08:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D7C62965;
        Thu,  6 Apr 2023 15:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1761CC433EF;
        Thu,  6 Apr 2023 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680793829;
        bh=0UD7lBi4KhWPJ7V/3+hujN1yIN9Kh2kmwkcgc5o2o2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rU3B19bLjMSfWSQKyVVBLd+GFum7QNWMNPJ+WV9uSc2cGuKr8vtOGRqp9WWRBSU/m
         Cm0Kkt0IJNae7kKhDULiEk3qKePAN60hPzRG3DmMywm4q+5i/4Wak2haSeJby/+G4B
         fQkj+uN1jddMGrmbMSeCRJSnFjjFWIhH4nTs58G6lk0mNnrAcJUqULhSa4kncIlWar
         PkUMwlnTdbkLcBsORvzKfi00k7MKQCVkaPhkDjnkyxDkudMV0ANVYDZ2g19OH878r0
         WJkwPR/9ZMv3oY2KpwKMk7gAS10M2V8EGLHVq3hU3Dnx/aY7o8VySRs6LCOSL6Jjrv
         uTqXx58lk8Qsg==
Date:   Thu, 6 Apr 2023 16:10:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Newman <peternewman@google.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        eranian@google.com, irogers@google.com, jolsa@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Subject: Re: [PATCH v5] arm64: pmuv3: dynamically map
 PERF_COUNT_HW_BRANCH_INSTRUCTIONS
Message-ID: <20230406151022.GB11802@willie-the-truck>
References: <20230403091547.441550-1-peternewman@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403091547.441550-1-peternewman@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Apr 03, 2023 at 11:15:47AM +0200, Peter Newman wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> The mapping of perf_events generic hardware events to actual PMU events on
> ARM PMUv3 may not always be correct. This is in particular true for the
> PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
> architected event, it may not always be available. This can be seen with a
> simple:
> 
> $ perf stat -e branches sleep 0
>  Performance counter stats for 'sleep 0':
> 
>    <not supported>      branches
> 
>        0.001401081 seconds time elapsed
> 
> Yet the hardware does have an event that could be used for branches.
> 
> Dynamically check for a supported hardware event which can be used for
> PERF_COUNT_HW_BRANCH_INSTRUCTIONS at mapping time.
> 
> And with that:
> 
> $ perf stat -e branches sleep 0
> 
>  Performance counter stats for 'sleep 0':
> 
>            166,739      branches
> 
>        0.000832163 seconds time elapsed
> 
> Co-Developed-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Co-Developed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Co-Developed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Peter Newman <peternewman@google.com>
> Link: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N
> ---
> v4->v5:
>  - update changelog tags

Thanks, this looks good to me.

Please can you rebase it on my for-next/perf branch so that I can queue it
up? More of the PMU code has moved out into drivers/perf/.

Cheers,

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-next/perf
