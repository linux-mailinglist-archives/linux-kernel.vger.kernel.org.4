Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8965F28A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjAERVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjAERUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:20:53 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F36319E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:12:53 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id bs20so34663379wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AVf+pfLkaJ1Gl2NWqezqv2bXezRKHHSaj8ghEqd14w=;
        b=y7jLrTG7p7QjcN2Cna7QAn3CMLp/iGX9hFgyWOvIeyQoOsHM3qakRasdP5KMfs+NZ2
         FPGzPh9C37o2fDUts5urh+UMB69Vw/ZtDYJo91usNWWpzFe27e91iTXgrN37D02UUx9t
         A9JvGt7PQ8GoRaaxdmXkthGFdlZyGOajaTqKTinkqnl+uv1XKe3UHCKFEvvr+4LtZsLL
         AjXOiLXb2Mb1Xe0l7+XuzUtB3Imrpgn0hRHnNjrVUHZ6R94g8p2yLgyyT+xyPCEPI3RN
         DYPF1DpAztnyht4GNPZeB9OWUWZVtmH+Mr01s3DiR0khgIxwjyEXhz5WtNBVPTTz3INm
         YZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AVf+pfLkaJ1Gl2NWqezqv2bXezRKHHSaj8ghEqd14w=;
        b=vYOj8wnfFRsxfSuJ1DQxSDs4d6WdP7Xtr5K/T0m0mYzbbEoAAx8hxPqiI9x/Xsr4Q+
         7o5L60YnrlDB9esaSDloygyvq/ATF7RQUtqdSSfoFW0swtM8wBUBZjE10u4vXtFQ90l4
         LPjyR1fGAJD8BdRr/sqjhELiJvWN372xY3QRvv9om0MFc+5to7biWY//VE5NkbYVYc0x
         ccPj5dxIcjnZ3HXOYSk9S4ZPvhRY2/YEIqq6B1ga+ieQ5nsx5ccU618dJVwC/F+NMUwE
         y2xPML9K0FAfWXuk9+okO4h/Ts0lhy2Bk3er8JO/wjlYT0SjqVvCqD+p8TdUfZOBPMs6
         hzLw==
X-Gm-Message-State: AFqh2kqn/TJS81g6MZGhoSHiyVAnm65QN2fR+ruF5ftNz1FeDwr+Rb+9
        ufkVexfmerjSD8OW9O3k9kJdwA==
X-Google-Smtp-Source: AMrXdXvaEZbEf1VJvkJQZUZ0wp7+NbVXpfFjW83Omw2E04q6K1OndbNKvbHNrGOYQSYHZx9OqH/3Tw==
X-Received: by 2002:adf:ea4a:0:b0:27e:8d9b:bc20 with SMTP id j10-20020adfea4a000000b0027e8d9bbc20mr26665705wrn.27.1672938471790;
        Thu, 05 Jan 2023 09:07:51 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:9cf4:fdb8:bb61:5f4e])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b002365730eae8sm37164853wrm.55.2023.01.05.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:07:51 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 5/8] soc: mediatek: pm-domains: Fix caps field documentation
Date:   Thu,  5 Jan 2023 18:07:32 +0100
Message-Id: <20230105170735.1637416-6-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105170735.1637416-1-msp@baylibre.com>
References: <20230105170735.1637416-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field is not for ACTIVE_WAKEUP exclusively. There are a lot of
other flags defined as well.

Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index da827e91d462..34642a279213 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -95,7 +95,7 @@ struct scpsys_bus_prot_data {
  * @ctl_offs: The offset for main power control register.
  * @sram_pdn_bits: The mask for sram power control bits.
  * @sram_pdn_ack_bits: The mask for sram power control acked bits.
- * @caps: The flag for active wake-up action.
+ * @caps: MTK_SCPD_* capability flags.
  * @bp_infracfg: bus protection for infracfg subsystem
  * @bp_smi: bus protection for smi subsystem
  */
-- 
2.39.0

