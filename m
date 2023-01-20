Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AACF6753F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjATL6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjATL6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640FAD12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674215864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTZlaOoCxAVaRKn5xChMm1eC8TnO2jmUA28f+mCgMkE=;
        b=dd9JJ7jWFYJ8ERVJM4JG52XLDj4/AOMVl/vbFwMCJ1jVg/jC+HHc8BeYqe7Ihzdf43hzLN
        Fa+oDDH1yvx8psE/zpxEXPg7q1QYRoUHq7JyYkRK9x8oX/qDk57kitHQ7aP2I5E7F9B1YW
        f4rRwWYDvdTHt81Qb9ZkHmzuP/WY+IY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-F3G6I7yuMCKekuoZ74gMZg-1; Fri, 20 Jan 2023 06:57:36 -0500
X-MC-Unique: F3G6I7yuMCKekuoZ74gMZg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71FAD185A78B;
        Fri, 20 Jan 2023 11:57:36 +0000 (UTC)
Received: from Diego (unknown [10.39.208.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D658492C1B;
        Fri, 20 Jan 2023 11:57:33 +0000 (UTC)
Date:   Fri, 20 Jan 2023 12:57:31 +0100 (CET)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, steve.wahl@hpe.com,
        alexander.antonov@linux.intel.com, ak@linux.intel.com,
        eranian@google.com, namhyung@kernel.org
Subject: Re: [PATCH RESEND 0/5] Fix UPI uncore issue on SPR
In-Reply-To: <81c169dd-1b8a-b324-c845-4edb97295884@linux.intel.com>
Message-ID: <alpine.LRH.2.20.2301201256560.5281@Diego>
References: <20230112200105.733466-1-kan.liang@linux.intel.com> <81c169dd-1b8a-b324-c845-4edb97295884@linux.intel.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

For the series,

Tested-by: Michael Petlan <mpetlan@redhat.com>

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

