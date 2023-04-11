Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFC6DDD52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDKOKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDKOJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B91D1FEA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681222142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FoWYY1/c70BQuziZUZwE68OnqBVL6gacC0azpYIo4ao=;
        b=aSs6nkt44L1Az5IZbS9attn0yF5/qh9VTL+OlwHMrFN4mg/gEOAJC2ZMHpT/TOgyCx3Sp1
        T+OPd2YKJNejsM6FCjzsg7XzcBNA1ZeI+nqpo7EErcsFQb13YG0OAqqorVoTWu/K5rs4Ix
        ZEWEa1D06J4e81FhTNaVL1ltAUCrjBc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-TnINk9ZNN3q4kEDmP-ebhQ-1; Tue, 11 Apr 2023 10:08:54 -0400
X-MC-Unique: TnINk9ZNN3q4kEDmP-ebhQ-1
Received: by mail-qt1-f199.google.com with SMTP id o4-20020ac87c44000000b003e38726ec8bso6379475qtv.23
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoWYY1/c70BQuziZUZwE68OnqBVL6gacC0azpYIo4ao=;
        b=RxTdnBRuMlfrSvrfUCUwsWti56S6CHgDj/pTAufGje/FoJwBD7okrHb/LtVGX+Nal5
         ZbQNo7IGsSoEGUVKm68S+aCEnwEkd/C2UPyGzTWgqLBt67U+yCrmeNpJITIJJ2XMWN6M
         9vX2pa7KyJm05RzV6sIgoYHRHTMYszZQC2xWaIkhpOmBagvoM+0o5tIoSXg45zFQ+ANv
         L/JlIX5lZnMxIb2Hga+9J17uuPeBp+k8nyDinymgk5sw/Ipkjb/PCms0ICe5NEr8NGvp
         7zYghe5AWEXeRA7KGBeA6bnO2HDs9H8uQM+HA3eQXVG1VM7b+ipV4an2P7bS26TbGDou
         bZfg==
X-Gm-Message-State: AAQBX9ftDgdOUw0GjSfC8RdPLfu6rrhoC5/a6n/rXcJ3EffVTuE+muii
        YmthxQAlpopv6GIvEoXeIk9ZJzfPhlvXJZNdQ/3DQtDb+C5HZj+KWplWdLSBU290iIv1jgqTqJo
        6Iii71txmgY2pZ6U4ZaPhLVx5bXUYbWvn
X-Received: by 2002:ac8:5907:0:b0:3e3:7e53:9a8f with SMTP id 7-20020ac85907000000b003e37e539a8fmr23833395qty.50.1681222133444;
        Tue, 11 Apr 2023 07:08:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ydzw7KBrtGDwEv60Ql5TM3aG88TVjfKTHmQBAGbNhhzKJpSvnJavXOUu8cMXR2+sUzUX42jg==
X-Received: by 2002:ac8:5907:0:b0:3e3:7e53:9a8f with SMTP id 7-20020ac85907000000b003e37e539a8fmr23833352qty.50.1681222133095;
        Tue, 11 Apr 2023 07:08:53 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h7-20020ac846c7000000b003e3921077d9sm3596208qto.38.2023.04.11.07.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:08:52 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     ogabbay@kernel.org, gregkh@linuxfoundation.org, osharabi@habana.ai,
        talcohen@habana.ai, dhirschfeld@habana.ai, obitton@habana.ai
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] accel/habanalabs: remove variable gaudi_irq_name
Date:   Tue, 11 Apr 2023 10:08:50 -0400
Message-Id: <20230411140850.3129374-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/accel/habanalabs/gaudi/gaudi.c:117:19: error:
  ‘gaudi_irq_name’ defined but not used [-Werror=unused-const-variable=]
  117 | static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
      |                   ^~~~~~~~~~~~~~

This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/accel/habanalabs/gaudi/gaudi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index a29aa8f7b6f3..a1697581c218 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -114,13 +114,6 @@ static u32 gaudi_stream_master[GAUDI_STREAM_MASTER_ARR_SIZE] = {
 	GAUDI_QUEUE_ID_DMA_1_3
 };
 
-static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
-		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
-		"gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq 1_3",
-		"gaudi cq 5_0", "gaudi cq 5_1", "gaudi cq 5_2", "gaudi cq 5_3",
-		"gaudi cpu eq"
-};
-
 static const u8 gaudi_dma_assignment[GAUDI_DMA_MAX] = {
 	[GAUDI_PCI_DMA_1] = GAUDI_ENGINE_ID_DMA_0,
 	[GAUDI_PCI_DMA_2] = GAUDI_ENGINE_ID_DMA_1,
-- 
2.27.0

