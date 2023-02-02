Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94192687F92
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjBBOKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25488F13;
        Thu,  2 Feb 2023 06:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4DB61B5C;
        Thu,  2 Feb 2023 14:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6339C433D2;
        Thu,  2 Feb 2023 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675347017;
        bh=KnHBoINmS58SP6n7EMnX7mpN9fx1nvdp/zRrtfMztuw=;
        h=From:To:Cc:Subject:Date:From;
        b=xHjIi4Ol/C52BR/7Yu6IPxGVAe6Nqf26XayN1nZ1i8+MV2sM9aYILtFR4FVOzjPHl
         Evaope9f6rGz1FEmxodot7sM0TEik3IqaedJTUB86DAZsue1GpIcXOpRNULGLDD6aW
         sZFwF18YEb1QgjKutftjc8EHRN/jEM38b3XIIsx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-scsi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: snic: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 15:10:09 +0100
Message-Id: <20230202141009.2290380-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; i=gregkh@linuxfoundation.org; h=from:subject; bh=KnHBoINmS58SP6n7EMnX7mpN9fx1nvdp/zRrtfMztuw=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3jzh8SExYLL/n4FGXmIAnWo0aC7fejHjzdb5o5cq9q2NT d1yb3RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAT0c5gmO8Y0Sdx0+n/9e1vvkbnHS kNV5j85xPDgq5FQpFnpp7ZMi+4tt10z5LnXffm7wcA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic at
once.

Cc: Karan Tilak Kumar <kartilak@cisco.com>
Cc: Sesidhar Baddela <sebaddel@cisco.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/snic/snic_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 57bdc3ba49d9..9dd975b36b5b 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -437,6 +437,6 @@ void snic_trc_debugfs_init(void)
 void
 snic_trc_debugfs_term(void)
 {
-	debugfs_remove(debugfs_lookup(TRC_FILE, snic_glob->trc_root));
-	debugfs_remove(debugfs_lookup(TRC_ENABLE_FILE, snic_glob->trc_root));
+	debugfs_lookup_and_remove(TRC_FILE, snic_glob->trc_root);
+	debugfs_lookup_and_remove(TRC_ENABLE_FILE, snic_glob->trc_root);
 }
-- 
2.39.1

