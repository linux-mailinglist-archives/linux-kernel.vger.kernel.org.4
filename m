Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7692B5EC209
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiI0MEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiI0MEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:04:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BF59F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pXB424lDn1hFN24n6cTbpmppnRXapviGsBP0Dd9v8gU=; b=coNiGvWlXAt2Mq9+nmtXyp1TGZ
        krR8TYJItVs/xfQ6OkLRHJzUdWInvLCp38xUVCLrga/JgottSFvxL/ClOWzvM/1zFPHvos5xGAVOs
        3SteKqjV6/nbu0mdNkzyFE1YTEKYkyh6CTd4SCogCyzlyyeeNVgmbJfFJp2Z/HawUoXCLwoKBdvOp
        ztI8+F9qUjxnay8Tyqhd6UITv2LSfum0uJaocKtwIVH3n9DcySZ5UlENfenkkOW6rx9B1l4o1U8dG
        jt+kSkEdRZbhsIZEGbApxK+HSk0OXaUf1v6DjczGJtXjRgzFshfSSjl6b8f+lUVvHoIHyLDzn+4uE
        2uTtOd9A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od9Jj-00BPEA-NP; Tue, 27 Sep 2022 12:04:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68D1F3001D6;
        Tue, 27 Sep 2022 14:03:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F5332BDDB522; Tue, 27 Sep 2022 14:03:59 +0200 (CEST)
Date:   Tue, 27 Sep 2022 14:03:59 +0200
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
Subject: Re: [RFC PATCH 22/23] x86/hreset: Configure history reset
Message-ID: <YzLmr/vmYZozeUKm@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-23-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909231205.14009-23-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:12:04PM -0700, Ricardo Neri wrote:

> +static u32 hardware_history_features __read_mostly;

__ro_after_init ?

> +static __always_inline void setup_hreset(struct cpuinfo_x86 *c)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_HRESET))
> +		return;
> +
> +	/*
> +	 * Use on all CPUs the hardware history features that the boot
> +	 * CPU supports.
> +	 */
> +	if (c == &boot_cpu_data)
> +		hardware_history_features = cpuid_ebx(0x20);
> +
> +	if (!hardware_history_features)
> +		return;
> +
> +	wrmsrl(MSR_IA32_HW_HRESET_ENABLE, hardware_history_features);
> +
> +	pr_info_once("x86/cpu: Intel History Reset (HRESET) activated\n");
> +}
> +
>  /* These bits should not change their value after CPU init is finished. */
>  static const unsigned long cr4_pinned_mask =
>  	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
