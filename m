Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E701609508
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJWRQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJWRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:16:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFFB5B712;
        Sun, 23 Oct 2022 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666545376; x=1698081376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=phJn1/NZrxTs/vQXICVYO2Tr/COj78RHiDOjKVWAHsc=;
  b=liSV7eSJOue89sYHiTh2OUv8949gI/zH8YvSqcZvaQXqL9UL+xm9skoa
   p6nwQcQ/55nkkETQqnreQGfqrX91QS09IZwSNn1j1EcGCW0mVYlAp7A8A
   fpeuy9GLIjhN+Z1oZiBgzg0aJBYmxrzttr7GGgokiQRTYAB8y+gnEc5LE
   59QYn7Nw+aPacjW1kg36BXlvTrG3JkNTyGoaKBSn37kA8hrF84f3I4jfb
   OvVC/x2y0GHnr0yVN5Srj0hXO9PnjskjHivxbb8Kcy5YnhHSQlqR0Ary/
   nN+g0g8Y8tmn1avLRVaCzyuLv/NitZIeKBDLH0KKxFG8Htqm5rq4HDcSG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="333866876"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="333866876"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 10:16:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="608961343"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="608961343"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 10:16:12 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com, shawn.c.lee@intel.com,
        antony.chen@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v2] usb: typec: mux: Enter safe mode only when pins need to be reconfigured
Date:   Mon, 24 Oct 2022 22:46:11 +0530
Message-Id: <20221024171611.181468-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to enter safe mode during DP/TBT configuration
if the DP/TBT was already configured in mux. This is because safe
mode is only applicable when there is a need to reconfigure the
pins in order to avoid damage within/to port partner.

In some chrome systems, IOM/mux is already configured before OS
comes up. Thus, when driver is probed, it blindly enters safe
mode due to PD negotiations but only after gfx driver lowers
dp_phy_ownership, will the IOM complete safe mode and send an
ack to PMC.
Since, that never happens, we see IPC timeout.

Hence, allow safe mode only when pin reconfiguration is not
required, which makes sense.

Fixes: 43d596e32276 ("usb: typec: intel_pmc_mux: Check the port status before connect")
Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Signed-off-by: Lee Shawn C <shawn.c.lee@intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

v2:
1. Formatted the title
2. Incorporated the logic in pmc_usb_mux_safe_state
3. Bug fixes
4. Reviewed by

 drivers/usb/typec/mux/intel_pmc_mux.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index a8e273fe204a..795829ffe776 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -369,13 +369,24 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
 	return pmc_usb_command(port, (void *)&req, sizeof(req));
 }
 
-static int pmc_usb_mux_safe_state(struct pmc_usb_port *port)
+static int pmc_usb_mux_safe_state(struct pmc_usb_port *port,
+				  struct typec_mux_state *state)
 {
 	u8 msg;
 
 	if (IOM_PORT_ACTIVITY_IS(port->iom_status, SAFE_MODE))
 		return 0;
 
+	if ((IOM_PORT_ACTIVITY_IS(port->iom_status, DP) ||
+	     IOM_PORT_ACTIVITY_IS(port->iom_status, DP_MFD)) &&
+	     state->alt && state->alt->svid == USB_TYPEC_DP_SID)
+		return 0;
+
+	if ((IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
+	     IOM_PORT_ACTIVITY_IS(port->iom_status, ALT_MODE_TBT_USB)) &&
+	     state->alt && state->alt->svid == USB_TYPEC_TBT_SID)
+		return 0;
+
 	msg = PMC_USB_SAFE_MODE;
 	msg |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 
@@ -443,7 +454,7 @@ pmc_usb_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
 		return 0;
 
 	if (state->mode == TYPEC_STATE_SAFE)
-		return pmc_usb_mux_safe_state(port);
+		return pmc_usb_mux_safe_state(port, state);
 	if (state->mode == TYPEC_STATE_USB)
 		return pmc_usb_connect(port, port->role);
 
-- 
2.34.1

