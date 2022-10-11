Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ABA5FB0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJKLGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKLGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:06:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB05D8BB89
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:06:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so15682068pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kingston-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+57ZqvNhATXLr/1cd2ohAamNcyquwTAjd/E20cKw2s=;
        b=VcFLBz+4MS1GumDcQtPFx6tVseQBByOcIHhTXPA82TisbjpEtb65HgNCMwG6u5+jnO
         YGgC3hTHIiRAi9EDKn69/5eRQkQ+4n8RuokPoV8062RX84Uk8nc3Jp5fvnl3PGNOtHzx
         aXTVo3aBmiDMQtF2Fk6wsz0Mdtxm2echPDrXw+hAnkLAFAaOzu2Vqwdt3G8OyWOfC+ss
         hUd13ApwQAeXVKvNONSN8id/jl6mT8AnBgltyO30rFDxMx8Oc+2nUWuQxIL6sBX3n6rq
         wcIP/yqE0G9R1ZHpAoYUfMyHN5xuNNdKFxZbGC0IEuuVMfUI2vBwPzrLqFJzV3nVBqze
         /3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+57ZqvNhATXLr/1cd2ohAamNcyquwTAjd/E20cKw2s=;
        b=UhgxE5RvgtvGT1UzdlrLFBz9Ss69GRyGw4sA9hISjvmzUBAjOw2zLOMZaWsMYB+b3g
         zYnFKdomOL/H7faV3wNecq8BTJKdGhucKs6yV7QBqhh/B422JG030NpPVQAYg9b84qrB
         Ls8ht7omx1dyV1oiczHNkX2njxn6Ve37CzBsmL19T2eENMcPt0lCz3AJtEmZy/qeMv32
         jPJMECGWReiF2ya1j3OWLBcLdFptwJoLNiHve38Y3EbYldCmTmKf1L6m5jihKVLqqouu
         lUmqXNOrJnRcyBQl7dXZDPSd+FyM+xnTYVz8K42plevGX2FwNhu5suLUlkrWVeUdv8eZ
         d3IQ==
X-Gm-Message-State: ACrzQf3Af/1KD/HwJsSvfmW8l9aV0A+wAgMpq/gO+Ht/d0yq0XWHApEh
        WsJx6bbwzjrfbqBNIoPT+YStLw==
X-Google-Smtp-Source: AMsMyM4UQwQoNpu+6donIYg/lUKUPw1egJCzLRU1XqQhLs8AcQBG6QxtKsMhD7hX5G1bCWeC4Sd/ZA==
X-Received: by 2002:a17:902:f7c4:b0:182:25d6:fc4b with SMTP id h4-20020a170902f7c400b0018225d6fc4bmr11247623plw.63.1665486411414;
        Tue, 11 Oct 2022 04:06:51 -0700 (PDT)
Received: from sped.tw.kingston.corp ([123.51.141.8])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7940e000000b00562677968aesm8752001pfo.72.2022.10.11.04.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 04:06:50 -0700 (PDT)
From:   Xander Li <xander_li@kingston.corp-partner.google.com>
To:     bvanassche@acm.org, paulburton@kernel.org, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, jhogan@kernel.org, christian@brauner.io,
        jeff_yang@kingston.corp-partner.google.com,
        dora_chueh@kingston.corp-partner.google.com,
        james_liu@kingston.corp-partner.google.com,
        vincent_wu@kingston.com, xander_li@kingston.com.tw,
        Xander Li <xander_li@kingston.corp-partner.google.com>
Subject: [PATCH] nvme-pci: disable write zeroes on Kingston SSD
Date:   Tue, 11 Oct 2022 04:06:42 -0700
Message-Id: <20221011110642.4333-1-xander_li@kingston.corp-partner.google.com>
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

signed-off-by: Xander Li <xander_li@kingston.com.tw>

Kingston SSDs do support NVMe Write_Zeroes cmd but take long time to process.
The firmware version is locked by these SSDs, we can not expect firmware improvement, so disable Write_Zeroes cmd.
---
 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98864b853eef..d08c8c854f3a 100644
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

