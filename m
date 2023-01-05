Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6240465E81A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjAEJoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAEJod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:44:33 -0500
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5C1479EA;
        Thu,  5 Jan 2023 01:44:32 -0800 (PST)
X-UUID: 804c3e73b6a14ec39fec93fa705b63bf-20230105
X-CPASD-INFO: 67c3d77b275c46ada19488d1ec90ff30@f4edU5FpZZJeV3evg3msnoFiaWRoZIS
        Ap51ZYpSWX1CVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBiXoZgUZB3hXmdU5ZlZw==
X-CLOUD-ID: 67c3d77b275c46ada19488d1ec90ff30
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:2.0,URL:-5,TVAL:173.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:73.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:2.0,CFOB:2.0,SPC:0,SIG:-5
        ,AUF:7,DUF:11702,ACD:193,DCD:193,SL:0,EISP:0,AG:0,CFC:0.373,CFSR:0.127,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 804c3e73b6a14ec39fec93fa705b63bf-20230105
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 804c3e73b6a14ec39fec93fa705b63bf-20230105
X-User: xurui@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <xurui@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 210505913; Thu, 05 Jan 2023 17:44:30 +0800
From:   xurui <xurui@kylinos.cn>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        xurui <xurui@kylinos.cn>
Subject: [PATCH] fbdev/g364fb: Fix a compilation issue
Date:   Thu,  5 Jan 2023 17:44:39 +0800
Message-Id: <20230105094439.1478337-1-xurui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/video/fbdev/g364fb.c:202:4: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]

Signed-off-by: xurui <xurui@kylinos.cn>
---
 drivers/video/fbdev/g364fb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/g364fb.c b/drivers/video/fbdev/g364fb.c
index 05837a3b985c..beef4bcec3c5 100644
--- a/drivers/video/fbdev/g364fb.c
+++ b/drivers/video/fbdev/g364fb.c
@@ -175,7 +175,8 @@ int __init g364fb_init(void)
 {
 	volatile unsigned int *curs_pal_ptr =
 	    (volatile unsigned int *) CURS_PAL_REG;
-	int mem, i;
+	int mem;
+	uintptr_t i;
 
 	if (fb_get_options("g364fb", NULL))
 		return -ENODEV;
-- 
2.25.1

