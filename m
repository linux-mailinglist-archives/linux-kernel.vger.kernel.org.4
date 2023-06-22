Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93C73A554
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFVPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFVPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE57EA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687448731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0NqUtHzBlRyAKRtYPhN8+KmHj1spzFJlhdBUav2GW4=;
        b=NVv02qOzB0QPm8XcEyBGQTGBDI5bKQdjNQ0fjjJ0VeE3XyV3faj+wYY3CtBiFoKIb5gh4h
        OvPSL8dUYhu5FNF1bU/lDI1RhiToNDsc3OGLfnF967npCMMGftew2hLr9wndhLUc+1gexs
        EBuPe/P/ECywgXY2Nu6upyReEgdDHrc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-dM1pfrdXOrK9OUwCA0yK1w-1; Thu, 22 Jun 2023 11:45:27 -0400
X-MC-Unique: dM1pfrdXOrK9OUwCA0yK1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF51E3813F2D;
        Thu, 22 Jun 2023 15:45:15 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2C9C112132C;
        Thu, 22 Jun 2023 15:45:12 +0000 (UTC)
Date:   Thu, 22 Jun 2023 11:44:58 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] Sched/fair: Block nohz tick_stop when cfs bandwidth in
 use
Message-ID: <20230622154458.GD727646@lorien.usersys.redhat.com>
References: <20230622132751.2900081-1-pauld@redhat.com>
 <20230622102216.3b841f80@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622102216.3b841f80@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 10:22:16AM -0400 Steven Rostedt wrote:
> On Thu, 22 Jun 2023 09:27:51 -0400
> Phil Auld <pauld@redhat.com> wrote:
> 
> > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> > can easily run well past their quotas before a remote tick does
> > accounting.  This leads to long, multi-period stalls before such
> > tasks can run again. Currentlyi, when presented with these conflicting
> > requirements the scheduler is favoring nohz_full and letting the tick
> > be stopped. However, nohz tick stopping is already best-effort, there
> > are a number of conditions that can prevent it, whereas cfs runtime
> > bandwidth is expected to be enforced.
> > 
> > Make the scheduler favor bandwidth over stopping the tick by setting
> > TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> > runtime limit enabled.
> > 
> > Add sched_feat HZ_BW (off by default) to control this behavior.
> 
> So the tl;dr; is: "If the current task has a bandwidth limit, do not disable
> the tick" ?
>

Yes.   W/o the tick we can't reliably support/enforce the bandwidth limit.


Cheers,
Phil

> -- Steve
> 

-- 

