Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0572F64EF20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiLPQa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiLPQaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:30:13 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788694D5FA;
        Fri, 16 Dec 2022 08:30:12 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 3328BE000A;
        Fri, 16 Dec 2022 16:30:08 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bin Yang <yangbin@rock-chips.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v2 2/2] usb: dwc2: prevent core PHY initialization on Rockchip
Date:   Fri, 16 Dec 2022 17:29:29 +0100
Message-Id: <20221206-dwc2-gadget-dual-role-v2-2-0de821615dd3@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
References: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-141d4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

In Rockchip vendor kernel, the core PHY initialization is disabled with
the following justification:

 The usb phys need to be controlled dynamically on some Rockchip SoCs.
 So set the new HCD flag which prevents USB core from trying to manage
 our phys.

This is required to get USB gadget working in dual-role mode on Ringneck
PX30 SoM on a Haikou Devkit.

Cc: Bin Yang <yangbin@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 9ed9fd956940..9095437b3236 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -117,6 +117,7 @@ static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
 	p->lpm_clock_gating = false;
 	p->besl = false;
 	p->hird_threshold_en = false;
+	p->hcd_skip_phy_initialization = 1;
 }
 
 static void dwc2_set_ltq_params(struct dwc2_hsotg *hsotg)

-- 
2.38.1
