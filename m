Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FE05F075B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiI3JPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiI3JO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:14:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FD625D0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:14:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c6-20020a17090a4d0600b0020958fcd9acso2432775pjg.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kingston-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QPd9eEXSDM4l8sHCKdklGbGGizcbCpDO0CxV5alpHdk=;
        b=yjfnBkSz5gPsFoCQBPNRLWkEwc6Yj5gcU4LKGWGBFlg5gtjLPPpePyI824obQTjKGj
         /ip+LMsvmM8XESkCOwtta10++yxWpMv07x78xVZ10PE+dkqM0lWSksIXqO74eMIxCoR2
         cvqPCjYwBO0Dulq21r7d4bydGf8pWlV3GgfkS2uJDIjhx1OujgaB2d7un3o+DNCnpABT
         vZA9nbxCN3CLIoZLf6JKle6lbaaW2zgZH8EuMH15Opn6A/G6gtGQwugteIS8L9FpMaHR
         4YST30Z+1uDXJhD3M5N97qzp9LsF+U9u6ZKs3+mOmVuz/+NnyPB6iCskwiqF4HXNQj9/
         NM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QPd9eEXSDM4l8sHCKdklGbGGizcbCpDO0CxV5alpHdk=;
        b=nrAGsElPmHVcnTaXMUrnH6DNMe5Yd8frvesFwxmPzI1K8iCYGCd4efzVXRb1sT2HgK
         lJ8/BNTdQ07bP2ZNb5TBFPny29PuecDloiyjSJkPTsaL+pXM2oME1YY7VLxZ7TuPff/H
         /Y2fpv8Wwhg7lavuLhtdsxc9vD8JUfz1+b/AdaT6zYnBaFN49JBYn6PzNmKuNVtX2Lx1
         lMLOs9T9VU+/pv+eAhE0lRdbOww/EONScyW13LOHZdK/Ft2W2pXpcuMT92eVme8VQDQ2
         xd4Zd7aQZX5qcLTmb9iIovieT3R8+L2jS6HwVSVENtTC6IqAMZfk+PHoNZUQ+KPwMR2K
         3U6g==
X-Gm-Message-State: ACrzQf0+hEPMkKT0uqJp2YRMOFBtc4LsPz1HChJz/z811Q4PlT/Z4auY
        oQ8HEobxlbp2tbkjdtBrcx4ZTw==
X-Google-Smtp-Source: AMsMyM7wf9/ARhY4ybWJ/gXUgwD2rR6i0+3Q89cvvDVTMieCiUCoYlL1XsoklGRjdjWIVtL2NF3xDg==
X-Received: by 2002:a17:902:e5c9:b0:178:5a6f:6eb8 with SMTP id u9-20020a170902e5c900b001785a6f6eb8mr8076240plf.42.1664529294615;
        Fri, 30 Sep 2022 02:14:54 -0700 (PDT)
Received: from sped.tw.kingston.corp ([123.51.141.8])
        by smtp.gmail.com with ESMTPSA id u19-20020a634713000000b0043c84559f1bsm1221409pga.66.2022.09.30.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:14:54 -0700 (PDT)
From:   Xander Li <xander_li@kingston.corp-partner.google.com>
To:     paulburton@kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, jhogan@kernel.org, christian@brauner.io,
        jeff_yang@kingston.corp-partner.google.com,
        dora_chueh@kingston.corp-partner.google.com,
        james_liu@kingston.corp-partner.google.com,
        vincent_wu@kingston.com.tw, xander_li@kingston.com.tw,
        Xander Li <xander_li@kingston.corp-partner.google.com>
Subject: [PATCH] nvme-pci-disable-write-zeros-support-on-kingston-SSD
Date:   Fri, 30 Sep 2022 02:14:01 -0700
Message-Id: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)
 mode change 100644 => 100755 drivers/nvme/host/pci.c

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
old mode 100644
new mode 100755
index 98864b853eef..d08c8c854f3a
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3503,6 +3503,16 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x2646, 0x5018),   /* KINGSTON OM8SFP4xxxxP OS21012 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x5016),   /* KINGSTON OM3PGP4xxxxP OS21011 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x501A),   /* KINGSTON OM8PGP4xxxxP OS21005 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x501B),   /* KINGSTON OM8PGP4xxxxQ OS21005 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
-- 
2.25.1

