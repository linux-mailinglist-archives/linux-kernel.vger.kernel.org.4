Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB66B689C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjBCOwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjBCOvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:51:48 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 06:51:47 PST
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A26F9EE14
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:51:46 -0800 (PST)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230203145042fb6f5c09fa4e60e438
        for <linux-kernel@vger.kernel.org>;
        Fri, 03 Feb 2023 15:50:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2NyostHau00yFANqCpLq5nifgI6rwhrmtoY/jfHx2Is=;
 b=CJBGn6O5tt+YtviI7Rqvp915HSd/PvX58OE1ttGShpokhNS4cP2PVb4h+VmzX8aoU49BxQ
 xj/mpKUdVwkhDxpAZesf4Ci8fcGZYn9wBk0KMrFjyGqTysO8pDQRVR/BKTrDs9BeOoLWAg7t
 41VN7coSQdsxCGiw01BIdq6ZaNsfg=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 1/4] tty: n_gsm: mark unusable ioctl structure fields accordingly
Date:   Fri,  3 Feb 2023 15:50:20 +0100
Message-Id: <20230203145023.6012-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

gsm_config and gsm_netconfig includes unused fields that have been included
to allow future extension without changing the structure size.
Unfortunately, no checks have been included for these field. The actual
value set by old user space code remains undefined.
This means that future extensions can not use these fields without breaking
old user space code which may set unexpected values.

Mark these fields accordingly to avoid breaking code changes.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 include/uapi/linux/gsmmux.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

v2 -> v3:
Split previous patch 1/3 into two commits as recommended in the review.
No other changes.

Link: https://lore.kernel.org/all/Y9vYxgGd6kC+ZIgR@kroah.com/

diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index cb8693b39cb7..785d6b253f6d 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -19,8 +19,7 @@ struct gsm_config
 	unsigned int mtu;
 	unsigned int k;
 	unsigned int i;
-	unsigned int unused[8];		/* Padding for expansion without
-					   breaking stuff */
+	unsigned int unused[8];	/* Can not be used */
 };
 
 #define GSMIOC_GETCONF		_IOR('G', 0, struct gsm_config)
@@ -29,9 +28,9 @@ struct gsm_config
 struct gsm_netconfig {
 	unsigned int adaption;  /* Adaption to use in network mode */
 	unsigned short protocol;/* Protocol to use - only ETH_P_IP supported */
-	unsigned short unused2;
+	unsigned short unused2;	/* Can not be used */
 	char if_name[IFNAMSIZ];	/* interface name format string */
-	__u8 unused[28];        /* For future use */
+	__u8 unused[28];        /* Can not be used */
 };
 
 #define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
-- 
2.34.1

