Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DBA5FC19D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJLIF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJLIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:05:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D5D2ED71
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bEh9Pd3MDqJD5jn5B5Zhbaid1G7o0Yr+8S2seXposuc=; b=s9rPBA1a2K7sWWHVDxAQwEP/Ac
        IQgkPc4YhYsj0fpPws3vjaBWZJp6YfUG/cvcMqRjYPxdbnyH78jgkHkd/p/dD+k0aatEJnWHa11Dy
        7qyfikDnz7Zaf3pLJeTXCdl99Gx3m3PtJZx6KHvk7+7r5uj2qifaWHCWdN+sZ08coYXV3eDgtg3z5
        66pnM+NimshZkVI0jaiGdaMjmCrTnHCijvxjAB8APV4y/WPG5fleDMwWtejlL1RQ+erc3/JETn0IW
        UlFD+97bKSAUNleaFEXjpTk64l+7Q1erwCjPkC1a7HQEdRG6TyjpAoPFkN/gG7gR2L2wCEBZxdB2q
        IvnOzd5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiWjc-005fHu-8O; Wed, 12 Oct 2022 08:05:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CFC030008D;
        Wed, 12 Oct 2022 10:04:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62A2320E1D7DB; Wed, 12 Oct 2022 10:04:54 +0200 (CEST)
Date:   Wed, 12 Oct 2022 10:04:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH V2 2/6] perf/x86/intel/pebs: Fix PEBS timestamps
 overwritten
Message-ID: <Y0Z1Jr2jtrrAN5L+@hirez.programming.kicks-ass.net>
References: <20220901130959.1285717-1-kan.liang@linux.intel.com>
 <20220901130959.1285717-3-kan.liang@linux.intel.com>
 <CAM9d7cgWDVAq8-11RbJ2uGfwkKD6fA-OMwOKDrNUrU_=8MgEjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgWDVAq8-11RbJ2uGfwkKD6fA-OMwOKDrNUrU_=8MgEjg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 11:20:54AM -0700, Namhyung Kim wrote:

> One thing I noticed is that the system has a config option
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y.

You can't build x86 without that.
