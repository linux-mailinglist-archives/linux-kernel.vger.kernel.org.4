Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B95714667
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjE2IlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjE2IlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:41:21 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5D2B8;
        Mon, 29 May 2023 01:41:19 -0700 (PDT)
Received: from [192.168.122.1] (217-149-172-244.nat.highway.telekom.at [217.149.172.244])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0EDADCFB25;
        Mon, 29 May 2023 08:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685349678; bh=89HzrClw04VkGT9+4YTbd8hPl6wcm5TiIVznRJGtang=;
        h=From:Date:Subject:To:Cc;
        b=gxZhk/il9OAjqSTezPHzMflVT0QXFcFrzG7bDPkZHS6/FnyUTZTnyde/eslswQ7R1
         mVvSopzATLjXosMIc7N8Yemtbnvyth0dlBdpSYV46qHg9w7rZqnF7I6sLFexWDpAjT
         /UZSfMHjzglqS294Nst9dZvDfyOSAQS483TtWsn0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 29 May 2023 10:41:15 +0200
Subject: [PATCH v3] soc: qcom: ocmem: Add OCMEM hardware version print
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230509-ocmem-hwver-v3-1-e51f3488e0f4@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIACpldGQC/32OzRKCIBSFX6Vh3XUQTKFV79G0ALwmC7TAyJ/x3
 UNXLZqW353z3XMWEtBbDOR8WIjHaIPtuwT8eCCmVd0dwdaJCaOM0xOV0BuHDtp3RA9SaqM515Q
 JTZKhVUDQXnWm3Zyn6R244ISsCiizIpu20MNjY8e98npL3Now9H7aF8R8u/4uiznkoAVHg7xhe
 SkuM++GVzZOM9n+RPbHZckVRlSSK1rVjfl213X9ANGuEvgHAQAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=89HzrClw04VkGT9+4YTbd8hPl6wcm5TiIVznRJGtang=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkdGUriuKEVu0Uc2zepZr9SZvcrVu+ijjwccuh2
 HPcvvoroI2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZHRlKwAKCRBy2EO4nU3X
 VtUZEAC9tD7gFjeuA1v+iZSd/BxH7UKrMPRNTlYN3wyfRX050HEbqWtmJqRyflQEqsSVHZ/UrLI
 lWR1ZnIqH+IpTSTfknd0KYjFdw2Z22e0P/zouQ3u/JLPSnrPUQmR/i/Eh9Gwhi5FrFAVfPQEoDw
 MC+kMLFlikvlwCE7ubeq/1A0LaZ9Xy+Xbc2qsou9QcpwphNLAxYxY9wkgaTORljBQ/5NofpL9Bl
 JVJGGS9rTuoGGNFtMQ2cwKTSt1MciW+hNFLswosSM5isimnPb0Bud5A6QucCtE/YhmTWVDf1v3X
 V93lAeCGzeKfgsoUvcVhD9o8o6z7VJMqLZJb0Bm68mBCAIvBUl3kq9goCJn3cZM6fMa880XbPXS
 k+IebdYTvvWeO49Rtg9nDTI+Dm9khHPp7VB9iQbqHwltccMi8lfFo2I6AGBuOOTDFgknG0fEgHZ
 hZh4/qVqpDYNw79sZOjXLQ64udCC7W7IfIwPBRW99I0TvPq+ttdA+MnJ3OjMF8erSeieVBvGh1L
 MXFdrvfAck2j9EBEIn89CEsT9BjDEnCDopOuqyHTXtWSiFxCHgh9gSmAYUExEGP4TMY4/LOPxYM
 DrzXRyTM/Us45ic/+7+7eH+eXcB6ZkS0QZ1aue1ojvhHk3lHodQe5n39k/nnhCIkIY7flYKNyDP
 8VQ9d2b5hTabfjQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might be useful to know what hardware version of the OCMEM block the
SoC contains. Add a debug print for that.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
This patch is depends on [0] but could also be applied in the other
order, if conflicts are resolved.

[0] https://lore.kernel.org/linux-arm-msm/20230506-msm8226-ocmem-v1-1-3e24e2724f01@z3ntu.xyz/
---
Changes in v3:
- Use %lu instead of %ld for print (Konrad)
- Re-wrap lines so reading is easier (Konrad)
- Link to v2: https://lore.kernel.org/r/20230509-ocmem-hwver-v2-1-8c8793a07dfc@z3ntu.xyz

Changes in v2:
- Use FIELD_GET macros for getting correct bits from register (take
  wording from mdp5: major, minor, step which hopefully is sort of
  accurate)
- Link to v1: https://lore.kernel.org/r/20230509-ocmem-hwver-v1-1-b83ece3f2168@z3ntu.xyz
---
 drivers/soc/qcom/ocmem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index c3e78411c637..ef7c1748242a 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -76,6 +76,10 @@ struct ocmem {
 #define OCMEM_REG_GFX_MPU_START			0x00001004
 #define OCMEM_REG_GFX_MPU_END			0x00001008
 
+#define OCMEM_HW_VERSION_MAJOR(val)		FIELD_GET(GENMASK(31, 28), val)
+#define OCMEM_HW_VERSION_MINOR(val)		FIELD_GET(GENMASK(27, 16), val)
+#define OCMEM_HW_VERSION_STEP(val)		FIELD_GET(GENMASK(15, 0), val)
+
 #define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_GET(0x0000000f, (val))
 #define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_GET(0x00003f00, (val))
 
@@ -355,6 +359,12 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 		}
 	}
 
+	reg = ocmem_read(ocmem, OCMEM_REG_HW_VERSION);
+	dev_dbg(dev, "OCMEM hardware version: %lu.%lu.%lu\n",
+		OCMEM_HW_VERSION_MAJOR(reg),
+		OCMEM_HW_VERSION_MINOR(reg),
+		OCMEM_HW_VERSION_STEP(reg));
+
 	reg = ocmem_read(ocmem, OCMEM_REG_HW_PROFILE);
 	ocmem->num_ports = OCMEM_HW_PROFILE_NUM_PORTS(reg);
 	ocmem->num_macros = OCMEM_HW_PROFILE_NUM_MACROS(reg);

---
base-commit: 8705151771af822ac794b44504cd72eebc423499
change-id: 20230509-ocmem-hwver-99bcb33b028b

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

