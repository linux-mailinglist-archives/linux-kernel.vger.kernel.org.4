Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C12872F52C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbjFNGuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbjFNGuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:50:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB301A3;
        Tue, 13 Jun 2023 23:50:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666520247f8so324236b3a.2;
        Tue, 13 Jun 2023 23:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686725420; x=1689317420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNU2A/dUYsnfw4tdADFd8+n69e8TqzXUbv0O6opxA8E=;
        b=V62JOONWlQRzNU874AKBiipNAAJPArF8i6gxpgW+5O+5WMIRvclpKTGCqpMExANoxz
         ROh9x2n1UvQOBt8IOr5NiJlgeyJMbYH1rZLKSc2mXjFRyaa7o+Jp/+h1QumUYB9IGRvT
         SW/JAJiCP4HynCBdx1AYu51vxCAzQnrkN4EzAfCe2weiJNAobq2sC9Zi5P/d8wP/dlzv
         SRxAl5BX+lMHOfwtfG4C0EWSD4Iko2kJeNO/NFxGmiDNunB0sWpBl0xeyP4Gve5M1/W1
         Hb4UFqNVAW1lEJ4MDsHxEoGuG8dMRZEiLusAv/m918j+U1TxvIdCzvE/x7AXf8virniK
         cexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686725420; x=1689317420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNU2A/dUYsnfw4tdADFd8+n69e8TqzXUbv0O6opxA8E=;
        b=UqJU6UbP52n/NczctyyjvZ9/zEAlsRNUWhLQ4KfAfPIGFktyJkZp2cxo+FAMY1PXY0
         7Rx+Hcl+6qfjTrQSF4Qmw+XUKJKXx69MoPois/xQL1fP4+791qaOM98Z44qyzmqdp37K
         DjSU9J/HWOol9Z6R+vi9riMDAwjULpBDy1Bx3fYc61gBikWZC2w/Bvu9XZqq1J/7RAYL
         cSUVYkIM0p7tlLt/GWvDGI331/a+2s9pmt7+4hkUAzKVjiqFuAKXoNou6PRlejpgrX8V
         gKv/hJkZj3BEcNQkSQo+rsCN87GwtcU3P0jeVOMlhsAZe8hyVvSQpw9Tbc7l5DZZMx4g
         zNTw==
X-Gm-Message-State: AC+VfDzdcdcagJh3LYr563TxvvZiJXNeOAWLeCfRP6b+f84GbBZ7pc8b
        ZzVV8DW36jUxF6qP0tVieVw=
X-Google-Smtp-Source: ACHHUZ6TCrTOyaQrRE/PfsRWkHfvCnSu/mmtmuZs/UIQm7YuEqQwaom1mQ4V+PTcqp9nf5Pgqp9S9w==
X-Received: by 2002:a05:6a20:7fa3:b0:112:1e0d:14ae with SMTP id d35-20020a056a207fa300b001121e0d14aemr1054131pzj.7.1686725420098;
        Tue, 13 Jun 2023 23:50:20 -0700 (PDT)
Received: from localhost.localdomain ([61.68.230.184])
        by smtp.gmail.com with ESMTPSA id a18-20020a62bd12000000b0064ff855751fsm9629371pff.4.2023.06.13.23.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 23:50:19 -0700 (PDT)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] platform/x86: apple-gmux: don't use be32_to_cpu and cpu_to_be32
Date:   Wed, 14 Jun 2023 16:49:32 +1000
Message-ID: <20230614064931.3263-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparce doesn't seem to like using be32_to_cpu and cpu_to_be32 to convert
values for the MMIO gmux to/from the host architecture.

Instead use iowrite32be and ioread32be to always convert, which should be
fine because apple-gmux is only used on x86 with is always little endian.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305161712.5l3f4iI4-lkp@intel.com/
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index e02b4aea4f1e..cadbb557a108 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -278,7 +278,7 @@ static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
 	iowrite8(GMUX_MMIO_READ | sizeof(val),
 		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
 	gmux_mmio_wait(gmux_data);
-	val = be32_to_cpu(ioread32(gmux_data->iomem_base));
+	val = ioread32be(gmux_data->iomem_base);
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -288,7 +288,7 @@ static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
 			       u32 val)
 {
 	mutex_lock(&gmux_data->index_lock);
-	iowrite32(cpu_to_be32(val), gmux_data->iomem_base);
+	iowrite32be(val, gmux_data->iomem_base);
 	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
 	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
 		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-- 
2.41.0

