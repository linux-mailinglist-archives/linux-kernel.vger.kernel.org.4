Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F5E711959
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbjEYVn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjEYVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC3012C;
        Thu, 25 May 2023 14:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 615AD64B71;
        Thu, 25 May 2023 21:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DB8C4339B;
        Thu, 25 May 2023 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051001;
        bh=hVFyQUZN1gcvG6t3Dpq635c426eBMKWXinhJ3HGYh9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGI9nQarh6/dDMgWqzLaHz2tcFxHEP3FNk3dJo770kxOgy8E0LJyKAqlE+8jo5Iz7
         i1gdU/pd6W2jdEXcJru8gg5rlqj9E45F1fCDuQrxTcO5pnOKEUwGjm+1FkxK4Xje9E
         rIstQEBLmrKi1/p3JTjltsB0DJRnx+6PTnB7SSxulUpBkLLqNXOof1II5O73QtnHMf
         Auoe2QSPd8MXvUeutyKUrr57FVkUT9ujcnYjjm0IQ2rChSTKMJk449mIHEOBcc3nII
         kjX50inG7/9hu/5DIb2MKMSXYvHO+KTXbg3InDmIR6bxFsoDsRhMxBZwGRIivtd4Sc
         r79YnXhY6S1wg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] Docs/mm/damon/faq: remove old questions
Date:   Thu, 25 May 2023 21:43:05 +0000
Message-Id: <20230525214314.5204-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two questions of DAMON faqs have raised when DAMON patches
were first submitted.  More than one year has passed since DAMON patches
get merged in the mainline, and that kind of questions are not asked
nowadays.  Remove the questions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/faq.rst | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/Documentation/mm/damon/faq.rst b/Documentation/mm/damon/faq.rst
index dde7e2414ee6..3279dc7a8211 100644
--- a/Documentation/mm/damon/faq.rst
+++ b/Documentation/mm/damon/faq.rst
@@ -4,29 +4,6 @@
 Frequently Asked Questions
 ==========================
 
-Why a new subsystem, instead of extending perf or other user space tools?
-=========================================================================
-
-First, because it needs to be lightweight as much as possible so that it can be
-used online, any unnecessary overhead such as kernel - user space context
-switching cost should be avoided.  Second, DAMON aims to be used by other
-programs including the kernel.  Therefore, having a dependency on specific
-tools like perf is not desirable.  These are the two biggest reasons why DAMON
-is implemented in the kernel space.
-
-
-Can 'idle pages tracking' or 'perf mem' substitute DAMON?
-=========================================================
-
-Idle page tracking is a low level primitive for access check of the physical
-address space.  'perf mem' is similar, though it can use sampling to minimize
-the overhead.  On the other hand, DAMON is a higher-level framework for the
-monitoring of various address spaces.  It is focused on memory management
-optimization and provides sophisticated accuracy/overhead handling mechanisms.
-Therefore, 'idle pages tracking' and 'perf mem' could provide a subset of
-DAMON's output, but cannot substitute DAMON.
-
-
 Does DAMON support virtual memory only?
 =======================================
 
-- 
2.25.1

