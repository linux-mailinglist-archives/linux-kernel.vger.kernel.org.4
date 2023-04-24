Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93146EC77B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjDXHyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjDXHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:54:40 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271F010E7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:54:39 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230424075437c91b3f3775558fdb90
        for <linux-kernel@vger.kernel.org>;
        Mon, 24 Apr 2023 09:54:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RH+IPOwJITsK55x7GggxOQ9MIYHJ4riLL8mEAOOeoXc=;
 b=SzKskAqAU1VFoE/Uv0dZm+lVtO9JrwPoRL43i05+A47eUJ1Gq2QWJ74nmZhFludD8f0vJL
 CEvajtupfrgJEa4JHVrFxU9gWTkjSx/r3Yz37kq0Bggso5aUulPBm1Hz0HLMLOx0UlaYshGa
 PWO4s5g2WPpWsmhEeD6qSkx/Wy/Ss=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 6/8] tty: n_gsm: increase gsm_mux unsupported counted where appropriate
Date:   Mon, 24 Apr 2023 09:52:49 +0200
Message-Id: <20230424075251.5216-6-daniel.starke@siemens.com>
In-Reply-To: <20230424075251.5216-1-daniel.starke@siemens.com>
References: <20230424075251.5216-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

v2 -> v3:
No changes.

Link: https://lore.kernel.org/all/20230420085017.7314-7-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 10fc02133efa..941489230f9f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1590,6 +1590,7 @@ static int gsm_process_negotiation(struct gsm_mux *gsm, unsigned int addr,
 		if (debug & DBG_ERRORS)
 			pr_info("%s unsupported I frame request in PN\n",
 				__func__);
+		gsm->unsupported++;
 		return -EINVAL;
 	default:
 		if (debug & DBG_ERRORS)
@@ -1897,6 +1898,8 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
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

