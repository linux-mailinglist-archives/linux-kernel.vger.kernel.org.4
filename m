Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462F26FF8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbjEKRwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbjEKRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:52:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74278E4F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:52:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965e93f915aso1500330766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827527; x=1686419527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D8URLn+g23i1yjj8oxAaJ0e3uDPsCn61szunzKVPv/w=;
        b=Zh2jDRQmDyfhBT7SzBRW/AxeGcAbWYTjfZUdcdmTR5ZzpAUG3A3u2mA18iWOVdZ//9
         N2CV3ucvdmm83AQRy8YIpF0GPsY7+kV6ndE5yVC1dketCE8N7eRY+hpyV5i2t8qqWe3k
         0D1M9Xp8qjBKEUfe/7eY7QgFoRVcEG66oWmq99yG1WzUhKLnaaAP7CrBvOvWW48humfs
         1X+I90Un05dHTu6Ie/263lfXMkBoMjFV+MJ7FYpL5vyYKG1OJVQLfG4ElXmM52/n/qI4
         ZsejIb29XzggAUfCx36KYRTAnYHpaWsUQRmvvLT47gNZXkR6qrTx+puql+ukdPI2vS5V
         QSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827527; x=1686419527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8URLn+g23i1yjj8oxAaJ0e3uDPsCn61szunzKVPv/w=;
        b=UU2Y3A8V2rce/pmW7/BuBkYr6HoTYecrxvnhkJGWqolknpIa9aAnleRgrDwyllUJ/S
         iUxJ2azJw2hGzNxqB5mFrvjZMAdOj1BhRf+mN/kgyNfCb8D3TdC9WufMZ03Q10Ixm963
         gBN/p2vgmcVHqG9S57i0+C8bwbLaX5oXOE1Jhihp/5g8vo1DrvSCqVoejHh6pwkNZaOr
         XQ5c7ukpBkR7for3ksz7Zp+tsej+AIPIP8OM5sNHaix4tcKVDuxzBsn3+jx/O4LDcDdp
         hBOWokSyfkooMTNJu/MMEdh2LdCJ6LwMTpxsL9/mQNKKeNNaUrzMKwNDZyPhOvIRoJ6K
         5Fkw==
X-Gm-Message-State: AC+VfDxcLj6uPlqqkssBryf6IWo6qY+YujIwGU+0QHjbtr0VD+ODLnH+
        nVcGcJw8kmkgeLvhsOTDNw73Cw==
X-Google-Smtp-Source: ACHHUZ4SFqleJ+uFXYZqmJAP+bswnbjWqBEMdGDFjJofys8Tqnizpo8GaGcGWbZqGJmDDShfrkzQcQ==
X-Received: by 2002:a17:907:8a16:b0:96a:2cd7:5085 with SMTP id sc22-20020a1709078a1600b0096a2cd75085mr6885906ejc.44.1683827526917;
        Thu, 11 May 2023 10:52:06 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id w10-20020a170907270a00b00965e9a23f2bsm4259091ejk.134.2023.05.11.10.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:52:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ufs: hwmon: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:52:04 +0200
Message-Id: <20230511175204.281038-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Changes since v1:
1. Correct whitespace
---
 drivers/ufs/core/ufs-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-hwmon.c b/drivers/ufs/core/ufs-hwmon.c
index 4c6a872b7a7c..101d7082446f 100644
--- a/drivers/ufs/core/ufs-hwmon.c
+++ b/drivers/ufs/core/ufs-hwmon.c
@@ -146,7 +146,7 @@ static umode_t ufs_hwmon_is_visible(const void *_data, enum hwmon_sensor_types t
 	return 0;
 }
 
-static const struct hwmon_channel_info *ufs_hwmon_info[] = {
+static const struct hwmon_channel_info *const ufs_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LCRIT),
 	NULL
 };
-- 
2.34.1

