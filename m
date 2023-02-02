Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E3C6882AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjBBPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjBBPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:35:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26296E9B;
        Thu,  2 Feb 2023 07:34:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53041B826B7;
        Thu,  2 Feb 2023 15:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9486EC4339B;
        Thu,  2 Feb 2023 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351983;
        bh=Qda/PQv4RqX7g5dgxLcjBeYi+1CYJvm2YonTqRTHp+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KALluE7lJtGUkrnFm20tyBKum8/w3TbICvviZ/It3rBf/4T+x5MOQTu4Co3Mp7DRP
         HVwrCAWzC0nkk6c7wLAlmtfCHRxkYrB9Zu1eqBYbJV2mOh6rHSXmQ0PVQNgnTV53rH
         k9SebNJCICbs7COFDLc91CaG9GPBBBfAPuOD6y8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] USB: sl811: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:32:26 +0100
Message-Id: <20230202153235.2412790-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=gregkh@linuxfoundation.org; h=from:subject; bh=Qda/PQv4RqX7g5dgxLcjBeYi+1CYJvm2YonTqRTHp+g=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r08sePN5rmds879195Im6Tst7F/gf63qZGBjj+j9Q5tP tIh7d8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBErKUZFjSoLnryeQODXe79UyKlxm 3nBRc4VjPMj3k5v+/JJDGv46VTpEQ/bGnWMgg3BAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/sl811-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index d206bd95c7bb..b8b90eec9107 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1501,7 +1501,7 @@ static void create_debug_file(struct sl811 *sl811)
 
 static void remove_debug_file(struct sl811 *sl811)
 {
-	debugfs_remove(debugfs_lookup("sl811h", usb_debug_root));
+	debugfs_lookup_and_remove("sl811h", usb_debug_root);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.39.1

