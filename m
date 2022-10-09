Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10F55F89FF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJIHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJIHYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:24:23 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1241F622;
        Sun,  9 Oct 2022 00:24:22 -0700 (PDT)
Received: from localhost.localdomain ([222.20.126.44])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 2997NQwF022725-2997NQwI022725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 9 Oct 2022 15:23:31 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: cdns3: adjust the partial logic of cdnsp_pci_remove
Date:   Sun,  9 Oct 2022 15:23:05 +0800
Message-Id: <20221009072305.1593707-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cdnsp_pci_remove, if pci_is_enabled returns true, it will
call cdns_remove; else it will call kfree. Then both control flow
goes to pci_dev_put.

Adjust this logic by modifying it to an if else.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/usb/cdns3/cdnsp-pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index fe8a114c586c..efd54ed918b9 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -192,14 +192,12 @@ static void cdnsp_pci_remove(struct pci_dev *pdev)
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_get_noresume(&pdev->dev);
 
-	if (!pci_is_enabled(func)) {
+	if (pci_is_enabled(func)) {
+		cdns_remove(cdnsp);
+	} else {
 		kfree(cdnsp);
-		goto pci_put;
 	}
 
-	cdns_remove(cdnsp);
-
-pci_put:
 	pci_dev_put(func);
 }
 
-- 
2.25.1

