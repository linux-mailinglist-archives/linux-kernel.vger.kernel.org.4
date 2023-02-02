Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516EA687FBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjBBOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBBOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:16:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC2E3A7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:16:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E43F261B6F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC62C433D2;
        Thu,  2 Feb 2023 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675347385;
        bh=eyB9EfdjOjsyCAKlInNRW2YVGbe2pIAJQIW53I+B88U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZ8Fyyzj2OGN8S6mWaEhgew/LAVLGgvjnQ61ib9VFFV/gVbcZQGHjpF/qgI7FkFtn
         qIE9lrTm0ba4djaeXR/0Esl1E/sqI5pFo5AuI448Qsna9gV5XR/1QTWklKoVd6dvT1
         rG5sK2Rn4OXinNEYf+lp0ii4InhfUGm3ZpFUC2+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] drivers: base: dd: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 15:16:21 +0100
Message-Id: <20230202141621.2296458-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202141621.2296458-1-gregkh@linuxfoundation.org>
References: <20230202141621.2296458-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=gregkh@linuxfoundation.org; h=from:subject; bh=eyB9EfdjOjsyCAKlInNRW2YVGbe2pIAJQIW53I+B88U=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3j2797s/7R1V/UnRt1zTVWLXqFAmvM4+ftDYevrLuhU/p ThXHjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhI7nSGBcfe8F/waeIRTZx7wu2LZd V0BfdPjQzziy7V/7+8VuHxxxWPKq/+mTj91TGuDAA=
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
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 817ef27a78f7..8def2ba08a82 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -370,7 +370,7 @@ late_initcall(deferred_probe_initcall);
 
 static void __exit deferred_probe_exit(void)
 {
-	debugfs_remove_recursive(debugfs_lookup("devices_deferred", NULL));
+	debugfs_lookup_and_remove("devices_deferred", NULL);
 }
 __exitcall(deferred_probe_exit);
 
-- 
2.39.1

