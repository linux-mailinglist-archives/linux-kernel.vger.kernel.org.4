Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F2D72C845
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbjFLOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbjFLOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:24:08 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C64A1718;
        Mon, 12 Jun 2023 07:22:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso636699266b.1;
        Mon, 12 Jun 2023 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579750; x=1689171750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISIatYDj5BuGojobobgaM0/TeErPdxwKsDQR4SGZL5A=;
        b=qrfV2BhPPfiORUMEVMXDkxlGJVieviCOQX5269SToy6XUlqQn0kOa3V6bt4L34m7gZ
         DclNTILzZynTPaEf2wrXnLQajdRtgBrmtd5IVYX4pdpzUFFuqK8dVGEx1/wZRT+APyaj
         yYQem6HrPXUWeJVKwmtqvw8ZJH4AdJoZhMNW9uuRZ1lVDJaljN/cHkyazinI6MNv4BLJ
         qYcxXuVbZDD3c7dZEruPsOSXHO1DFvxhL2je4q1rg1utIXOjSPcXXsofR/KsM1Zv5ipA
         SwsCMqnu+2iCjsuMaq23YkYK+9tseYpe9SLq/I6OUANGJ/p3g6pDTVjJUCEyH/R7Sx+G
         DB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579750; x=1689171750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISIatYDj5BuGojobobgaM0/TeErPdxwKsDQR4SGZL5A=;
        b=e4/ee40lpDUmfcn6Syr/9DWZkmBv8ns5TyUJ2rRVrkO3JcUM8cBRnZVf5/vNTVX4Q1
         tekUpilJOffBV6Rkvi7BdjVAaEkiWmXXqLAkm+gI/fp9Ee+8aFPA8ijf10pEc9vAGJXZ
         LrdJFKQkfvEu7CvzkQmPfzOeSvWrTzskcsz3/53sDx3v7b/UVAihznbV4KpncRaSdce8
         qpi2EsHT50OcyTUHEJCbq0o2ZaV291SYqOYqxdkTZwO5nKfe/bkoT+PYaPKK/4KiYpNo
         yxnwz+LVXf+SU8Fza+g/1KUAJJ8MvMxS9QBDFL3khWSk6AxTtxCMN6EXG6psklZKgeOV
         fjJg==
X-Gm-Message-State: AC+VfDypRuHLMJzwZFGKJnePbQBPzlCaAe+exQPCzhOl7h0Foq8LkBcp
        l5AZZiTro9p2xF9odNXuE3Y=
X-Google-Smtp-Source: ACHHUZ4VDtYlFRbeeCTqNCkQYe+grnfQ7lYcYodCOYGeA6wYjoUhKUpSmvOr50NFUZisQEvunCrcvg==
X-Received: by 2002:a17:907:7249:b0:973:dd5b:4072 with SMTP id ds9-20020a170907724900b00973dd5b4072mr8070741ejc.53.1686579750137;
        Mon, 12 Jun 2023 07:22:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b009659fa6eeddsm5262528ejk.196.2023.06.12.07.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:22:29 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v5 2/7] iio: accel: kionix-kx022a: Remove blank lines
Date:   Mon, 12 Jun 2023 16:22:05 +0200
Message-Id: <b1809c807b0638c9a171ac56e99e9773531610be.1686578554.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686578553.git.mehdi.djait.k@gmail.com>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
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

Remove blank lines pointed out by the checkpatch script

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v5:
v4:
- no changes

v3:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f98393d74666..ff8aa7b9568e 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -341,7 +341,6 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
 
 	return ret;
-
 }
 
 static int kx022a_turn_off_lock(struct kx022a_data *data)
@@ -1121,7 +1120,6 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
 
-
 	ret = devm_iio_trigger_register(dev, indio_trig);
 	if (ret)
 		return dev_err_probe(data->dev, ret,
-- 
2.30.2

