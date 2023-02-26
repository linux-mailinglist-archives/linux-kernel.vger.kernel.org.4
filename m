Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8316A333D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBZRh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBZRhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:37:24 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063821A650;
        Sun, 26 Feb 2023 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677433010; bh=z+D+egR+IKnMs7kjuMNQ9QKI6HtiUZ3Hosht4R19zPw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=EEQO9cSVjeoATtyOmloe/fMJcCplhKOYas0s3copL2zAdh13bmNDODhD1ghRgXzN+
         VhnPtG0zcL+bcUF6OPj1mRNPRJADSYj8MBQ3KFoIAjOyORxeVP1VFqotvUJB/xgqMt
         OR4jEC/awV4xKVIi6WBZJ2yh7lUW/uWyPpkR7zek=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 26 Feb 2023 18:36:50 +0100 (CET)
X-EA-Auth: qamVEZnHJQXIEp9zxWVTYlqDSqL2sF3iYAhmrtrd2KZnayt/BOycf2pya47q0KpqLmWIBlKgn9iAfxETKxqSNw==
Date:   Sun, 26 Feb 2023 23:06:45 +0530
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
Message-ID: <Y/uYrf1M0R4lZZb1@ubun2204.myguest.virtualbox.org>
References: <cover.1676987821.git.drv@mailo.com>
 <719558b8a435a6f942b2cc3f5c0431212be76bc6.1676987821.git.drv@mailo.com>
 <Y/Z8qUYDXPFlzdsY@hirez.programming.kicks-ass.net>
 <Y/bx0Q6XRv0mNdAT@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/bx0Q6XRv0mNdAT@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:25:45AM +0530, Deepak R Varma wrote:
> On Wed, Feb 22, 2023 at 09:35:53PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 21, 2023 at 07:36:12PM +0530, Deepak R Varma wrote:
> > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > index 85a63a41c471..27c03e6dcb5d 100644
> > > --- a/arch/x86/events/core.c
> > > +++ b/arch/x86/events/core.c
> > > @@ -1896,9 +1896,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
> > >  		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
> > >  			next_str = strchr(str, ';');
> > >  			if (next_str)
> > > -				return snprintf(page, next_str - str + 1, "%s", str);
> > > -			else
> > > -				return sprintf(page, "%s", str);
> > > +				return sysfs_emit(page, "%s", str);
> > >  		}
> > >  		str = strchr(str, ';');
> > >  		str++;
> > 
> > How is this correct ?!?
> 
> oops.. that is bad on my part. My apologies for the wrong code.
> I will correct it and send in v3.

Hello Peter,
I reviewed the code more closely and concluded that the current implementation
is better as is. I sent in a v3 with necessary correction for your review.

I do have another observation from this area that I will send in as a separate
patch soon.

Thank you again.
./drv


> 
> Thank you Peter.
> 
> Regards,
> ./drv


