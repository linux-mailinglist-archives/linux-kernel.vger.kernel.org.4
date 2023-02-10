Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24AD691F15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjBJM20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjBJM2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:28:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4814314226;
        Fri, 10 Feb 2023 04:28:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m14so4883008wrg.13;
        Fri, 10 Feb 2023 04:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tsGNvhireWD4mNV5rJb2McKZOxhDc9wHPt6shXZhutQ=;
        b=jyP4fa8a6rGSNGgFV+LtOyKyJmPJUG2VVJwgFUcKZM33bq15Uvmdq6NcX/JT8AFNWM
         TvIupQ2MybJrObyL3RBPxufnvMyPZJaAUMIm+wcx14zKW2yvyH1y7hMKjo0sp93nTwbI
         yPY7ylfPvwdUjOTHNNrVh29F1p8cZuHIpbtRwfqcaQhbR96WTwySf9d9jQi04Z4CWw5U
         ViFmGX6N0axQHBij9WQ+CZtQHmPc7H2u0n4RWORte1auSkzfnZZOoI5vkJzT1lRkKX16
         PTCNps92zNQpcLQZNh+Z2uMTNV7RYt0PY5BXIG8URajdBM3sZdpLU5N+zaPzHuR0N9bF
         hMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsGNvhireWD4mNV5rJb2McKZOxhDc9wHPt6shXZhutQ=;
        b=4B22upGSUcgwHXhp7nrE5X6+/Rv0Sy8M9J3GBwAPAxaBLqK2B8/Rzf7PY5qN0plnJY
         rDZUSi6+b82I52eoeuF9yub/pebdMrIhTVZfejWyHBTBKSJh+hSYNPFyDf6oGqa4AYIe
         /xjj7JJjDzZ12kFcGoAs71q29v7V4Tziu9cPgoGklvuevuBBWlpVBquCPtRwsgM0fDvg
         J961JaFRgmqKuEtoCF7llaIMWP8aTCdXNy8bs+b8LibnNi//7Tyy/cSj9KHodQQYTzw1
         ZXY3i1o6s3Gv2t5egTrm2W0kGi/ymkuBuc0L/X1XqK1MkyMm0Tjzw2wiJNpOwi+q0gdo
         uRsg==
X-Gm-Message-State: AO0yUKUSsOH/bkm/3MPGB6ovzwpYR6A92OV5fH5iHQcuQVYAOBK0Ivji
        Mvyo6F9SJezy/1IABUxQMys=
X-Google-Smtp-Source: AK7set9O+rFcCoO6ppeRXI0IbW8z6ql/sCNVW+HCaPoQq4/g82X9kh32Cs6HGJf8H2VVTg9hL9gPog==
X-Received: by 2002:a5d:690b:0:b0:2bf:b839:c48b with SMTP id t11-20020a5d690b000000b002bfb839c48bmr15161203wru.51.1676032102792;
        Fri, 10 Feb 2023 04:28:22 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b002c5493a17efsm1540989wrq.25.2023.02.10.04.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:28:21 -0800 (PST)
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
Subject: [PATCH 0/3] arm64: dts: meson: gxbb-kii-pro: device-tree updates
Date:   Fri, 10 Feb 2023 12:28:14 +0000
Message-Id: <20230210122817.1027765-1-christianshewitt@gmail.com>
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

Christian Hewitt (3):
  arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
  arm64: dts: meson: gxbb-kii-pro: complete the bluetooth node
  arm64: dts: meson: gxbb-kii-pro: add initial audio support

 .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 84 ++++++++++++++++---
 1 file changed, 73 insertions(+), 11 deletions(-)

-- 
2.34.1

