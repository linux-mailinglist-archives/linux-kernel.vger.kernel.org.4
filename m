Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9EC660323
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjAFP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbjAFP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:28:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD8D6C283;
        Fri,  6 Jan 2023 07:28:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC736172C;
        Fri,  6 Jan 2023 15:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAC0C433D2;
        Fri,  6 Jan 2023 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673018912;
        bh=15nO7ikH9WcmjcSYjC3pbic2yBoSfe31epbJuYmddYE=;
        h=From:To:Cc:Subject:Date:From;
        b=DoIqPMDnsCYhQsnrxh7KXa4t4s2otZF4k/OBK3fUX97C3o9BxR8WmzBrmw5XYwenY
         eIBv85fAMH2VPkuFX58sWysE8CglHL8OlZkaAHPtCWLXzFnV2BnCWM4HO0bj7IbZxK
         LC3XxnNiV52GOtm5bL8SpWNnAK1MQ6Lf8RS62zz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] USB: fix memory leak with using debugfs_lookup()
Date:   Fri,  6 Jan 2023 16:28:28 +0100
Message-Id: <20230106152828.3790902-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=gregkh@linuxfoundation.org; h=from:subject; bh=15nO7ikH9WcmjcSYjC3pbic2yBoSfe31epbJuYmddYE=; b=owGbwMvMwCRo6H6F97bub03G02pJDMk77KSOfHllqLrNJL7r/UfV65zRQZMD9CdEms1NXRp5cZe1 y7a8jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIfQTDPAWvyfaad8TXPfhq3/Quj9 tr7u1TvQzzzI2EF106cVP8o9GpdTWvol8kvmK6BQA=
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
call debugfs_lookup_and_remove() instead which handles all of the logic at
once.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Jilin Yuan <yuanjilin@cdjrlc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 11b15d7b357a..a415206cab04 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -998,7 +998,7 @@ static void usb_debugfs_init(void)
 
 static void usb_debugfs_cleanup(void)
 {
-	debugfs_remove(debugfs_lookup("devices", usb_debug_root));
+	debugfs_lookup_and_remove("devices", usb_debug_root);
 }
 
 /*
-- 
2.39.0

