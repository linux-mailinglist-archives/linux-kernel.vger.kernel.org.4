Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C556E8D45
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjDTIy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjDTIxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:53:45 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3D86A6F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:52:01 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230420085159c6afeecf08a1b5d7ef
        for <linux-kernel@vger.kernel.org>;
        Thu, 20 Apr 2023 10:51:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7MNaE1HTKvukMJ9m1g98lEt+XmsMRBduxzjINiIWnBE=;
 b=m8YbMEjKF+E6FgUq5fYKF2eWGxj7w+j9I3bjoFkFNp8aCCRvicaQk8PVd8ppp4prvwdKtZ
 X1JCTiDZupsxpka8ng9gldocD2BiRzMWIVQaRMVFTejbrTveDf/tVaWxj05Y7szJMecanHny
 60I8IosV5p1r0QxwUxJtvRu6UnrtM=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 3/9] tty: n_gsm: add missing description to gsm_config
Date:   Thu, 20 Apr 2023 10:50:11 +0200
Message-Id: <20230420085017.7314-3-daniel.starke@siemens.com>
In-Reply-To: <20230420085017.7314-1-daniel.starke@siemens.com>
References: <20230420085017.7314-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Currently, all available structure fields in gsmmux.h except those
for gsm_config are commented.

Fix this by adding appropriate comments to the not commented fields.
Note that 'mru' and 'mtu' refer to the size without basic/advanced option
mode header and byte stuffing as defined in the standard in chapter 5.7.2.

Link: https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 include/uapi/linux/gsmmux.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

v1 -> v2:
Added remark regarding the mru/mtu size comment as this was unclear in the
review.

Link: https://lore.kernel.org/all/AS4PR10MB5895ADDAF211A669CCF7F8C5E0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index 33ee7b857c52..422a52e184b3 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -8,17 +8,17 @@
 
 struct gsm_config
 {
-	unsigned int adaption;
-	unsigned int encapsulation;
-	unsigned int initiator;
-	unsigned int t1;
-	unsigned int t2;
-	unsigned int t3;
-	unsigned int n2;
-	unsigned int mru;
-	unsigned int mtu;
-	unsigned int k;
-	unsigned int i;
+	unsigned int adaption;	/* Convergence layer type */
+	unsigned int encapsulation; /* Framing (0 = basic option, 1 = advanced option) */
+	unsigned int initiator;	/* Initiator or responder */
+	unsigned int t1;	/* Acknowledgment timer */
+	unsigned int t2;	/* Response timer for multiplexer control channel */
+	unsigned int t3;	/* Response timer for wake-up procedure */
+	unsigned int n2;	/* Maximum number of retransmissions */
+	unsigned int mru;	/* Maximum incoming frame payload size */
+	unsigned int mtu;	/* Maximum outgoing frame payload size */
+	unsigned int k;		/* Window size */
+	unsigned int i;		/* Frame type (1 = UIH, 2 = UI) */
 	unsigned int unused[8];	/* Can not be used */
 };
 
-- 
2.34.1

