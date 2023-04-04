Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F96D65D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjDDOyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjDDOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:53:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2410F9;
        Tue,  4 Apr 2023 07:53:55 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-190-097.ewe-ip-backbone.de [91.248.190.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1E75660316B;
        Tue,  4 Apr 2023 15:53:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680620034;
        bh=Rox0MV0ygtFD00bZWntkUfuFnzpO8a/o2DyaAD/vPW8=;
        h=From:To:Cc:Subject:Date:From;
        b=Vsv11d5K+i+BVfjQQnhgzSVMwZ3mnJoWt0/Pl6cMloSAop5WnNDcTfdz5qr/qzqni
         ax7E+n6yWrXyrKaXOjnLQgeLXrAcg1eHOnvKRu2CppD/qAL+MZXfS+GAItgDEImuH0
         b7mLf0OTVXRZzapxfShPSjMdrHEOPWXJRBwn/Uy39qqeeh8QYG4B8vtZUEJxD509UX
         cfxHW3sRDajr5gz+CJUs6+3+3lceVXOXOJdcbaSG+pcHOfuCZAd+dkQ7b4mHOTC4uq
         kXvQSP+JryV7tG5kuWOQPLfxw7HpmujJL8F1GExVWUOd/mV8N54hb72psIHJdRDt/W
         diCbZSvhtAq/w==
Received: by jupiter.universe (Postfix, from userid 1000)
        id B8E334807E1; Tue,  4 Apr 2023 16:53:51 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 0/3] generic-ohci/ehci: add RK3588 support
Date:   Tue,  4 Apr 2023 16:53:47 +0200
Message-Id: <20230404145350.45388-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This increases the max. allowed clocks for generic-ohci from 3 to 4.
On RK3588 a total of 4 clocks is required to access the OHCI registers.
EHCI already supports 4 clocks.

Changes since PATCHv1:
 * https://lore.kernel.org/all/20230331163148.5863-1-sebastian.reichel@collabora.com/
 * Add Alan's Acked-by to the driver patch increasing the clock count
 * Update bindings, adding rockchip,rk3588-ohci and rockchip,rk3588-ehci compatibles

-- Sebastian

Sebastian Reichel (3):
  dt-bindings: usb: Add RK3588 OHCI
  dt-bindings: usb: Add RK3588 EHCI
  usb: host: ohci-platform: increase max clock number to 4

 .../devicetree/bindings/usb/generic-ehci.yaml  |  1 +
 .../devicetree/bindings/usb/generic-ohci.yaml  | 18 ++++++++++++++++--
 drivers/usb/host/ohci-platform.c               |  2 +-
 3 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.39.2

