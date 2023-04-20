Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754666E8D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjDTIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjDTIx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:53:57 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E846BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:52:06 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202304200852011396a59810ab83a424
        for <linux-kernel@vger.kernel.org>;
        Thu, 20 Apr 2023 10:52:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3x2yGjeK5u1omGmfHkW7ePEBZf1+enMbPDW41ey/pcA=;
 b=jC6VnpGptfOYjt/kcGttoWZ0iYVUQEywQ1BjuMJ7ovnlexEs3HPeifOq1ZgRqGafxcj8qQ
 jvlLATkBil/ZBinzu123fmdn65aKhGVKJ4W9IhUFH94BNEuBOIdUGJcTrOo/7WghXGT6vWi2
 IWDn2WVzvkkdHrkZZQAu4MDiJzsMY=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 7/9] tty: n_gsm: increase gsm_mux unsupported counted where appropriate
Date:   Thu, 20 Apr 2023 10:50:15 +0200
Message-Id: <20230420085017.7314-7-daniel.starke@siemens.com>
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

The structure gsm_mux contains the 'unsupported' field. However, there is
currently no place in the code which increases this counter.

Increase the 'unsupported' statistics counter in the following case:
- an unsupported frame type has been requested by the peer via parameter
  negotiation
- a control frame with an unsupported but known command has been received

Note that we have no means to detect an inconsistent/unsupported adaptation
sufficient accuracy as this changes the structure of the UI/UIH frames.
E.g. a one byte header is added in case of convergence layer type 2 instead
of 1 and contains the modem signal octet with the state of the signal
lines. There is no checksum or other value which indicates of this field is
correct or should be present. Therefore, we can only assume protocol
correctness here. See also 'gsm_dlci_data()' where this is handled.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 3 +++
 1 file changed, 3 insertions(+)

v1 -> v2:
Added details about missing detection of inconsistent/unsupported adaption
to the commit message. A question about this came up during the review.

Link: https://lore.kernel.org/all/AS4PR10MB58955AB89CC251446B7509CBE0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index cc7be05c37ce..ce06cbbe79af 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1589,6 +1589,7 @@ static int gsm_process_negotiation(struct gsm_mux *gsm, unsigned int addr,
 		if (debug & DBG_ERRORS)
 			pr_info("%s unsupported I frame request in PN\n",
 				__func__);
+		gsm->unsupported++;
 		return -EINVAL;
 	default:
 		if (debug & DBG_ERRORS)
@@ -1896,6 +1897,8 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		/* Optional unsupported commands */
 	case CMD_RPN:	/* Remote port negotiation */
 	case CMD_SNC:	/* Service negotiation command */
+		gsm->unsupported++;
+		fallthrough;
 	default:
 		/* Reply to bad commands with an NSC */
 		buf[0] = command;
-- 
2.34.1

