Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEBB6882AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjBBPfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBBPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:34:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA047307C;
        Thu,  2 Feb 2023 07:34:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A9C61BB5;
        Thu,  2 Feb 2023 15:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8F0C433D2;
        Thu,  2 Feb 2023 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351966;
        bh=zYUhwxvav6OX9dqGVpvSV+FIFto0//6GTil1TIfrs/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=meqjabsZwYpZDMReGP2gDw4ZJoKDiN9uEJKp+XYVRkF1reNpR+HczMs6SQRzOLXy8
         riMdCpBpWPGdct57+Q+wJ6Y70mayWLsWE4DoRJHVsoohROCWchkMFy30elskW3XENJ
         W0TtDmzFZYrUCdCUG89GW1eGKqnfRyTvyZqZ3rw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] USB: chipidea: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:32:23 +0100
Message-Id: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=gregkh@linuxfoundation.org; h=from:subject; bh=zYUhwxvav6OX9dqGVpvSV+FIFto0//6GTil1TIfrs/Y=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r09w/KwR4b9RY0diwv/MdwF+t6bNLfGRm/2h/8KX1LNL fgo4dMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBENu1jmJ9W/tnLJT6KJXFbyTSxBw 9XsxvanWdYMHfJmeWh4kZ9vf9TT/Bs8nbbU5ExGwA=
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

Cc: Peter Chen <peter.chen@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/debug.c b/drivers/usb/chipidea/debug.c
index faf6b078b6c4..bbc610e5bd69 100644
--- a/drivers/usb/chipidea/debug.c
+++ b/drivers/usb/chipidea/debug.c
@@ -364,5 +364,5 @@ void dbg_create_files(struct ci_hdrc *ci)
  */
 void dbg_remove_files(struct ci_hdrc *ci)
 {
-	debugfs_remove(debugfs_lookup(dev_name(ci->dev), usb_debug_root));
+	debugfs_lookup_and_remove(dev_name(ci->dev), usb_debug_root);
 }
-- 
2.39.1

