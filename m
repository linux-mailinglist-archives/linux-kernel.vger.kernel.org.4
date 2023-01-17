Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029BA66E5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjAQSSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjAQSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:14:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1684F844;
        Tue, 17 Jan 2023 09:55:04 -0800 (PST)
Date:   Tue, 17 Jan 2023 17:54:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673978098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5gAG4zyi44i/U2VPhKM2izw3dl4jUTO1hKiLKOHNZE=;
        b=kLjJ0YBJv5dQhPkTkqqj/b+ve9EBXYOvIVHAETb1zN43J5PfM4ARKXeQbwrZWAj3s+FJr2
        w6opu9sT82JDHz6nWgm0RpOgl77bQlzG0f3lf0pU0Hq6e/HrIJmSKaz6KBEjeJsAfVpQwH
        mL9NuWK/0MdMs/3VFq7D+8KMsnVxkFj+HIdZRFKdtYpcju4TsZUq7ixF/bEImdsVKXTS4p
        WVG9BEIKhKa3jfM839rqRwJhwtjIIinFWehEYcjkD9lDPd2L68W+POQVPyKnxEc2xWCL/u
        yo4WyDi3gj6A2jKSSRz2DGNN0R1Hc4HTVXo0RvU2+geM8IUqwNXS3DT/AGRf3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673978098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5gAG4zyi44i/U2VPhKM2izw3dl4jUTO1hKiLKOHNZE=;
        b=RP52s0euAx0igtcaDP4h2GderM3mikD8ITObWo0GCyT9jtE7eRH2GbqVx5Mn+Ig66pXWUk
        XbkajuGQefTvm5AA==
From:   "tip-bot2 for Ming Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/affinity: Remove the 'firstvec' parameter from
 irq_build_affinity_masks
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.g.garry@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221227022905.352674-2-ming.lei@redhat.com>
References: <20221227022905.352674-2-ming.lei@redhat.com>
MIME-Version: 1.0
Message-ID: <167397809817.4906.18299720094794858383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     cdf07f0ea48a3b52f924714d477366ac510ee870
Gitweb:        https://git.kernel.org/tip/cdf07f0ea48a3b52f924714d477366ac510ee870
Author:        Ming Lei <ming.lei@redhat.com>
AuthorDate:    Tue, 27 Dec 2022 10:29:00 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 17 Jan 2023 18:50:06 +01:00

genirq/affinity: Remove the 'firstvec' parameter from irq_build_affinity_masks

The 'firstvec' parameter is always same with the parameter of
'startvec', so use 'startvec' directly inside irq_build_affinity_masks().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>                                                                                                                                                                                                    
Link: https://lore.kernel.org/r/20221227022905.352674-2-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d9a5c1d..3361e36 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -337,10 +337,10 @@ static int __irq_build_affinity_masks(unsigned int startvec,
  *	2) spread other possible CPUs on these vectors
  */
 static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
-				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
 	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
+	unsigned int firstvec = startvec;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -463,8 +463,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(curvec, this_vecs,
-					       curvec, masks);
+		ret = irq_build_affinity_masks(curvec, this_vecs, masks);
 		if (ret) {
 			kfree(masks);
 			return NULL;
