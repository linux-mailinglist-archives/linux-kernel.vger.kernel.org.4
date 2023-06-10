Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCC72AE60
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjFJT0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjFJT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:26:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA6270F;
        Sat, 10 Jun 2023 12:26:45 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77a62a84855so136904639f.1;
        Sat, 10 Jun 2023 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686425204; x=1689017204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByHw0rvddOiCXzdPhf00oxkKHXxWYbbkLr+bifjUB/o=;
        b=Am7DkPXvoR8lhKRFR9YJ9/7DIEwja1sjBijIcqzTL14ZVsxmIM2QGu3ZfLDQcijMiR
         xhSpS5LDqewUenmF1KmbcE5ov8StEXgdR9UK2ifviR6TZ5A1IeIj04vmD6AnQYoGwe+S
         K9Mvim97LcW5Ndgo6TC920/H6ghhGB/p8bdQQqZLTp2SF0X3C1AqWYgs/pb1yNz+cXNk
         BcBcMTlHkHyCwhKMagSo5kjClnKKmqTIGnyxvXsD+Yrtl933AJ27bLjaJFFmk8EA4egm
         /gGhEIzDUcOqeHR8F97XvKfbkAhKsOv7Pgyk4+cHEK/UWpZ5kODMyviYOmn3g+qdpfIv
         9mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686425204; x=1689017204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByHw0rvddOiCXzdPhf00oxkKHXxWYbbkLr+bifjUB/o=;
        b=MNMNsT9zoKfVvH1e2Eb6KbvBmUIjnftW2Jh5r6oyQHjrSfr9W0eNlomKGEX1aSwdRh
         795pN/HCQfqLfhDmayoKbuEY8oWB2BNWUm97qdF2/0IEzHgICgmiCfJZ++yeuI18qxKb
         qzgz7YjfS7bpQ7rnYLvPars4Ogb9OeozxG2/XoI80fiS9nWSHhbhLeqTax9Eqs81iDGt
         pheAd2/Gmxh+7xH15qZZ6CBztr2uW2C931/wQ+9f8jYlsXF5gDbCN5tdlc0SaeRdbYUW
         IMYCET9MYepXfLnXSoWBhL8DE9zrcVElSLqeBPs8mf0yCqAaU8TN6V3FupiFsTrpWbcK
         zqWQ==
X-Gm-Message-State: AC+VfDwYAB70FtYuGQ0WWq8a8HkY95LkkSf2nOVJ4Tvyfc2COqW1RQNA
        GR90sBXa1YeP8aSTi6ewWok=
X-Google-Smtp-Source: ACHHUZ6wex0UngegSlkbj4dzFzq8Lw9WAuvyuh/uPVvGYYWF6nONqF3iibg37rTl9voPdwzbRxAAMw==
X-Received: by 2002:a5e:c20d:0:b0:76c:c974:9da with SMTP id v13-20020a5ec20d000000b0076cc97409damr4015315iop.19.1686425204215;
        Sat, 10 Jun 2023 12:26:44 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:7d74:3e3b:c016:e413])
        by smtp.gmail.com with ESMTPSA id a24-20020a6b6618000000b00752f62cd3bdsm1963834ioc.12.2023.06.10.12.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:26:43 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/3] arm64: dts: imx8mn/imx8mm-beacon:  Add HDMI
Date:   Sat, 10 Jun 2023 14:26:33 -0500
Message-Id: <20230610192637.263600-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The DSI updates are in the DRM tree and Linux next with some updates
that now allow the DSI to connect to an HDMI bridge and successfully
sync displays at various resolutions and refresh rates.


V3:  Alphabetize regulator names.
     Add register names for EDID and Packet
     Add I2C address change for the camera since it
     conflicted with the I2C address of the HDMI bridge.

V2:  Make 'compatible' the first thing in the new nodes.

Adam Ford (3):
  arm64: dts: imx8mn-beacon: Add HDMI video with sound
  arm64: dts: imx8mm-beacon: Change camera I2C address
  arm64: dts: imx8mm-beacon: Add HDMI video with sound

 .../freescale/imx8mm-beacon-baseboard.dtsi    |   4 +-
 .../boot/dts/freescale/imx8mm-beacon-kit.dts  | 131 +++++++++++++++++
 .../boot/dts/freescale/imx8mn-beacon-kit.dts  | 133 ++++++++++++++++++
 3 files changed, 266 insertions(+), 2 deletions(-)

-- 
2.39.2

