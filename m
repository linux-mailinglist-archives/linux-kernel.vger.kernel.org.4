Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8CF6B80B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjCMScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjCMSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:31:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A2582A94;
        Mon, 13 Mar 2023 11:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CCABB811E3;
        Mon, 13 Mar 2023 18:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9ABC433D2;
        Mon, 13 Mar 2023 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732186;
        bh=BQ3qJWQ4zg4slNAg8mMque6OMF2Djl4oQD+H69jP9YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOUprOLhlkrlwRZlYiu/wusk/ux2b99AOfviPnKSf76GQ+8jEd73QVbTrjw/hspgt
         4/VnagP02qN2iTAexDyC3Dfip+bob26aEJ47a2TyvbqJcwJu3DvHpnI3IHsN+7L7T0
         nYFQqJV33hPBlZE6QD0wkfj2buWCA9/P06lYmIkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 17/36] sh: intc: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:59 +0100
Message-Id: <20230313182918.1312597-17-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=gregkh@linuxfoundation.org; h=from:subject; bh=BQ3qJWQ4zg4slNAg8mMque6OMF2Djl4oQD+H69jP9YY=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82RWiLd1ftjeein5+RdZTqZ4vXOT8mUW3BDf4n/fa5 vauY09iRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzkjDrDgrmXDFfe01psfmur 8OJyrscbWTMyLRgWNN8X4bb9MP25+R2T4CKV2SyczH5XAA==
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

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/sh/intc/userimask.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
index f9f043a3d90a..abe9091827cd 100644
--- a/drivers/sh/intc/userimask.c
+++ b/drivers/sh/intc/userimask.c
@@ -61,10 +61,18 @@ static DEVICE_ATTR(userimask, S_IRUSR | S_IWUSR,
 
 static int __init userimask_sysdev_init(void)
 {
+	struct device *dev_root;
+	int ret = 0;
+
 	if (unlikely(!uimask))
 		return -ENXIO;
 
-	return device_create_file(intc_subsys.dev_root, &dev_attr_userimask);
+	dev_root = bus_get_dev_root(&intc_subsys);
+	if (dev_root) {
+		ret = device_create_file(dev_root, &dev_attr_userimask);
+		put_device(dev_root);
+	}
+	return ret;
 }
 late_initcall(userimask_sysdev_init);
 
-- 
2.39.2

