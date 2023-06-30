Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCB87435A8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjF3HTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjF3HSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:18:54 -0400
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD1F19BA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:18:52 -0700 (PDT)
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id F8P2qe5pmwtegF8P2qinBt; Fri, 30 Jun 2023 09:18:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1688109529; bh=vzmN4kJ3h47heL9B7a4O2NpUoBSMDfUBOXPHa+mny4w=;
        h=From:To:Subject:Date:MIME-Version;
        b=O1vfhkdI1zTrqCaCJIJEQD3Rkdmi4dggT8/z7HOsyJnEp5qOq8Sc7NjlnkLLvwqIq
         b2Odfl8u66oue6snszfSdlrc7UpizJ1vPqkcoKx6lcy+Gqjz/oF8vh+AtlGcEd1CM6
         tNBqHkh8nVUDMIZ32CNNcYEktjqVeHAtV2gZeewxcmtsq/YTWOBnKYs7tysKW5WJ7p
         QWTw6FqdINR5NaCs1N2tCjEMAhNNZnqTtksq/xH9Uqs5oqBSpSHUfFDHhvy6aZqKU9
         muu6GRZ+QkXCXMqF5g6lbCNeEqHxmZo7aFW1SyagCQym1nM1ThHrab8hIx4e1DbtQz
         MlZH9U1HKf+ig==
From:   Rodolfo Giometti <giometti@enneenne.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charlie Johnston <charlie.johnston@ni.com>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH 1/2] include/uapi pps.h: increase PPS_MAX_SOURCES value
Date:   Fri, 30 Jun 2023 09:18:25 +0200
Message-Id: <20230630071826.105501-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfH/fmpQtNa7krYCUIJp18QipuTeXnS7k65LZHqKFjv+ecqqzgsEctZ+Z2uMSFFhohYiIdUGzrsbMFP6QSAUkBMxoz1p45oiy21BknMamhPiWJe3TNZBI
 H0sdV9Mllqba/jsyK/sfvLe6fV2fX84KLyYZvzLh/61VmuAccJREUbRsN5lknsujQZ7sQUheYIYk504lG+ZXz4lEG94v0KyIyVZk+VG/bLRNjqOCiBiZrOa/
 z8fM7f4XXmkxuLLQEDcKIfJbZHqhOk61kELSzVJyWPIK1+ION18a2f6qJSGrrIyT2wiKVm5oQhQlAvQOzXLKpUyFu7Z+TFjiInnwbWlxJwg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charlie Johnston <charlie.johnston@ni.com>

For consistency with what others use for minors, this change sets
PPS_MAX_SOURCES to MINORMASK.

The PPS_MAX_SOURCES value is currently set to 16. In some cases this
was not sufficient for a system. For example, a system with multiple
(4+) PCIe cards each with 4 PTP-capable ethernet interfaces could run
out of the available PPS major:minors if each interface registers a
PPS source.

Signed-off-by: Charlie Johnston <charlie.johnston@ni.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---
 include/uapi/linux/pps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
index 009ebcd8ced5..90f2e86020ba 100644
--- a/include/uapi/linux/pps.h
+++ b/include/uapi/linux/pps.h
@@ -26,7 +26,7 @@
 #include <linux/types.h>
 
 #define PPS_VERSION		"5.3.6"
-#define PPS_MAX_SOURCES		16		/* should be enough... */
+#define PPS_MAX_SOURCES		MINORMASK
 
 /* Implementation note: the logical states ``assert'' and ``clear''
  * are implemented in terms of the chip register, i.e. ``assert''
-- 
2.34.1

