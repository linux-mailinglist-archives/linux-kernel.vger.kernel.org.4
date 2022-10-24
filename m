Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753BC60AF79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJXPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiJXPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658601DF16
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DCA861411
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B210C433C1;
        Mon, 24 Oct 2022 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666622183;
        bh=3kVC08NNnjFfypW5XVgXQUIfx+GRlGJ5ATemF0ZLdmw=;
        h=From:To:Cc:Subject:Date:From;
        b=jlYzoYpqGGQYY02ihbgVoc81e1agDYRoPao2MzOMdUiTfSm00R8EQj1B0+NtYNZ22
         3t3gE0TeKcerQKjRrMvIVjbe3+DVRkQpUKMhrXRQiNvcoS+2WBdyTou6ou4Y2rsZQx
         eFGFxTtN+QyzIA9ijbAW0JaBNA2Gv1VKXtlX/P9ofeyKcxfbUXF13l0gE+ehTNu4/H
         VTDJsT2znJ7Y35vnFo68kaubli2YNgpSYAzyzQ7dcu2oAyg8eFdA29W1P5XFioaOuq
         1v83QMhC44vsh0vQJez6dgChusgYSM9ykg4XQ29Yx5+w8ee7H0qDZJc6Ze6DU1YJKl
         D99mm77T8l6wQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omyYh-00030Y-7j; Mon, 24 Oct 2022 16:36:07 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] firmware/psci: demote suspend-mode warning to debug level
Date:   Mon, 24 Oct 2022 16:34:17 +0200
Message-Id: <20221024143417.11463-1-johan+linaro@kernel.org>
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

On some Qualcomm platform, like SC8280XP, the attempt to set PC mode
during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
is now logged at warning level:

	psci: failed to set PC mode: -3

As there is nothing users can do about the firmware behaving this way,
demote the warning to debug level.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Note that a separate change to the cpuidle driver will start logging the
mode actually used:

	https://lore.kernel.org/all/20221020115513.93809-1-ulf.hansson@linaro.org/

Johan


 drivers/firmware/psci/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e7bcfca4159f..462f37fa6a86 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -165,7 +165,7 @@ int psci_set_osi_mode(bool enable)
 
 	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
 	if (err < 0)
-		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
+		pr_debug("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
 	return psci_to_linux_errno(err);
 }
 
-- 
2.37.3

