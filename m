Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A796ECAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjDXLAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjDXLAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:00:04 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93DE211F;
        Mon, 24 Apr 2023 04:00:02 -0700 (PDT)
Received: from pride-poweredge-r740.. ([172.16.0.254])
        (user=lihuya@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33OAxja5026652-33OAxja6026652
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Apr 2023 18:59:45 +0800
From:   lihuya <lihuya@hust.edu.cn>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        lihuya <lihuya@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] usb: dwc3: remove dead code in dwc3_otg_get_irq
Date:   Mon, 24 Apr 2023 18:59:31 +0800
Message-Id: <20230424105930.49944-1-lihuya@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lihuya@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() only return non-zero irq number on success, or
negative error number on failure.

There is no need to check the return value of platform_get_irq()
to determine the return value of dwc3_otg_get_irq(), removing
them to solve this problem.

Signed-off-by: lihuya <lihuya@hust.edu.cn>
---
 drivers/usb/dwc3/drd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 039bf241769a..c2e09700212d 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -154,11 +154,6 @@ static int dwc3_otg_get_irq(struct dwc3 *dwc)
 		goto out;
 
 	irq = platform_get_irq(dwc3_pdev, 0);
-	if (irq > 0)
-		goto out;
-
-	if (!irq)
-		irq = -EINVAL;
 
 out:
 	return irq;
-- 
2.34.1

