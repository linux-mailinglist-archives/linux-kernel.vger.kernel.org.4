Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9491970C36B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjEVQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjEVQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:29:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C5FE;
        Mon, 22 May 2023 09:29:42 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2CD696606E6E;
        Mon, 22 May 2023 17:29:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684772981;
        bh=9ASGeUvinStCu5UjjzSmu8IdJUtabf2Tqkwqbkp/olU=;
        h=From:To:Cc:Subject:Date:From;
        b=T95+iqMZb+YVI9iy2kUF2ABA1Ri/qRxWV7y5RFtj2o8KB2GbD/iDeO2mpT+lVQzUa
         P28hxF11xl65H6SWwC1o/vLx7cjP2s1Ij7eY2wkqNjwPMGtqIH9alC8bXmQD5cXJEv
         UfcVIDYQAdc+J4JPEqRVw/iKf7GVrEhSW83pdUbmHUOzt/dc8lSFmWazttu9V5ruC4
         8Py9WE7+toaoE6ZfJugIHjRwoXZ7IORPoQjNNbl0czNIXW/DOIXpWjKKIdOpqhIi6r
         pIrAllEtgGQlvPXI2Bf3AvrjRa6wEejhyW4RzU13oVNxaFfkEGRP3+3Cs+xj0l57No
         S6NIXsGj62QLQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id EFC574805CC; Mon, 22 May 2023 18:29:37 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 0/3] generic-ohci/ehci: add RK3588 support
Date:   Mon, 22 May 2023 18:29:34 +0200
Message-Id: <20230522162937.53190-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This increases the max. allowed clocks for generic-ohci from 3 to 4.
On RK3588 a total of 4 clocks is required to access the OHCI registers.
EHCI already supports 4 clocks.

Changes since PATCHv4:
 * https://lore.kernel.org/linux-usb/20230413173150.71387-1-sebastian.reichel@collabora.com/
 * Rebase to v6.4-rc1
 * Re-add minItems for rockchip,rk3588-ohci = false

Changes since PATCHv3:
 * https://lore.kernel.org/all/20230406135552.23980-1-sebastian.reichel@collabora.com/
 * Fix the PATCH version in the patchset subjects :)
 * Collect Rob Herrings's Reviewed-by
 * Drop maxItems = 4 from rockchip,rk3588-ohci = true branch (4 is the default value)
 * Drop minItems = 1 from rockchip,rk3588-ohci = false branch (1 is the default value)

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

 .../devicetree/bindings/usb/generic-ehci.yaml   |  1 +
 .../devicetree/bindings/usb/generic-ohci.yaml   | 17 ++++++++++++++++-
 drivers/usb/host/ohci-platform.c                |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.39.2

