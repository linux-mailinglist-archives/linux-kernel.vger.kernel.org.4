Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948647313A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbjFOJXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241180AbjFOJXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:23:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228A42963
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:23:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so14060245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686820999; x=1689412999;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1eJ4rnNncWrFdm7bzEMvmmaAxoGgUg9BTjanAGULWsI=;
        b=lNkaJMTARfH1VVBY7ioewtuj5T+/397Y5tzHIR0/jHDP8W0qjTF7ROKZKBzio6ZDtM
         wz85yYf9rauahRbspJ9s3ynh/jlbRjglnIKT+CsyjlIzWwS5TmC5AZD5xnfAUDvB/RJB
         LggpzGXbhIzCo+neKd43+fZoTWVheIVOYJvXGAVa7hpXDQqhlY8/1yZYNRMzXkX1z0Jb
         mfirEGq/JuIzsmUSLje77zdGGJE9e8Ym6jDOJrS1VD1W2R98ElQCo5GmEcifSBefY5ld
         FQvcvqT4EQ8BJCGxkUbOFE9ndvWoHgK9LMbosqKz80XUC1GS5pCFuonQbF5iwsyiYn27
         GE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686820999; x=1689412999;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eJ4rnNncWrFdm7bzEMvmmaAxoGgUg9BTjanAGULWsI=;
        b=c2WCHbvCFfZiAv5xexYxGxCvRtmlY3HiAtkbadkd2F/8EH37V6haFVy+hkGmn/0FBD
         Z4zG1b1z5QELMHFc0XNOPqovKk28Pn4qhiEtdw7Hmn5YNdAXI0CKbICa2A+g/Wq8frEw
         lC99D3pkmUc5UmVqVah4LBWvBolenQFRp6JmyCRNo+VdR6mC2ppgP+9TsNfaWVWsX7+c
         oV+JwLkkhaosUypefLmdPr3MO/tC33qVR0TLDHt5EEagYlSTTMSOXNsk0pMp44MGjsYY
         ghHoLFXLUYLgUFYZ7FlDKpBohgIjbrik38EXedngL6On1mWZetuh1F4tPQvZU2UiBwad
         2W6g==
X-Gm-Message-State: AC+VfDxgRT3vIo89G98+2hVFZ94SwJQA0yLTdubQhR4XUgwFK+k/O0M6
        Tdvz3cOJd/bvZXwe7KSWnsCw4g==
X-Google-Smtp-Source: ACHHUZ6C/7h2raAbsdWfbPiQPMNqx4kHVtCF3NETr54+UGit+TWqvkF/22lfW66ubm4EKfaSeLbUFA==
X-Received: by 2002:a1c:6a18:0:b0:3f6:a966:ee8d with SMTP id f24-20020a1c6a18000000b003f6a966ee8dmr11361233wmc.26.1686820999555;
        Thu, 15 Jun 2023 02:23:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l8-20020a1c7908000000b003f7f4dc6d14sm19658140wme.14.2023.06.15.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 02:23:19 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 15 Jun 2023 11:23:17 +0200
Subject: [PATCH] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from
 dma_request_chan()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v1-1-6da9bf2db4a4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAITYimQC/x2OywrCMBBFf6XM2oG0kmj9FXExiWM70DzMtCKU/
 rvB5TlwD3cH5SqscOt2qPwRlZwa9KcOwkxpYpRnYxjMcDaut7jmIgE1Xq01uBVdK1PEl3xRi+D
 ESfAdcsRSs2ccabwE77xlctCanpTRV0phbtW0LUuTpXLb/0/cH8fxA7kKpZqUAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <error27@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=e61ddUxKVebTptBbisyS/Wr1T7LFFXf6wr3UGnWvpKY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkitiGXiHO86mu7QvqOwC0OnKaPO//C+YLvVBvmcp7
 ijTrhBmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIrYhgAKCRB33NvayMhJ0Y8aEA
 CUDTxQcSCAJscYUDzIxaLaeeelc2MzGtpM/PDKENWhBEgHkYKTPuCQxxhILZ7lQj1WLEW1+x1HuqLI
 EaR5FosiP+uwEN6bWCjS8DaqNPsh9Fovy0r1auSCYXy739hxzPOY1ANt1GVOl4TfP+WGdbL6913QH6
 ly9qT/jClaYomhtUzTlIBOqo+fEwMI1yhtNDV4bkQww1K8Osd9cgQY29rRbkllaSS/+yQGnvIQ3ASS
 yXxbKoPxSkMoEi+1Em5leQLktTPxGIgH8zi7mlYgk5E+OAqvAbOLj+eqRcvF6W/Y7si6dYide8wz0n
 3Dl921NMJi5BZlmSCszRrgK/a74zjkyLCmi7LNzqaK1uY314PIY7cEROcSw7+zkQRL10374l8BzUf3
 sNKG+truLBNhyuQv3fRuQKr1GdPTVXtjb78ZnAJEzMr+j0kYWlseOzRMWZ/FarEDkB8CHjDcJxiihu
 LCiTQ9Fi+WfiZ0Xz4Ny95HkGYWNia5tgGUApYckUJCKNNmkR3LlmU8J7JShx4pUO6xi/qdfNUPyA4U
 bJj5IAXeLPW+77oz+bX130fDPS3kJpQsyQjKxjb+/UkASdEiKIsgIf7fepuO9s5t0CtQ12R7ieEVJF
 NZ4ll5PIjYAnGdIqAUE2rybPSKLORzMspXEa+yD05nr08fQc2BFF++uThNPg==
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
 drivers/spi/spi-geni-qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 206cc04bb1ed..0ebcc5fe92de 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -661,7 +661,8 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			geni_se_select_mode(se, GENI_GPI_DMA);
 			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
 			break;
-		}
+		} else if (ret == -EPROBE_DEFER)
+			goto out_pm;
 		/*
 		 * in case of failure to get gpi dma channel, we can still do the
 		 * FIFO mode, so fallthrough

---
base-commit: 925294c9aa184801cc0a451b69a18dd0fe7d847d
change-id: 20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-9a97cb6b5ea6

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

