Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992C968BBFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBFLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBFLrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:47:40 -0500
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4C30E9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:47:37 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023020611473405ec702c36a2ec9083
        for <linux-kernel@vger.kernel.org>;
        Mon, 06 Feb 2023 12:47:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=wS7DCQJ3CnjHhUZAXPDyQtVIoeoWJA5RCvr8dQtB6ns=;
 b=e/KSb6r7YnuAcqRH1RaUxjgAutpUc7UdxF4/5oW+APJ3S88wqhSV/2O+sRiy7hpIMlqk2a
 mmt+Ej/38zRQeMdgP/+bUK6dOkodF5vbt4ODti05gn7qKkzZF/QZ+pvxxARhtM91FaBn2KMg
 drfdyw+BBUIYuE2sGd+I17qat+L98=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 1/4] tty: n_gsm: mark unusable ioctl structure fields accordingly
Date:   Mon,  6 Feb 2023 12:46:03 +0100
Message-Id: <20230206114606.2133-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v3 -> v4:
No changes.

Link: https://lore.kernel.org/all/20230203145023.6012-1-daniel.starke@siemens.com/

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

