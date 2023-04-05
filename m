Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981BF6D73EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbjDEFtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbjDEFsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:48:45 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1240EE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:48:43 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230405054841f3cf610f578aa093fb
        for <linux-kernel@vger.kernel.org>;
        Wed, 05 Apr 2023 07:48:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TFt+C5BrvavywiqvORD4lxZZuzc6pzPiidKcYuSljTk=;
 b=EDHpM/HFdWDdIOOLBJ3jyOja5SOVbRjyjQSYWoGey9yxeuKEBClaUkgtsFO59Lw0AeItvp
 r9F+CL2KaF68LsI9cHYPpuVXmtP+gPPeu2c7kdCtluhztqxDWJmaoqo2DCREz1xyjVZPsHmq
 V8wuN4RRXPNzDKqYEY22kCvSW5dRc=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 7/9] tty: n_gsm: increase gsm_mux unsupported counted where appropriate
Date:   Wed,  5 Apr 2023 07:47:28 +0200
Message-Id: <20230405054730.3850-7-daniel.starke@siemens.com>
In-Reply-To: <20230405054730.3850-1-daniel.starke@siemens.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 317aa67ed169..49cb2dbfa233 100644
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

