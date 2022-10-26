Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7113560E2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiJZN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiJZN5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:57:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E0DB9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7700CB82256
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2473BC433D6;
        Wed, 26 Oct 2022 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666792664;
        bh=t4btE/+qdMMC0jKvmw5NCgtrdHE2HNaZB5p9dfo+HMU=;
        h=From:To:Cc:Subject:Date:From;
        b=YrVxNDdhLRgt4PR45aJuqDkjiIqL+57Y58mohI/g8KvpTf8IyUPI5yjThSO51OBiy
         xhm6vtccUlGArHk977rZkB3+FZ9seglvIOZDyJIZM7pOChdqAkDr75kaL/NqkBnYoy
         6SCefp9HcxJCW7R/yfDY/SF/ATwkefo4lttt4OJhVxxFgOFeB1ydwfPTPLQCplF2OL
         3bLWapzQrWoyKubZxG03hlXOOqI5AUDlY6s1IXQ3XNfvnSoxYJG59TbZ8+LUFLYQPw
         QolQN/SQJffGfiE4t6f0Qsqu7hcGQzN63UXoKSW6JHR0BmHwJS3fEtE9rMMeVeQljv
         Z8pjJ/CR5ecsw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1onguM-00026t-U4; Wed, 26 Oct 2022 15:57:27 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2] firmware/psci: demote suspend-mode warning to info level
Date:   Wed, 26 Oct 2022 15:54:45 +0200
Message-Id: <20221026135445.8004-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Qualcomm platforms, like SC8280XP, the attempt to set PC mode
during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
is now logged at warning level:

	psci: failed to set PC mode: -3

As there is nothing users can do about the firmware behaving this way,
demote the warning to info level and clearly mark it as a firmware bug:

	psci: [Firmware Bug]: failed to set PC mode: -3

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/firmware/psci/psci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e7bcfca4159f..f8fa32f0a130 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -165,7 +165,8 @@ int psci_set_osi_mode(bool enable)
 
 	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
 	if (err < 0)
-		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
+		pr_info(FW_BUG "failed to set %s mode: %d\n",
+				enable ? "OSI" : "PC", err);
 	return psci_to_linux_errno(err);
 }
 
-- 
2.37.3

