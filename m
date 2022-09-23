Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967525E7F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiIWP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiIWP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:58:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CA147CDF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o2so940349lfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=oMr0u4U4uB857JftbbkRJcLFLiEsse/bULU+XmmO99c=;
        b=DSFhUhEI5jIJ0l79fZ/RpiMJcCABCZt41//uZqQbhGP+SMHboZlWew64YaUL1Zt6N1
         WROtxtQ0pjiBJrz3Wwk+Z4gL6aQmsyhW2wZg/WwUBlp0wdev6ge4JNVSnEcEPt68091w
         cZGTSk4LWL3RB3uOZXbgOKMNCpVqIEBTwkJzSXYfiUAfKN96zhSkqOh2/hbanYKv6qYI
         kM5t9xA10/DXsmypKJulAM6TKIfLSMN67PwQ/1h6RDXckeoIKj4WEA+fnzbArU+kBCh1
         bQu6GcdEMfLxrIVD5Z1e3hxwW1meD2gZDnV8/5c3YFVQeKDDeWpq9kh4UORGoymDNHE3
         mSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oMr0u4U4uB857JftbbkRJcLFLiEsse/bULU+XmmO99c=;
        b=ITPuAtwAA6VTRKd+UJtNdw8KtPxwM3pG2cioxY2B760b3Xz3pLYW9GWbbSESIk5hJd
         UQLbR4lxYuRmqm5P5Tmd8diY1YgdSIpmLwdsQHGAUVFjotii/vcVOBDv6bXSyrUpSVHX
         pkVThKvKjHAminyrdCtvOAOwpwDbiLNr1cz6Fyl742KrS1ki1IcITF+pRqE+QGrcu3Fg
         wh/qVOyOp8XRR59IKTZlRVSnVlE2zMWoFjPS3rhDy1rsx2qFymVesaGN8kxRQ/dCbbjP
         Zi+CAEoaqkYDvAZXo7U1h4uYC/kH4n4GZd3di193TJ/QckdwpsnSJxTfh8pG6j3f+pDA
         T9/Q==
X-Gm-Message-State: ACrzQf3yGchNLfY5MYDgHDr2o/7xmBnGAAI8b4Q0I98lR5A3foNkr1q+
        PBQdFoKlt4Hn8pOj65AmmleKew==
X-Google-Smtp-Source: AMsMyM6SHmdPjbUQmqQLrTntDA+yJrodNrgqKTD0Yq6Gwj0hUWQkPwkCKVr0Q4Ko35CpEspD8KIpAw==
X-Received: by 2002:a05:6512:1590:b0:49a:9db4:5a31 with SMTP id bp16-20020a056512159000b0049a9db45a31mr3367232lfb.667.1663948671660;
        Fri, 23 Sep 2022 08:57:51 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be17-20020a056512251100b0049a4862966fsm1502286lfb.146.2022.09.23.08.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:57:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] slimbus: qcom-ngd-ctrl: reinit the reconf completion flag
Date:   Fri, 23 Sep 2022 17:57:40 +0200
Message-Id: <20220923155740.422411-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
References: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinitialize the reconf completion flag when ngd registers are
not retainied or when enumeration is lost for ngd.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 548dd7661334..e8ebfcd0655c 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1136,6 +1136,12 @@ static int qcom_slim_ngd_power_up(struct qcom_slim_ngd_ctrl *ctrl)
 		return 0;
 	}
 
+	/*
+	 * Reinitialize only when registers are not retained or when enumeration
+	 * is lost for ngd.
+	 */
+	reinit_completion(&ctrl->reconf);
+
 	writel_relaxed(DEF_NGD_INT_MASK, ngd->base + NGD_INT_EN);
 	rx_msgq = readl_relaxed(ngd->base + NGD_RX_MSGQ_CFG);
 
-- 
2.34.1

