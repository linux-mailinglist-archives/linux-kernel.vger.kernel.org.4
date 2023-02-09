Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E116569112E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjBITUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBITUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:20:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438504740B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D394D61B9A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2561C433A0;
        Thu,  9 Feb 2023 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675970416;
        bh=3ZPhytsG6MoiFI71uMGAzjRAm4p3c/2mkgqWantxo+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rA9v/IlAimkmQzJd9fC7BNDYoPRQfdmYdGr+BsMUvy6S1DlXT51Ze4eoQXL+sPJej
         saLINvtg1Ytlv865eJ5j2Tv8XVxFNX6a+4wtC9SaFulcqmopRSukl9hmpf11dKstlN
         +QYIu/tzbD+w+BSs7eqEOgDdxDn5MExI0Gzhea5qwmoaSOzQNpgt68WwOdoOD7/OH0
         bEIifYbc7ua2i4DE53Awy0TLV7o64OPnHiwTruOuFRURpYproX4HVWe/wBmJTG5yM2
         e7UvDENGm8vA0b/rWFcbw/96jTHVryPSdrKOSnhIl69NwvCEDoXV2m+URReTq6okbt
         dFDxxllM6tZRA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/damon/Kconfig: add DAMON debugfs interface deprecation notice
Date:   Thu,  9 Feb 2023 19:20:08 +0000
Message-Id: <20230209192009.7885-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209192009.7885-1-sj@kernel.org>
References: <20230209192009.7885-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
kernel is released.  And, v6.1.y has announced to be an LTS[1].

Though the announcement was there for a while, some people might not
noticed that so far.  Also, some users could depend on it and have
problems at  movng to the alternative (DAMON sysfs interface).

For such cases, note DAMON debugfs interface as deprecated, and contacts
to ask helps on the Kconfig.

[1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 7821fcb3f258..436c6b4cb5ec 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -60,7 +60,7 @@ config DAMON_SYSFS
 	  the interface for arbitrary data access monitoring.
 
 config DAMON_DBGFS
-	bool "DAMON debugfs interface"
+	bool "DAMON debugfs interface (DEPRECATED!)"
 	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
 	help
 	  This builds the debugfs interface for DAMON.  The user space admins
@@ -68,8 +68,9 @@ config DAMON_DBGFS
 
 	  If unsure, say N.
 
-	  This will be removed after >5.15.y LTS kernel is released, so users
-	  should move to the sysfs interface (DAMON_SYSFS).
+	  This is deprecated, so users should move to the sysfs interface
+	  (DAMON_SYSFS).  If you depend on this and cannot move, please report
+	  your usecase to damon@lists.linux.dev and linux-mm@kvack.org.
 
 config DAMON_DBGFS_KUNIT_TEST
 	bool "Test for damon debugfs interface" if !KUNIT_ALL_TESTS
-- 
2.25.1

