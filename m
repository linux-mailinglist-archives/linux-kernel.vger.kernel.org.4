Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879976ABF3C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCFMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjCFMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:13:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9669F1EBEB;
        Mon,  6 Mar 2023 04:13:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso8015393wmi.4;
        Mon, 06 Mar 2023 04:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678104836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT9y+F3nAx8M1+hkZjVAuy8akn4IL3WwNtD6c7JLnj8=;
        b=SOssMskgVOFHRRzz+EZDrSBhxRu46Q/D0JnfzQQY/JmmuNWbIBYI6amj6hG0jL6EGD
         uwmLw9HYjQAH8biJqv4XaMfB35k0i8uz+wd0LzTpeDL+aXchHssuBv0QhyRnl7kCVBuR
         ZHY9oPKG5ZQs5/UHAbPvpvN2wlOZYZxA9k/7qr/JdV92vD/nUAEc0hb+u983/b9X8nTI
         n07BYY+DWweJ3MerFY9w7zevne2hIGdnFr3OULfJzk4DG+TWSzK9mgNpXvOhMNsdtS82
         hL8WnROhHlPDTu2KSLTNFyxL38gvcolMbi7fXL+DzN4vFIqN9QdmYLIYYGSGT8G/aHNv
         nFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678104836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZT9y+F3nAx8M1+hkZjVAuy8akn4IL3WwNtD6c7JLnj8=;
        b=UsXRbwUhNWI+nVSzwn59286kFWvmJqt0U8GCqwIo0ywjkmvapmkvzY/SkpATGRG0Yu
         lFQQo+bRPEjbjVV+MiMCOV9GiNcCQSQelsSNeRSdCSj6z+x+cNU5R/D+xV81x3V2Yfy/
         6B01rzJwBdBXEdxzeVD976w3/Cx+YHYG8COypv057G6VVU3VJQdanp/oT//677FEmxbb
         zhJ9h7O6ub+lioG2dhPm5wZmnZr1fc5obtCb15m2+roFs5GU0FlazkY4+eifV/Ztz7Bd
         otchZYCPEGw7Jb60QCgFFaIXYk2xXnYu6x6hGL1ZVxBNshQeMLq327bUSRo1eJozFzbH
         rQ0g==
X-Gm-Message-State: AO0yUKWjpGMEeFcjN6GDSE5RctFnhpCTsPn6rJSs4O73IC/USebuRwHY
        RaKr0iH36Ilym6NyOSCumkbHx5qp4J9q2g==
X-Google-Smtp-Source: AK7set9dFzn2lm4BCjjz5GEIMiJre2zEgf/nPRpL7Z+sxuK83NltFVE2upco+0CsgkMyJdZjXRA/Jw==
X-Received: by 2002:a05:600c:4509:b0:3eb:29fe:7343 with SMTP id t9-20020a05600c450900b003eb29fe7343mr8812408wmo.33.1678104835886;
        Mon, 06 Mar 2023 04:13:55 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d660a000000b002c70ce264bfsm9814798wru.76.2023.03.06.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 04:13:55 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 0/3] arm64: dts: meson: gxbb-kii-pro: device-tree updates
Date:   Mon,  6 Mar 2023 12:13:48 +0000
Message-Id: <20230306121351.1606360-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First we sort nodes in the current dts and remove some blank lines. Then we
add the remaining bits needed for Bluetooth to work. And finally we add the
AIU audio card to have HDMI and S/PDIF audio output.

Changes since v2:
- Rebase on linux-amlogic/for-next

Changes since v1:
- Add reviews from Neil
- Drop unneded 'okay' from audio patch

Christian Hewitt (3):
  arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
  arm64: dts: meson: gxbb-kii-pro: complete the bluetooth node
  arm64: dts: meson: gxbb-kii-pro: add initial audio support

 .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 82 ++++++++++++++++---
 1 file changed, 71 insertions(+), 11 deletions(-)

-- 
2.34.1

