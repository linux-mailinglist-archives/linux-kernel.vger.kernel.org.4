Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47371FD40
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjFBJMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjFBJLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:11:42 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 02:10:16 PDT
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B18910EC;
        Fri,  2 Jun 2023 02:10:16 -0700 (PDT)
From:   Daniil Dulov <d.dulov@aladdin.ru>
To:     Jemma Denson <jdenson@gmail.com>
CC:     Daniil Dulov <d.dulov@aladdin.ru>,
        Patrick Boettcher <patrick.boettcher@posteo.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: [PATCH] media: cx24120: Add retval check for cx24120_message_send()
Date:   Fri, 2 Jun 2023 01:55:01 -0700
Message-ID: <20230602085501.375731-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.20.125]
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cx24120_message_send() returns error, we should keep local struct
unchanged.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5afc9a25be8d ("[media] Add support for TechniSat Skystar S2")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/media/dvb-frontends/cx24120.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/cx24120.c b/drivers/media/dvb-frontends/cx24120.c
index 2464b63fe0cf..307efef263f2 100644
--- a/drivers/media/dvb-frontends/cx24120.c
+++ b/drivers/media/dvb-frontends/cx24120.c
@@ -972,7 +972,9 @@ static void cx24120_set_clock_ratios(struct dvb_frontend *fe)
 	cmd.arg[8] = (clock_ratios_table[idx].rate >> 8) & 0xff;
 	cmd.arg[9] = (clock_ratios_table[idx].rate >> 0) & 0xff;
 
-	cx24120_message_send(state, &cmd);
+	ret = cx24120_message_send(state, &cmd);
+	if (ret != 0)
+		return;
 
 	/* Calculate ber window rates for stat work */
 	cx24120_calculate_ber_window(state, clock_ratios_table[idx].rate);
-- 
2.25.1

