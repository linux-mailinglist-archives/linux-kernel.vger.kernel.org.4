Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1943264394A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiLEXJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiLEXI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:08:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9A6544;
        Mon,  5 Dec 2022 15:08:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2DBBCCE1347;
        Mon,  5 Dec 2022 23:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54E3C433B5;
        Mon,  5 Dec 2022 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670281722;
        bh=r1rD9KyNMBqJg8aGe8o3Z8JXG+myDQ882BtgLSHPqNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpC/jo3FRVmu71R9MEs5kfN81AQUSgkCo1RtoY8sR8M5AhiTlSFop6eidAkEL500R
         3WWeMUWcyVAticHGeqK/2aoP8zJ2gfXDWFu0DRK+hzXV2/39r+iQZYfw63lsFkytSN
         wOQZ5WYoYuankdXi/+EmB2YQYxAiySX71ZEFP5fi870/7LjhHr9MA18flwOrJ3jfAU
         deKq/xJ+DW/jCprrJLiuNPeBq/OuVw/y5UTtOZ6Q2bVccJDKKRGeXg5n55Rl2VfBSN
         6Vb0MObMeDp4t09OaVDRWiRflX+wMpfxXXb6pqRqdmoXfABnsVMwFcPmCptnviYamo
         +bBIg9JrEMXgQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 10/11] Docs/admin-guide/mm/damon/usage: document DAMOS filters of sysfs
Date:   Mon,  5 Dec 2022 23:08:29 +0000
Message-Id: <20221205230830.144349-11-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205230830.144349-1-sj@kernel.org>
References: <20221205230830.144349-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document about the newly added files for DAMOS filters on the DAMON
usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 48 +++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 1a5b6b71efa1..3d82ca6a17ff 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -87,6 +87,8 @@ comma (","). ::
     │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
+    │ │ │ │ │ │ │ filters/nr_filters
+    │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
     │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
     │ │ │ │ │ │ │ tried_regions/
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
@@ -151,6 +153,8 @@ number (``N``) to the file creates the number of child directories named as
 moment, only one context per kdamond is supported, so only ``0`` or ``1`` can
 be written to the file.
 
+.. _sysfs_contexts:
+
 contexts/<N>/
 -------------
 
@@ -268,8 +272,8 @@ schemes/<N>/
 ------------
 
 In each scheme directory, five directories (``access_pattern``, ``quotas``,
-``watermarks``, ``stats``, and ``tried_regions``) and one file (``action``)
-exist.
+``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and one file
+(``action``) exist.
 
 The ``action`` file is for setting and getting what action you want to apply to
 memory regions having specific access pattern of the interest.  The keywords
@@ -347,6 +351,46 @@ as below.
 
 The ``interval`` should written in microseconds unit.
 
+schemes/<N>/filters/
+--------------------
+
+Users could know something more than the kernel for specific types of memory.
+In the case, users could do their own management for the memory and hence
+doesn't want DAMOS bothers that.  Users could limit DAMOS by setting the access
+pattern of the scheme and/or the monitoring regions for the purpose, but that
+can be inefficient in some cases.  In such cases, users could set non-access
+pattern driven filters using files in this directory.
+
+In the beginning, this directory has only one file, ``nr_filters``.  Writing a
+number (``N``) to the file creates the number of child directories named ``0``
+to ``N-1``.  Each directory represents each filter.  The filters are evaluated
+in the numeric order.
+
+Each filter directory contains three files, namely ``type``, ``matcing``, and
+``memcg_path``.  You can write one of two special keywords, ``anon`` for
+anonymous pages, or ``memcg`` for specific memory cgroup filtering.  In case of
+the memory cgroup filtering, you can specify the memory cgroup of the interest
+by writing the path of the memory cgroup from the cgroups mount point to
+``memcg_path`` file.  You can write ``Y`` or ``N`` to ``matching`` file to
+filter out pages that does or does not match to the type, respectively.  Then,
+the scheme's action will not be applied to the pages that specified to be
+filtered out.
+
+For example, below restricts a DAMOS action to be applied to only non-anonymous
+pages of all memory cgroups except ``/having_care_already``.::
+
+    # echo 2 > nr_filters
+    # # filter out anonymous pages
+    echo anon > 0/type
+    echo Y > 0/matching
+    # # further filter out all cgroups except one at '/having_care_already'
+    echo memcg > 1/type
+    echo /having_care_already > 1/memcg_path
+    echo N > 1/matching
+
+Note that filters could be ignored depend on the running DAMON operations set
+`implementation <sysfs_contexts>`.
+
 .. _sysfs_schemes_stats:
 
 schemes/<N>/stats/
-- 
2.25.1

