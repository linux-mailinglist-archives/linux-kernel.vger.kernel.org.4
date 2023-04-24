Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D846EC776
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjDXHyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjDXHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:54:40 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD95E65
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:54:36 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230424075434f1c1d3583ff7c18645
        for <linux-kernel@vger.kernel.org>;
        Mon, 24 Apr 2023 09:54:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cRH4nX3kvz4VCstupXacwcxAHkGzJLXypxwShXAZZ2M=;
 b=kue6cTzmaDbSfYeW6YTZMOGBGGHNT040b0t12m37SYwKO0peb9FAPlTRUFA+WbICtx9wTt
 h/iR0Xaidy2Vl713gfMVstd6aZkyyyHi3YAp89KQPCWNYJM6A6lCHoc6ZSgeCG/mOGzZ11rW
 EkP7Ur4tFflpqlYqQCEl0sGqb8Krg=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 2/8] tty: n_gsm: add missing description to gsm_config
Date:   Mon, 24 Apr 2023 09:52:45 +0200
Message-Id: <20230424075251.5216-2-daniel.starke@siemens.com>
In-Reply-To: <20230424075251.5216-1-daniel.starke@siemens.com>
References: <20230424075251.5216-1-daniel.starke@siemens.com>
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

Converting the other fields to kernel doc format remains an open task for
future patches.

Link: https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 include/uapi/linux/gsmmux.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

v2 -> v3:
Changed added comments to kernel doc format as remarked in the review.
Added remark regarding remaining documentation fields to commit message.

Link: https://lore.kernel.org/all/ZEEd_oOvJYranmzN@kroah.com/

diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index 33ee7b857c52..d3b9b37a9082 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -6,6 +6,28 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/**
+ * struct gsm_config - n_gsm basic configuration parameters
+ *
+ * This structure is used in combination with GSMIOC_GETCONF and GSMIOC_SETCONF
+ * to retrieve and set the basic parameters of an n_gsm ldisc.
+ * struct gsm_config_ext can be used to configure extended ldisc parameters.
+ *
+ * All timers are in units of 1/100th of a second.
+ *
+ * @adaption: Convergence layer type
+ * @encapsulation: Framing (0 = basic option, 1 = advanced option)
+ * @initiator: Initiator or responder
+ * @t1: Acknowledgment timer
+ * @t2: Response timer for multiplexer control channel
+ * @t3: Response timer for wake-up procedure
+ * @n2: Maximum number of retransmissions
+ * @mru: Maximum incoming frame payload size
+ * @mtu: Maximum outgoing frame payload size
+ * @k: Window size
+ * @i: Frame type (1 = UIH, 2 = UI)
+ * @unused: Can not be used
+ */
 struct gsm_config
 {
 	unsigned int adaption;
@@ -19,7 +41,7 @@ struct gsm_config
 	unsigned int mtu;
 	unsigned int k;
 	unsigned int i;
-	unsigned int unused[8];	/* Can not be used */
+	unsigned int unused[8];
 };
 
 #define GSMIOC_GETCONF		_IOR('G', 0, struct gsm_config)
-- 
2.34.1

