Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327DB711962
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbjEYVnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjEYVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2FF134;
        Thu, 25 May 2023 14:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4846764B7C;
        Thu, 25 May 2023 21:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A86C433AA;
        Thu, 25 May 2023 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051004;
        bh=kRx7Ql+X4ob3mmhrjF9h89mhxljZdGi0sjiE1FJX5Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRtNgrzlQpPWHCCJkCxIGW1T5QYX30ZV8PyfpuCpNijZF9fG2o9gwhI6hI1HuJuXB
         hEwvfN7QVmwNyqjHfLLBfdaSIwkwvAeh4ai3YycdDhNdLrn/guKnvJYpJxeSa1o32c
         m2WjEJiDsMxQNDzClBhV3o2/T/UchbSiFGGtIQ+d0lsE1tOsOIlXxCuEgOEhMSMPla
         JQJBV6ZYCoZXflk0PqwtzFGyYe6sLxQAQ7MU1tQjmuPzm2vL+AiCHkc4D7ehrXqizE
         HD1eVdUSAJxbUwSnSU5CRNkR6EqAb+1My+CxxAybPlhXoNzE+GHkvt7oYzk5/Nb5Bk
         kz20ij5EG1pUQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] Docs/mm/damon/design: rewrite configurable layers
Date:   Thu, 25 May 2023 21:43:09 +0000
Message-Id: <20230525214314.5204-6-sj@kernel.org>
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

The 'Configurable Operations Set' section is a little bit outdated.
Update the text.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index eaf52f3a9144..4a22bab124cf 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -22,24 +22,23 @@ DAMON subsystem is configured with three layers including
 Configurable Operations Set
 ---------------------------
 
-DAMON provides data access monitoring functionality while making the accuracy
-and the overhead controllable.  The fundamental access monitorings require
-primitives that dependent on and optimized for the target address space.  On
-the other hand, the accuracy and overhead tradeoff mechanism, which is the core
-of DAMON, is in the pure logic space.  DAMON separates the two parts in
-different layers and defines its interface to allow various low level
-primitives implementations configurable with the core logic.  We call the low
-level primitives implementations monitoring operations.
-
-Due to this separated design and the configurable interface, users can extend
-DAMON for any address space by configuring the core logics with appropriate
-monitoring operations.  If appropriate one is not provided, users can implement
-the operations on their own.
+For data access monitoring and additional low level work, DAMON needs a set of
+implementations for specific operations that are dependent on and optimized for
+the given target address space.  On the other hand, the accuracy and overhead
+tradeoff mechanism, which is the core logic of DAMON, is in the pure logic
+space.  DAMON separates the two parts in different layers, namely DAMON
+Operations Set and DAMON Core Logics Layers, respectively.  It further defines
+the interface between the layers to allow various operations sets to be
+configured with the core logic.
+
+Due to this design, users can extend DAMON for any address space by configuring
+the core logic to use the appropriate operations set.  If any appropriate set
+is unavailable, users can implement one on their own.
 
 For example, physical memory, virtual memory, swap space, those for specific
 processes, NUMA nodes, files, and backing memory devices would be supportable.
-Also, if some architectures or devices support special optimized access check
-primitives, those will be easily configurable.
+Also, if some architectures or devices supporting special optimized access
+check primitives, those will be easily configurable.
 
 
 Operations Set Layer
-- 
2.25.1

