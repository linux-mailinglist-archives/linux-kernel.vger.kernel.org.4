Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C245FD804
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJMLA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJMLAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:00:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF67160C9D;
        Thu, 13 Oct 2022 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1kt3Nt1T71dSHeBMzhW3EUeOzPlxOUDZLoubcBCIwV8=; b=sGG1MCa6hZQMG59So6zoxk0b3y
        MPNgF7h6vElznfKaZefWySoFCwCy9MeJvjGyqJKlUahKRcHH2zWU/HL5nmF49JHtKOoRdH5UPvHGr
        V0fMjATm/E/JaTWiYG9IKXFxuWfy35cFuQS9WA/Fit2ixtVJFw1tkrzk0K0j+2I9P2S/+fE1fBJPy
        zycy4+djRv7LW0h4qZjCl7e/IR2a2+QhB8GN1bCzdMohAsJxhtV7F5qmf1gfn0sPxJE4/AWk+v8QL
        L/WNd0IEAK+Bblx2F1+phbZTCeBpt99TDmviSxSg587+4Y+g9HoMTT2IUu9Gx1kffFyCVRC26Fkhc
        MdASJ0Bg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oivwR-006ekn-JJ; Thu, 13 Oct 2022 10:59:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CC96300446;
        Thu, 13 Oct 2022 12:59:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB92B2BB8B0C7; Thu, 13 Oct 2022 12:59:49 +0200 (CEST)
Date:   Thu, 13 Oct 2022 12:59:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, ndesaulniers@google.com,
        srw@sladewatkins.net, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2] perf: Rewrite core context handling
Message-ID: <Y0fvpQEEl/tK6mJ5@hirez.programming.kicks-ass.net>
References: <20221008062424.313-1-ravi.bangoria@amd.com>
 <Y0VTn0qLWd925etP@hirez.programming.kicks-ass.net>
 <ba47d079-6d97-0412-69a0-fa15999b5024@amd.com>
 <Y0V3kOWInrvCvVtk@hirez.programming.kicks-ass.net>
 <Y0WsRItHmfI5uaq3@hirez.programming.kicks-ass.net>
 <174fb540-ec18-eeca-191d-c02e1f1005d2@amd.com>
 <Y0awHa8oS5yal5M9@hirez.programming.kicks-ass.net>
 <Y0cn1xazYpNmqhRo@hirez.programming.kicks-ass.net>
 <99caec5f-dcdf-70c6-8909-11552ce42a20@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99caec5f-dcdf-70c6-8909-11552ce42a20@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:37:23PM +0530, Ravi Bangoria wrote:

> > -	refcount_t			refcount;
> > +	refcount_t			refcount; /* event <-> ctx */
> 
> Ok. We need to remove all those // XXX get/put_ctx() from code
> which we added to make refcount a pmu_ctx <-> ctx.

Them already gone :-) I've not yet fixed up the typoes, but current
version should be here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/core

Thanks!
