Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1325EC203
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiI0MBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiI0MA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:00:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80A14FE2F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4LgJr/QYXmxBnVVctWMA0X5/dO2VSHradCK/BPcROEg=; b=jXmTh1VdmO1TsUShnPRysUOsr3
        Z8vfm0J+ijfbwRIaJ36PXyYysADC+sp6uK5jAH3r0/hT+SBKfjdvfAEgc9icLAAe/f73IETU8kcYV
        UGu9Ci0Gy2bWh+UlWTezIboyzF3clWJHjAn8NIwRy8xM2U/GVct9NSgJCP8Y7qPBNOfZ+tRV+WUyg
        OP83B56wUfNyn9m+1xlAXjU6vsjnKMb4yDaWGDzX2TzUYw3UpsmjD0Ny++GTS4V1ymqMcbjnC+YCH
        OpS7n9C6CZWcjlROhp3CyINyUvZPAB/Dc+C5dc609JOH9ilpKZ6Svs9OH2lgk9QIe74KTH9PJG+8b
        HuYGSoyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od9GS-00GHRs-8p; Tue, 27 Sep 2022 12:00:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D94533001D6;
        Tue, 27 Sep 2022 14:00:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C95042BDDB523; Tue, 27 Sep 2022 14:00:39 +0200 (CEST)
Date:   Tue, 27 Sep 2022 14:00:39 +0200
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
Subject: Re: [RFC PATCH 17/23] thermal: intel: hfi: Enable the Intel Thread
 Director
Message-ID: <YzLl5+yMUrrGiphr@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-18-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909231205.14009-18-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:11:59PM -0700, Ricardo Neri wrote:

> +config INTEL_THREAD_DIRECTOR
> +	bool "Intel Thread Director"
> +	depends on INTEL_HFI_THERMAL
> +	depends on SMP
> +	select SCHED_TASK_CLASSES
> +	help
> +	  Select this option to enable the Intel Thread Director. If selected,
> +	  hardware classifies tasks based on the type of instructions they
> +	  execute. It also provides performance capabilities for each class of
> +	  task. On hybrid processors, the scheduler uses this data to place
> +	  tasks of classes of higher performance on higher-performnance CPUs.

Do we really need yet another CONFIG symbol for all this!? AFAICT this
Thread Director crud simply extends the HFI table and doesn't actually
carry that much code with it.

Best to always have it on when HFI is on, no?
