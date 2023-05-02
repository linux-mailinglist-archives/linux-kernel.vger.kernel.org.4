Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF196F475E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjEBPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjEBPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:37:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD04E7;
        Tue,  2 May 2023 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IN2XFj5wbX0SEj5WPNdCLS4YOUJ8lCRfIxHwS3n4SLM=; b=UvuPnIHH2ZyTeqEaGBAbZmphIi
        KcpDfy+hpLBTVcWQ7wLzysRwgLAudR+uL1BjCQXdNFPJczSrebqoqBZYsbsnGVf3FvhY6ZHyIGOfh
        cgr0vb95jSA/lnHogagj3dKhkvKuALD/+nhCiZrNww0+Zz12rwTWOUuOu4q4vy8ZqPgbn4AYh9ctP
        hzBKIhAjRlrKWEfmNN8Ddm/HjEUDx5AGwqbwrP/8U/jOFlrkUuAOTngENxnFvpm+unxat/5nHqYMM
        HMrPx7w4yT6/3up9pMZIWT1TgDrBq7LLS2lQC1o6TwHm1/qNGZKSxH5OMTEbTbMwmz5rZotvPskAh
        /YH6kYZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pts3r-00GLIL-0i;
        Tue, 02 May 2023 15:37:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B2CD3002BF;
        Tue,  2 May 2023 17:37:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1250530375740; Tue,  2 May 2023 17:37:02 +0200 (CEST)
Date:   Tue, 2 May 2023 17:37:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v3 2/3] perf/ibs: Fix interface via core pmu events
Message-ID: <20230502153701.GF1597538@hirez.programming.kicks-ass.net>
References: <20230425142205.762-1-ravi.bangoria@amd.com>
 <20230425142205.762-3-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425142205.762-3-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 07:52:04PM +0530, Ravi Bangoria wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 151299940d9a..232121a6d1e2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11648,16 +11648,6 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  		goto unlock;
>  	}
>  
> -	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
> -		ret = perf_try_init_event(pmu, event);
> -		if (!ret)
> -			goto unlock;
> -
> -		if (ret != -ENOENT) {
> -			pmu = ERR_PTR(ret);
> -			goto unlock;
> -		}
> -	}
>  fail:
>  	pmu = ERR_PTR(-ENOENT);
>  unlock:

Would it make sense to put the above and the below cleanup in a separate
patch after this?

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11631,25 +11631,24 @@ static struct pmu *perf_init_event(struc
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
-	if (pmu) {
-		if (event->attr.type != type && type != PERF_TYPE_RAW &&
-		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-			goto fail;
-
-		ret = perf_try_init_event(pmu, event);
-		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
-			type = event->attr.type;
-			goto again;
-		}
+	if (!pmu)
+		goto unlock;
 
-		if (ret)
-			pmu = ERR_PTR(ret);
+	ret = -ENOENT;
+	if (event->attr.type != type && type != PERF_TYPE_RAW &&
+	    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+		goto fail;
 
-		goto unlock;
+	ret = perf_try_init_event(pmu, event);
+	if (ret == -ENOENT && event->attr.type != type && !extended_type) {
+		type = event->attr.type;
+		goto again;
 	}
 
 fail:
-	pmu = ERR_PTR(-ENOENT);
+	if (ret)
+		pmu = ERR_PTR(ret);
+
 unlock:
 	srcu_read_unlock(&pmus_srcu, idx);
 
