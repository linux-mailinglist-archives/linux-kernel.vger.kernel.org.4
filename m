Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F02730512
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjFNQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjFNQgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:36:14 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FF32130;
        Wed, 14 Jun 2023 09:36:12 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7CF5ECFDAD;
        Wed, 14 Jun 2023 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1686760570; bh=/Nap/h5b8ifbytezb1RECo6i67zkmm+JJ16tgLDL5U0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=OfxvI8eg6MCmxixT0y3le+iOeLQVOXt7OZQqzGw+q7kHqUdbUS67gh9XyD6r9V3Fp
         i3XmjhW/VVGPc6FxmNUDe0qXa5f79F9Lya4H+1iyFGBHrKqUakQyqNbFq0G0kHddei
         B6udNErXW0licLl6spB/Ml4QtJyK+gbHJ2eShgRg=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 14 Jun 2023 18:35:47 +0200
Subject: [PATCH v3 1/6] soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v3-1-79da95a2581f@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=/Nap/h5b8ifbytezb1RECo6i67zkmm+JJ16tgLDL5U0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkiex0QxiX051YGU3US5+bhXZmRwUWOPqTdKlr7
 G0extjMpSaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZInsdAAKCRBy2EO4nU3X
 VsF6D/458w91+bkJJGwKYob7yR28gw3zEleuIJDF8JLm3XVvbKovoPNVcTc9XgIonAI/M5L6tl8
 feR3TY3EMXkrh4NCRM7HrfqyAJX+nTBDyCzEq6yiPAHFG+EsLs4cGeuZwdhNkOGGlYddb/nGzv6
 cQ+7ZAIlLRIBZBKiZdEdZtb+oAr2W4DCXCG3Gf63LeIm0EqILhEEN73dxnD+Qbs9mqcNsmgJQ7G
 WP7zmuMu3C5lJlUYm1KRZZy12bc04d8slUNs+w3vkkUBc0y6kulkrtbdX7euXT80wMt21/jiyf6
 Um3TvCBI/dmCkDOPQSuUblp0jjxwfNmYKaoqzOGCzvFuBX37r3Z37gonPJAhgex4HBYNOVyrUMp
 AZfs7wPuLRKY4MvBidoHNivgwIh3tUY7uNv761+f+BKyRrYVw1aAQLUCh5k6wttdb9WphAqr4/d
 EsWfuxpp9S6bW+r6Dg6KNz8djwt9AYZOoKz+QRmlvKh+yBC/2Ds2O1GcOnYq0Bbp8vOOVCEKP5J
 vXrznHGT/ocf39GLNlnMiks8nsSYEJwxrsClw2vvPoRc86/7jq+6UFGlIRnKUoTDzvx2YSbhOiq
 XLhyqn9zQv2+zs5hmkPuADFc+lhNrqMBGbWbkl5fwDQbhzQVt/K2y2D69w/gGshJPmUT5BezcxW
 nxoT7McJJ6njyQQ==
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
index aaddc3cc53b7..ef7c1748242a 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -80,8 +80,8 @@ struct ocmem {
 #define OCMEM_HW_VERSION_MINOR(val)		FIELD_GET(GENMASK(27, 16), val)
 #define OCMEM_HW_VERSION_STEP(val)		FIELD_GET(GENMASK(15, 0), val)
 
-#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_PREP(0x0000000f, (val))
-#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_PREP(0x00003f00, (val))
+#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_GET(0x0000000f, (val))
+#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_GET(0x00003f00, (val))
 
 #define OCMEM_HW_PROFILE_LAST_REGN_HALFSIZE	0x00010000
 #define OCMEM_HW_PROFILE_INTERLEAVING		0x00020000

-- 
2.41.0

