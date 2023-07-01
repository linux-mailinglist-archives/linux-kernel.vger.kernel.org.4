Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5C7449DD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGAOgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGAOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:36:46 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA5399;
        Sat,  1 Jul 2023 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688222201;
        bh=bTXXrh3I7Ct13OK63PeVaHtQA/9y4IkNy2DPolC2mMg=;
        h=From:To:Cc:Subject:Date;
        b=nNq0b0YtjEFDSP53Hj+bpcR3o5rq0NlWKZDZZcV5e5tTsJhnB2TEitXvOTJkQSaVJ
         57tAfVn7tcMmSdEkDC8uByNfFPAKC9OnIzDKTJvQf0gNoqP0jmGA25gUZ5XJ+/iblL
         VUh1Bste6mrQvt3F97FDAXNU/esesUpznBSKRlmA=
Received: from localhost.localdomain ([116.132.239.198])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 7902A2CB; Sat, 01 Jul 2023 22:30:16 +0800
X-QQ-mid: xmsmtpt1688221816tcmhwbai2
Message-ID: <tencent_71A3B792C0AA3D9E148E517B24BC6E006A09@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTdjorrBObRnaBbbmHnXwCW6Hdeb+OBv/ZDseonaZ15xWGfRdj5u
         OnKCTkJfWMmoXIvyy8b8UA7TD4AwyyOqz1bdXmfi9g4gg90zH/Ok//SJsyASCl62HYFCHtEM8aFf
         L6EfP+u+xBfo4DRM/cJuqKBrdGZdcsaXK7JsGXDlLsjwrZH8H7m6Gu5b5VeEjmml3I+rncCaG63H
         u2+Uxtq+xl2ylXPmdAIop8f21ktj1/HL9PafTwwsKz3ZHB/JXWmLxaw8OA+fAG+X7I24DekClufs
         oGsRPwErEGI1ENx9PYhrTo8dKSF3gsgivUMcWPD4T4sWuFvAZL8NMl3QwhTePxmWRtGoiYeUBTSr
         AKhYL/jWArdLVQlE/bINXOn1POLHFMd5W48Xotfr0BBVb/nhPAW7tnJfcG2/4l2Jcz/z97Bg3u3Y
         7JqDHI477WIruFBbAZ80beamqzfUud6hDHWztJ/cOHkgIQXDZEZYDQOVSDjwRNzX6cdQLDixM0XE
         k9WL3HO8E5mFlByWV6bNM9gRM8PQzrlLE76Ob4kPbHuyCvRL4ANxcPChJ1MScFVRNXL9Krrb/1fv
         8rrodbptK80hV+X6eD8qjJCa94tTuA9DBg3fo30IfpWOwvzEGAk0QNagDBY3SZIbBlw8r1zusW1z
         P1BM3R5m8flfSpzJPzelwKFnhezhnZ6JdIR2AaXFlamYmONpeUW4qKV3wa4w1XD/gqG7kZfLmxTs
         OmXoSkPcNHieFiiUS5cxKjhPB8V/9d/SZezqAQvF4R64rbBdd+h0JD0zeWnvGiakq/MaZs0h+XTL
         tx2m9MLLJWlsaBJ6vKBAafSiMbwbkumu0nTYiXHunBIfYk+C+7346Eo6ST+m5XLXr4tv+CdyKIq3
         byF7cV/U3WO1fUFnY36YOjOgf5FKWlXYpgY0BSnY+7j33wAa8k3CwJNeS/M3umrH0JpYSmKV8mfg
         m5qTk2bm/d5rU0J8BvDJYeHkTJV2Mix9evsXY09Usv3WDoHjJ/UZhRP8JABJ8r
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     gregkh@linuxfoundation.org
Cc:     u.kleine-koenig@pengutronix.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] usb: r8a66597-hcd: host: fix port index underflow and UBSAN complains
Date:   Sat,  1 Jul 2023 22:29:57 +0800
X-OQ-MSGID: <20230701142957.3352-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If wIndex is 0 (and it often is), these calculations underflow and
UBSAN complains, here resolve this by not decrementing the index when
it is equal to 0.

Similar commit 85e3990bea49 ("USB: EHCI: avoid undefined pointer
arithmetic and placate UBSAN")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/usb/host/r8a66597-hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 9f4bf8c5f8a5..a65e0d995a4b 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2141,9 +2141,11 @@ static int r8a66597_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 {
 	struct r8a66597 *r8a66597 = hcd_to_r8a66597(hcd);
 	int ret;
-	int port = (wIndex & 0x00FF) - 1;
-	struct r8a66597_root_hub *rh = &r8a66597->root_hub[port];
 	unsigned long flags;
+	u32 port_index = wIndex & 0xFF;
+
+	int port -= (port_index > 0);
+	struct r8a66597_root_hub *rh = &r8a66597->root_hub[port];
 
 	ret = 0;
 
-- 
2.41.0

