Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4D1654569
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiLVQ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLVQ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:57:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6721215F3D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671728215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQbiQgVa8Sd+/Pe5VdbOI63fL3/bgCZNkjMcKwZRP68=;
        b=FiwpMrA7P1S/stReRsh+BeuQNqEP+3k25ttoGc+2GI3mdwSCQqBnU9t9wsyyTZYjk0eSBF
        7EVtnGDg1Y3zCtBtjto5Gz90/OdsvFrwY4FmCmbxOGNbiLeN14Moe+PjH9ps3twqT+IZqs
        1pTw3EbhXaf7e5Hau3lAGnUIR3zlDCY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-511-1Wc5JLECP1W_W5miONW82g-1; Thu, 22 Dec 2022 11:56:54 -0500
X-MC-Unique: 1Wc5JLECP1W_W5miONW82g-1
Received: by mail-wm1-f70.google.com with SMTP id h126-20020a1c2184000000b003d96bdce12fso210830wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQbiQgVa8Sd+/Pe5VdbOI63fL3/bgCZNkjMcKwZRP68=;
        b=Jap4adEykqByOKD85WHs66AS08FGO/o9gIxG7badg/1fSm4y25xFeVeFP2IE6Vu0GU
         KVpuPeqZ2kn+lRcYyf4Q00c+c3NUQ8nRkRrEwslYtXt9q46mhzgIF436BbLTiPkcCNuV
         SmFQP3vd51xDBr6k71jrq5FRbEMiCTpfa3F62QWNHU29DPbnMsR2/Y3c2gmpC64MozvP
         Eq6oSs5/7EwN3FVtsDymUjJBnWmwXk/j5ZkRo+iEDusQuTxQm8OY2eyisdCV/8H0Apkf
         ClADCTgNDaQzatbIzjG7muLLK6SHOZSm2vTZ2MrOClBcdotkEGliodhvsU6lvcj+g1K5
         B7YQ==
X-Gm-Message-State: AFqh2koXh8W+aKlVCE5V98TrylAYw8RJjcS99Ok+kBH7u45oTFBe9Bbu
        Uc6pNHJlP366xNgiSTxA4cmez52Kjh4SY6tSEaPSGQUe13vjHzitjpFa3IqlUqwoXHj5OzATeph
        KDx5v+5myMr2FPYU+xWsBMVk5
X-Received: by 2002:a05:600c:154b:b0:3cf:674a:aefe with SMTP id f11-20020a05600c154b00b003cf674aaefemr4724713wmg.22.1671728213068;
        Thu, 22 Dec 2022 08:56:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuOZOe9BJd7XkAbkJc+rkQYeIs2MCsgTmWjd7D8H2aHQPtv06n5zjhQyRVO8OYHzIpRlu/3LA==
X-Received: by 2002:a05:600c:154b:b0:3cf:674a:aefe with SMTP id f11-20020a05600c154b00b003cf674aaefemr4724695wmg.22.1671728212900;
        Thu, 22 Dec 2022 08:56:52 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003c71358a42dsm8768201wms.18.2022.12.22.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 08:56:52 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 5/7] x86/sched: Remove SD_ASYM_PACKING from the "SMT"
 domain
In-Reply-To: <20221220004238.GB23844@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
 <Y5IKuJTjE6Pjrw9I@arm.com>
 <20221214165900.GA972@ranerica-svr.sc.intel.com>
 <xhsmhwn6s62b5.mognet@vschneid.remote.csb>
 <20221220004238.GB23844@ranerica-svr.sc.intel.com>
Date:   Thu, 22 Dec 2022 16:56:51 +0000
Message-ID: <xhsmhr0wre5rg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/22 16:42, Ricardo Neri wrote:
> On Thu, Dec 15, 2022 at 04:48:14PM +0000, Valentin Schneider wrote:
>> With that said, so far all but one flag (SD_PREFER_SIBLING, and that's
>> because of big.LITTLE woes) follow the SDF_SHARED_{CHILD, PARENT} pattern,
>> if SD_ASYM_PACKING no longer does then we need to think whether we're
>> trying to make it do funky things.
>
> My thesis is that x86 does not need the SD_ASYM_PACKING flag at the SMT
> level because all SMT siblings are identical. There are cores of higher
> priority at the "MC" level (maybe in the future at the "CLS" level).
>
> Power7 is fine because it only uses SD_ASYM_PACKING at the SMT level.
>

So with what I groked from your series, I agree with you, x86 shouldn't
need it at SMT level.

What about the below?

---

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 57bde66d95f7a..8dc16942135b4 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -132,12 +132,12 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 /*
  * Place busy tasks earlier in the domain
  *
- * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
- *               up, but currently assumed to be set from the base domain
- *               upwards (see update_top_cache_domain()).
+ * SHARED_PARENT: Usually set on the SMT level. Can be set further up if all
+ *                siblings of an SMT core are identical, but SMT cores themselves
+ *                have different priorites.
  * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
+SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * Prefer to place tasks in a sibling domain
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1d338a740e56..2d532e29373b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1772,6 +1772,19 @@ queue_balance_callback(struct rq *rq,
 	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
 			__sd; __sd = __sd->parent)
 
+static inline struct sched_domain *__highest_flag_domain(struct sched_domain *sd, int flag)
+{
+	struct sched_domain *hsd = NULL;
+
+	for (; sd; sd = sd->parent) {
+		if (!(sd->flags & flag))
+			break;
+		hsd = sd;
+	}
+
+	return hsd;
+}
+
 /**
  * highest_flag_domain - Return highest sched_domain containing flag.
  * @cpu:	The CPU whose highest level of sched domain is to
@@ -1783,15 +1796,7 @@ queue_balance_callback(struct rq *rq,
  */
 static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
 {
-	struct sched_domain *sd, *hsd = NULL;
-
-	for_each_domain(cpu, sd) {
-		if (!(sd->flags & flag))
-			break;
-		hsd = sd;
-	}
-
-	return hsd;
+	return __highest_flag_domain(rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd), flag);
 }
 
 static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
@@ -1806,6 +1811,16 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 	return sd;
 }
 
+static inline struct sched_domain *highest_parent_flag_domain(int cpu, int flag)
+{
+	struct sched_domain *sd;
+
+	SCHED_WARN_ON(!(sd_flag_debug[ilog2(flag)].meta_flags & SDF_SHARED_PARENT));
+
+	sd = lowest_flag_domain(cpu, flag);
+	return __highest_flag_domain(sd, flag);
+}
+
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8154ef590b9f8..4e0e5b27c331b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -692,7 +692,7 @@ static void update_top_cache_domain(int cpu)
 	sd = lowest_flag_domain(cpu, SD_NUMA);
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
-	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
+	sd = highest_parent_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
 
 	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY_FULL);

