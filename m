Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17726D1E84
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCaK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjCaK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:56:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855E11DFB2;
        Fri, 31 Mar 2023 03:56:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so22961153pjz.1;
        Fri, 31 Mar 2023 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SMQ46G8IRFQna3g+4B67sNj9wZf4cksdhNQ4IUcuW4=;
        b=fX6Lk+BZ2iQGVeeWcpYCgL6buScSfsomo/VT9UiB3OraK0hYkzgQR5/VCi2Vq1pqyY
         ZRa5t3MdvPpKsBk8H1cW2QnqaTl9icu8tR7nMsMm85HLOfB2bXv1tONgGrYaujnCOCaL
         1Agi8+gBOSXKGPq8W9K4H3aEAMkBNf/04UrduOPkpRomXKGlw7lN3bF+IDbEgSQFmsx5
         PreEhJMkw6N4vnzVhhFvnSajBT+s0VNzilC/t+ND/QZ9ktiHiLneBZ7cOb6u2x4k3iJC
         yS0Id9irHqVAzko2NjcP0aLtMch2WcU0WiTjT6eZnXnyRB/t+0s6y5Y5bcr/M2YfNOfQ
         lV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SMQ46G8IRFQna3g+4B67sNj9wZf4cksdhNQ4IUcuW4=;
        b=Q+ArwnLPOerVnzAOdLnv4fxGHc/uplolu9Xzwq9DBJfDcixrj3ARx63pEQhyXHwyTK
         Fm5LX3l0nTeUYnhzejbcOByfQkjC27G5Qll6mxH4U2StmshsiL3dLdXysKZvXO07qAWX
         7prfPSr7yBRhycYXJVN878zQ1YNtK9UQloQIX7lqxLHuWE+3DlzRay8xoIm3wy8J2U59
         Kpo+N7j5Z/eMJPLqbkDfyzeW6TVqJpSOYojsDsO5+sR3pfiyza7bwBcq6zyEO0RPLhBx
         QQLI3LZhvxZfw2fSTibl/je0lYCLxIVyX5BHtXDYaiz08Pfklmun8i+/edsMtD5U1siY
         1SwA==
X-Gm-Message-State: AAQBX9crP4ij1t7SwIIrMdyAL5Aq8oGSeOJDS2vF6G3RxBAKuWQpbMYl
        2Z5PGGj+GbkdSWI8+mKS38QoVNjstmw=
X-Google-Smtp-Source: AKy350bGmCl9KJloR8IYlvEjE0+9QSMIhliwa1HoIkdPTEXjvchCoxyBb92WhyA8Poqc7V/1u5hPGQ==
X-Received: by 2002:a17:902:e0c5:b0:1a0:6eb4:3871 with SMTP id e5-20020a170902e0c500b001a06eb43871mr21529970pla.20.1680260198024;
        Fri, 31 Mar 2023 03:56:38 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-983f-c7ff-3efd-77d9-6c16.emome-ip6.hinet.net. [2001:b400:e25c:983f:c7ff:3efd:77d9:6c16])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b0019acd3151d0sm1287665plb.114.2023.03.31.03.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:56:37 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V7 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Fri, 31 Mar 2023 18:55:35 +0800
Message-Id: <20230331105546.13607-13-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
so no voltage switch required.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 3f232f4e0820..388d87537847 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -144,6 +144,27 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 	}
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * MMC callbacks                                                             *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
+						  struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	/*
+	 * For UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage switch required.
+	 */
+	if (sdhci_uhs2_mode(host))
+		return 0;
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -152,6 +173,9 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_uhs2_start_signal_voltage_switch;
+
 	return 0;
 }
 
-- 
2.25.1

