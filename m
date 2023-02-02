Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756B96882E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjBBPnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBBPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:43:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CCA27D46;
        Thu,  2 Feb 2023 07:42:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B829461BE2;
        Thu,  2 Feb 2023 15:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6DFC4339B;
        Thu,  2 Feb 2023 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351976;
        bh=9jlFcZReaRqGG5HOvntUdmyxy0CRaO52IN9kpSRb2vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/d22WHalF5IHieEA4ZC3AdeKcY3j4jnBr2gh1Zj2mWqDDsuQpS0haOplVBNpPmLH
         OjrXrrg3HRti65BZYpgzkNgZE3SWX0VYdxW2gnkLUGX4SBq1QQxt5aMMUfia4foUeg
         X62puFv1JX/3I+0OBWuz5wnVwwHj9ze7NTHweqtw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] USB: gadget: s3c2410_udc: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:32:35 +0100
Message-Id: <20230202153235.2412790-13-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=gregkh@linuxfoundation.org; h=from:subject; bh=9jlFcZReaRqGG5HOvntUdmyxy0CRaO52IN9kpSRb2vs=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r09eL5hl8nPLpjW9Ex/53eWat+utokDKkYcxQV9a05Yt YKnX7YhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJPLZmmF+7cu2Ca7vnFfyz2Hta8r FI2dHca7MY5nAaKEa/PxRfsrPmDYv45xgu2w7R9QA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jakob Koschel <jakobkoschel@gmail.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/s3c2410_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index 8c57b191e52b..3525a3c260a7 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -1881,7 +1881,7 @@ static int s3c2410_udc_remove(struct platform_device *pdev)
 		return -EBUSY;
 
 	usb_del_gadget_udc(&udc->gadget);
-	debugfs_remove(debugfs_lookup("registers", s3c2410_udc_debugfs_root));
+	debugfs_lookup_and_remove("registers", s3c2410_udc_debugfs_root);
 
 	if (udc->vbus_gpiod)
 		free_irq(gpiod_to_irq(udc->vbus_gpiod), udc);
-- 
2.39.1

