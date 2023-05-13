Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8298701693
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbjEMM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjEMM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 08:27:22 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1932D62;
        Sat, 13 May 2023 05:27:21 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-643aad3bc41so10233447b3a.0;
        Sat, 13 May 2023 05:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683980841; x=1686572841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnz6Khl7XgNC5OnSNF8E9zgjZK2OQEXJEFFxrxG8RJM=;
        b=EFfnMpZvwqbFGqH1Cz1hwMi7+JzjU+hedGkJkWFuegnNgh7fdKzpCtOGATyuJOYaEm
         SyiRFPPasVd6qheTRyu3tHQWtFb5/yF/QwTfILq/KzT/qWrIs64RSiE/2oSf/PHX1y1t
         /W6jwW+5Yhl7v7Ukjk9NfcQ0ugfOc63/wNQsjtZqh8+PYblMxJ3WyDFowLF38dHxz7WZ
         vKuUtHmp/t77/1yopMKGCtCu//342Qp8k2JASsxWFgGeW1mXGdUdVfrfn9dM7leVzwNl
         o1iB/nWC43ToRePOifM/pJaP6MJZx670RADTIvDaUtxlHwJdqLFiBQS5t6HhUY06zI59
         Nuiw==
X-Gm-Message-State: AC+VfDzS0cLAP3b+LW17WQuvlGRMyiC5Ay6Cz7v7v02sjbmd2trdTum2
        hS2KJq5QZXQPRj23yghVnreRjMfe55Whvu7B
X-Google-Smtp-Source: ACHHUZ5nCz5VXXON1tGJRriKDy5oC05xvZoPW2YUTwRBowC4tXDXqvFcchJAICWbyB6sMbusB4V+bQ==
X-Received: by 2002:a05:6a20:160e:b0:101:b3f6:d67e with SMTP id l14-20020a056a20160e00b00101b3f6d67emr19853546pzj.27.1683980840610;
        Sat, 13 May 2023 05:27:20 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a2dc200b0024e11f7a002sm21951196pjm.15.2023.05.13.05.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 05:27:20 -0700 (PDT)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi:pic32: Fix missing error code 'ret' in the failure path
Date:   Sat, 13 May 2023 05:26:53 -0700
Message-Id: <20230513122653.45226-1-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch warning -
drivers/spi/spi-pic32.c:634 pic32_spi_dma_prep() warn: missing error code 'ret'

Currently in case of pic32_spi_dma_config() failure, SUCCESS is returned.
Capture and return the error code in the failure path.

This is based on static analysis only. Compilation tested.

Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
---
 drivers/spi/spi-pic32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f2af5e653f3d..2b1b1eea9c64 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -630,7 +630,8 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 		goto out_err;
 	}
 
-	if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
+	ret = pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE);
+	if (ret)
 		goto out_err;
 
 	/* DMA chnls allocated and prepared */
-- 
2.34.1

