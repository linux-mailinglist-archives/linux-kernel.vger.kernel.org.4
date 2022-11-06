Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092E361E18E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiKFKWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKFKWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:22:17 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125946173
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667730122; bh=ISjlC7Zy+nyFdyGUXO1A3JhMcsFjRxDUI5qhIuaQEww=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=BXnanERqeXpxhMkZZL6hWqf/Fk5eUEbmtImWn+m5Uc0A7KF7Um6w7Sf7M5NRAftzy
         7zjFea4uFUItTNNSm/9W2ir0fpmkcjNfxOYmIeQ94A+40HhyZ40GzqBx5vdRIANQMg
         sIIJrSz1Upm30NdtKDdjHZYe29nb5EdsGmCeTauU=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  6 Nov 2022 11:22:02 +0100 (CET)
X-EA-Auth: a+kvvG//INTDj2l+ci+g/2Ip90DYBs8/Wx6kRlgV1YlG+PWrT+xXkgxFT4PzrWnEJ9En91A+4LGBwibu1KVBfatWZZiw29ER
Date:   Sun, 6 Nov 2022 15:51:58 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: use min helper macro for variable
 comparison
Message-ID: <Y2eKxoUWtbPY/88b@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code by using min helper macros in place of lengthy if/else
block oriented logical evaluation and value assignment. This issue is
identified by coccicheck using the minmax.cocci file.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index b6abd3770e81..b4e19174bef2 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -1004,10 +1004,7 @@ static int _nbu2ss_in_dma(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
 	/* MAX Packet Size */
 	mpkt = _nbu2ss_readl(&preg->EP_REGS[num].EP_PCKT_ADRS) & EPN_MPKT;

-	if ((DMA_MAX_COUNT * mpkt) < length)
-		i_write_length = DMA_MAX_COUNT * mpkt;
-	else
-		i_write_length = length;
+	i_write_length = min(DMA_MAX_COUNT * mpkt, length);

 	/*------------------------------------------------------------*/
 	/* Number of transmission packets */
--
2.34.1



