Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3663664EA26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiLPLTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiLPLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:19:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD89167E7;
        Fri, 16 Dec 2022 03:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3wRp5ZGx5kiuxjosfiMrA8DF+A0U9qyxpgTwKOxpegg=; b=RBK2OIb9hMLPOkJnVKb076SADP
        GMqJZ9KRts/r0V4Ft5akZTHnoO6h4yT8h4G4Wa74+vsVOyjULxJGhMRDr94NwLl2cRN/Wo/tpXtoB
        E1VgQsvotWFICibrxkyUH6exxohiZ3dzGCHPbaniyGO2nrv+2pU46/fsUpmPwc14p0OpVhCPu1Xf5
        wBdQfw44cY7exj8gzzu5bP3Sk96WFyr9Ra5S+MHXygYxJidrn5NkqN5LhzKc+I77mWe5luGI6LEXn
        uloy72JmtBJT6lcMEMsb8XnK1LDfuEhkhEwKBcsXqLWGLhx5We5UWACViVKKzZg05GAbDxtseggNR
        T1UVN/AQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p68kj-00FOqs-Bn; Fri, 16 Dec 2022 11:19:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF24E300E04;
        Fri, 16 Dec 2022 12:19:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAAC62C539E75; Fri, 16 Dec 2022 12:19:34 +0100 (CET)
Date:   Fri, 16 Dec 2022 12:19:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, frederic@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
Message-ID: <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
 <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:42:59AM -0800, Srinivas Pandruvada wrote:
> +		/* Give ksoftirqd 1 jiffy to get a chance to start its job */
> +		if (!READ_ONCE(it.done) && task_is_running(__this_cpu_read(ksoftirqd))) {
> +			__set_current_state(TASK_UNINTERRUPTIBLE);
> +			schedule_timeout(1);
> +		}

That's absolutely disgusting :-/
