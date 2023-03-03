Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0886A9DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCCRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCCRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:38:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B64126D2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:38:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c18so2096599wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677865079;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXAgSxR0AuvE1RlyHl2dG9qnudLNG7Z0WUen9Hyx3RE=;
        b=vkdLyLAzlfjGHoHFflYNqeu1C6AJ2M8i7oDRPm4NF4ns4hb3QVl9q8WbtbGkqa/3yL
         ZrGqrcjvBNkVxcov1IyKtlevOrlUML9D1hlgGYmUHIW3UFdFcmbxXjF5iy8I7r5UAOtQ
         axb27zr5JSqBXqkMp7ZID+wOj5pIV/o+e2MKon27vwp3lFB6zf2slnvwJi0GjMwuXJ0y
         i5yw4XUDDA4jTXxJz8dpVRZviKH/X2q9oOH9GE43ZBRDZ2xFZhdkXDiGgraqf4xHS6cR
         T6HnydwjesttCN/5LF230BFO51hxTTuQbiTeU/7gKeFqPkMUANxU4KIHvEUHwFuPnlxW
         6tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677865079;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXAgSxR0AuvE1RlyHl2dG9qnudLNG7Z0WUen9Hyx3RE=;
        b=w4mPHRYt7Bq1UK2YS8ZDrkpzjErXJWi+w8oNDKkK6hHZaAV+GyEzV8kQYMM+O/l+jr
         Pj60yorrywlnO0OE7orupFoiIL/hS6lPkvPE80kz+vwQP7ahFilow1f23avk5yEpa0Cm
         pUjAhLIkShB/gXfgFXg2LhNAadFr8uVtY4vZGIpOvqIYUiod/Q5kh/m4Mck1TsXHbgBD
         uwTQbQvXwc2XbkvvZBV67yPEeHXmLZLyDC1gRNVuPlhye7CTja+0qYY6gsNfr21IQKic
         iLjM5QiboI5znr0/7tXRIc6yOHHoHcuDvVsv2y+r+1LCZPm31hU9mF86XBvJO/6b3BCU
         DALg==
X-Gm-Message-State: AO0yUKWEaoUDW5l7H1/p4MyyohsiLkMsauaYT9dUfnNMKPanwmDt1qHX
        sGhQEXnx87oHkoVVDKW0wLunoA==
X-Google-Smtp-Source: AK7set++YWc0KYr2Viqi8a+s+yXjDowfZmZqPONnrixxWTi/0ABDatqDREtvS/0B29vq2Sw60EJ6Ig==
X-Received: by 2002:a05:600c:1553:b0:3eb:3f2d:f22f with SMTP id f19-20020a05600c155300b003eb3f2df22fmr2458292wmg.21.1677865079531;
        Fri, 03 Mar 2023 09:37:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c161300b003eb5a0873e0sm2990170wmn.39.2023.03.03.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:37:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] arm64: amlogic: Add initial support for BPI-CM4 module
 with BPI-CM4IO baseboard
Date:   Fri, 03 Mar 2023 18:37:56 +0100
Message-Id: <20230303-topic-amlogic-upstream-bpi-cm4-v1-0-5a23a1ade6bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQwAmQC/x2NSwrDMAxErxK0rsB1mtL0KqUL21USgX/ISQmE3
 L2izGJ4s3hzQCNhavDsDhD6cuOSFa6XDsLi8kzIH2WwxvZGg2upHNClWGbtrbZVyCX0lTGkG46
 WzHC302McDKjEu0boxeWwqCZvMepYhSbe/6+v93n+ABzNLdiFAAAA
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for both the BananaPi BPI-CM4 module and the BananaPi
baseboard which is comnpatible with the RaspberryPi CM4IO baseboard.
                                                                                            
The BananaPi BPI-CM4 module follows the CM4 specifications at [1],
but with a single HDMI port and a since DSI output.

The current CM4IO baseboard DT should work fine on the Raspberry CM4
baseboard and other derivatives baseboards, but proper DT should
be written for other baseboards.

The split is done so it's easy to describe a new CM4 baseboard, enabling
only the necessary HW used on the baseboard.

[1] https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      dt-bindings: arm: amlogic: Document the boards with the BPI-CM4 connected
      arm64: dts: amlogic: Add initial support for BPI-CM4 module with BPI-CM4IO baseboard

 Documentation/devicetree/bindings/arm/amlogic.yaml |   8 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts  | 165 +++++++++
 .../boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi  | 388 +++++++++++++++++++++
 4 files changed, 562 insertions(+)
---
base-commit: 38d2b86a665b5e86371a1a30228bce259aa6c101
change-id: 20230303-topic-amlogic-upstream-bpi-cm4-92e0562f8950

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

