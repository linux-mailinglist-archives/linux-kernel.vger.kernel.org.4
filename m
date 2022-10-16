Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA8E5FFFEE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJPOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJPOsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:48:04 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 698662AC62;
        Sun, 16 Oct 2022 07:48:03 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 078351401FE;
        Sun, 16 Oct 2022 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665931680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hEmvd+bLXZkxs7tcafb47/EuNnXtF1xF7FdoA1UFwEg=;
        b=cCEbjqP0ukPYqrd/2k/4yAWSjVrV+PmyqbpczV5rLaEaEbIV4AovGSKL1SYAe+qD5ByWZ6
        QebMENFawCPWPp6/Z+1mQgPLitj1tSbjFq3qNLettPg3TdCDmt/cXGzeOH+ffLmVMbNpH7
        hWYPTAig7KamU8YT7Z0j2+B65oZfT8A=
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
Subject: [RESEND PATCH 0/7] arm64: dts: qcom: sdm845: commonize bluetooth pinconf
Date:   Sun, 16 Oct 2022 15:47:06 +0100
Message-Id: <20221016144714.1742824-1-kc@postmarketos.org>
X-Mailer: git-send-email 2.38.0
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

[resending from a different address as protonmail keeps deleting In-Reply-To headers]

This series commonises the 4-pin pinconf used by almost all devices which have have
Bluetooth on uart6 and removes the node from individual device DTS files.

It also updates the old hsuart alias definitions to serial1. I'm happy to drop this if it
may causes issues with userspace, but it seemed to make sense to throw in while we're at it.

This is a followup to Dmitry's suggestion on an earlier patch:
https://lore.kernel.org/all/CAA8EJpqz32_LxmBVbcLt0sV=e1JzGtWEmMsKsQNoZzuGgLWbBQ@mail.gmail.com/

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Caleb Connolly (6):
  arm64: dts: qcom: sdm845: commonize bluetooth UART pinmux
  arm64: dts: qcom: sdm845-cheza: commonize uart6 pinconf
  arm64: dts: qcom: sdm845-db845c: commonize uart6 pinconf
  arm64: dts: qcom: sdm845-oneplus-common: commonize uart6 pinconf
  arm64: dts: qcom: sdm845-xiaomi-beryllium: commonize uart6 pinconf
  arm64: dts: qcom: sdm845-xiaomi-polaris: commonize uart6 pinconf

Dylan Van Assche (1):
  arm64: dts: qcom: sdm845-shift-axolotl: fix Bluetooth firmware loading

 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 39 ++-----------------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 27 ++-----------
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 30 ++------------
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  9 +++++
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 29 ++------------
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 27 +------------
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 23 +++++++++++
 7 files changed, 46 insertions(+), 138 deletions(-)

-- 
2.38.0

