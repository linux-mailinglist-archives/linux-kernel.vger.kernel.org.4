Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF63680CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjA3MFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbjA3MFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:05:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296411159
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675080250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtGSnZQBOaiFCOK5YsykEI7VrXzbcyKT5geFwEAfHuQ=;
        b=haztBRkVpxPVwABJItsnAKf+yg+Aie9Gr9kI18Iq5s02/HfZqc6igVG2bBP/0bIBGHOHX3
        EsPxD6xUFbajASWYJH6+tMP6lHPYgfPr8M2XCyOz6hAy8DFnGbPisHTCyP6TNQMPs4CcvY
        uPsHroqgSQ1iwdmUHrl3ZzV32nC0Bxg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-KWIb1iCcOD-_7M9IUc1D4g-1; Mon, 30 Jan 2023 07:04:08 -0500
X-MC-Unique: KWIb1iCcOD-_7M9IUc1D4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5955C3C025D9;
        Mon, 30 Jan 2023 12:04:07 +0000 (UTC)
Received: from Diego (unknown [10.39.208.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C8B2140EBF5;
        Mon, 30 Jan 2023 12:04:05 +0000 (UTC)
Date:   Mon, 30 Jan 2023 13:04:03 +0100 (CET)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, steve.wahl@hpe.com,
        alexander.antonov@linux.intel.com, ak@linux.intel.com,
        eranian@google.com, namhyung@kernel.org
Subject: Re: [PATCH RESEND 0/5] Fix UPI uncore issue on SPR
In-Reply-To: <81c169dd-1b8a-b324-c845-4edb97295884@linux.intel.com>
Message-ID: <alpine.LRH.2.20.2301301157410.5281@Diego>
References: <20230112200105.733466-1-kan.liang@linux.intel.com> <81c169dd-1b8a-b324-c845-4edb97295884@linux.intel.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

gentle ping #2... How does it look with the patchset acceptance?
Is everything OK? Does it need any additional testing/etc.?
When could the patches be expected to land in Linus' tree? Is it
within v6.2 scope?

Thank you.
Michael

On Thu, 19 Jan 2023, Liang, Kan wrote:
> Hi Peter & Ingo,
> 
> Gentle Ping. Please let me know if you have any comments on the patch set.
> 
> Thanks
> Kan
> 
> On 2023-01-12 3:01 p.m., kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > The discovery table of UPI on SPR MCC is broken. The patch series is
> > to mitigate the issue by providing a hardcode pre-defined table.
> > 
> > The broken discovery table can trigger a kernel warning message, which
> > is overkilled. The patch series also refine the error handling code.
> > 
> > Kan Liang (5):
> >   perf/x86/uncore: Factor out uncore_device_to_die()
> >   perf/x86/uncore: Fix potential NULL pointer in uncore_get_alias_name
> >   perf/x86/uncore: Ignore broken units in discovery table
> >   perf/x86/uncore: Add a quirk for UPI on SPR
> >   perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table
> > 
> >  arch/x86/events/intel/uncore.c           |  34 ++++-
> >  arch/x86/events/intel/uncore.h           |   4 +
> >  arch/x86/events/intel/uncore_discovery.c |  60 ++++++---
> >  arch/x86/events/intel/uncore_discovery.h |  14 +-
> >  arch/x86/events/intel/uncore_snbep.c     | 158 ++++++++++++++++++-----
> >  5 files changed, 210 insertions(+), 60 deletions(-)
> > 
> 
> 

