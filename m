Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0E655DED
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 18:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiLYRAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 12:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiLYQ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:59:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D07938BE;
        Sun, 25 Dec 2022 08:59:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o15so6511245wmr.4;
        Sun, 25 Dec 2022 08:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7Uxgqg5mAtgEreFJVlyY9FG6dh29sWzofDPJcOPslk=;
        b=W+z5fHTW0GWZfXeF5Fz+zx0jp9fjQpYyWv/sgsDVZguqzeap9vHyRDwo8Pd3tg6PHk
         O0Gyr/CHU/wSZJYlL5ASoF2XVE370spCTn7F5hxACWF4dMnLNxew9n/Q2ZEv0mjNm6Hf
         6bDTzqaQd3Kp64PYuMNdhjg/sTFuHHENKsP6YS5HO+v20avYKx1rQTrk/nxPJSE7kdUH
         P35nPj+Eprgyl+f0bwnG99lXoiy6hh8ffynJbLXuQVgz/Se1eRm9Z2m83yhF+mFT9/Ok
         7duSnv4dibiRHVZjNvAWURAd97D3uIelrZlUwR1aTnDq5uhuqQilq7VLqf7zj8DcYofN
         VSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7Uxgqg5mAtgEreFJVlyY9FG6dh29sWzofDPJcOPslk=;
        b=VpPa6lzJzk6ZDcEG7dvLZVka/e+gSW/YjzB8zi1JaXrOiLGGkQ+GcTp0KFSUaFHnhm
         ASck7QiPHV0zPPerhPyzzhyAMjlJDKmtuGRfm/a6BCWFtIU7YiaJ3JyxQ5f2Ui8Vpqfr
         vzTaSCv45l1ITlh6zAvHJT3zfQrKUponZ64LNlk+zq41FjB1bBRAZhOm9iJdYexder09
         seWVL9pEUWs/KlLTxNPiD/9ho5usq5MiAIPHq+9X+JLrZaV8f/iKhxVx05O9VwNA86tB
         9xCi11uJ6gq+ED8dd1yEmgGRzaImiZdpj2wwQPsDnmg0kVuLoEQqQ+8wr+y7yAhLbr8J
         xDOg==
X-Gm-Message-State: AFqh2kqFjItVa5oL1pn5etsSs9R8IJsygIEHW5YIWU6dZ8iP1xuqcrEJ
        VeXqKUrWK+bSzQUCodWSX5hkX3jzA+o=
X-Google-Smtp-Source: AMrXdXuT2E457V230n2bDHOPYEK+CtL4Z9J9GgfherN++wEWxFmuDoWgzzapKU7pA2H3QSlks2mPTw==
X-Received: by 2002:a1c:7c0f:0:b0:3d5:816e:2fb2 with SMTP id x15-20020a1c7c0f000000b003d5816e2fb2mr12060163wmc.14.1671987596475;
        Sun, 25 Dec 2022 08:59:56 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003d23928b654sm17734371wms.11.2022.12.25.08.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 08:59:56 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
Date:   Sun, 25 Dec 2022 17:59:21 +0100
Message-Id: <778a9d07ad1d88e036cc1ddd9c3fa53390b906a3.1671986815.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671986815.git.ang.iglesiasg@gmail.com>
References: <cover.1671986815.git.ang.iglesiasg@gmail.com>
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

Add bosch,bmp580 to compatible string for the new family of sensors.
This family includes the BMP580 and BMP581 sensors. The register map
in this family presents significant departures from previous generations.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 72cd2c2d3f17..f52c4794e21b 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -17,6 +17,7 @@ description: |
     https://www.bosch-sensortec.com/bst/products/all_products/bmp280
     https://www.bosch-sensortec.com/bst/products/all_products/bme280
     https://www.bosch-sensortec.com/bst/products/all_products/bmp380
+    https://www.bosch-sensortec.com/bst/products/all_products/bmp580
 
 properties:
   compatible:
@@ -26,6 +27,7 @@ properties:
       - bosch,bmp280
       - bosch,bme280
       - bosch,bmp380
+      - bosch,bmp580
 
   reg:
     maxItems: 1
-- 
2.39.0

