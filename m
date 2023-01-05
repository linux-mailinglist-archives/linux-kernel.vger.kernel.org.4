Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8431665F25B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjAERPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjAEROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:14:55 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19ED59F90
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:09:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t15so27899592wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQxJ8mog5ezSsMdjmsKqEBp6+hXiOvAg1jR6vm7PG+8=;
        b=4kxlkctBN34tswnclEHBz3Zz73r4pUFC3OC7ddlY91cJy5vWRE78R5eHn/ugD86m3o
         jJh9k7A9+zB7UWJtwYiyQP5yb/m+gYZJOcY6bTC6XJsH6Y4oduXx6hjq0322pOClRJqr
         PZwUiUfdQRKJkQPm00aWn2qRJ3J0U+jAqOBw9IbL4/Y3kN2NmSwIVKuW2qUdXslRjIcA
         iVqbzc9PtKskIO1dfXDCdTKTFFk39hIB8FQ/0WIpCL+RfpI9xuRfIbpyThFlSQsrGA8i
         G0FnEuyS3Nxrm/0Up0tup4tht2hBMA2X68hicu/hs698GRIdbIRbXAkG5Jh+akhGAimJ
         tC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQxJ8mog5ezSsMdjmsKqEBp6+hXiOvAg1jR6vm7PG+8=;
        b=ReIvLTfCeKa/B6No7XAqZcqKNpDaTU1KhhzBKpbZzpMhujJR6MY73dq7qDZ0UWhMLm
         XntI2AVwxkwkp4pAj2hKR81IL8wheHMKcN2lxyLyW8hoFRO1MIf8rY22SdiR3Dr+SV1f
         hCHI2R8/ilO+h7n+xGEfP0KBDl9g4stxhemb0r/J7i/+2oTU7F5o2x3aCkGDlqS6Y2q+
         fFx5TaPKpKFL9a5y12pTsjHcPp3g6DdgDuGXOlXGYagCFrhH8nwTZpPs5SElECYmLX1k
         TfeBVYamXC5gDuAamjfxREgxR/uvWJPUxlhI0zG3k+JKfRUqz8M1i63Ok6Tfm3I1qjoc
         IiMA==
X-Gm-Message-State: AFqh2kpd+a3Kop9LJT/mZnOC4cjU/EYN3wJh3PusGvlMOaCslhMpH35U
        JP3MXwfywFWytkbKusj4+RNfDw==
X-Google-Smtp-Source: AMrXdXuj6LXzblcUMFL7Ac48d0ZUS2gXbM/A1z/fodQupcf7Yy/HCR4r5KENqvOgeaf+oVvjoUeOzg==
X-Received: by 2002:a05:6000:789:b0:242:43d1:6d8a with SMTP id bu9-20020a056000078900b0024243d16d8amr40267367wrb.59.1672938470765;
        Thu, 05 Jan 2023 09:07:50 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:9cf4:fdb8:bb61:5f4e])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b002365730eae8sm37164853wrm.55.2023.01.05.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:07:50 -0800 (PST)
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
Subject: [PATCH 4/8] soc: mediatek: pm-domains: Document scpsys_bus_prot_data
Date:   Thu,  5 Jan 2023 18:07:31 +0100
Message-Id: <20230105170735.1637416-5-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105170735.1637416-1-msp@baylibre.com>
References: <20230105170735.1637416-1-msp@baylibre.com>
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

Add a short documentation for the fields in struct scpsys_bus_prot_data.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 8aaed1c939d7..da827e91d462 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -66,6 +66,18 @@
 				INFRA_TOPAXI_PROTECTEN,		\
 				INFRA_TOPAXI_PROTECTSTA1)
 
+/**
+ * struct scpsys_bus_prot_data - Bus protection setting
+ * @bus_prot_set_clr_mask: Bitmask used for the set and clear registers.
+ * @bus_prot_set: infracfg set register.
+ * @bus_prot_clr: infracfg clear register.
+ * @bus_prot_sta_mask: Bitmask used for the status register.
+ * @bus_prot_sta: infracfg status register.
+ * @bus_prot_reg_update: Only update the register bits given in the mask, do not
+ *			 write the whole register.
+ * @ignore_clk_ack: Ignore the result in the status register for clear
+ *		    operations.
+ */
 struct scpsys_bus_prot_data {
 	u32 bus_prot_set_clr_mask;
 	u32 bus_prot_set;
-- 
2.39.0

