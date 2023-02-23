Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C356A0227
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjBWE4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjBWE4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:56:45 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31D31E3F;
        Wed, 22 Feb 2023 20:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677128150; bh=mvZGstpEL9ZF5XhvQ8Sk4puue/WRYuf6cEKinTtT/nw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=QU9Kis/rEzizbq+lzNCdr8jN2+g4D+sXrcdrvBAWw0DOq/gGoBYUB8eUcj9I1B97+
         Kc4kkwBVJ/BW8xWmMpBgFodi63UiGDSJlhHiekOvGEZ5BnjoI6ZdzyEPRroYSCYMhR
         gff54v0s9Itetb+MsVWZAVyHscJVjpTONNy7gMk4=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 23 Feb 2023 05:55:50 +0100 (CET)
X-EA-Auth: w1tJG6aBq96uRusMGtbYZezFwDdxEqXWpbeiOtNbPKP845V9IQXv3WuIxjC78dy6CdXHxxaS2DDH5bqHd+l1Zw==
Date:   Thu, 23 Feb 2023 10:25:45 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v2 1/3] perf/x86/core: Use sysfs_emit() in show()
 callback function
Message-ID: <Y/bx0Q6XRv0mNdAT@ubun2204.myguest.virtualbox.org>
References: <cover.1676987821.git.drv@mailo.com>
 <719558b8a435a6f942b2cc3f5c0431212be76bc6.1676987821.git.drv@mailo.com>
 <Y/Z8qUYDXPFlzdsY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/Z8qUYDXPFlzdsY@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:35:53PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 21, 2023 at 07:36:12PM +0530, Deepak R Varma wrote:
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 85a63a41c471..27c03e6dcb5d 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1896,9 +1896,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
> >  		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
> >  			next_str = strchr(str, ';');
> >  			if (next_str)
> > -				return snprintf(page, next_str - str + 1, "%s", str);
> > -			else
> > -				return sprintf(page, "%s", str);
> > +				return sysfs_emit(page, "%s", str);
> >  		}
> >  		str = strchr(str, ';');
> >  		str++;
> 
> How is this correct ?!?

oops.. that is bad on my part. My apologies for the wrong code.
I will correct it and send in v3.

Thank you Peter.

Regards,
./drv


