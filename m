Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B8D722324
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjFEKOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjFEKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:14:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA84EE;
        Mon,  5 Jun 2023 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b2pSoZ2MVUP/2fRl3RLOjQHQ8caqiz3LxI4BQNfXXW8=; b=p+GOH75Gz7cgdwRri2QfcUQqj4
        4cOul7CanwFNKbNANL2U1MKV/ugc2zuCxoPZq7e5MRkcKvsPecTSPQK9Vd6vqHKHpswCX45l8ybay
        p0Ib4N16+cqKnj0otiwB8PxWpINGyMrjCtiwXIOAr+I0AbbSe7amnThBgGw1h+0dC+BsLduTSnU3R
        AaMjDUX4fxM/bQC+zJw4L/trRMRmy7Z3C/mz+yyLLgzWCA7x/5sF9N61DXp8DwvJ5QbjOtUixNtIF
        jcAB6HPAXgNqJpjRZW2VPWkJuenRXBiEvfnc3DbqKR96Ffig3uhTuhb5FW0b8x7r8OKqZvNOtOwP3
        vneD+wGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q67Dt-003KYD-2n;
        Mon, 05 Jun 2023 10:14:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55C8D300188;
        Mon,  5 Jun 2023 12:14:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A7D7244F040F; Mon,  5 Jun 2023 12:14:01 +0200 (CEST)
Date:   Mon, 5 Jun 2023 12:14:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Message-ID: <20230605101401.GL38236@hirez.programming.kicks-ass.net>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
 <20230605092731.GZ4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605092731.GZ4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 11:27:31AM +0200, Peter Zijlstra wrote:

> That said; given that this commit has been tagged twice now, I suppose I
> should go revert it and we'll try again after a more thorough audit.

I'll go queue this then...

---
Subject: perf: Re-instate the linear PMU search
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Jun  5 11:42:39 CEST 2023

Full revert of commit 9551fbb64d09 ("perf/core: Remove pmu linear
searching code").

Some architectures (notably arm/arm64) still relied on the linear
search in order to find the PMU that consumes
PERF_TYPE_{HARDWARE,HW_CACHE,RAW}.

This will need a more thorought audit and clean.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11630,27 +11630,38 @@ static struct pmu *perf_init_event(struc
 	}
 
 again:
-	ret = -ENOENT;
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
-	if (!pmu)
-		goto fail;
+	if (pmu) {
+		if (event->attr.type != type && type != PERF_TYPE_RAW &&
+		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+			goto fail;
+
+		ret = perf_try_init_event(pmu, event);
+		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
+			type = event->attr.type;
+			goto again;
+		}
 
-	if (event->attr.type != type && type != PERF_TYPE_RAW &&
-	    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-		goto fail;
-
-	ret = perf_try_init_event(pmu, event);
-	if (ret == -ENOENT && event->attr.type != type && !extended_type) {
-		type = event->attr.type;
-		goto again;
+		if (ret)
+			pmu = ERR_PTR(ret);
+
+		goto unlock;
 	}
 
+	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
+		ret = perf_try_init_event(pmu, event);
+		if (!ret)
+			goto unlock;
+
+		if (ret != -ENOENT) {
+			pmu = ERR_PTR(ret);
+			goto unlock;
+		}
+	}
 fail:
-	if (ret)
-		pmu = ERR_PTR(ret);
-
+	pmu = ERR_PTR(-ENOENT);
 unlock:
 	srcu_read_unlock(&pmus_srcu, idx);
 
