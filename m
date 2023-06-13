Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80CC72DF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241699AbjFMKXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbjFMKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:22:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B821732;
        Tue, 13 Jun 2023 03:22:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-970056276acso809743166b.2;
        Tue, 13 Jun 2023 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686651775; x=1689243775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7eS0y2fZVSHt4SziOxLfohEhzcd/dxb9fbYHjyvH3c=;
        b=THEAlSXWVZdUovhdcgcOf2oWLhgC8GetER0j3qTEsOAB2suChgrYVEIFyMpZbu1fc0
         bKZEc9ZdJzZPYUuD1N6gFaLG1pZ9YoAGcNqRzeIIRvRHg4x0tcN+pRMqV7h6IpNgys3n
         /iFg42r2jijPT/3ndWlET41dqSK45Ji1VKmkKvUHP6uiHb+8fYjw3Fhmdz5qgH2cHtus
         5YezdNlnGOrNOxaURguiFubtD93hEu7I5Wwm2n9x9CAB8q7KC2XXPeB4sfsrvcpW8a2K
         KpRYJisXRQuilI1EEGx4cSEAOvEoAkezlqY/Y41jdCIIi/T4hug7kIK9JyQ1noA/n0Lk
         c+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651775; x=1689243775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7eS0y2fZVSHt4SziOxLfohEhzcd/dxb9fbYHjyvH3c=;
        b=CRfWOfIa/L720zpFLl2zlWZelvwbH/OIS0L+HYR0JeIfZsE3r2EL2+RMpYd47g6XE+
         JVyHJC/96rj4OJ8QIW26LNbrf+GTxVceN3aGa7FuhvxHPC/h1ON3Vr7Bn9DvNXPN871D
         YeDPSI4LXMyK6uO8eglGXdCSR+aWEgIi0kCoHQ1ULNfpdLzrUENUtfJipj++bS1cgS/I
         uVGaLGiX2LEt/SHkRMzdX8uQAztdzLmuOu1GjBrbcXjohN32X5A3+2GTUO1PKNcD20TU
         WtiyDE1djsln9i2BiyNRw73dFbShlKCpb0IfsMloyV0f+7kOIaYbZW7wa1/I1BITfYto
         1Xuw==
X-Gm-Message-State: AC+VfDwK9Aka9qRWT3zh2FS+OVzfmcDVr49fR7ngX1zyHBoRfq8bknO9
        VMmMpPtNuRMc3QFCc6TfLug=
X-Google-Smtp-Source: ACHHUZ6Koi3vwCwNxc37bJI9/ZzcERLeaFbxxlR8zfR4jWCsgkHZazOJBXf8fzDRdfs+HL4CDAuMTg==
X-Received: by 2002:a17:907:5c6:b0:973:cc48:f19d with SMTP id wg6-20020a17090705c600b00973cc48f19dmr11366573ejb.52.1686651775372;
        Tue, 13 Jun 2023 03:22:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::298a])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906038700b009787b18c253sm6492493eja.181.2023.06.13.03.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:22:55 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v6 3/7] iio: accel: kionix-kx022a: Warn on failed matches and assume compatibility
Date:   Tue, 13 Jun 2023 12:22:36 +0200
Message-Id: <2c69e918cb6dfab663bb62952c554b6b72f58390.1686651032.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686651032.git.mehdi.djait.k@gmail.com>
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
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

Avoid error returns on a failure to match and instead just warn with
assumption that we have a correct dt-binding telling us that
some new device with a different ID is backwards compatible.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v6:
v5:
v4:
- no changes

v3:
- changed from 'unsupported' to 'unknown'
- removed the opening bracket

v2:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index ff8aa7b9568e..494e81ba1da9 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1036,10 +1036,8 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
-	if (chip_id != KX022A_ID) {
-		dev_err(dev, "unsupported device 0x%x\n", chip_id);
-		return -EINVAL;
-	}
+	if (chip_id != KX022A_ID)
+		dev_warn(dev, "unknown device 0x%x\n", chip_id);
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-- 
2.30.2

