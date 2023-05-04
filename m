Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC266F77AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjEDVCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjEDVBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:01:39 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA6A14E61
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230734;
        bh=4SJMp1te2JkZx1CFuIwS27tlAnRiNSVpgrNwcTggKBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8/ofAq1zgKtNVBwizAqBo6VPHz1KvIuRHyyIfW/cPGoa7HBxwdD9IsDlm6MCfCtU
         1Xq0ctKQjJZsSymzJWterSninx0fyNR8uNTt9RPL7HoqCGPi5ltJh72eT959mbzWgI
         enh/p1OD/wGmFU6zjf73ft0NWHva2NXDvyOaeyvmKW2J6w4fgUDmRMByTkDG/Yu87m
         HaISwZxSXkZzBXIqxuRTqQqcNofwWRm66ELNBvhTuDtu7UBZm2kD53A49JLxV+JThy
         cMYcG2P2Kx2EaxdL5zwM9Cz/N67dTecAMHrvHfzTAdLhGGJ7PidlDOgDOh5QOSn43U
         +E94H2JQg/gBw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yp1R7Yz11jH;
        Thu,  4 May 2023 16:05:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFC PATCH 10/13] resource_ext.h: Remove useless parentheses around macro parameters
Date:   Thu,  4 May 2023 16:05:24 -0400
Message-Id: <20230504200527.1935944-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parentheses around macro parameters which are surrounded by commas is
a scenario where those added parentheses are useless, because the comma
is the operator with the lowest precedence.

Remove those useless parentheses to make list iteration code consistent
across kernel headers.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/resource_ext.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/resource_ext.h b/include/linux/resource_ext.h
index ff0339df56af..f4a3c0040886 100644
--- a/include/linux/resource_ext.h
+++ b/include/linux/resource_ext.h
@@ -60,11 +60,11 @@ resource_list_destroy_entry(struct resource_entry *entry)
 	resource_list_free_entry(entry);
 }
 
-#define resource_list_for_each_entry(entry, list)	\
-	list_for_each_entry((entry), (list), node)
+#define resource_list_for_each_entry(entry, list)		\
+	list_for_each_entry(entry, list, node)
 
 #define resource_list_for_each_entry_safe(entry, tmp, list)	\
-	list_for_each_entry_safe((entry), (tmp), (list), node)
+	list_for_each_entry_safe(entry, tmp, list, node)
 
 static inline struct resource_entry *
 resource_list_first_type(struct list_head *list, unsigned long type)
-- 
2.25.1

