Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB5462D7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiKQKTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQKTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:19:12 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C554D5ED
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668680340; bh=SzVxtKeetSOTjll6GIenMJHr7FVUowUUcMEMgbJoa9M=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=LvbMT/p3+qBL53qZms+nv4EtBnzKNLk+Cn+km56ubnzcPc/mjKgv0eUv3uorg61JB
         zrb0lUuLtPzZRx4B09DlEV4MaDBqIpgPIbFGMgfCAWPxHYHaZFR+2D1ijOyXM2CsMf
         VsIl2r3Bg3f9lY2gkoAr64ubnMBTv7As/DBijdm8=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 17 Nov 2022 11:19:00 +0100 (CET)
X-EA-Auth: usK3miqBlpaK6KvcL4GXadFp8n6JQ3Xl8zXAoWm5N3DuIV6veHX1uibGv0qvoiLHAPSFUCRL/fEV5ZzpFdDcgFINefyT/hZR
Date:   Thu, 17 Nov 2022 15:48:45 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     gustavoars@kernel.org
Subject: [PATCH] staging: wlan-ng: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y3YKhee8L+kAfHM4@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code currently uses C90 standard extension based zero length arrays.
The zero length array member also happens to be the only member of the
structs. Such zero length array declarations are deprecated and the
new C99 standard extension of flexible array declarations are to be
used instead.

The DECLARE_FLEX_ARRAY() helper allows for a flexible array member as
the only member in a structure. Refer to these links [1], [2] for
details.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://lkml.kernel.org/r/YxKY6O2hmdwNh8r8@work

Issue identified using Coccinelle.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Notes:
   1. Proposed change is compile tested only.
   2. Solution feedback from gustavoars@kernel.org


 drivers/staging/wlan-ng/hfa384x.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 0611e37df6ac..3a1edcb43e07 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -960,15 +960,15 @@ struct hfa384x_pdr_nicid {
 } __packed;

 struct hfa384x_pdr_refdac_measurements {
-	u16 value[0];
+	DECLARE_FLEX_ARRAY(u16, value);
 } __packed;

 struct hfa384x_pdr_vgdac_measurements {
-	u16 value[0];
+	DECLARE_FLEX_ARRAY(u16, value);
 } __packed;

 struct hfa384x_pdr_level_comp_measurements {
-	u16 value[0];
+	DECLARE_FLEX_ARRAY(u16, value);
 } __packed;

 struct hfa384x_pdr_mac_address {
--
2.34.1



