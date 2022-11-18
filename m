Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B5F62F16B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbiKRJj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbiKRJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:39:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F67A18B31;
        Fri, 18 Nov 2022 01:39:43 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 26B4FAF4;
        Fri, 18 Nov 2022 10:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668764381;
        bh=8759RmpiUD0qDZZy0EBtArWNV2cOPT6xrqlG+fmlROo=;
        h=From:To:Cc:Subject:Date:From;
        b=FeA6osoqu0n82Tne2fJ/CiBNmJyqNK/nLk+xhu/Z1J3rj36na4gmB+1xjsdkAgKcF
         COTXTrSrfp3WfLvsVuSjAvMdqN1U012qbAl+a/QVrH1T9Vq676jPGTcQa5WaoTfmLx
         J1xYHTSEq9CiCRzFcp0eb8MO9AMKMbPfSh0buMqI=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] media: rkisp1: Add support for i.MX8MP
Date:   Fri, 18 Nov 2022 18:39:17 +0900
Message-Id: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series depends on v3 of "dt-bindings: media: Add macros for video
interface bus types" [1].

This series extends the rkisp1 driver to support the ISP found in the
NXP i.MX8MP SoC.

The ISP IP cores in the Rockchip RK3399 (known as the "Rockchip ISP1")
and in the NXP i.MX8MP have the same origin, and have slightly diverged
over time as they are now independently developed (afaik) by Rockchip
and VeriSilicon. The latter is marketed under the name "ISP8000Nano",
and is close enough to the RK3399 ISP that it can easily be supported by
the same driver.

The last two patches add support for UYVY output format, which can be
implemented on the ISP version in the i.MX8MP but not in the one in the
RK3399.

This version of the series specifically has been tested on a Polyhex
Debix model A with an imx219 (Raspberry Pi cam v2).

[1] https://lore.kernel.org/linux-media/20220615221410.27459-2-laurent.pinchart@ideasonboard.com/

Laurent Pinchart (3):
  dt-bindings: media: rkisp1: Add i.MX8MP ISP example
  media: rkisp1: Add and use rkisp1_has_feature() macro
  media: rkisp1: Configure gasket on i.MX8MP

Paul Elder (11):
  dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
  media: rkisp1: Add match data for i.MX8MP ISP
  media: rkisp1: Add and set registers for crop for i.MX8MP
  media: rkisp1: Add and set registers for output size config on i.MX8MP
  media: rkisp1: Add i.MX8MP-specific registers for MI and resizer
  media: rkisp1: Shift DMA buffer addresses on i.MX8MP
  media: rkisp1: Add register definitions for the test pattern generator
  media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
  media: rkisp1: Support devices without self path
  media: rkisp1: Add YC swap capability
  media: rkisp1: Add UYVY as an output format

 .../bindings/media/rockchip-isp1.yaml         |  79 ++++++++++-
 .../platform/rockchip/rkisp1/rkisp1-capture.c | 102 +++++++++++---
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  32 +++++
 .../platform/rockchip/rkisp1/rkisp1-debug.c   |  14 +-
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |  67 +++++++--
 .../platform/rockchip/rkisp1/rkisp1-isp.c     | 128 +++++++++++++++++-
 .../platform/rockchip/rkisp1/rkisp1-regs.h    |  90 ++++++++++++
 .../platform/rockchip/rkisp1/rkisp1-resizer.c |  35 ++++-
 include/uapi/linux/rkisp1-config.h            |   2 +
 9 files changed, 509 insertions(+), 40 deletions(-)

-- 
2.35.1

