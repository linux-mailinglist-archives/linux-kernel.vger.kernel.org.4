Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B268D3FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBGKXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBGKXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DE916AF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675765380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kaGTXgzMg0XGfm10jL8cEFT/Bw3WHCNbxpsPm5Ff46U=;
        b=XSY7mx6L3jX9bQKe0qwtwVGRC9lS0FgJxup/NWXS1iZ9yFGfoRQ3+aMwl6zT09DiktbUO/
        vlOtFT4oI+R37cDA4ZVKLkh+9llXZJJd5mNB0XHg52GC8WOQv38pmDWn8b5pVVPMLkP9Bt
        J7B2yjUvc7Bwe1zyOm4grB7FZPSzjBE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-yA9R5vuuPnyAHZUdS59F8A-1; Tue, 07 Feb 2023 05:22:58 -0500
X-MC-Unique: yA9R5vuuPnyAHZUdS59F8A-1
Received: by mail-wm1-f72.google.com with SMTP id d14-20020a05600c34ce00b003dd07ce79c8so7951412wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaGTXgzMg0XGfm10jL8cEFT/Bw3WHCNbxpsPm5Ff46U=;
        b=q6IPSunLdFdVAzO+0jrgwNhnWdeDhGkY8Nf/OB6N8t1mbF1KnK5pHfbDUeCbQDTI5z
         GEFJLv8DJOcRqlHeS5P3zLF9ZaT5890QqFeub6bGTK+qHsB4GuWxSxBoQ+LC8mPfQRiV
         c8ph7FpAPTGkAk76nFkqEhvlrBgLuvyFPwDSGxXfyfrxT0nNoSRn2FjxPWUjnpsOjntc
         2DVkLLfn5x0y3pVGNm3csiAMre8HungQux15l9iWelJLFGI538j5A4PE/l1DZREaKUHL
         Mta/tjrEDiQV8i+cTZ7CFxJ3xRf2Pgr0pRLoZ8MOMP7po9zvwIDIEk5wr/b8qSCRwzYP
         jBbQ==
X-Gm-Message-State: AO0yUKUfp1U2UyJM8cJMM4PXnaCBPJPNX3CP5QR0NuLPKZsd8TrqxerQ
        3P/v1q/cvZsglDSDAdEFMY6Rbio6ku/EVUfLNaFNXLz6L3n9tzIWQmCHlrYyw0y+AgTWKGbKmn6
        AYc6yPz7wijKnsMMnfvlXLp7Q0pD8h6Hmur8y0cdndhKDsd6AHgvuesf1GTsSgHUOOdAospfy7i
        trXAq/
X-Received: by 2002:a05:600c:30d3:b0:3dc:2137:d67d with SMTP id h19-20020a05600c30d300b003dc2137d67dmr2548340wmn.16.1675765377550;
        Tue, 07 Feb 2023 02:22:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+kFJF3IIArixCkhseEqNzPTZb4cGYHwhhx51Ic3oP3/RY+LTlDYZBBIOlKPPts4sizqXDatw==
X-Received: by 2002:a05:600c:30d3:b0:3dc:2137:d67d with SMTP id h19-20020a05600c30d300b003dc2137d67dmr2548318wmn.16.1675765377333;
        Tue, 07 Feb 2023 02:22:57 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c459000b003e00c9888besm2632708wmo.30.2023.02.07.02.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:22:57 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Albert Esteve <aesteve@redhat.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] Revert "venus: firmware: Correct non-pix start and end addresses"
Date:   Tue,  7 Feb 2023 11:22:54 +0100
Message-Id: <20230207102254.1446461-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a837e5161cfffbb3242cc0eb574f8bf65fd32640, which broke
probing of the venus driver, at least on the SC7180 SoC HP X2 Chromebook:

  [   11.455782] qcom-venus aa00000.video-codec: Adding to iommu group 11
  [   11.506980] qcom-venus aa00000.video-codec: non legacy binding
  [   12.143432] qcom-venus aa00000.video-codec: failed to reset venus core
  [   12.156440] qcom-venus: probe of aa00000.video-codec failed with error -110

Matthias Kaehlcke also reported that the same change caused a regression in
SC7180 and sc7280, that prevents AOSS from entering sleep mode during system
suspend. So let's revert this commit for now to fix both issues.

Fixes: a837e5161cff ("venus: firmware: Correct non-pix start and end addresses")
Reported-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/media/platform/qcom/venus/firmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 142d4c74017c..d59ecf776715 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -38,8 +38,8 @@ static void venus_reset_cpu(struct venus_core *core)
 	writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
 	writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
 	writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
-	writel(0, wrapper_base + WRAPPER_NONPIX_START_ADDR);
-	writel(0, wrapper_base + WRAPPER_NONPIX_END_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
 
 	if (IS_V6(core)) {
 		/* Bring XTSS out of reset */
-- 
2.39.1

