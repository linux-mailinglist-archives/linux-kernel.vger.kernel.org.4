Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552CE6FDF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbjEJNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbjEJNtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B5449C;
        Wed, 10 May 2023 06:49:18 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvTe2KWi0j0LWLx4UMP4SOKhlBq4JwIPfjz/2XNZiUs=;
        b=3CRtUOW3B5jbYWO8jIvNd3po3sfgMlv15pam8S3hWykhWS8QsnvnudVI1gYsYEgZjmIaoa
        ovU0df4h3vvkKmF6K06fqlDkxi85luu6fbA3PQtDuwsQk89WeLLfhwdZ5W/1UpNinE67dN
        muCSz84Tpr878EOd76DF5zkO3z8kHR+IGQYa+za9dzGUKo0PIKss9n8G0fwbCSqaMtuPBa
        vAin8T/AEp+0bT/SUMmXuULRwbVsuodXGiXuyqIwOQmB/KWqm0te8D7vCthdC2XlKnjQJ7
        tX9MAd1X8lXb7hDtENGAqeJhHvvHtGmiZzX5nWDbPIbM7/W9Jlnysj0PE5+yAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvTe2KWi0j0LWLx4UMP4SOKhlBq4JwIPfjz/2XNZiUs=;
        b=6KM1mX3/SWFtga4hfaY04qmdVvD2dpzTGsDqd3qXoRGvbtQfHP+GNwadopa98zSog3OYw4
        l9hHPfzbMw4uaVCQ==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Remove SHARED_CHILD from ASYM_PACKING
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-10-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-10-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655168.404.2208152058819623598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ca528cc501896a808dc79c3c0544369d23b331c8
Gitweb:        https://git.kernel.org/tip/ca528cc501896a808dc79c3c0544369d23b331c8
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:45 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:37 +02:00

sched/topology: Remove SHARED_CHILD from ASYM_PACKING

Only x86 and Power7 use ASYM_PACKING. They use it differently.

Power7 has cores of equal priority, but the SMT siblings of a core have
different priorities. Parent scheduling domains do not need (nor have) the
ASYM_PACKING flag. SHARED_CHILD is not needed. Using SHARED_PARENT would
cause the topology debug code to complain.

X86 has cores of different priority, but all the SMT siblings of the core
have equal priority. It needs ASYM_PACKING at the MC level, but not at the
SMT level (it also needs it at upper levels if they have scheduling groups
of different priority). Removing ASYM_PACKING from the SMT domain causes
the topology debug code to complain.

Remove SHARED_CHILD for now. We still need a topology check that satisfies
both architectures.

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-10-ricardo.neri-calderon@linux.intel.com
---
 include/linux/sched/sd_flags.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 57bde66..fad77b5 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -132,12 +132,9 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 /*
  * Place busy tasks earlier in the domain
  *
- * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
- *               up, but currently assumed to be set from the base domain
- *               upwards (see update_top_cache_domain()).
  * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
+SD_FLAG(SD_ASYM_PACKING, SDF_NEEDS_GROUPS)
 
 /*
  * Prefer to place tasks in a sibling domain
