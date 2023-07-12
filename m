Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62AE750BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjGLPDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjGLPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39611BD1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689174165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kvr3qVn5V77zWJcaKe9AHXcXT+HniwXcgFa7KzwlkrU=;
        b=MUiYwIw39nK7k6M6tGbYRHxq/xau24PSMttYtddLkry2R/bLX5N6+GgVg9c/D6VBZ088fA
        VIE+IKZBsocKhWkpZ69vYBRgOa2wMJ0WGfw+j4AdJ29mUhJNxwL10s98NScAJmyDfIfuY/
        LWA2oyvc6aDwX1870C5pBXnSRzaoEBs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-6giLTuT6OGielh0qdwSoLg-1; Wed, 12 Jul 2023 11:02:44 -0400
X-MC-Unique: 6giLTuT6OGielh0qdwSoLg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76783ba6d62so821944685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174164; x=1691766164;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvr3qVn5V77zWJcaKe9AHXcXT+HniwXcgFa7KzwlkrU=;
        b=Q+w04a6bFzRxTxkPBEtnbjWNjsAMtN4KSO+uLLm+kbflSFQd0bqYPexkaUNoDv7Wiz
         WHMvgqdinKxsOpDTKRIkMAPyBO4pdS+6aFgCUAkBPG9HCewlqrqdWiAQ60HGFhNxjp2A
         K+UgAujtMeehJAdgzM5kLk8K4ORnMH9Osb8D3TKPtzlSnBtKgE6lxZDsbxj+tkIJ75av
         GcIwqy+gY++dz8ZQmti5UMcNo22uKnTNYdYcKuCH7mV5euPrB7HvZln08ZgaSsnt07M/
         BX10mas0/ym7AFJAeIH6O/x9PsRjQu8ZhfpEpsfk/xA51Tl31dmPQe13HTDUa9UTQBtG
         DifQ==
X-Gm-Message-State: ABy/qLYXKVVzLqQHIB+FcJ1S8wAdQzL/us6gfMOlbhkYStCFprWuhslp
        l9XRLK+EKi44sKdfX9RKDsH2ggQyYoOEbE03lZxtzmdU2XWu/U2UAkzNr7lfBhxcN1ZW+U07uEA
        8QsW38KDsf5mk30rANmTuiGb9
X-Received: by 2002:a0c:e545:0:b0:636:2169:4298 with SMTP id n5-20020a0ce545000000b0063621694298mr15517849qvm.1.1689174163863;
        Wed, 12 Jul 2023 08:02:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH++qRRrnEHCZes7rTAj13UdiM5e25ZcfTV6Uk9SSKDV/YGCPR9BTbMWih8KQjwtk707jkosQ==
X-Received: by 2002:a0c:e545:0:b0:636:2169:4298 with SMTP id n5-20020a0ce545000000b0063621694298mr15517822qvm.1.1689174163605;
        Wed, 12 Jul 2023 08:02:43 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id o6-20020a0ccb06000000b0062ff0dd0332sm2251154qvk.38.2023.07.12.08.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:02:43 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC][PATCH] sched: Rename DIE domain
In-Reply-To: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
References: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
Date:   Wed, 12 Jul 2023 16:02:38 +0100
Message-ID: <xhsmh1qhduq9d.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/23 16:10, Peter Zijlstra wrote:
> Hi
>
> Thomas just tripped over the x86 topology setup creating a 'DIE' domain
> for the package mask :-)
>
> Since these names are SCHED_DEBUG only, rename them.
> I don't think anybody *should* be relying on this, but who knows.
>

FWIW I don't care much about the actual name.

There are some stray references to DIE in comments - see below. Bit funny
to see:
- *  - Package (DIE)
+ *  - Package (PKG)

With that:
Acked-by: Valentin Schneider <vschneid@redhat.com>

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2a..190a647534984 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9439,7 +9439,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
  * imbalances in the number of CPUS are dealt with in find_busiest_group().
  *
- * If we are balancing load within an SMT core, or at DIE domain level, always
+ * If we are balancing load within an SMT core, or at PKG domain level, always
  * proceed.
  *
  * Return: true if @env::dst_cpu can do with asym_packing load balance. False
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e9d9cf776b7ab..2cdcfec1d1c89 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1118,7 +1118,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
  *
  *  - Simultaneous multithreading (SMT)
  *  - Multi-Core Cache (MC)
- *  - Package (DIE)
+ *  - Package (PKG)
  *
  * Where the last one more or less denotes everything up to a NUMA node.
  *
@@ -1140,13 +1140,13 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
  *
  * CPU   0   1   2   3   4   5   6   7
  *
- * DIE  [                             ]
+ * PKG  [                             ]
  * MC   [             ] [             ]
  * SMT  [     ] [     ] [     ] [     ]
  *
  *  - or -
  *
- * DIE  0-7 0-7 0-7 0-7 0-7 0-7 0-7 0-7
+ * PKG  0-7 0-7 0-7 0-7 0-7 0-7 0-7 0-7
  * MC	0-3 0-3 0-3 0-3 4-7 4-7 4-7 4-7
  * SMT  0-1 0-1 2-3 2-3 4-5 4-5 6-7 6-7
  *

