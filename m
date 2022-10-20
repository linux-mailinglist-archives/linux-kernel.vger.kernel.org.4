Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97694606413
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJTPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJTPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:16:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45801136409
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f11so35064786wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=lTDMDCDikO894I2FgciNbIL2IAOM8w7a+kTIfkIAPMwv51/V0acIRNTjlCEZ36RRDf
         PrsjV5wL1wTdai5/OpGT0qbDSu7AVPrwsfBps+tv4PY6lziaO0t9PiDxLdlddWVQFfAX
         yEKWIO62oUZjNtUyDXWXKAbByzuUkDx4XaskF4U0qYozpx4r0glx4Qcu/NraN2nyHfCG
         dby0HW4oZUkeQjS/500DpVkziMRCU2uN9HFWfuwGluZiGsC/Cdd5RtNvecKSqUqYLbow
         t0UBemQ2wgh3cziVOGtmBUNXJDyAI14+NmHv+py383JAfYGMWFNqJxLqrTNuw7N4Odi5
         1Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=X39fQx6pyzD4Xw6EVWqhLRm8KtZUxDR1Qan5TpFfsz1nrYnYmniD/Ma6iC4PAPPBrv
         0AtqJj8RNVza0sVBdTOmLeTgVnJdT/+/rEJu+tB6wosO/ZCiA++EwCgkrD9XjqFSCfXU
         NT+L+7Wij3aNjLS7g6q1HdTbsjfrLcyPF5+1NKn1fKPdE4zG8mqeHlbdzJvE4NCwtf7Z
         P1UEbykMeKSgQf1VPdPgBE3cp++M8nNrzZ9Y84yPRxN2PI5U7smPPVE4KwujAJAdnepQ
         kiJuENo/cV5W1ybDExpk53sshEtDhjORb57vpJaNmsPyZT3qgVis4mic02mSHLZWoEwW
         /5hw==
X-Gm-Message-State: ACrzQf3Tl2RtS17JxQwVEzQZOwV4qGyXqAtGgwu+a0jEdUf0Y7zvwCZB
        NzH+hoaKTmaLOqKw7WsC9ytwDw==
X-Google-Smtp-Source: AMsMyM5BRAOxV+stH3UEOXaLk809vn4lxaZpN1GqorG7LeUTaIxAv4QERtw4FMEAanYlhzJgrnf9LA==
X-Received: by 2002:a5d:4f12:0:b0:22e:3920:a09c with SMTP id c18-20020a5d4f12000000b0022e3920a09cmr8693613wru.95.1666278977636;
        Thu, 20 Oct 2022 08:16:17 -0700 (PDT)
Received: from rainbowdash.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003c6f3e5ba42sm41362wmb.46.2022.10.20.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:16:17 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v6 03/10] pwm: dwc: change &pci->dev to dev in probe
Date:   Thu, 20 Oct 2022 16:16:03 +0100
Message-Id: <20221020151610.59443-4-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020151610.59443-1-ben.dooks@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc_pwm_probe() assignes dev to be &pci->dev but then uses
&pci->dev throughout the function. Change these all to the be
'dev' variable to make lines shorter.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 7568300bb11e..c706ef9a7ba1 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -202,14 +202,13 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = devm_kzalloc(&pci->dev, sizeof(*dwc), GFP_KERNEL);
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
 	if (!dwc)
 		return -ENOMEM;
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
-		dev_err(&pci->dev,
-			"Failed to enable device (%pe)\n", ERR_PTR(ret));
+		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -217,14 +216,13 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
 	if (ret) {
-		dev_err(&pci->dev,
-			"Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
+		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	dwc->base = pcim_iomap_table(pci)[0];
 	if (!dwc->base) {
-		dev_err(&pci->dev, "Base address missing\n");
+		dev_err(dev, "Base address missing\n");
 		return -ENOMEM;
 	}
 
-- 
2.35.1

