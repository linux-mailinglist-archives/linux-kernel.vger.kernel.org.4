Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFDE689C32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjBCOuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjBCOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:50:47 -0500
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC68F249
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:50:44 -0800 (PST)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230203145042fe7659cbb89a805056
        for <linux-kernel@vger.kernel.org>;
        Fri, 03 Feb 2023 15:50:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+nOvG2X3HLgF03w2fTPt3ooPfqHvAZ6ZsfqKleubf/o=;
 b=MSAb0QsdUJ/AWk9AaXt1zcoinF/++j29BUvdzRbtjI4GwNUBVaMDiNC1vBi1tNZuwvxgtH
 IqHAkhUURQjKAPPXif0ppEThsEQRbOfgUPadng0EwKW/sod2Jt+/PAkv5W7kFVndmfXoP44F
 9hnGufJ2qIhBof5tihYoIIkLSUBNY=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 3/4] tty: n_gsm: add RING/CD control support
Date:   Fri,  3 Feb 2023 15:50:22 +0100
Message-Id: <20230203145023.6012-3-daniel.starke@siemens.com>
In-Reply-To: <20230203145023.6012-1-daniel.starke@siemens.com>
References: <20230203145023.6012-1-daniel.starke@siemens.com>
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

The status lines ring and carrier detect are used by the modem to signal
incoming calls (RING) or an established connection (CD). This is
implemented as physical lines on a standard RS232 connection. However,
the muxer protocol encodes these status lines as modem bits IC and DV.
These incoming lines are masked by tty driver (see tty_io.c) and cannot be
set by a user application.

Allow setting RING via TIOCM_OUT1 and CD via TIOCM_OUT2 to allow
implementation of a modem or modem emulator.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 5 +++++
 1 file changed, 5 insertions(+)

v2 -> v3:
No changes.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d068df1cf2fd..cf1ab7d619d9 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -546,6 +546,11 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 		modembits |= MDM_IC;
 	if (dlci->modem_tx & TIOCM_CD || dlci->gsm->initiator)
 		modembits |= MDM_DV;
+	/* special mappings for passive side to operate as UE */
+	if (dlci->modem_tx & TIOCM_OUT1)
+		modembits |= MDM_IC;
+	if (dlci->modem_tx & TIOCM_OUT2)
+		modembits |= MDM_DV;
 	return modembits;
 }
 
-- 
2.34.1

