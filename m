Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F036E1EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDNIsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDNIsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:48:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1122786AA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD5E6459B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51F5C433EF;
        Fri, 14 Apr 2023 08:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681462050;
        bh=xw5UWuO5hoCUdGrcFe+54+dstkTJi6Khjey9N+AhacI=;
        h=From:To:Cc:Subject:Date:From;
        b=BOHfu+Pfr4XbeColxttlDahpgJulwCsmF6zbAAZoR2tRpPDTHXQc+1U/3X2avhSGs
         VyC3Qp7r9O/y6U0xz67dWjDRGDbS5HYywzwuFbVEJsqdlANmFVRASbR7ga0qJ5NXJz
         HFfStk16/nZkUSu4soM4IgXcG3N/Xjuj4XyIneLP2dZ3R3fsSW6tzbbXmcsM8/DytZ
         6rl9j5k/64FfayUr6KzB0QAZnktQzpIzI1c5VKVHdunlbDHG+fPqgUcI68SDbnc+un
         i1C4jR4SF8JqXt8ObvA2Rla4SMtuNAWuL0QwKtbogaN0L2sGGOQgwqpKCxilA9ijSa
         LRBM8CJIv6hCA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pnF5i-0008DN-LJ; Fri, 14 Apr 2023 10:47:35 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH RESEND v2] firmware/psci: demote suspend-mode warning to info level
Date:   Fri, 14 Apr 2023 10:46:19 +0200
Message-Id: <20230414084619.31524-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

This one fell between the cracks so resending with tags added.

Mark or Lorenzo, is this something you can pick up?

Johan


 drivers/firmware/psci/psci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 29619f49873a..d9629ff87861 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -167,7 +167,8 @@ int psci_set_osi_mode(bool enable)
 
 	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
 	if (err < 0)
-		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
+		pr_info(FW_BUG "failed to set %s mode: %d\n",
+				enable ? "OSI" : "PC", err);
 	return psci_to_linux_errno(err);
 }
 
-- 
2.39.2

