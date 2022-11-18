Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F216262EDF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiKRGxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241214AbiKRGxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A0982BE6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g12so7776501wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og63pceIA7GoiOGEU/UVdczuhva0E2O0k1c7uhpWYjw=;
        b=wZvVPFT8vDzSE53TcaNk+9avzt9t4pG8B+1nr2b2BRjO+bvROVeIIIEuvQcWX25C6q
         fZnSjy8VdUyYsejpiWbZOZKHrZhAvGvsGIp0gVaEF4k/gpoo/BrBfnv78vjK6NnyAn8J
         zM0/DWIAV9v3udqkOxFrJNOtdLMB6RYmqgW26/wXVU1dv7JQyq1tLtJD2letwU0Qz2VR
         v7vp3kxswmW/4iTD1DRdJLl3g+75s8Yv6FbXlYSby2OaS2Resqt7uYKOumbTI3D93nf+
         stgcoctXxFhSzltdH2qfT5JJfm7NSo/ZEb8GaUQip5SC3oIEBrbIqdWfsFqV4lvwnId7
         E1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=og63pceIA7GoiOGEU/UVdczuhva0E2O0k1c7uhpWYjw=;
        b=IkN0HSdvNPf8UGWnMEEfr3LstuD4kJ3OSARUAJUrLrk2MYib00rFCJeHHL5iI37e9R
         ++H+s9rsmR1IY1OXxNuOiJh/sIbzitLwEzl8XXuxocyAGKaAwLt/Rc7v8JPPDGAKO27U
         SrG+vvNvvX7mF/oLzvasni5uhkImOZ3MYK9vJbViXf1gaTt+GvTAtESkPbCH9FZpNwXa
         1lIZyAnSSP+jbuE3THQFDFQjfqU9ccOVQ5yXB0EI9blm3js+TOJXW2jRBSTxgVwMgIoN
         QcAaqctkqdiUjYZdl03NDR6coZ4FdNMKp7DfS+Q7JtiWw3tm4X50uwmseBZWqGPSAsO3
         U4qw==
X-Gm-Message-State: ANoB5pneQg8C+ep8b+e1jrYkXwp2anw3VbPfohvcOQpCqhFWSZ+uDMfr
        +6qzLJxJ4Zd06iP1JPfUM/S7sTJRedlJbw==
X-Google-Smtp-Source: AA0mqf6JAwuCAtAAOXkitHdw+khffDLfU3C1dx0WjC0FKcpDDqCD86HAO3kNqmbpVkWbCKTAfFbteg==
X-Received: by 2002:a5d:6191:0:b0:236:6102:bf3d with SMTP id j17-20020a5d6191000000b002366102bf3dmr3309947wru.705.1668754386251;
        Thu, 17 Nov 2022 22:53:06 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:53:05 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/12] slimbus: qcom-ngd-ctrl: reinit the reconf completion flag
Date:   Fri, 18 Nov 2022 06:52:43 +0000
Message-Id: <20221118065246.6835-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
References: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reinitialize the reconf completion flag when ngd registers are
not retainied or when enumeration is lost for ngd.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index a6f3b6860d8f..77aa6d26476c 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1205,6 +1205,12 @@ static int qcom_slim_ngd_power_up(struct qcom_slim_ngd_ctrl *ctrl)
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
2.25.1

