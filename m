Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467DB678BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjAWXK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAWXK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:10:57 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B5B2ED5E;
        Mon, 23 Jan 2023 15:10:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u19so34601536ejm.8;
        Mon, 23 Jan 2023 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KxVqHX/t1GmPKxmzWNFuPMIsX21SLa7bq9EMxvXTX4I=;
        b=FtrRebO7wW5W84nJClLKGVMZx+FCTjAL3RBPYe9/QWNiGKitzsEbDTvyq+O+ePTuMZ
         jKHVm6/rDt8c6wyOFK1MhXw6SFSpiWqYXbNgBZL9o+HI0W/C+ikDtusxS4w7Ovq3gVXW
         k7qcDU5jo1+wMo6nps3GK0xNWmoYIW4c9Vn4KvdSzcBIhQ1I3ctAHpzQxLPbqxJd9VFu
         p4WQdO/LTgj+IPpMfLmyfFbGJB9Yj4Lyi18T6QPZSeD1PURGbfoapSYm6jmPX3qG2wPS
         VPpEmSIL1gd7Hq5NDuARJXXWTAjx2BnsIMMzNy2iz7WG/cGtogBZoJ92TWDnupvk91Nh
         vJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxVqHX/t1GmPKxmzWNFuPMIsX21SLa7bq9EMxvXTX4I=;
        b=Us5PF9U3SBIxUoVu44YTdttHYXcf7YB9c20xViznDSLVlDlQWXRwiK5SqkviBIZHN4
         hJjpjl2JTTvyK0oWyTrS6aOWMHjRKAqol8AR8WpcfI71OBpUoappnIkpMwj/59jgSWxX
         0uhDq9XYUcXsC7uNQ49Txu0e8I76Dqgzab5246bZehH6+oCC+CWFEn3AEJyNa1nMJO+f
         g+/HrxKAFk9Y9+Y71aTyvfwU6BYGdU5w3JQ21899eO7pE79YTdxRnoNoE0ITOXhfjw8g
         kYvyMDD+PHAN+0crY4Q/IPEthSNvrvBI/OhW2+RVeEAh/gq+vl1lxJH5CDo4tvHDSL5g
         ss7w==
X-Gm-Message-State: AFqh2kpF8PdLS1w81PlrWyYQF/nGwZefR/XdaAp5HTNDNqa5SipBWO+1
        /vI7SuLJ9glYie1UBme6Hl1uqdVB920=
X-Google-Smtp-Source: AMrXdXvUZlJS0y5fAr6nFCzMNEtRAfvMzxLFBRf7zGTZoOdGh/si4UPGFi5rgfA6nUd5G6Cd1ndr4w==
X-Received: by 2002:a17:907:a2cb:b0:870:7b:94db with SMTP id re11-20020a170907a2cb00b00870007b94dbmr32254202ejc.28.1674515455117;
        Mon, 23 Jan 2023 15:10:55 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906709500b0084d43e23436sm72601ejk.38.2023.01.23.15.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:10:54 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add a driver for AMS TCS3490 light sensor
Date:   Tue, 24 Jan 2023 01:10:23 +0200
Message-Id: <20230123231028.26073-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
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

This light sensor can sense four channels of visible light
(red, green, blue, clear) and IR light. These features allow it to
be used for sensing the light source, or getting the environment color
temperature to adjust display gamma and backlight level.

It is used on Sony Xperia Yoshino family devices.

Tested on Sony Xperia XZ1 (poplar).

Markuss Broks (2):
  dt-bindings: iio: tcs3490: Add bindings for AMS TCS3490 light sensor
  iio: light: Add support for AMS TCS3490 Color Light-to-Digital
    Converter

 .../bindings/iio/light/ams,tcs3490.yaml       |  52 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  12 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/tcs3490.c                   | 272 ++++++++++++++++++
 5 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,tcs3490.yaml
 create mode 100644 drivers/iio/light/tcs3490.c

-- 
2.39.0

