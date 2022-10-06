Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2227E5F6E67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiJFTsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiJFTs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:48:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A331144FD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:48:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b2so6920897eja.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SubjIuBws5LPaK2F6fl7djEE32KNShOpGo87GmZ3kbY=;
        b=FHa/vDtdebdXMgW7KVsFf9ZcK5KpzB4y2fu+78ZJO/jInIegCXwPsLxu3ycGwwfrFx
         cvrB5c4DYtfygHY9cu8xOJGrI+J9hEGm0smqMLT3nhOnAtldgM7whWdYBfF43NBvsDKY
         OpaKP9PTtdqFTyIT4gkP1KTx/cVrOkNyEoS/Y40beWiJvipJFh0gwZgJVo1docdObzNe
         EMlR9KdacoLqDzGcUOYmo/Sf2CLKcIOADj3YBQFVzkxY/Xk6cagRy+NzBImEBKlN0VOk
         WtwhKkeDM5TYdKVvbzSvFXgFwti7sKUVJD/OZGHTq7hGO7vZHYplzoPDQCQGsGBhmTt/
         DiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SubjIuBws5LPaK2F6fl7djEE32KNShOpGo87GmZ3kbY=;
        b=emu7M3WelIg7ELbDXwFJN3ebIv/X3J+NjGe+6eKnf7KIYFXAyehEhjYGrisFlpm36O
         NOW6z3dCcplFxa3CKYUaDNIXz7p1MoIl9oFq4oECsdLcS6XWSQ5if9W6ymlmCXrjonNO
         H4qm6pretmBvA3nkPPsET1CZ/NSbGfeKKW0hdtLhZxKP5kJw8g5WeN9CBA1ipLNTJTJO
         dlzhvtSq/JL/4BtjXPLkclE5ylsogh0tpELB29dMG8NBEK05x0ez+qkVHn6/GGNKhiAS
         tE4U7axQ8IW8uwaTPKutsMdJQfyOlE6AbPfW8N5SWLyYgLpZ0hB25eLtEaGGS7nuRQxI
         +MCw==
X-Gm-Message-State: ACrzQf2ZXhPePl1dTnAHls0NHM9MbWi/petKEMlEBwUJcUR1y77qM4r9
        32zU+REZIcI4p8ftr/wQEkNUgw==
X-Google-Smtp-Source: AMsMyM7lGUO5s/XfctQB/DIPjA1h+5Xa7NpwAFS4jTATaxNFrWml5ah0CQthp5237VTD/JeaAGN5EQ==
X-Received: by 2002:a17:907:d90:b0:78d:48b1:496d with SMTP id go16-20020a1709070d9000b0078d48b1496dmr1207704ejc.665.1665085706326;
        Thu, 06 Oct 2022 12:48:26 -0700 (PDT)
Received: from fedora.. (dh207-96-33.xnet.hr. [88.207.96.33])
        by smtp.googlemail.com with ESMTPSA id l26-20020a170906415a00b0078116c361d9sm174229ejk.10.2022.10.06.12.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:48:25 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>, luka.perkov@sartura.hr
Subject: [PATCH] spi: qup: support using GPIO as chip select line
Date:   Thu,  6 Oct 2022 21:48:19 +0200
Message-Id: <20221006194819.1536932-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the device with QUP SPI adapter are actually using GPIO-s for
chip select.

However, this stopped working after ("spi: Retire legacy GPIO handling")
as it introduced a check on ->use_gpio_descriptors flag and since spi-qup
driver does not set the flag it meant that all of boards using GPIO-s and
with QUP adapter SPI devices stopped working.

So, to enable using GPIO-s again set ->use_gpio_descriptors to true and
populate ->max_native_cs.

Fixes: f48dc6b96649 ("spi: Retire legacy GPIO handling")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: luka.perkov@sartura.hr
---
 drivers/spi/spi-qup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 00d6084306b4..81c2e00532cf 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1057,6 +1057,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 	else
 		master->num_chipselect = num_cs;
 
+	master->use_gpio_descriptors = true;
+	master->max_native_cs = SPI_NUM_CHIPSELECTS;
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-- 
2.37.3

