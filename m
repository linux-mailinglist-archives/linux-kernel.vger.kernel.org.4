Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642ED6FDD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbjEJLvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbjEJLvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:51:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85C30FA;
        Wed, 10 May 2023 04:51:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f4ad71b00eso3278935e9.2;
        Wed, 10 May 2023 04:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719503; x=1686311503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=51hEK7YXkoSd1g6Hzk5qdU9VHHvC+FGDBMAdzDyQ404=;
        b=k5aBVriXyqdLa3IZkNKX69lcaW9Rqp0/vMjf590zERAZUjy8WgYBGhmazxCssHrkSY
         uQ59dMQ4HXg2rLjhIz7N5OKyIvXpslN39xFdZDlrw8Fe34yDkeLK0j7pYpK9TYkRbj7y
         cOxl1zEWUCUO1YMLwPO8qvlUld8Fy56oDH5PpShXfeLEJdbA7LbZcfzprH64NIPH1JBo
         DMaRcldozJGZ7YLSu7IDQFUgFCTa4hNBkLI+QzStUyk7BktfPndC8LENa7dg2p9h1Cm/
         Qyu49tPr428d508jhulgTgywFuYXtdy+VbnJWqttkAiMUgI1danfR2tdEWw6JsertGlZ
         928g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719503; x=1686311503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51hEK7YXkoSd1g6Hzk5qdU9VHHvC+FGDBMAdzDyQ404=;
        b=eZxmjku2UycjzSf3q+ruD9d+xetPGozD66Mh2HcqqOcxpZUcaY3+yH7MUOp6CI3GCx
         lenzXKm0MC5W4oWt+cjbrG66SfuexmAgu5pg8GG+Wh/FrB2Ak0JH1cgBQ/88wbz33zWK
         ZHg3JoQ+2FMKflxekeIea3EI3PgdM3Mp4lFPx6XfW6eTIvyzNqR4w4dImHn4/8r3i+qo
         siq9zM8M6jjd3eBCGMGljz0cdp8fEn9bXpIvoDQPeU5wFIerKVLjkDOle0ozedb6eLUl
         7NU/JicV+z7XqlKnrtc+4shlu3HgSI57LoD2Ii1MJBBu68f/iGBxUXg8SmaAR2SH+eDX
         VzUg==
X-Gm-Message-State: AC+VfDxYTO5g7nLTDWvp/X/LaIXswzszFdS9aqhI2gIbhVj0ft4h5/lW
        9slVgBtngB7Qxcj9eOUbyoM=
X-Google-Smtp-Source: ACHHUZ4YdWZGqpWdN1vxCPVAixPSERl9XFM+FnIR1iBCGg7XBTWBBkDEPx/1MGjGxJ0PUVXo8OEyug==
X-Received: by 2002:a1c:4c0b:0:b0:3f4:23e5:5baf with SMTP id z11-20020a1c4c0b000000b003f423e55bafmr7507500wmf.7.1683719503334;
        Wed, 10 May 2023 04:51:43 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b003f4283f5c1bsm7977393wms.2.2023.05.10.04.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:51:42 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] axp20x_usb_power: Add support for AXP192
Date:   Wed, 10 May 2023 12:50:39 +0100
Message-Id: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the AXP192's USB power supply. Most of this
series (patches 1-5) consists of refactoring the driver to avoid
explicit checks based on the variant ID. Doing that makes it very
easy to add support for the AXP192 in patches 6-7, and as a nice
side benefit, should make the driver more maintainable.

Patches 1-5 are unchanged from their previous submission[1].

[1] https://lore.kernel.org/all/20230218204946.106316-1-aidanmacdonald.0x0@gmail.com/

Aidan MacDonald (7):
  power: supply: axp20x_usb_power: Simplify USB current limit handling
  power: supply: axp20x_usb_power: Use regmap fields for VBUS monitor
    feature
  power: supply: axp20x_usb_power: Use regmap fields for USB BC feature
  power: supply: axp20x_usb_power: Use regmap field for VBUS disabling
  power: supply: axp20x_usb_power: Remove variant IDs from VBUS polling
    check
  power: supply: axp20x_usb_power: Add support for AXP192
  dt-bindings: power: supply: axp20x: Add AXP192 compatible

 .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
 drivers/power/supply/axp20x_usb_power.c       | 307 +++++++++---------
 2 files changed, 153 insertions(+), 155 deletions(-)

-- 
2.39.2

