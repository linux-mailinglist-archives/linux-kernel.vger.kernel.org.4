Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E023E60B6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiJXTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiJXTLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:11:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9627C1F9;
        Mon, 24 Oct 2022 10:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC231B815A9;
        Mon, 24 Oct 2022 17:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AD8C43470;
        Mon, 24 Oct 2022 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666633588;
        bh=S8N3UZ7gBOYKRFRy1cc+++5T5Gtx3WFgOSwLDzkycq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LiREqdLetOPDFQRyZCCTehNe1MrreQJ2I9j4scg3jL62B3rujAYFOshLm+/VnZTI2
         szACUAnHPSYoXH3/EsR7zCdEad7WkKV34SUiUrPsJcrJ5B/u0qSEtP5X/nGEibA96o
         AWrAr5QjEpPsX3gTpXliw6hQO7FlOZ3vu9Xu4/JQbHBQG+x9aXY4CmRO+J2bBEcd9P
         t+rye+9BUCg4kxUydcOjkmg3itRRcLkDsvwhBEmDox5C3q45BXlsUwpK/IUlol2cju
         vCTX3qbwdTwv5KuETRcBbj9PLuugT8DlexauESWlgTbfkQUdg6j9C6AMnP/M21wXOd
         ZS04O5Z3tuj2g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/2] Docs/admin-guide/mm/damon/usage: Fix wrong usage example of init_regions file
Date:   Mon, 24 Oct 2022 17:46:19 +0000
Message-Id: <20221024174619.15600-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024174619.15600-1-sj@kernel.org>
References: <20221024174619.15600-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON debugfs interface assumes the users will write all inputs at once.
However, redirecting a string of multiple lines sometimes end up writing
line by line.  Therefore, the example usage of 'init_regions' file,
which writes input as a string of multiple lines can fail.  Fix it to
use a single line string instead.  Also update the description of the
usage to not assume users will write inputs in multiple lines.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 89d9a4f75a29..c17e02e1e426 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -468,8 +468,9 @@ regions in case of physical memory monitoring.  Therefore, users should set the
 monitoring target regions by themselves.
 
 In such cases, users can explicitly set the initial monitoring target regions
-as they want, by writing proper values to the ``init_regions`` file.  Each line
-of the input should represent one region in below form.::
+as they want, by writing proper values to the ``init_regions`` file.  The input
+should be a sequence of three integers separated by white spaces that represent
+one region in below form.::
 
     <target idx> <start address> <end address>
 
@@ -484,9 +485,9 @@ ranges, ``20-40`` and ``50-100`` as that of pid 4242, which is the second one
     # cd <debugfs>/damon
     # cat target_ids
     42 4242
-    # echo "0   1       100
-            0   100     200
-            1   20      40
+    # echo "0   1       100 \
+            0   100     200 \
+            1   20      40  \
             1   50      100" > init_regions
 
 Note that this sets the initial monitoring target regions only.  In case of
-- 
2.25.1

