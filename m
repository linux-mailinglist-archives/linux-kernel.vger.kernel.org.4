Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FF6154A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiKAWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiKAWDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:03:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F363C7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B53DB81E27
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF57C433D7;
        Tue,  1 Nov 2022 22:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667340218;
        bh=NEW3Do9blxs64Lr6AHVrrQw2/a54TWTrLKMR+YeGsds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1CFkxeL+dqHmMQeH8SDS0lCGzwBkhf2aHgFfgMOEqNRvCflCYHQI12Oy5F8avJc3
         Agchqu719Zx4qxQ1F9QY9Fmuu9lScWN27OlP+GSN8ENks8z6FLxr7PFcWxFVcFTwgj
         gA6AGQFnZ8ZCWiBLhAIvR1411jLd8UqsVpR/3edr9frW/3xlDwPnoik0xeNFjhX7nI
         tGGbpkm6EWWV+g9CuX2snpTvjQH70mGLcHELAUY+wfCG2fW3gocNniE8fHFu0uWy/l
         y+4kDCJjON198FMyUp6iPw83AtZSxfKqgh9DjTGVQG83gSze8ypd8Xtc/pKTHBXRCf
         WoKgOp7KKNYKg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 8/8] Docs/ABI/damon: document 'schemes/<s>/tried_regions' sysfs directory
Date:   Tue,  1 Nov 2022 22:03:28 +0000
Message-Id: <20221101220328.95765-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101220328.95765-1-sj@kernel.org>
References: <20221101220328.95765-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAMON ABI document for the 'tried_regions' directory of DAMON
sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 08b9df323560..13397b853692 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -27,6 +27,10 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		makes the kdamond reads the user inputs in the sysfs files
 		except 'state' again.  Writing 'update_schemes_stats' to the
 		file updates contents of schemes stats files of the kdamond.
+		Writing 'update_schemes_tried_regions' to the file updates
+		contents of 'tried_regions' directory of every scheme directory
+		of this kdamond.  Writing 'clear_schemes_tried_regions' to the
+		file removes contents of the 'tried_regions' directory.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
@@ -283,3 +287,31 @@ Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the number of the exceed events of
 		the scheme's quotas.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/start
+Date:		Oct 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the start address of a memory region
+		that corresponding DAMON-based Operation Scheme's action has
+		tried to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/end
+Date:		Oct 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the end address of a memory region
+		that corresponding DAMON-based Operation Scheme's action has
+		tried to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/nr_accesses
+Date:		Oct 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the 'nr_accesses' of a memory region
+		that corresponding DAMON-based Operation Scheme's action has
+		tried to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/age
+Date:		Oct 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the 'age' of a memory region that
+		corresponding DAMON-based Operation Scheme's action has tried
+		to be applied.
-- 
2.25.1

