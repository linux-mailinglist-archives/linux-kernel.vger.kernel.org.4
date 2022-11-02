Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFB161662C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKBP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiKBP3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:29:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A871DE87;
        Wed,  2 Nov 2022 08:29:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y16so25052497wrt.12;
        Wed, 02 Nov 2022 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlDgVPwk9zxW4DatfSwtuEmtcIxF50e1Qm1Ff6dMXCM=;
        b=Sil0QvMZ6r3C3cjkjxE0gkeyq5icakmlBmFx8brOG50r0nMfUN3s5FPmvaGCelkzQw
         2NRVodtrXKFxQgv5Hp7HVdJgp2YcECeMOae4GyL/NA14Yx+9rdTWGmXsey9Z0662voqq
         fCAm8Na1h9SKzXiW1A6sMHfxuGgsIlxXDexBQehHpBr9vaWbQDo0QsqaVLD0r9eNPTfp
         gePt7iPMEq0PKgCAoyIXE4mmJ1pCN36kzpKI1aPsirzZ+VVbNspInWhO+Oecjue4Rt8L
         BEGd+MSSOurdUScXgft5hmucTihSn/38hF0Tq+YeRynKi8Kur14T9NiQZH80B8u3km4J
         GubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlDgVPwk9zxW4DatfSwtuEmtcIxF50e1Qm1Ff6dMXCM=;
        b=hrX8G99NkGtywVR9VkE56yqU+492LPXIXM8OUSnzBmkM5ny5/q+kti1oJnR/aDL3xc
         TmHpmxWN3g2MkHrt0Rh+uY0uwZlYgDkWpYHMbm7mZuBtNP0oNAPhTGVfT6FW6Nis8hxk
         Yq9tGR6froUQ/qs+AC0IuE39iHV2tumKN++WKbiZy/K5Ihg+bz++VRiGGd79dPqT1z4H
         gCZwwo8XUoAqQRaBtk1BMWWJYOzP48h73Evqjn5rmbGCrx+GyNP3P35oKK4mWwgVhyBp
         5t+B8EwnHUgq2/rRF58u+n9066QnJ2Z6kwueh3LjBnpGv47YnnmQmYyT6cBocnm3Ey9/
         kC3Q==
X-Gm-Message-State: ACrzQf3/k+0o6rFFyStsuTp34BQrmJ47HruyDT5ysROCpsjxQCtUa3l9
        eDDkblt7nruyPH0iaFbRgpQ=
X-Google-Smtp-Source: AMsMyM6Ni8f8wqql/3JbnazGeYIRFQ5AjQZUyijcgg0wjBGuVv6IRKmE6UMYKT5n3af1g1mLPiYf2g==
X-Received: by 2002:a5d:4f8d:0:b0:236:714b:29f0 with SMTP id d13-20020a5d4f8d000000b00236714b29f0mr14936530wru.145.1667402945591;
        Wed, 02 Nov 2022 08:29:05 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n188-20020a1c27c5000000b003b49ab8ff53sm2475078wmn.8.2022.11.02.08.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:29:05 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: nxp-fspi: make const array ls1028a_soc_attr static
Date:   Wed,  2 Nov 2022 15:29:04 +0000
Message-Id: <20221102152904.143423-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the const array ls1028a_soc_attr on the stack, instead
make it static. Also makes the object code smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index d6a65a989ef8..1c1991a26c15 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -924,7 +924,7 @@ static int nxp_fspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 
 static void erratum_err050568(struct nxp_fspi *f)
 {
-	const struct soc_device_attribute ls1028a_soc_attr[] = {
+	static const struct soc_device_attribute ls1028a_soc_attr[] = {
 		{ .family = "QorIQ LS1028A" },
 		{ /* sentinel */ }
 	};
-- 
2.37.3

