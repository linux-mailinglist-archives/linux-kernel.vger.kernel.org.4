Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D11460026A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJPRaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJPRaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:30:15 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4843F23EA0;
        Sun, 16 Oct 2022 10:30:12 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id A0E4A140236;
        Sun, 16 Oct 2022 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665941411; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qMJ1wKOWPulBHuLLt6QL69rlVOjiDRA6VNbPCt/Z9jc=;
        b=Q13BYuDWEvaL0SWKkGMNSDtT/u2WBmL7JDfWJkrjLxEbiCu5ifhjVGeHu60ub2KbIwTOg+
        WhT8OEh8vDjEgxevQMrgldkk5YKHWpaX5Z+ZtlHnE1atbTPxDpziJtSU68H7Sar9HQisCf
        9RmhOiSyeaeKZT/V6I1troGKh/ElUNU=
From:   Caleb Connolly <kc@postmarketos.org>
To:     caleb@connolly.tech
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: sdm845: commonize bluetooth pinconf
Date:   Sun, 16 Oct 2022 18:29:40 +0100
Message-Id: <20221016172944.1892206-1-kc@postmarketos.org>
X-Mailer: git-send-email 2.38.0
Reply-To: Caleb Connolly <caleb@connolly.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caleb Connolly <caleb@connolly.tech>

This series commonises the 4-pin pinconf used by almost all devices which have have
Bluetooth on uart6 and removes the node from individual device DTS files.

It also updates the old hsuart alias definitions to serial1. I'm happy to drop this if it
may causes issues with userspace, but it seemed to make sense to throw in while we're at it.

This is a followup to Dmitry's suggestion on an earlier patch:
https://lore.kernel.org/all/CAA8EJpqz32_LxmBVbcLt0sV=e1JzGtWEmMsKsQNoZzuGgLWbBQ@mail.gmail.com/

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Changes since v1:
 * Address Krzysztof's comments
 * Refactor series to show pinmux move in a single patch
 * Put hsuart0->serial1 alias fixes in a single patch

Caleb Connolly (2):
  arm64: dts: qcom: sdm845: commonize bluetooth UART pinmux
  arm64: dts: qcom: sdm845-*: fix uart6 aliases

Dylan Van Assche (1):
  arm64: dts: qcom: sdm845-shift-axolotl: fix Bluetooth

 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 39 ++-----------------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 27 ++-----------
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 30 ++------------
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  9 +++++
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 29 ++------------
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 27 +------------
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 22 +++++++++++
 7 files changed, 45 insertions(+), 138 deletions(-)

-- 
2.38.0

