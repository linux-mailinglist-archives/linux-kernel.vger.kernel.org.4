Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA6E6D7F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbjDEOaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjDEO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:29:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAD45FCA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:29:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t10so141417898edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680704970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bjq5zDxQyCkbnAUsg6zX1gfO+rxaxBPGXjBwDghiQE=;
        b=H4hC3GDaNY44R/lZfk9Ppbm04ZMF5VnKXQo5sU2rs19jEBD1Dyv2ix/zvRT4NLrrsa
         gKUAAoBHb/y2VkC+zquiud4T86UODXw2uIb0xpw9Zk5c5yoHuYbA+VWMH4M3c2Wf27MV
         dlTlbX3nwRy1R8cC+JsuXrmFGrA5+GU5cZejIqv443Ffl6j16h+DEzwiUl9yDIjHpruh
         bDgn2edhzmivIj6V01L+h6g1vaanKpJn4K1aGSYr11MWd2swUep5dbnfXf+vHBsrAuFe
         7GJ8vXWNrep9nDx2niSXc2l7fLZJetgFmGBMctRaVsGSPjanVvi6f9NItyO/YtymZBXj
         dFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680704970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Bjq5zDxQyCkbnAUsg6zX1gfO+rxaxBPGXjBwDghiQE=;
        b=tZsS+3RSFy22pG6NvQwFAutwILkhT4pZABoJzPU2KtUwT9UQHgA32Ki8cjxDvkks58
         gEW3Ol7934GQ1DF3LF2pdHfCz+so37WgLISqX52qm+il/lvM2L1mZdO0QLXBWMwnmkUX
         Hqh4GNX0EBfB5Xi8llJiQT8NHXzmwboS5gal8FfCrkCgnkz/iYc2GOVS5zZaLASNbrII
         AlnDuz4vQ7Qx15dYkDnuYnGVJtOZLmLJKZJ9CjHTHuymxhXSQ8CX0qLgnysJgm0Qgn4j
         hghHGTnNW3/AZvs6BHAp7fZPSiEGLtCj2vY0UBPBV2UGGVrc7jtDsf7byfz/5v6Ko7W5
         Vb9g==
X-Gm-Message-State: AAQBX9f4y2cc7ISDMZU8gXZkOnaWBXRp6/ssku8J22SQrR44bF5Bqu02
        Nzd0T0wDfZXjkeL7mtzOXjyXXQ==
X-Google-Smtp-Source: AKy350bdNfN0ijKa36g6weBhlJu2OQB7Xk7REHbQEoBD/66q2jMFOaL9TSIUlG21GWdW2wFWZjG6Qw==
X-Received: by 2002:a17:907:a413:b0:91d:9745:407a with SMTP id sg19-20020a170907a41300b0091d9745407amr3450196ejc.14.1680704969847;
        Wed, 05 Apr 2023 07:29:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709063c0d00b008b176df2899sm7454367ejg.160.2023.04.05.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:29:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org, Patrick Lai <quic_plai@quicinc.com>
Subject: [PATCH] soundwire: qcom: Fix enumeration of second device on the bus
Date:   Wed,  5 Apr 2023 16:29:26 +0200
Message-Id: <20230405142926.842173-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Soundwire buses (like &swr0 on Qualcomm HDK8450) have two devices,
which can be brought from powerdown state one after another.  We need to
keep enumerating them on each slave attached interrupt, otherwise only
first will appear.

Cc: <stable@vger.kernel.org>
Fixes: a6e6581942ca ("soundwire: qcom: add auto enumeration support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Patrick Lai <quic_plai@quicinc.com>
---
 drivers/soundwire/qcom.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index c296e0bf897b..1e5077d91f59 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -587,14 +587,9 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
 				dev_dbg_ratelimited(swrm->dev, "SWR new slave attached\n");
 				swrm->reg_read(swrm, SWRM_MCP_SLV_STATUS, &slave_status);
-				if (swrm->slave_status == slave_status) {
-					dev_dbg(swrm->dev, "Slave status not changed %x\n",
-						slave_status);
-				} else {
-					qcom_swrm_get_device_status(swrm);
-					qcom_swrm_enumerate(&swrm->bus);
-					sdw_handle_slave_status(&swrm->bus, swrm->status);
-				}
+				qcom_swrm_get_device_status(swrm);
+				qcom_swrm_enumerate(&swrm->bus);
+				sdw_handle_slave_status(&swrm->bus, swrm->status);
 				break;
 			case SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET:
 				dev_err_ratelimited(swrm->dev,
-- 
2.34.1

