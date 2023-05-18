Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB4707EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjERLLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjERLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:11:23 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3641726
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:10:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52cb78647ecso1255505a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1684408213; x=1687000213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNgCxoNy0iWdhtCrH6AIWqX1e2dT+qQZZIRyWuGq614=;
        b=nlkVQPFJ0/a1VNcboRGvbiUZyw0b9uP7ZyiABT3y50/k/8P1vp54f9fo6QWz2CamGQ
         s0dBWgqAYwG51aydodcYFj8yMa49E7K6e0K9HQe6YwCZ5avKxderxQkM/ox4XuqQBOe2
         Wm3VyPfKP6UB6JR13wkB31LzrryjpV9Xt9X/o3OTvHSqz3r2PUEHm7ZjIYarRsqj3kt9
         c3uwE/1ZLaazAP4RGTbTFeCI5zoa1NUstRk13N5MulschTSaF470CQxKSNXxmILN7uNz
         ZYBigZPZRl/gPZdTi6p1S9MZh+KU1mc9+313OqNcDGaT6aFvIyShTa1onge4WBnMxNKf
         p6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684408213; x=1687000213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNgCxoNy0iWdhtCrH6AIWqX1e2dT+qQZZIRyWuGq614=;
        b=Jfm3bJItybyYABQIJa3PyRM8Uqm94x3YTW5TNsKDCQ378pednPxz6ersqbsOF+p1/O
         4Omf/0KVKStncoI+MgYpbSyBj4OP91ulki1Mr2VGHF6bpwI81ujCL6RG5kvLLKxYWJ8c
         XH644ToxqPsL3bqgDJu3gFqP7CEO5ajlUKWrezjHE3ywT7bRkHlCqCFp6TIo7/srZly4
         kvoe7XDKBrdaSazPHlREnc6vAXX9jqeIn9zNsc6zSQSo+QLgp+1jJl8xoWP7t6a2D8eA
         HMOteNuYkU8cU69v4bV0sI0TBYTS38C/okyuXv5R9gwp8lTw4fO08oQjoazsiY3yDO88
         Jefg==
X-Gm-Message-State: AC+VfDw6a7vbjVTGx1+GEHT9JbGee6idLPUhitJohYSB4IRqK1/wW3xB
        VurmlbnSLVdBRU7C8iTp6zRAFA==
X-Google-Smtp-Source: ACHHUZ5p3m9IXT/VrcKW03FAmlq5KkxcpRQ3qCZXLILR73T8w/ktksRDlLev7aXTuk7g9tUm0tdgHA==
X-Received: by 2002:a17:902:ff0a:b0:1ac:921c:87fc with SMTP id f10-20020a170902ff0a00b001ac921c87fcmr1869076plj.32.1684408213450;
        Thu, 18 May 2023 04:10:13 -0700 (PDT)
Received: from localhost ([2400:4152:be0:9900:8044:5deb:d73d:fbff])
        by smtp.gmail.com with UTF8SMTPSA id h7-20020a170902b94700b001acae9734c0sm1114921pls.266.2023.05.18.04.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 04:10:12 -0700 (PDT)
From:   Masahiro Honda <honda@mechatrax.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Honda <honda@mechatrax.com>
Subject: [PATCH v5] iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
Date:   Thu, 18 May 2023 20:08:16 +0900
Message-Id: <20230518110816.248-1-honda@mechatrax.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sigma-Delta ADCs supported by this driver can use SDO as an interrupt
line to indicate the completion of a conversion. However, some devices
cannot properly detect the completion of a conversion by an interrupt.
This is for the reason mentioned in the following commit.

commit e9849777d0e2 ("genirq: Add flag to force mask in
                      disable_irq[_nosync]()")

A read operation is performed by an extra interrupt before the completion
of a conversion. At this time, the value read from the ADC data register
is the same as the previous conversion result. This patch fixes the issue
by setting IRQ_DISABLE_UNLAZY flag.

Fixes: 0c6ef985a1f ("iio: adc: ad7791: fix IRQ flags")
Fixes: 1a913270e57 ("iio: adc: ad7793: Fix IRQ flag")
Fixes: e081102f307 ("iio: adc: ad7780: Fix IRQ flag")
Fixes: 89a86da5cb8 ("iio: adc: ad7192: Add IRQ flag")
Fixes: 79ef91493f5 ("iio: adc: ad7124: Set IRQ type to falling")
Signed-off-by: Masahiro Honda <honda@mechatrax.com>
---
v5:
 - Fix the patch title.
 - Add fixes tags.
 - Add information about behavior to the commit message.
v4: https://lore.kernel.org/linux-iio/20230502102930.773-1-honda@mechatrax.com/
 - Remove the callback.
v3: https://lore.kernel.org/linux-iio/20230420102316.757-1-honda@mechatrax.com/
 - Remove the Kconfig option.
v2: https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatrax.com/
 - Rework commit message.
 - Add a new entry in the Kconfig.
 - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the IRQ.
v1: https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.com/

 drivers/iio/adc/ad_sigma_delta.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d8570f62078..7e219287074 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
+
+	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
+	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+
 	ret = devm_request_irq(dev, sigma_delta->spi->irq,
 			       ad_sd_data_rdy_trig_poll,
 			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
-- 
2.34.1

