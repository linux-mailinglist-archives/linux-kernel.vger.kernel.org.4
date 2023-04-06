Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C867C6D98B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbjDFN4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbjDFNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:55:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB4D7D9A;
        Thu,  6 Apr 2023 06:55:57 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-216.ewe-ip-backbone.de [91.248.189.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F5E666031C4;
        Thu,  6 Apr 2023 14:55:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680789355;
        bh=2/b7fnBYB9tfIRfdA8hbgFbYJXG7VEGgEbFn0/+ybOs=;
        h=From:To:Cc:Subject:Date:From;
        b=AkWVVjJmnECaY3BGS0UO8rAGgvbEzSP7eV/1j3SPO7cPN/M34UV/c69hLpA5FcG3Z
         QqErf6JAK8Y4Wq2OrzAHIMz2glqCVipeOIR2MSPoIxhYnpNChJQfCQqmlhx9F6PEvn
         exAqHs0oFHDw5yeaVFCicg6C0+vLQ3nqaa3mgXqC1uw6XJRsLdz4ONXCfSSI2JdHlt
         SKfYjybBgPNqMpoGTo4npdCZAb1XpnQfT+Tn8F7qNkomh64DtKBVUAZCTE12uroMPp
         riigSEWEddT0XykmJAefRoxWLj3Uvm/9gWp98zRv7WQSw87GYb3GgxWb2TYwyrmkkq
         hbHy+LxBl7//Q==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E681A4807E1; Thu,  6 Apr 2023 15:55:52 +0200 (CEST)
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
Date:   Thu,  6 Apr 2023 15:55:49 +0200
Message-Id: <20230406135552.23980-1-sebastian.reichel@collabora.com>
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

Changes since PATCHv2:
 * https://lore.kernel.org/all/20230404145350.45388-1-sebastian.reichel@collabora.com/
 * Added Krzysztof's Ack to the EHCI binding update
 * Changed OHCI binding update according to Krzysztof's feedback

Changes since PATCHv1:
 * https://lore.kernel.org/all/20230331163148.5863-1-sebastian.reichel@collabora.com/
 * changed cover-letter subject
 * Add Alan's Acked-by to the driver patch increasing the clock count
 * Update bindings, adding rockchip,rk3588-ohci and rockchip,rk3588-ehci compatibles

-- Sebastian

Sebastian Reichel (3):
  dt-bindings: usb: Add RK3588 OHCI
  dt-bindings: usb: Add RK3588 EHCI
  usb: host: ohci-platform: increase max clock number to 4

 .../devicetree/bindings/usb/generic-ehci.yaml  |  1 +
 .../devicetree/bindings/usb/generic-ohci.yaml  | 18 +++++++++++++++++-
 drivers/usb/host/ohci-platform.c               |  2 +-
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.39.2

