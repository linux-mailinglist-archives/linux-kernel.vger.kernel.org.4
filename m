Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC36073374E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346164AbjFPRSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjFPRSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:18:34 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659DD2101;
        Fri, 16 Jun 2023 10:18:33 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qAD5i-00G84E-Pp; Fri, 16 Jun 2023 18:18:30 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qAD5i-000LxN-1g;
        Fri, 16 Jun 2023 18:18:30 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] perf/core: make nr_addr_filters static
Date:   Fri, 16 Jun 2023 18:18:29 +0100
Message-Id: <20230616171829.84392-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_attr_nr_addr_filters is not accessed outside of kernel/events/core.c
so make it static to avoid the following sparse warning:

kernel/events/core.c:11288:1: warning: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index db016e418931..56255ace94d4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11285,7 +11285,7 @@ static ssize_t nr_addr_filters_show(struct device *dev,
 
 	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
 }
-DEVICE_ATTR_RO(nr_addr_filters);
+static DEVICE_ATTR_RO(nr_addr_filters);
 
 static struct idr pmu_idr;
 
-- 
2.39.2

