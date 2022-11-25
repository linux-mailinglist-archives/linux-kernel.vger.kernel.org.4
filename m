Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37C56388CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiKYLc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiKYLcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC99E71
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669375882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o0whn50hBaBPJSQq4RKgv9QraGn/cvKe5x1wVFmyAmE=;
        b=SlXFNtIfhLSLJJFZTLFel6Zm0fqtSe6GM0iAC3fTCDUxrewQ2pcz433oitshdAEO+5Lx6r
        8NXll8EtvROApyPHY8fokz7SCUU1Uy612coS+fRzHmSLkBuvAwEE69hfjBXurpRhUdwN39
        T39mGYmL6xEhXeEVbI0qlvcEOeh8Ahc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-511-QPKfae2GMsKRlqMm3L8dQA-1; Fri, 25 Nov 2022 06:31:21 -0500
X-MC-Unique: QPKfae2GMsKRlqMm3L8dQA-1
Received: by mail-qk1-f197.google.com with SMTP id bk30-20020a05620a1a1e00b006fb2378c857so5066079qkb.18
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0whn50hBaBPJSQq4RKgv9QraGn/cvKe5x1wVFmyAmE=;
        b=zlwAUbsxH6KbFQGMUC1FXuHrQJhM4sHxHbqUGOhNW3NIiSqIvVx5y2Spab6ib9G3t+
         4er0XtO5QQhmbnl8trg7MnmpUktaVJf+4SdytSQ4e64vxmsLz48Fu1Guvd9Ni7E6Ud50
         7R34kqx0Emfj8bcJ8b7sNPXAwSHbvPnT3CeQb+IRYiyBWJWWbD2Of+4QqTuuAat62URa
         185Zkh6ufDCFcssBuJjo+yoNcR6UVkguGAzTtTHRpg006KNn8nWfC0XixKoIBAevO3Cy
         bSe94bDI7FCGMJTHLnPLj0gJL39qGybLOEVAHJFiKtUWdIXaeKRwWWLQft1vy6H2IJNy
         a2Fg==
X-Gm-Message-State: ANoB5pnNRgL34I68A0DIlVZWp/pQWxCUlVTRzKEvcVHuvbKBhNeyzk94
        49O3EgBoph56DnGdfyCAADadfyly+zAxrUO0m4uBv+DRWoV6BnsvQDKRWxY1R8s/JUb5m/EDflo
        lmqpOL/ZY35XKDTuskJkJmBY=
X-Received: by 2002:ac8:734d:0:b0:3a5:2784:f462 with SMTP id q13-20020ac8734d000000b003a52784f462mr18738799qtp.590.1669375880842;
        Fri, 25 Nov 2022 03:31:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5MrrxAhGW+JX7yXKj/nNSxGBgtw9E8v2y+gdjXK61hr+gPJZuL1eilM+sjR/92x2KZrbXqiw==
X-Received: by 2002:ac8:734d:0:b0:3a5:2784:f462 with SMTP id q13-20020ac8734d000000b003a52784f462mr18738776qtp.590.1669375880599;
        Fri, 25 Nov 2022 03:31:20 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-144.cust.vodafonedsl.it. [2.34.28.144])
        by smtp.gmail.com with ESMTPSA id q1-20020a05620a0d8100b006fc2f74ad12sm2581080qkl.92.2022.11.25.03.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:31:20 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] iio: adc: xilinx-ams: fix devm_krealloc() return value check
Date:   Fri, 25 Nov 2022 12:31:12 +0100
Message-Id: <20221125113112.219290-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang-analyzer reported a warning: "Value stored to 'ret'
is never read".

Fix the return value check if devm_krealloc() fails to resize
ams_channels.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/iio/adc/xilinx-ams.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 5b4bdf3a26bb..a507d2e17079 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1329,7 +1329,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 
 	dev_channels = devm_krealloc(dev, ams_channels, dev_size, GFP_KERNEL);
 	if (!dev_channels)
-		ret = -ENOMEM;
+		return -ENOMEM;
 
 	indio_dev->channels = dev_channels;
 	indio_dev->num_channels = num_channels;
-- 
2.38.1

