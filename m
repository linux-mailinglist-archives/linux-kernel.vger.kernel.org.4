Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA1D6E4F63
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjDQRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjDQRjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:39:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A45BBA;
        Mon, 17 Apr 2023 10:39:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o29-20020a05600c511d00b003f1739de43cso1754509wms.4;
        Mon, 17 Apr 2023 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753150; x=1684345150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/djxTOJ3x/NPtL+O6ti8i4+uQIKOqNWvQ/15BQ6ZKIE=;
        b=ZzANMxbByQJeUrp6Tnh7+0PiRepMh66KBM+l9O1zc3bEcmT/eYd5kDTEacsbRhsyEk
         5qGG+Bw03n4EGKAY/KJiV6n15tky2Iv7S7aIUIHOnhMDnrKD0f2Na783Go/8BztUbuUQ
         qKPBpEuEWl/WACjzmlor0ke07zSvp3TcqGgdDoEzHCpoOBhMwcX8GTGvAgHeC9BXqDRC
         moI4KtYcOjZfVwgUPzoxPmNL36Mj/5mIJmyjVQEzXmoq4EjF0feQvP4IDysl8seHP6B2
         QYt0he/bYZLBXXMwJe9VR/31+Iy2K9BX9xq3lnk4xJsPqKFbh7Ef3c6/VViu2J2a3ILT
         rXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753150; x=1684345150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/djxTOJ3x/NPtL+O6ti8i4+uQIKOqNWvQ/15BQ6ZKIE=;
        b=hE5+o9OoBDzmohs04PK8OUJ9qoqCa0Pl308nE3LAKMLC/d2KJIEcLNAdLA6W2gzwGl
         tWxZzlXj2AiLgHM5V7ZBsNy1Y4L3nf5mi0Q7J7FweCnY9/dkV7Yu/XmS6r0DlhYgAdki
         k2yi3u9mgfxKHST/b3bKzLtyPUqF4iq4VYw5761x5Y2u88nCTM4X8psy911yfkHxVE1k
         8+PIBYc1VDJAkLn4iT7kYGVkJNIT84u3ZGcsEEEMk/z8QT5CvwB0PNl870B3XI1w15ia
         9+1xz138PfMCCC36fz9WYmWrvlgx2Nvju2YDJbjy66uXCIHn2i7aax1+f4JsybmgP321
         oZtg==
X-Gm-Message-State: AAQBX9dDlob5wiwaqDLjRgCKP09VkuNVh5mkXEkXxSWt0LisUstyiAil
        qfKQUVP2D4eMYUa304+d35W8ur8kNUXBjw==
X-Google-Smtp-Source: AKy350ZQqUksrzWBOisqa1NVB4oOCWRb15F9kiwMNg0+qKvzsdDnaRS4HKyc1Olf0iPIcy2LhnS90Q==
X-Received: by 2002:a1c:6a10:0:b0:3f1:7316:6f4 with SMTP id f16-20020a1c6a10000000b003f1731606f4mr3475167wmc.20.1681753150220;
        Mon, 17 Apr 2023 10:39:10 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (35.145.195.178.dynamic.wline.res.cust.swisscom.ch. [178.195.145.35])
        by smtp.gmail.com with ESMTPSA id iw1-20020a05600c54c100b003f174cafcdasm2478211wmb.7.2023.04.17.10.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:39:09 -0700 (PDT)
From:   Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
X-Google-Original-From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 0/4] arm64: dts: colibri-imx8x: misc fixes
Date:   Mon, 17 Apr 2023 19:38:26 +0200
Message-Id: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a few small issues on the just introduced Colibri iMX8X:

* Remove duplicate GPIO3_IO01 pin configuration
* Remove GPIO3_IO01 pin configuration from SoM level
* Delete non-existing i.MX8X peripherals adc1 and dsp

In addition to that a small cleanup patch is added
* Move iomuxc pinctrl from SoM to carrier board level

Andrejs Cainikovs (1):
  arm64: dts: colibri-imx8x: delete adc1 and dsp

Emanuele Ghidoli (3):
  arm64: dts: colibri-imx8x: fix eval board pin configuration
  arm64: dts: colibri-imx8x: move pinctrl property from SoM to eval
    board
  arm64: dts: colibri-imx8x: fix iris pinctrl configuration

 .../boot/dts/freescale/imx8x-colibri-eval-v3.dtsi  |  6 ++++++
 .../boot/dts/freescale/imx8x-colibri-iris.dtsi     |  3 +--
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi   | 14 ++++++++------
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.34.1

