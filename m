Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC6645AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLGNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLGNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:19:43 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E92322B1A;
        Wed,  7 Dec 2022 05:19:41 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A39924000A;
        Wed,  7 Dec 2022 13:19:36 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>,
        Bin Yang <yangbin@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 0/3] usb: dwc2: fix USB peripheral role in dual-role mode on PX30
Date:   Wed,  7 Dec 2022 14:19:15 +0100
Message-Id: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

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

I'm assuming the patch disabling phy initialization might need to be made
Rockchip-specific?

To: Minas Harutyunyan <hminas@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: William Wu <william.wu@rock-chips.com>
Cc: Frank Wang <frank.wang@rock-chips.com>
Cc: Bin Yang <yangbin@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

---
Bin Yang (1):
      usb: dwc2: prevent core phy initialisation

Quentin Schulz (2):
      usb: dwc2: disable lpm feature on Rockchip SoCs
      usb: dwc2: power on/off phy for peripheral mode in dual-role mode

 drivers/usb/dwc2/gadget.c   | 6 ++++--
 drivers/usb/dwc2/hcd.c      | 7 +++++++
 drivers/usb/dwc2/params.c   | 4 ++++
 drivers/usb/dwc2/platform.c | 3 ++-
 4 files changed, 17 insertions(+), 3 deletions(-)
---
base-commit: 76dcd734eca23168cb008912c0f69ff408905235
change-id: 20221206-dwc2-gadget-dual-role-aac67e6d42fd

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>
