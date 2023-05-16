Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF58E7058D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEPU2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjEPU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E6776BF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A6363A0B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E8AC4339B;
        Tue, 16 May 2023 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268871;
        bh=sfgV9HY8dwtJ3Sv8P/RJdi60yqFBSKBu5UEl+OFhL8A=;
        h=From:To:Cc:Subject:Date:From;
        b=YB8SszKjLhZQUYiC2kX8p3x/of9ENI3oPjkM3LoWjIXDffii0h0lM9Uy+70qcdcyZ
         J1j7VseFWwiciyYfi8fpzn6jM4bnAAX2FTSwAhnAt6bVWf4cbrkguINCEUU3SbxfHB
         5V2Cp8YK5GpnMYVfRqjI7+RrJri/B/NzVuD5037v38GhZMll/22iNu3zlHMuYgnb2t
         sBO3o3NO9GvadoOp84HsnymoYgtULDRFtCPtjpG/vwLxGryFtaHq0FNq1AsnGft0tl
         ZiYtt2xvNz5AyBo/8VSQcnMPrz2w8XC1chqUK1HzLBHc4oJrh6OPcUp9SsghNorHmo
         I1XqzulsFuH5w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: intel-lpss: hide suspend/resume functions in #ifdef
Date:   Tue, 16 May 2023 22:27:42 +0200
Message-Id: <20230516202746.561111-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_PM is disabled, the prototypes for these two functions
are not visible:

drivers/mfd/intel-lpss.c:482:5: error: no previous prototype for 'intel_lpss_suspend' [-Werror=missing-prototypes]
  482 | int intel_lpss_suspend(struct device *dev)
      |     ^~~~~~~~~~~~~~~~~~
drivers/mfd/intel-lpss.c:503:5: error: no previous prototype for 'intel_lpss_resume' [-Werror=missing-prototypes]
  503 | int intel_lpss_resume(struct device *dev)

Add the same #ifdef around the definition of the unused functions,
which avoids the warning and slightly reduces the code size.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/intel-lpss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index cfbee2cfba6b..9591b354072a 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -460,6 +460,7 @@ void intel_lpss_remove(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(intel_lpss_remove);
 
+#ifdef CONFIG_PM
 static int resume_lpss_device(struct device *dev, void *data)
 {
 	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
@@ -514,6 +515,7 @@ int intel_lpss_resume(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(intel_lpss_resume);
+#endif
 
 static int __init intel_lpss_init(void)
 {
-- 
2.39.2

