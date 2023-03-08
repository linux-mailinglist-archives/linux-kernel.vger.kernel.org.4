Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4F6B0234
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCHJCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCHJCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:02:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8A195E10;
        Wed,  8 Mar 2023 01:02:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i34so62763172eda.7;
        Wed, 08 Mar 2023 01:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aj1XRnsx5td4L/az9hbccvez6mU5pRCf3IxlJcNxtSI=;
        b=dD6mHp0qpzP0N5Ndo4+CjRXH54SkATN9d3jOe6O05zPWarFK2IrEa0oYZuxnZUXBIY
         X7Fi6qePGRWH5RctNbtNaBG5h8A4id1CwELR15BgqK3qxsR1+uOvDb9DA9qXY14qwOef
         9VL9DHmUssMf4jxdMfi0Ab72SlTqPyB4+/RSfvSN8QOmIH/pd6Jl1+DUlP+77FJorcpU
         e8vjmpR/0DJWPqvJRqfy28HGQ00fhOMWP6Mv8iT0mecHdR9cgGDITnPx73uyW+9MwzMm
         QmEM6nOqgFk8r7n27l04WNSB87oRx8o1hE7ISsTr1xxruvElv8d2eQPv1LzHnuL4pTK8
         rJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj1XRnsx5td4L/az9hbccvez6mU5pRCf3IxlJcNxtSI=;
        b=vEBylpfej2UuwC4HMOt18l47aydZP65QKYIcp6smt6yVPLEmHMb7uNcQXe6LcYzeEJ
         8Ynico1Mfyb4MuOrZ35sd03AoFzHsbrxh2MIn5KG9Yccw+JYk01dWmfAOhg9rKbz1/zS
         Rf1+Bd/jjLq9EwbE00q6OEqGSOXRhIuGOlz6b90TqN9xzu2muNgciNz4kdMc5wd7b8BA
         /arXTcO1dF0+nLtdD9dRy+Sw4LSNAnP/0baybfIXb6gtKuSlJKy5czKt1cZbyPz5ceMe
         R/+SPaED7qZ2eUMkOKQ7S8AgjZv5rmApMLCVsDWGNu0le7sIyzZFuFqcs0rhu4+sOCLV
         89hw==
X-Gm-Message-State: AO0yUKX+B/8tQpEcnp+QH4bLBLoaoq7DWFpmk/7r/JRNvZh4D7P9Y75i
        rveE3M9dCjNfyhMIUju32sM=
X-Google-Smtp-Source: AK7set82aRXlgAd0Zhzsld/fTujGffmrK3B8Q1CFtAmMxA6FY0kiJMg6iH9C75K3DZuUmy5nyleMPw==
X-Received: by 2002:a17:906:4f94:b0:8f7:3488:fd78 with SMTP id o20-20020a1709064f9400b008f73488fd78mr17548184eju.0.1678266147429;
        Wed, 08 Mar 2023 01:02:27 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090643c700b008caaae1f1e1sm7153709ejn.110.2023.03.08.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:02:27 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Update APDS990x ALS to support IIO
Date:   Wed,  8 Mar 2023 11:02:15 +0200
Message-Id: <20230308090219.12710-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add apds990x binding scheme, convert it to get basic data from
dts and use common IIO API. Since it works with IIO now, move from
/misc to /iio.

Svyatoslav Ryhel (4):
  dt-bindings: iio: light: add apds990x binding
  misc: adps990x: convert to OF
  misc: apds990x: convert to IIO
  iio: light: move apds990x into proper place

 .../bindings/iio/light/avago,apds990x.yaml    |  76 ++
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/{misc => iio/light}/apds990x.c        | 802 +++++++++---------
 drivers/misc/Kconfig                          |  10 -
 drivers/misc/Makefile                         |   1 -
 6 files changed, 509 insertions(+), 391 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
 rename drivers/{misc => iio/light}/apds990x.c (67%)

-- 
2.37.2

