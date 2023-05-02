Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC96D6F483A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjEBQVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjEBQVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A5118E;
        Tue,  2 May 2023 09:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E34261B76;
        Tue,  2 May 2023 16:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73496C433EF;
        Tue,  2 May 2023 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683044502;
        bh=ZzbkDdtCYNoJrBH/OYvqw4h9vP/Qo32eWG/OQtGFegA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sv5UWOKhfs2uI1mryJUJ5j5EHnzxGcTRC/XkPWTbIV3VF6rb8uLSpjt5vKgXoqrmv
         S5gFFV23R8wZ2IQXyk0OpMKlLOHjdP/kOlP7GtNiMW/cfMeFx0Gtt6xVqLDkLdn0Ha
         CXvL52tSQQmq44pQu7H6FmWuYOw2i5Gl6KmQLbDH304kzAuA4dKVpumYNp2oGJh4M5
         Hmj6tU4r+x0IVLxObv8mSa8F9xqMlWUADv6pqbiUNUJMa2seMYikqYwwUthV6NtQAE
         r/ETRgUR/luLQr9iOkxqjDoZX7DsQ/fbys55erHfuB8LIl50Oz7s8PTEqnQIkFaqXk
         UImpqV1BKTc/w==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, r-gunasekaran@ti.com, srk@ti.com,
        wcheng@codeaurora.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] usb: dwc3: gadget: Avoid controller stop in .suspend if !softconnect
Date:   Tue,  2 May 2023 19:21:32 +0300
Message-Id: <20230502162133.148821-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502162133.148821-1-rogerq@kernel.org>
References: <20230502162133.148821-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If softconnect is not set it means the controller has not started,
so no point in stopping it in dwc3_gadget_suspend()

Cc: stable@vger.kernel.org # 5.16
Fixes: 8217f07a5023 ("usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC unbind")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c0ca4d12f95d..b5170374cd18 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4656,7 +4656,7 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
 	unsigned long flags;
 
-	if (!dwc->gadget_driver)
+	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
 	dwc3_gadget_run_stop(dwc, false);
-- 
2.34.1

