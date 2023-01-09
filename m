Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4E662C13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjAIRDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbjAIRCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:02:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E2F4102D;
        Mon,  9 Jan 2023 09:02:12 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:02:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZm38wdW5+QOVUucpdsdwwl/TOi/yt5E1upu2Li1qCY=;
        b=cCBUL4x8HGnC62fOlgO8uitWTXVGHQWj/puqUAxMxTsQXYmLfMfE8iFyBS/45oFCJBGPYz
        XdaR43tfZ7Ew3w/kWtP0RGav70RY7Fq4ZRyIKlTRpfJbF3EwoZesH55um+9MwJ2jNISZ/t
        Ofqm1aR25afDcAmYm1NdRLramtcTlNdCPzqibjTIIqoVeeYBSS46Ve3IAgbL6DOBvDTy0Z
        fFmwjX9ywPn0ENlKZlAqIPa9cpBmT3589I4HELpI0Ur1gcfD9A4LngpWVWgmnOfguR+S9q
        jY4uCQDg3zSlLfTuZ/yKHpdYSpoMcKfpCECSdn6Qt3/enOF0BQnv6odzfZQmzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZm38wdW5+QOVUucpdsdwwl/TOi/yt5E1upu2Li1qCY=;
        b=Rr4qhwltgqwkvwPOscWkOznZ3pv9gLBkWOA6fZcDQGmI8uRgkdHRBsbqq2J8iqK6mRmJAr
        0aChjyrPlkdWsTAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add PMU_FORMAT_ATTR_SHOW
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230104201349.1451191-1-kan.liang@linux.intel.com>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167328372960.4906.10711570935052964699.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b6c00fb9949fbd073e651a77aa75faca978cf2a6
Gitweb:        https://git.kernel.org/tip/b6c00fb9949fbd073e651a77aa75faca978cf2a6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 Jan 2023 12:13:41 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:22:07 +01:00

perf: Add PMU_FORMAT_ATTR_SHOW

The macro PMU_FORMAT_ATTR facilitates the definition of both the "show"
function and "format_attr". But it only works for a non-hybrid platform.
For a hybrid platform, the name "format_attr_hybrid_" is used.

The definition of the "show" function can be shared between a non-hybrid
platform and a hybrid platform. Add a new macro PMU_FORMAT_ATTR_SHOW.

No functional change. The PMU_FORMAT_ATTR_SHOW will be used in the
following patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230104201349.1451191-1-kan.liang@linux.intel.com
---
 include/linux/perf_event.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c6a3bac..ad92ad3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1724,7 +1724,7 @@ static struct perf_pmu_events_attr _var = {				    \
 		  .id = _id, }						\
 	})[0].attr.attr)
 
-#define PMU_FORMAT_ATTR(_name, _format)					\
+#define PMU_FORMAT_ATTR_SHOW(_name, _format)				\
 static ssize_t								\
 _name##_show(struct device *dev,					\
 			       struct device_attribute *attr,		\
@@ -1733,6 +1733,9 @@ _name##_show(struct device *dev,					\
 	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
 	return sprintf(page, _format "\n");				\
 }									\
+
+#define PMU_FORMAT_ATTR(_name, _format)					\
+	PMU_FORMAT_ATTR_SHOW(_name, _format)				\
 									\
 static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
 
