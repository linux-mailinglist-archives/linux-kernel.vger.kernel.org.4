Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA29711961
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbjEYVnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbjEYVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0BA12C;
        Thu, 25 May 2023 14:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B91464B75;
        Thu, 25 May 2023 21:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC00C433EF;
        Thu, 25 May 2023 21:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051004;
        bh=GDYnOCmR9taeLPi11qkRjJOP5JKJ+SKnVQLPWS9novo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sm66ncKTjd+QyK0/mKdZ2zUyUEX/24G5aM3/NnaMM53ZqmMolOjDQdXnpxWvXkPrZ
         xVdPCE2X+IQA/H5pnFnmzbre0Yi4CuEg6MvoI1KuC4N/YdmtpKGqDH54/x9qKPRBl2
         C3aiKztWzNc62p9d9ceWUBmoiZbFZHmt+kQ3Z2qhmL0zkZbtm9SV+DewauTDlp7SL4
         sIKnTVcDThUbT2aFIP+9Mi2A5QLIPCcKLz2fyJs/mxe/XkVozkH77Xf8NZ8VZRUF13
         Zik9/tM+ygV+5FwhARYsu/xmcOjgGc0MA0bPW5scFNE4SBfH+y+vaIjdtUPz9bF+Q8
         6iD6bMZ2wuNFA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] Docs/mm/damon/design: update the layout based on the layers
Date:   Thu, 25 May 2023 21:43:08 +0000
Message-Id: <20230525214314.5204-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON design document is describing only the operations set layer and
monitoring part of the core logic.  Update the layout based on the
DAMON's layers, so that more parts of DAMON including DAMOS core logic
and DAMON modules can easily be added.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 3b4ce873fa71..eaf52f3a9144 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -19,8 +19,8 @@ DAMON subsystem is configured with three layers including
   interfaces for the user space, on top of the core layer.
 
 
-Configurable Layers
-===================
+Configurable Operations Set
+---------------------------
 
 DAMON provides data access monitoring functionality while making the accuracy
 and the overhead controllable.  The fundamental access monitorings require
@@ -42,8 +42,8 @@ Also, if some architectures or devices support special optimized access check
 primitives, those will be easily configurable.
 
 
-Reference Implementations of Address Space Specific Monitoring Operations
-=========================================================================
+Operations Set Layer
+====================
 
 The monitoring operations are defined in two parts:
 
@@ -105,8 +105,12 @@ conflict with the reclaim logic using ``PG_idle`` and ``PG_young`` page flags,
 as Idle page tracking does.
 
 
-Address Space Independent Core Mechanisms
-=========================================
+Core Logics
+===========
+
+
+Monitoring
+----------
 
 Below four sections describe each of the DAMON core mechanisms and the five
 monitoring attributes, ``sampling interval``, ``aggregation interval``,
@@ -115,7 +119,7 @@ regions``.
 
 
 Access Frequency Monitoring
----------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The output of DAMON says what pages are how frequently accessed for a given
 duration.  The resolution of the access frequency is controlled by setting
@@ -142,7 +146,7 @@ size of the target workload grows.
 
 
 Region Based Sampling
----------------------
+~~~~~~~~~~~~~~~~~~~~~
 
 To avoid the unbounded increase of the overhead, DAMON groups adjacent pages
 that assumed to have the same access frequencies into a region.  As long as the
@@ -159,7 +163,7 @@ assumption is not guaranteed.
 
 
 Adaptive Regions Adjustment
----------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Even somehow the initial monitoring target regions are well constructed to
 fulfill the assumption (pages in same region have similar access frequencies),
@@ -178,7 +182,7 @@ keeping the bounds users set for their trade-off.
 
 
 Dynamic Target Space Updates Handling
--------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The monitoring target address range could dynamically changed.  For example,
 virtual memory could be dynamically mapped and unmapped.  Physical memory could
-- 
2.25.1

