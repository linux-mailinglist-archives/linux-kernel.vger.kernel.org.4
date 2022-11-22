Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034B2633E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiKVOEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiKVOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:04:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454A1F2C3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:03:17 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 294213F367
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669125795;
        bh=MmX49LWmqBGT8gmV2EsghBdLKDSPXDw+pVh33IsMCLc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=m2u4ZSMxhLzt2fzKT6eez2efrj+6th9JDP7cXDV72ln47wVMOFABYhDzSt83Mmh9r
         xjkAr7P3EkrozsaQhnxwvt/umpBl5hngXrBA1z5umfalpThm7+ExFEvcyaY50PgLo6
         E5rDBCklMbRiO4OR9jJ3eu5bVL1bXIZ4dC5bGuqy9nWebf74HVJ4sYlAjGNTMdkfMr
         9aZ3Bq4TWIhl1tkOnGGfkjyuSqbl+2x+YT2H/o9u/+I5Je9p0QCLyofNBbFZ7PC3Dl
         ACAJe+p+H5ZlrfwmOoxsE5nNR6sFq6SWBOtalCMX03pdVcEpOwv+3y4tqoDVwM3TO0
         P0XSZ2sYQlRhA==
Received: by mail-wr1-f71.google.com with SMTP id j30-20020adfa55e000000b00241b49be1a3so4279723wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmX49LWmqBGT8gmV2EsghBdLKDSPXDw+pVh33IsMCLc=;
        b=Dict+OPRFrokJmXmelMzTE5sp/zNYzZuPWgPyy8mMi1/F732dzY3fu0+K5AEnzZzVh
         jKjrXLrbn9mq9V/fje2VhkmezD3BzQn8z7yK+ZEOFBlZQ6akFRrNOfFUnRmsiTtwI6h7
         tZ7EhlGwupCCbIfy2LBp3ocMYKCX0iHTJ7frztAM4aMJ/6O6SB9rpkCi131x6pw3k6jb
         AEx7Aesh3lcVviOrPHyEm00LoD9o6s8YzEVbjauEuG2OW3ZDTGYvAAUICK/CUHvkjCDB
         gQLEB2FVARsf8YaQi018TVgvCmqfqaOu3doEer3VAf3wWnl1r/nzZk1HrFCDX87rcfBw
         haeQ==
X-Gm-Message-State: ANoB5pkgwJxeKODvNv+IcLzbDEs3jYAdJBzh8Gi0t1ldekAvk1tw3EkQ
        CoqFSXynJktv1DbNRbl5/QrjzSOIVWUFAxvkmjtWr2gym6YVTlRJ8cWQjXXSndWApy27el83g7o
        oQtT1aCQPrXdnO4RGjn0IMUIOT2bk0tdmLveApyU/+g==
X-Received: by 2002:a5d:6ac7:0:b0:241:bf95:c9a2 with SMTP id u7-20020a5d6ac7000000b00241bf95c9a2mr11902766wrw.387.1669125793788;
        Tue, 22 Nov 2022 06:03:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6itCxbOSfPPcAiL47OVea+GeSvLP64Yp86nrlqnW+Dypb4W+pn3NIa/J+w8XPmI/i0f5DWZQ==
X-Received: by 2002:a5d:6ac7:0:b0:241:bf95:c9a2 with SMTP id u7-20020a5d6ac7000000b00241bf95c9a2mr11902547wrw.387.1669125790435;
        Tue, 22 Nov 2022 06:03:10 -0800 (PST)
Received: from localhost ([137.220.91.195])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003cfd64b6be1sm28849313wmq.27.2022.11.22.06.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:03:09 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] Bluetooth: btintel: Correctly declare all module firmware files
Date:   Tue, 22 Nov 2022 14:02:22 +0000
Message-Id: <20221122140222.1541731-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strictly encode patterns of supported hw_variants of firmware files
the kernel driver supports requesting. This now includes many missing
and previously undeclared module firmware files for 0x07, 0x08,
0x11-0x14, 0x17-0x1b hw_variants.

This especially affects environments that only install firmware files
declared and referenced by the kernel modules. In such environments,
only the declared firmware files are copied resulting in most Intel
Bluetooth devices not working. I.e. host-only dracut-install initrds,
or Ubuntu Core kernel snaps.

BugLink: https://bugs.launchpad.net/bugs/1970819
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---

Notes:
    Changes since v4:
    - Add missing "intel/" prefix for 0x17+ firmware
    - Add Cc stable for v4.15+ kernels
    
    Changes since v3:
    - Hopefully pacify trailing whitespace from GitLint in this optional
      portion of the commit.
    
    Changes since v2:
    - encode patterns for 0x17 0x18 0x19 0x1b hw_variants
    - rebase on top of latest rc tag
    
    Changes since v1:
    - encode strict patterns of supported firmware files for each of the
      supported hw_variant generations.

 drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a657e9a3e96a..d0e22fe09567 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2656,7 +2656,25 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE("intel/ibt-11-5.sfi");
-MODULE_FIRMWARE("intel/ibt-11-5.ddc");
-MODULE_FIRMWARE("intel/ibt-12-16.sfi");
-MODULE_FIRMWARE("intel/ibt-12-16.ddc");
+/* hw_variant 0x07 0x08 */
+MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
+/* hw_variant 0x0b 0x0c */
+MODULE_FIRMWARE("intel/ibt-11-*.sfi");
+MODULE_FIRMWARE("intel/ibt-12-*.sfi");
+MODULE_FIRMWARE("intel/ibt-11-*.ddc");
+MODULE_FIRMWARE("intel/ibt-12-*.ddc");
+/* hw_variant 0x11 0x12 0x13 0x14 */
+MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
+/* hw_variant 0x17 0x18 0x19 0x1b, read and use cnvi/cnvr */
+MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].sfi");
+MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].ddc");
-- 
2.34.1

