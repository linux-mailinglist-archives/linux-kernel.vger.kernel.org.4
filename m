Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3964EF1C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiLPQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiLPQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:30:08 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A0956D5D;
        Fri, 16 Dec 2022 08:30:07 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id A9E43E000B;
        Fri, 16 Dec 2022 16:30:01 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bin Yang <yangbin@rock-chips.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v2 0/2] usb: dwc2: fix USB peripheral role in dual-role mode on PX30
Date:   Fri, 16 Dec 2022 17:29:27 +0100
Message-Id: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
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

On Theobroma Ringneck SoM, USB peripheral role when in dual-role mode does not
work and displays the following error message:
dwc2 ff300000.usb: dwc2_core_reset: HANG! Soft Reset timeout GRSTCTL_CSFTRST

The USB sniffer shows nothing and dumping the host registers is stuck on
HCDMA(0) register.

Note that for some reason it works "fine" on PX30-EVB (there's another issue but
not related to/fixed in this patch series).

Since there's no documentation available for this IP, this patch series is
basically just slightly adapted downstream BSP vendor kernel patches and I
cannot unfortunately give more information than what I have.

This patch series was tested on Theobroma Ringneck SoM on Haikou devkit and PX30
EVB. It fixes Ringneck support and does not break PX30-EVB's.

For reference, the content of those commits can be found in tag
linux-5.10-gen-rkr1, and the following commits have been used:
964d50060bf53a8defd1fc561b9261424f25ddad
ad81c375602819a538ad68d979906c05663046e2
6e6adab8f735bc4fe27a67bdc3144d8fa89250d4
7c3a4e60247fd7f7b04d95d15cb12c63a5c20408

Note that Rockchip kernel called a slightly different implementation of
__dwc2_lowlevel_hw_enable instead of dwc2_lowlevel_hw_enable but it seemed more
right to me to call dwc2_lowlevel_hw_enable as done for the forced peripheral
mode.

Note that it is still not flawlessly working but the support is improved
(somewhat working vs not working at all).

To: Minas Harutyunyan <hminas@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Bin Yang <yangbin@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Changes in v2:
- add "shadow" variable for HCD skip_phy_initialization so that it can be
  configured on a per-platform basis,
- Patch 1 and Patch 2 of the v1 are already in linux-next next-20221216, so removed from this series,
- Link to v1: https://lore.kernel.org/r/20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com

---
Quentin Schulz (2):
      usb: dwc2: allow platforms to prevent core phy initialisation
      usb: dwc2: prevent core PHY initialization on Rockchip

 drivers/usb/dwc2/core.h   | 6 ++++++
 drivers/usb/dwc2/hcd.c    | 2 ++
 drivers/usb/dwc2/params.c | 1 +
 3 files changed, 9 insertions(+)
---
base-commit: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
change-id: 20221206-dwc2-gadget-dual-role-aac67e6d42fd

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>
