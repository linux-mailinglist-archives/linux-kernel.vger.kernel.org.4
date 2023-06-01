Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7093719134
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjFADQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFADPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:15:49 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132E7133;
        Wed, 31 May 2023 20:15:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77493b3d18cso24539439f.0;
        Wed, 31 May 2023 20:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685589345; x=1688181345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D4/gO6XzfXDIrnN6Za2h18cWQCzN5ROHDvFmtwAmudE=;
        b=aMxcq21jtx1Z9prFEVIcVdMpob4QsBzi6pEUBVw+8fc0YVcDo9cQDOEZEYirQ/o0vh
         3P+6XoiatoFBbtW7m+JGCcg6mVN8Uw7jgRNjzb90Fgw+oFcdyAQLiDWlTlnzckzYaBwe
         bLU5g75Qdw/j05ZHf/Oe/aVSW4tJtWSJmE9ZgMbcK4HdzJEINvrQTNgjPrLgKt1Nq06y
         Pu2zZzudls6QVpMbBD6V++JVip7n38ym/0xxAJDzf2OvmzVbJMAziWLqc0UawuM+cSOc
         f3EFDu2y4EYrEXzSYyrVpWxGtPTEa7fJcHqWm64jePSrPrM1IGPw64Y8OvZic3mN6HSS
         7jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685589345; x=1688181345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4/gO6XzfXDIrnN6Za2h18cWQCzN5ROHDvFmtwAmudE=;
        b=GdeBk8LcBRExz69rbtOicceuyWzaXFneC1F9sCyKg4fLQWjMQQ/NNdHGlArUDr36e/
         ZRUTf6nBa8BnvrRj6jTa5sPU/ntUxVIN20vH3CDXwPlnkeB6/a631i45+EoVp83vUmVU
         sIp6X5zKRc+AKKf7/YtRw/cdIFPTdrzmVua06xaVLzRWr/8BzINO6T3KI6kXYVMsWg2T
         2z3jMbUO5WvYvlrO81BIltmvUa4cPcwrLsKBjHq/xVYK1P1L/cSLVYETIcxXiEpG8mXu
         8PCuzRAEfL7swM4XqAt0XXMzpaU7JQDeXv2MrCeu6zl8S9pLbIXW3P5Z+btU6f69npxv
         QuHw==
X-Gm-Message-State: AC+VfDzefNcgyWIneRNfwwY80E8OdPCEXDQDZEm4nWyJkE6FfbcAZNiK
        k/uCeVcYXRFjUI1wQxx//vE=
X-Google-Smtp-Source: ACHHUZ59Cs+/Q8eganB2/dKEb/mwwnRZnRrFojpciU475H4QwR8u+eQ9hw+kNCWMEK/u7RMYtoYEbw==
X-Received: by 2002:a5e:a914:0:b0:775:5f74:f4c7 with SMTP id c20-20020a5ea914000000b007755f74f4c7mr7696453iod.17.1685589345144;
        Wed, 31 May 2023 20:15:45 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:6ae0:d0f8:5d79:f782])
        by smtp.gmail.com with ESMTPSA id b66-20020a0295c8000000b004165d7d6711sm1852590jai.71.2023.05.31.20.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 20:15:44 -0700 (PDT)
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
Subject: [PATCH 0/2] arm64: dts: imx8mn/imx8mm-beacon:  Add HDMI
Date:   Wed, 31 May 2023 22:15:24 -0500
Message-Id: <20230601031527.271232-1-aford173@gmail.com>
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

Adam Ford (2):
  arm64: dts: imx8mn-beacon: Add HDMI video with sound
  arm64: dts: imx8mm-beacon: Add HDMI video with sound

 .../boot/dts/freescale/imx8mm-beacon-kit.dts  | 132 +++++++++++++++++
 .../boot/dts/freescale/imx8mn-beacon-kit.dts  | 134 ++++++++++++++++++
 2 files changed, 266 insertions(+)

-- 
2.39.2

