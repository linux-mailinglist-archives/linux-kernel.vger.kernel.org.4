Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57186FF903
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbjEKR45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbjEKR4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:56:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3F093C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-966287b0f72so1194509366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827773; x=1686419773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blxzVw5ZIRppHWsDqH1Uz1DLv37Tw0S0eWN39CE26xY=;
        b=PCiS09Mtp3jTfvU/PIeslpOX0gEXgltnNeOCp7MxNnmSaPrQ4IDqlpIacMJ8KyUWvh
         m+ClNSoIBsenJK6wexQCrgc/tj9WbbRW9pOEfDzmyKi8Zz6MKTuq0uol6pJZcIp2bhYw
         rd61WY7zODd4R4K8Opdlto7PP482k7XCGS+3WESaZ0Mxg263s09THRNVoV45JFELDv//
         5qIFmN/Es1kxRIUKa9DNdp4URnRoXOwPxNOYTNyj35Ntxr71e8nk9oArhvPTyDZrk+O7
         9l38Ll5UJVeUSQDfXUXCqf9rI3PcAu4TtzUkbQJ7wL6ZPkzVLNpEANi8QWmMaMHe08VV
         FUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827773; x=1686419773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blxzVw5ZIRppHWsDqH1Uz1DLv37Tw0S0eWN39CE26xY=;
        b=GIlViMW5esNuKNzUdL+N1jpGVko5wSv226lakoGUjBA14Pw+pAC/uRcBOwcgzWKVkT
         0oAlPF+qrTnGROVKJR/DNbYnYMoY1XlYz2ZkEED6ETThbQjY40OiWZbNQrCcoO//en4r
         QTLZcSv/HF8yGx/MY9N5DYYfKl2eNxvlz72FdCsHFgQKFNmvMQHpSb9mlGjfIAWgtJbg
         1/QIqxquwgr1htOMka8Uh7B/NJkqBRDDkDvOyQ86V3xcrJe3yTP4qPDlwz4bsFRPI/3f
         AZF+XgSL83SF/aVg1XQEQsQaQ1+cDZd6ThcJ5xpCef9cCJ+gk97tdb03DLhDrnobC9Cx
         DBBg==
X-Gm-Message-State: AC+VfDy4pWVpn7Ty4MYqCy+RWRmN5/hBXiqRnm6R34IUw2FxgwD9wClj
        sIRiFM5TNhIhzPf3yJ/yd61iZg==
X-Google-Smtp-Source: ACHHUZ62nod24sIcYklrKeiETNWewOdWZVgMa8O/DUFPIND2jx1iCiGcnKX2rRP63Doav9NoiaI5kg==
X-Received: by 2002:a17:907:3686:b0:94a:56ec:7f12 with SMTP id bi6-20020a170907368600b0094a56ec7f12mr21091597ejc.30.1683827773470;
        Thu, 11 May 2023 10:56:13 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id lf23-20020a170906ae5700b0094ee700d8e4sm4247029ejb.44.2023.05.11.10.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:56:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 2/4] rtc: ds3232: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:56:07 +0200
Message-Id: <20230511175609.282191-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511175609.282191-1-krzysztof.kozlowski@linaro.org>
References: <20230511175609.282191-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointers to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-ds3232.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index dd31a60c1fc6..ce46016c9fd8 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -359,7 +359,7 @@ static const struct hwmon_channel_info ds3232_hwmon_temp = {
 	.config = ds3232_hwmon_temp_config,
 };
 
-static const struct hwmon_channel_info *ds3232_hwmon_info[] = {
+static const struct hwmon_channel_info * const ds3232_hwmon_info[] = {
 	&ds3232_hwmon_chip,
 	&ds3232_hwmon_temp,
 	NULL
-- 
2.34.1

