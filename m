Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C4A70E6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjEWUzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjEWUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:55:21 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2A711A;
        Tue, 23 May 2023 13:55:20 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 967E5CFBBB;
        Tue, 23 May 2023 20:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684875319; bh=YjTptnEb5/JjSbifG6vzXu6nUUHMPKQYPG4+UHcnidg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=qcOaQDdAaaYqE049ckHiY7s8oHp//icmSBETQjPlz3UzgknlRntBOx/mMdg4zFKMM
         y5y6ssMg1EvNd2WNg6QAmk7zxSatn0HdecKZDiWm27vwCbM6Tcuxe3azetcUnXYO3Y
         C236u91kOqouoUkaNuupC+4jnRhfa8/KLUysosO4=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:55:08 +0200
Subject: [PATCH v2 1/6] soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v2-1-177d697e43a9@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=YjTptnEb5/JjSbifG6vzXu6nUUHMPKQYPG4+UHcnidg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSgw3OEwGS59qxpQAig/EAaGhkgIu2qG4Ss/A
 9WlgqLkdI6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0oMAAKCRBy2EO4nU3X
 VlwzD/9wY81zFENNfYkJX3nlFGfitX/zvhzG14WdGf/UglMrvf6vk5ABKjIILizTcIRB2Q+hHgO
 j/e7i72pxAW1zsuhHmxOWLRTZPIgcjVXRPXDragYP5OrfZC+j8Z8fpJEiF7Sm6LvW5KfpeM57Ek
 Fgabft1g9xmOGTAPn/Dl7OzVoC7vcwkajBF4epHl/brjBHooAv5SWiyFfgNBBuC84NknzQVz2P/
 hRV4oFbYi7inPseG9H9HD4FKhI1rECzTsJUiz81uqlwacwueTnRrjh34i2lwsu8zLuXaH2FoTDu
 dnqWLF8U4Z6f6FKMlPpDkm0zHe8UYvBBPV4umBPm0sx2rRxFfdrNQzjc+0+m8UFZiSoLeMTNDMl
 wOH9b6MuEisEcAk3d8KjsZhshWW0jLpQdKhmL88TMIsV2njgzxMwjcsC/B58qj6jRBfQ8EJ9kAg
 08Q+HFMIeR4I9KRIQQ4OcA3MCQv7UAV9yx2XOCLShDH/1xhhCzAVKeDf1Aspn23VdOHZuRGnbb4
 1bHAwiR4cqP0yK6/M+QeZAivgMiWovoNwEJVwxo9h03F2RGtenBvq69PP16+JLxP04LzvSaYlA6
 MWXmF2HtG/Me2oSugRz9gB6uRUVFQNaOLYnm9DUghnSWROy6Le//DzyGYb5CZgqf8na/+2nD03p
 QIHEUiR89KxBigg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're using these two macros to read a value from a register, we
need to use the FIELD_GET instead of the FIELD_PREP macro, otherwise
we're getting wrong values.

So instead of:

  [    3.111779] ocmem fdd00000.sram: 2 ports, 1 regions, 512 macros, not interleaved

we now get the correct value of:

  [    3.129672] ocmem fdd00000.sram: 2 ports, 1 regions, 2 macros, not interleaved

Fixes: 88c1e9404f1d ("soc: qcom: add OCMEM driver")
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/ocmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index 199fe9872035..c3e78411c637 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -76,8 +76,8 @@ struct ocmem {
 #define OCMEM_REG_GFX_MPU_START			0x00001004
 #define OCMEM_REG_GFX_MPU_END			0x00001008
 
-#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_PREP(0x0000000f, (val))
-#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_PREP(0x00003f00, (val))
+#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_GET(0x0000000f, (val))
+#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_GET(0x00003f00, (val))
 
 #define OCMEM_HW_PROFILE_LAST_REGN_HALFSIZE	0x00010000
 #define OCMEM_HW_PROFILE_INTERLEAVING		0x00020000

-- 
2.40.1

