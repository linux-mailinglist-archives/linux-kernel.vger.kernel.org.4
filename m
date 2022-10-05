Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213765F514E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiJEJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJEJEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:04:02 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C57644D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:03:57 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1og0GQ-007ckN-Ue;
        Wed, 05 Oct 2022 11:02:51 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] drivers: vmware: balloon - report inflated memory
Date:   Wed,  5 Oct 2022 12:01:56 +0300
Message-Id: <20221005090158.2801592-7-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate inflated memory changes to mm.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/misc/vmw_balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 91d4d2a285c5..ce581e3d101c 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1161,6 +1161,8 @@ static void vmballoon_inflate(struct vmballoon *b)
 
 		cond_resched();
 	}
+	/* Update core after inflation is done - send a single notification */
+	balloon_set_inflated_free(atomic64_read(&b->size) << 2);
 
 	/*
 	 * Release pages that were allocated while attempting to inflate the
@@ -1285,6 +1287,8 @@ static unsigned long vmballoon_deflate(struct vmballoon *b, uint64_t n_frames,
 
 		cond_resched();
 	}
+	/* Update core after deflation is done - send a single notification */
+	balloon_set_inflated_free(atomic64_read(&b->size) << 2);
 
 	return deflated_frames;
 }
-- 
2.31.1

