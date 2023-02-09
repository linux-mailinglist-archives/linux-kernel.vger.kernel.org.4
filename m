Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A48690829
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBIMEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjBIMD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:03:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1D6611F8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UCUngvVeDGt6B+YYkhIGibiFb1IGSWjwVwfCNujk4BI=; b=l+//1wYh/rLyduFvss4rVjF0xd
        Tc9sYONZXA9poNwTLuBJsmoyESKNeVOiiVdEdrcX3683AeYgWgdET0/OMjD08aZseaTPPYlbzJkmp
        AuDqifX0QebPRW8oxRhABgMOUwpjyAK/+iSV7sF5er80DZzH/rPBOreZM3MjlX7wsnNI4KnIJwPr2
        C/yDUmcVWKEe+FzRMpmiNvb9aEqlUukLY3ra8QBABKoLJ85je0IrncidNXAlXGmmZP/Q5eQma3OOx
        Ey2bKbt5MXU/HMsTwHvUHH7glW3VdX3e4xHMOh1Ug83W9uxjLjf79jMPIvXJVYOiztZ7Tb+PmD4rT
        s+gesjDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pQ5U9-007u19-0S;
        Thu, 09 Feb 2023 11:53:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 458C4300293;
        Thu,  9 Feb 2023 12:53:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2853209F7542; Thu,  9 Feb 2023 12:53:41 +0100 (CET)
Date:   Thu, 9 Feb 2023 12:53:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
Message-ID: <Y+TexehP3140vxBu@hirez.programming.kicks-ass.net>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtB_YR8e6fcx3Un0vTeJR4EJS9sOXG=wLb8rZeM5Ub4yyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB_YR8e6fcx3Un0vTeJR4EJS9sOXG=wLb8rZeM5Ub4yyA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 08:56:32AM +0100, Vincent Guittot wrote:

> > +                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> > +                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))
> 
> This 2nd if could be merged with the upper one

Wasn't this exact same condition used in the previous patch as well?
Does it wants to be a helper perhaps?
