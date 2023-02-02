Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13E687F97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjBBOLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBBOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:11:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DE88F13
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:11:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74458B8266A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB0BC4339B;
        Thu,  2 Feb 2023 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675347069;
        bh=gBdaWyT3fPaApgmaz3AU3hrMLEA89JaIs6+g1TDSppM=;
        h=From:To:Cc:Subject:Date:From;
        b=lAnVZyNHprfWqUF/wAqyHEyrJuuxchV5O5U28OSvwGQlf2CaqDMHZCzNczPMXBDWw
         ajW0AHu9KpeHrFCC3s1GxpgkCrzxmfA/pqdm03PPrsVuhEmBMgsWJggY8oP/qi5u1a
         KDtKm/huij4AqTnAuz7ijqO9qPuuW0bp9AOfoiC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] misc: vmw_balloon: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 15:11:00 +0100
Message-Id: <20230202141100.2291188-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=gregkh@linuxfoundation.org; h=from:subject; bh=gBdaWyT3fPaApgmaz3AU3hrMLEA89JaIs6+g1TDSppM=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3j5ScCXXcbd9hLvzNuSpMKnGtT0GjQ//lP4JuC3dN817K rb2zI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbyRoVhQYtV4NdfeQIruB+c+HWlUy 5wWum8SQwLlhUyN316M8Or+MSmy6uqpKe8eVITAQA=
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

Cc: Nadav Amit <namit@vmware.com>
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vmw_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 61a2be712bf7..9ce9b9e0e9b6 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1709,7 +1709,7 @@ static void __init vmballoon_debugfs_init(struct vmballoon *b)
 static void __exit vmballoon_debugfs_exit(struct vmballoon *b)
 {
 	static_key_disable(&balloon_stat_enabled.key);
-	debugfs_remove(debugfs_lookup("vmmemctl", NULL));
+	debugfs_lookup_and_remove("vmmemctl", NULL);
 	kfree(b->stats);
 	b->stats = NULL;
 }
-- 
2.39.1

