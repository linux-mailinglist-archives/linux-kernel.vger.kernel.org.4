Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84D690E37
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBIQTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBIQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:19:19 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0F65A9C8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:19:18 -0800 (PST)
Received: from localhost.179.lan (unknown [94.29.124.73])
        by mail.ispras.ru (Postfix) with ESMTPSA id BF6E740737CD;
        Thu,  9 Feb 2023 16:19:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BF6E740737CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1675959555;
        bh=tLZo/bcb1EOssw17se/FP5c6fL7fMLC93o2ouQs+qsk=;
        h=From:To:Cc:Subject:Date:From;
        b=bBg7GYv0wHRcC3LFE1fVPT3Gv3QsaH89vfq4pXj+33wNmIDh+5iJBb9dCRSMvUGuw
         oZEJHmWKcoqY2j6MlWhn6QYdb/QfCJKIzczHGQpS7SJ2HkadjKPZloUZ2VrqSp1xb/
         kHpEuVFUNRGgYIxwizlj1jmnuQuX7rloX+QXZB+I=
From:   Anton Gusev <aagusev@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anton Gusev <aagusev@ispras.ru>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] staging/wlan-ng: Check hfa384x_dowmem result in hfa384x_drvr_flashdl_write
Date:   Thu,  9 Feb 2023 19:18:36 +0300
Message-Id: <20230209161836.29991-1-aagusev@ispras.ru>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hfa384x_drvr_flashdl_write, hfa384x_dowmem is called in a cycle
without checking the result. Ignoring an error there may lead to an
incorrect flash download buffer value during the consequent write.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anton Gusev <aagusev@ispras.ru>
---
 drivers/staging/wlan-ng/hfa384x_usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index c7cd54171d99..baac5c02f904 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -1880,6 +1880,12 @@ int hfa384x_drvr_flashdl_write(struct hfa384x *hw, u32 daddr,
 						writepage,
 						writeoffset,
 						writebuf, writelen);
+			if (result) {
+				netdev_err(hw->wlandev->netdev,
+					   "dowmem(page=%x,offset=%x,data=%p,len=%d) failed, result=%d. Aborting d/l\n",
+					   writepage, writeoffset, writebuf, writelen, result);
+				return result;
+			}
 		}
 
 		/* set the download 'write flash' mode */
-- 
2.39.1

