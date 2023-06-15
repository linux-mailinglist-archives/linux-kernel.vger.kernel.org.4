Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9536373193B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjFOMvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbjFOMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:51:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E186269A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:51:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so15961205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686833507; x=1689425507;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYJRLhJE4BnkxztSK7kLLVvhbfeHX+zQ18aXvSE//Mk=;
        b=FlAnmp40K3oTJ1IUAyOBngrA3PiAh+TkWNWfUpd2rbFeWMtY3/A3bq/DwjhZ3/X0u8
         GWEwuQPjChk+3WnpI7YhKHYmDYp5peNUykjt1yYLPW7IOdaqWJmPm4hXhNp1So2/PuSt
         VXKakPFuRInShzS5xj2CuIQRYe7DUAEn3OkZTMg5oAMuSJju/kAK/AUr6j04eaOVxvY2
         z6WZ4+PYPVoVUS/pQbTQiCUQMM9kp/PRRBmLFvyNUey/fWBDPbDnzKCaeku0Ibvkq+dA
         CDSRwtQtMB2KTGBUs7qbqvVLHA+oj1gy0u4Ultu3lqbnPsIP7i6yw4afwFaX5f+TJiQ5
         /raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833507; x=1689425507;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYJRLhJE4BnkxztSK7kLLVvhbfeHX+zQ18aXvSE//Mk=;
        b=JUjD7gqjvwRoAvAFP5KZ4cHLwofEgEgZ1Orj3JwJK12Si7z5RM9qfZedjDwy9TCIIi
         9tiOE1wGU1GsymvNAfo8fr1WmmC70iPUtLv1TY21WiOQjWphj1XMfzeG+KVda76Nyxhc
         AyeYaeJd3Todn1mKoROdwV1HFcusV4loYJP8Ji5ETpEu1C1L7D2w3hFbMAReloKqNvbv
         s/qmGpQIofbCZV8i3O+wzbGWIKPmPSDejM4KqWuHsFl8K4OqMZP1/lEMQot2f5CaX1xJ
         bhvz/SkE5BJog8iKDDFyzA/vf9n0pg4t0r5gO0PDnWHMBAG4xZAmldUzwXTLCW7O/84b
         u+Bg==
X-Gm-Message-State: AC+VfDzgOiUWbRVQATCXucRKIyEC+IEHiGoPX9iFI2ebBcm1lrrIBhi6
        RSQmQoJ02PF672HUAN+8ATDA4g==
X-Google-Smtp-Source: ACHHUZ7fDZNQOH0mI2GK6cVBnr76IWQmxXOL4V/h1hnDdDkqhPrwBPALCL7rb+85tXil+uM3OHOWng==
X-Received: by 2002:a1c:750a:0:b0:3f7:5d:4a06 with SMTP id o10-20020a1c750a000000b003f7005d4a06mr12053858wmc.1.1686833507644;
        Thu, 15 Jun 2023 05:51:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l15-20020adff48f000000b003078cd719ffsm20968662wro.95.2023.06.15.05.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:51:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 15 Jun 2023 14:51:45 +0200
Subject: [PATCH v2] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from
 dma_request_chan()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v2-1-670c3d9e8c9c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGAJi2QC/52OQQ6CMBBFr0K6dgwgoLjyHobFtAwwCbR1CkRDu
 LuVI7h8P/nv/00FEqag7smmhFYO7GyE/JQoM6DtCbiNrPI0v6RVVsLsPBsI060sU1h8mIVwgo7
 fEDxDT5bhZdwEXpwmqLG+Gl3pkrBS0akxEGhBa4Zotcs4xtALxf5x4tlEHjjMTj7HpzX7pf/Or
 xlkULVY6y5vdYHFY2SL4s5OetXs+/4FmeeJAwABAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <error27@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=33BJA58rmJ1iVUNBM3K7fDzrmpBXHsLW49qR9cG18TA=;
 b=owEBbAKT/ZANAwAKAXfc29rIyEnRAcsmYgBkiwlinikvfoSVmG6jc9PFWVS4J6MwJUKiOnCx2S08
 78qHlICJAjIEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIsJYgAKCRB33NvayMhJ0TFiD/
 iISPz42k3ObVR4hBJ1YtfvRMOxHEs7dAzOH+8df8z6ZODNdR5WGT6RZ5cUU8nJt1i7QoYu57vSmC1f
 gQxZsZCsyTBKQzjS+NhzFXKHJtKISt+jp+ZB65ppMSFraQnYkQawfGfP7gbXRV9wpaH3UK4fRLsI4j
 5ofO8jwrZDWD6bFw7mqVMjhfebzbXqcdPQX2xZI1+f7D7Mxi8TtZvB7vvfyVzpqKLhd8coftcJrYoy
 h4fYo9RZtxdjqDSqKSoP2pf/DIU75lqZ6RsxgT1m01Tn0f8+/v7mBBgEiK/3W2W346d+mxU1F0en1z
 x9bCydQ9uOwcycNzeO1LK2fLEAJZc+QJ7ta9QBGOAY4ODph5DIDBlldTD+pidtZCSXEnD5PrYdiYx8
 n0tt1pdvz/Rxjq7dLEq9kIr2dpdgctbY/1xaRwRkNG6arJQL0dzu6VOSxvmlXDLNojcErxmSafCbqj
 sAqO6PKoxgk8g8cRbeYDEwqLxPRBAwzKohbP1w+oE2gMdThw3K7YHiWZlbllmd4d/oycUsmr8nVf4x
 pMTUDQI/1AIzcOiUNuPXrqo4+8sxka/Tp5XeYwLXmJ6kWX8qCsKLTTIIh+uYrb1KIvQdB6OgKSE/OJ
 x5zdERBJ9vjpaenm250J1bjbj8wwbuBS6q91elzJ2qVlOhBeZNPMvWw95A
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now spi_geni_grab_gpi_chan() errors are correctly reported, the
-EPROBE_DEFER error should be returned from probe in case the
GPI dma driver is built as module and/or not probed yet.

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Fixes: 6532582c353f ("spi: spi-geni-qcom: fix error handling in spi_geni_grab_gpi_chan()")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- added braces to second side of the if statement
- Link to v1: https://lore.kernel.org/r/20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v1-1-6da9bf2db4a4@linaro.org
---
 drivers/spi/spi-geni-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 206cc04bb1ed..26ce959d98df 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -661,6 +661,8 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			geni_se_select_mode(se, GENI_GPI_DMA);
 			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
 			break;
+		} else if (ret == -EPROBE_DEFER) {
+			goto out_pm;
 		}
 		/*
 		 * in case of failure to get gpi dma channel, we can still do the

---
base-commit: 925294c9aa184801cc0a451b69a18dd0fe7d847d
change-id: 20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-9a97cb6b5ea6

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

