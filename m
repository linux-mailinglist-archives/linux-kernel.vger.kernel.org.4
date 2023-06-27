Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1674013C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjF0Qcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjF0Qbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:31:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A3359E;
        Tue, 27 Jun 2023 09:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C940F611DD;
        Tue, 27 Jun 2023 16:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35835C433CB;
        Tue, 27 Jun 2023 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687883503;
        bh=GJTR0fuq9BYrm0IoPMBtlqWndUVb8e5wV/QtxPR9vds=;
        h=From:To:Cc:Subject:Date:From;
        b=jX3dBg74rhvE6obyMgTC2O5DQXzvT3zGCWLUbE9iEDYUD0uUQgbqU2Ing/+JiTHtg
         bFYV0rXN/qU3rjtMYpoDWzh4McJXPqeFqxxPUzE7EVP6uV/1xn5XoD+Bsau9baRoPa
         B0k6ERoKzti4dXyNzbj42FbOj/hSZ7FUIf3Zruuhv21JzlkbfszPK0qWMsfcR6j1kt
         r67gk6BQsr19XlxiMg/I+R6f7GokpUY8ryb1I5R2Q/Cbtyro+Qit8cwMaVPiiASp7j
         sv3gwd9KdglLia6V7RfpRcU/vilB7OSOyQMsdhzXIocIefhfCgAqAbPMGrkhC+TB+w
         UCyXsXULDS7CQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: don't reset device side if dwc3 was configured as host-only
Date:   Wed, 28 Jun 2023 00:20:18 +0800
Message-Id: <20230627162018.739-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
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

Commit c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on
system_suspend in host mode") replaces check for HOST only dr_mode with
current_dr_role. But during booting, the current_dr_role isn't
initialized, thus the device side reset is always issued even if dwc3
was configured as host-only. What's more, on some platforms with host
only dwc3, aways issuing device side reset by accessing device register
block can cause kernel panic.

Fixes: c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7b2ce013cc5b..16d7a1d1cbfa 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,9 +277,9 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode, then we can return early.
+	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-- 
2.40.1

