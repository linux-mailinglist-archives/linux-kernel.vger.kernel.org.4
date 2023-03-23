Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF826C688B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCWMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCWMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:38:14 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5C82726;
        Thu, 23 Mar 2023 05:38:13 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q6so9890741iot.2;
        Thu, 23 Mar 2023 05:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0+bynfY00cSHIQkWQ+zWdlHvZK8vqNNp0Ky9kD5v54=;
        b=mgMcflB5KA73/EKyNij7S3rJtq36/WSvZ2mvo02ncMPDNqVKryKSrou1ObzG6sV1dh
         eYzOmo9sv9JS5FFNzhzMUKMDPIXGCWBZ2M4D+q86ql2CNuR2qu5ivZdTBoBw45A9si/j
         Sqrfz0MmeFemZPXpSA5jW6+jBUyJsvTJ7FEK/iokV3RFLRA3mtYdKlOPQ4BzaWazrQsM
         oLI8Q4TVIQ8jbmGZiaAUBtsmkZzcyaSEdgimcVWOz7LJn37E0BEV3XyocyHvp1MpDRSH
         y+sLfB8KvtPrCcL1xHsqwA5u9eTdo2qGf/7rwFRj7iIYebsQ0X7uD6AapaV3XaUYvEoA
         AKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0+bynfY00cSHIQkWQ+zWdlHvZK8vqNNp0Ky9kD5v54=;
        b=V+g5gmG2OB+23kAkGaAkGTVgPgGHJcI9KkzLsRSBbeskvPIfa3nDZvzHhAx57A7m3t
         35/oU+VkJF3SH1b91EyAt45h8nAj5IVVEK3BMmbKUuY97df/O2A18nhLmqehhqtAmikX
         81HXsl2I63d080cpBZaHdIg30ympC8THWfZ9A55eKImOLU1wIBPG58ySka7Q4yF7cZS+
         lChOZ3xVvB+2BOqZgwEwjo+flXyKwUjeIi04n+YrHP1o8/5/Y1nX4cYdv7tc01HRuU6+
         fME19E4nFHhbOJC2DnF2/9vU1j/Fn7tQ+MgZkx77PUeyylHjlweqHbP3m+OFkDG4HqP8
         kboA==
X-Gm-Message-State: AO0yUKXxvcLZG9r5w8XlZ89vohMo+kxcE7+KiRYfJ7J+ZlNmq28tDan6
        HXcv6uUQqMs9cvWx0LvS9cU=
X-Google-Smtp-Source: AK7set/WWhepU+oqjkK7UqqkkawBKVSq+Np02Zli5m9hkZjc3hKS+f1QfT5zwOtJK1BWMNoa4aLFfA==
X-Received: by 2002:a6b:ef04:0:b0:753:989:ebb5 with SMTP id k4-20020a6bef04000000b007530989ebb5mr4138339ioh.7.1679575092378;
        Thu, 23 Mar 2023 05:38:12 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id n11-20020a6bed0b000000b00758993500f3sm1307608iog.7.2023.03.23.05.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:38:11 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>, Andy Yan <andyshrk@163.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add support for NanoPi R2C and OrangePi R1 Plus LTS
Date:   Thu, 23 Mar 2023 20:38:03 +0800
Message-Id: <20230323123807.11882-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this patchset adds two new boards using the Motorcomm NIC which
got supported/fixed in kernel v6.3:

* FriendlyARM NanoPi R2C - yt8521s
* Xunlong OrangePi R1 Plus LTS - yt8531c

Tianling Shen (4):
  dt-bindings: Add doc for FriendlyARM NanoPi R2C
  arm64: dts: rockchip: Add FriendlyARM NanoPi R2C
  dt-bindings: Add doc for Xunlong OrangePi R1 Plus LTS
  arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS

 .../devicetree/bindings/arm/rockchip.yaml     | 12 ++++--
 arch/arm64/boot/dts/rockchip/Makefile         |  2 +
 .../boot/dts/rockchip/rk3328-nanopi-r2c.dts   | 40 +++++++++++++++++++
 .../rockchip/rk3328-orangepi-r1-plus-lts.dts  | 40 +++++++++++++++++++
 4 files changed, 90 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts

-- 
2.40.0

