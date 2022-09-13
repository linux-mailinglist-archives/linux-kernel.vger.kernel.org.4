Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6E5B7971
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiIMS2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiIMS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0496B15E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A7EDB81095
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7202BC43150;
        Tue, 13 Sep 2022 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091102;
        bh=w3PmzI3eXAtMjTvuW+AZdIXWuI7edjAfsNckFtn3Io4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+gTc8Q3zvNURan9GfDYXpMFt0z7EM7ZU4Rk7rB6CF4TVUZ9u0lOC9R/mnSsqr1rU
         R09efwl3daVaFAsKHd+OnmT6ETvV0PMjyb4ottR6blkea3JwhH7siUgh+ef1mPMkU4
         EKaFrbCBRaCJZXOHM29xOnmuI+YeeF34swnPisfOy1yL6mT6wVb1wKUEh4oXq34IwI
         eLdb6WfOc5+5tc+sbCgWEYV4dgsETv9WG00qb3xBPewMoB8T/VL0hZF3QnKA2oMvFA
         6vRLl+ewWOzfgDKb1A4WAfcd+sFizn3ILxbC4f+DqYoawhNS02fcOoxPe0EIvzMD4/
         jGRysRwAE1RFg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/22] mm/damon/modules-common: implement a watermarks module parameters generator macro
Date:   Tue, 13 Sep 2022 17:44:39 +0000
Message-Id: <20220913174449.50645-13-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
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

DAMON_RECLAIM and DAMON_LRU_SORT have module parameters for watermarks
that having same names.  This commit implements a macro for generating
such module parameters so that we can reuse later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index 0abd0636bc64..1370590a37d1 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -16,3 +16,10 @@
 			0600);						\
 	module_param_named(max_nr_regions, attrs.max_nr_regions, ulong,	\
 			0600);
+
+#define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
+	module_param_named(wmarks_interval, wmarks->interval, ulong,	\
+			0600);						\
+	module_param_named(wmarks_high, wmarks.high, ulong, 0600);	\
+	module_param_named(wmarks_mid, wmarks.mid, ulong, 0600);	\
+	module_param_named(wmarks_low, wmarks.lowulong, 0600);
-- 
2.25.1

