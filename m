Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F32E5ED2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiI1Bkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiI1Bkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:40:37 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5565D160E60;
        Tue, 27 Sep 2022 18:40:36 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 4A7671E80D33;
        Wed, 28 Sep 2022 09:36:19 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 01LCsSIfww9e; Wed, 28 Sep 2022 09:36:16 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 1F5A61E80D70;
        Wed, 28 Sep 2022 09:36:16 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] scsi: Remove unnecessary (void*) conversions
Date:   Wed, 28 Sep 2022 09:40:20 +0800
Message-Id: <20220928014020.10746-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void pointer object can be directly assigned to different structure
objects, it does not need to be cast.

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 include/scsi/libfcoe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index fac8e89aed81..e6be85dfa249 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -364,7 +364,7 @@ struct fcoe_port {
  */
 static inline struct net_device *fcoe_get_netdev(const struct fc_lport *lport)
 {
-	struct fcoe_port *port = ((struct fcoe_port *)lport_priv(lport));
+	struct fcoe_port *port = lport_priv(lport);
 
 	return (port->get_netdev) ? port->get_netdev(lport) : NULL;
 }
-- 
2.18.2

