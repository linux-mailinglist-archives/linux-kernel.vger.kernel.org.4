Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF15867FEBB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjA2ME5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2MEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:04:55 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCB6212AD;
        Sun, 29 Jan 2023 04:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1674993889; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=FMxvNvScFeDpnWHOGLZpFA/TtqLA5G8GagZO9Tylivo=;
        b=z3zESg1noeFor04quLxNTJchiE2tZxdyOECgsz5OgJvYLA+bF8+jkU0ok5W8dTsQRvQ/VB
        LunP1AShAH8JSouVV+zirYDpXhIhqNZz1v01dJYpErYz3XNIwoPkafiNqd4QwNiwI1Yopy
        HNQFPjHq5KcK6MnVKTuuYISdy7yKkcY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        list@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 0/4] rtc: jz4740: Various updates
Date:   Sun, 29 Jan 2023 12:04:38 +0000
Message-Id: <20230129120442.22858-1-paul@crapouillou.net>
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

Hi,

Here's a revised patchset that introduces a few updates to the
jz4740-rtc driver.

Patch [1/4] used to break ABI, it does not anymore.
Patch [2/4] did not change, patch [3/4] is new.

Patch [3/4] has been updated to use dev_err_probe(), use __clk_hw_get()
instead of looking up the parent's clock by name, and will now register
the CLK32K clock when the #clock-cells device property is present
instead of doing it based on the compatible string.

V2 had an extra patch to add support for fine-tuning the RTC; but since
it was not tested enough I decided to drop it from the V3 until it's
ready for prime time.

Cheers,
-Paul

Paul Cercueil (4):
  dt-bindings: rtc: Add #clock-cells property
  rtc: jz4740: Use readl_poll_timeout
  rtc: jz4740: Use dev_err_probe()
  rtc: jz4740: Register clock provider for the CLK32K pin

 .../devicetree/bindings/rtc/ingenic,rtc.yaml  | 29 ++++++
 drivers/rtc/Kconfig                           |  2 +-
 drivers/rtc/rtc-jz4740.c                      | 94 ++++++++++++++-----
 3 files changed, 99 insertions(+), 26 deletions(-)

-- 
2.39.0

