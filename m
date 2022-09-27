Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07B05EC375
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiI0NBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiI0NB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:01:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120FAA2209
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JajMUTWFWdf52LEvQ3sdkC4KhamKYR9MOGDGh7+XACA=; b=UBtsrGDqWvvym8LUIXYIIW653+
        ia4Y+PnhWnbokr6Rn0/I9FQCCO3A8142BQhLdTYyK96xplEyXFQRfHHQi9q64fg9+uvStOY/oqfo1
        P4eNU+/9IuPx4KEoA1PRjnyC0X3rctkoyBy03qhpNENCT8NzEw/7uW6C+zFLdvghOeGtivtjFwlgQ
        e87NSRAKcz9/9Bhi9+KhFFzdZGotAK1XQxu6RS7zQ6f+mm8zwI09ZW/8aVdJey+ZBqnmb3obCjgWg
        6vUYbDVHNY/rS6dZ5bzglqv80ypOHMt38503jiDYjc4DCdhs25/JplTkb8KbptK4NwRZYJg1sG0HO
        W/wcO+rQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odACy-00GHzB-C7; Tue, 27 Sep 2022 13:01:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E295B3001D6;
        Tue, 27 Sep 2022 15:01:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFDDD2BDF120B; Tue, 27 Sep 2022 15:01:07 +0200 (CEST)
Date:   Tue, 27 Sep 2022 15:01:07 +0200
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 01/23] sched/task_struct: Introduce classes of tasks
Message-ID: <YzL0E/8sz1viLau7@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-2-ricardo.neri-calderon@linux.intel.com>
 <YyHbOqoH+V6FUY68@hirez.programming.kicks-ass.net>
 <20220916144112.GA29395@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916144112.GA29395@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 07:41:13AM -0700, Ricardo Neri wrote:

> At least on Intel processors, class 0 is a valid class. The scheduler needs to
> have a notion of unclassified tasks and decide how to handle them, IMO.
> 
> Intel processors currently support 8-bit, unsigned classes. I doubt other
> architectures will ever support more than 256 classes. Short can handle all the
> possible classification values and also the unclassified case.
> 
> On the other hand, class 0 could be the default classification unless hardware
> classifies differently. 0 would be special and need to be documented clearly.
> This would work for Intel processors.

You can always do: class = hw_class + 1; that makes 0 'special' and the
hardware class can be trivially reconstructed by subtracting 1.
