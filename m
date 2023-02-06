Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7368BC01
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBFLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjBFLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:48:51 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 03:48:42 PST
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109F130C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:48:40 -0800 (PST)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202302061147373eb31dba550380a485
        for <linux-kernel@vger.kernel.org>;
        Mon, 06 Feb 2023 12:47:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HhS7+5mD6CUlGIqfQ082PHM7C4tTeQJNXTgjkyBnukA=;
 b=DarpiACRIUtayO5szqOMAQ3wagw2Waz1V8ShxwyFHmgvPLWqfdpqkjntvsngoy2ayfnuTU
 Qfjn9Eo4bqynRXFqhT8ASr2F2gWuR5w4NIUfFuWs945rVEqfsIroiT7CawARGiUQO5q5vYSR
 Pg8MOkvl/RCrUujMYv4AeF3wK1wwA=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 3/4] tty: n_gsm: add RING/CD control support
Date:   Mon,  6 Feb 2023 12:46:05 +0100
Message-Id: <20230206114606.2133-3-daniel.starke@siemens.com>
In-Reply-To: <20230206114606.2133-1-daniel.starke@siemens.com>
References: <20230206114606.2133-1-daniel.starke@siemens.com>
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

v3 -> v4:
No changes.

Link: https://lore.kernel.org/all/20230203145023.6012-3-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c94df9cd282f..79efbfd27171 100644
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

