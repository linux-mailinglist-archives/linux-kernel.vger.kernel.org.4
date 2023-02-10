Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0178691C53
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjBJKJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjBJKJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:09:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAA134F68
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=17gnpumNvDg1uLOrdDtUU76XG/ciCpkL2co9kCLrSms=; b=cAmFY7/yTSDJxkKFKu4sBUS4NR
        N9CYH0kJddJPl7UIEkeR1dBiEZg6PQ455M7fQ1+G4zYwsgS3GGSBGIx9vqanGuiqSnWPqWAcdnq5i
        fpFoSK9Hz0nmgXCJJDIJIRf81ZSmqT0JuQqfSCti/4DQQsfwlgHIuCBekm9D+QSyKgdeTJG/gpkoc
        8zbO6q18Ox7+uwivej9956Ym2X9NO0JaRaUIv5xbNx6Dg5h1mY6XOdXmNKP5zWkg3XkJuSZ7JFwKC
        +5XrmZkn3nG3MiCTWB43Z7/VMzhy8tnloyXNt65ZCPXXGliXKFbEe196Mio0UNxW5gs4exteYjdQQ
        krz6oXKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQQKl-0030lO-U5; Fri, 10 Feb 2023 10:08:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0376030012F;
        Fri, 10 Feb 2023 11:08:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5F5520A1CFBA; Fri, 10 Feb 2023 11:08:46 +0100 (CET)
Date:   Fri, 10 Feb 2023 11:08:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Message-ID: <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:58:34PM -0800, Ricardo Neri wrote:
> SD_PREFER_SIBLING is set from the SMT scheduling domain up to the first
> non-NUMA domain (the exception is systems with SD_ASYM_CPUCAPACITY).
> 
> Above the SMT sched domain, all domains have a child. The SD_PREFER_
> SIBLING is honored always regardless of the scheduling domain at which the
> load balance takes place.
> 
> There are cases, however, in which the busiest CPU's sched domain has
> child but the destination CPU's does not. Consider, for instance a non-SMT
> core (or an SMT core with only one online sibling) doing load balance with
> an SMT core at the MC level. SD_PREFER_SIBLING will not be honored. We are
> left with a fully busy SMT core and an idle non-SMT core.
> 
> Avoid inconsistent behavior. Use the prefer_sibling behavior at the current
> scheduling domain, not its child.
> 
> The NUMA sched domain does not have the SD_PREFER_SIBLING flag. Thus, we
> will not spread load among NUMA sched groups, as desired.
> 

Like many of the others; I don't much like this.

Why not simply detect this asymmetric having of SMT and kill the
PREFER_SIBLING flag on the SMT leafs in that case?

Specifically, I'm thinking something in the degenerate area where it
looks if a given domain has equal depth children or so.

Note that this should not be tied to having special hardware, you can
create the very same weirdness by just offlining a few SMT siblings and
leaving a few on.
