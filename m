Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD8672B22A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjFKOEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjFKODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:03:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265A2E7A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso35574345e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492229; x=1689084229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5re7Wx5T8B7oy9Wn1ES2X1LY+O2Vj3neWx0oIPUli+M=;
        b=RIMOHUl6E8QAr+gyQQBb4OHPFN0LzLK1TLumfo9ECzCeDu5+Yf2cigdpJz8jF8NouM
         cuqOEeRrl96c+OFiyah2dPuJdfXgM1q3H/zVpQLrI5TK5qTx68DP0MmBKd5mPGSgIL6f
         vAbuqpxH3i6LDGmBxdqcq0Yc4HQDjGhhfyv3RA2BGca020hUu4/I4jSOq07TzfJW7jzs
         K8gBQ+m0YQN93woM0TI0HsLGoocLo6a7PSfznTtyg0wxREsl/QwyTHO7Jx/K6Ru3m37d
         TobLwhB0Z3AxCamcH2abmYjTPvqWuf2R1DCxlpdLG3TMypAB/yjygwCLYj3mnWpaSMjM
         PchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492229; x=1689084229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5re7Wx5T8B7oy9Wn1ES2X1LY+O2Vj3neWx0oIPUli+M=;
        b=jwEppP7+4/09RtpG/9yaVb6B6DXTmlUfkZDsGbTNnd8OCVSu4sjLXnQeC4ZwW/7v1T
         n2j0+Vgry1Ef0EJxOoRRrMu2pGJw5zhvukAsxFJd7bIjkPkLqw+3yaF1ki6N++QR2o9C
         pc0hYH3Ja1uxc40UtgRzBg8sUox6nCe8NRHXRh/P5IntYrZo6s0f+2iBeMGl2tjDRkUa
         mJfLmg55lKmTSDrzRpa6lC5kZnDbGYhn9KAu01j3cqEXY3MU33j/E6zs0zpB0nSUCF3H
         0e17rgKe5J9qAdX67UW/u8YaLu4t86HF6eb950O9va6rX/9Sqt0ePi96IltSjfPA0emv
         2txg==
X-Gm-Message-State: AC+VfDyazy+zZgzeJc9c4Zz3jSsoGXDY3K7cBvX5WZy2n5Z/1JWVTdj0
        IY6/smZFbwAZxxBmHLQJxk239w==
X-Google-Smtp-Source: ACHHUZ7FsJYqLsHn6251U+vpmnP2kaIaT7ztm1W46o0/3Gron0epI0qaWqnVk62em0pwmCoHXrLmVQ==
X-Received: by 2002:a1c:7c08:0:b0:3f7:e80b:bfc with SMTP id x8-20020a1c7c08000000b003f7e80b0bfcmr6033002wmc.30.1686492229638;
        Sun, 11 Jun 2023 07:03:49 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/26] nvmem: rmem: Use NVMEM_DEVID_AUTO
Date:   Sun, 11 Jun 2023 15:03:09 +0100
Message-Id: <20230611140330.154222-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.com>

It is reasonable to declare multiple nvmem blocks. Unless a unique 'id'
is passed in for each block there may be name clashes.

Avoid this by using the magic token NVMEM_DEVID_AUTO.

Fixes: 5a3fa75a4d9cb ("nvmem: Add driver to expose reserved memory as nvmem")

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 80cb187f1481..752d0bf4445e 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -71,6 +71,7 @@ static int rmem_probe(struct platform_device *pdev)
 	config.dev = dev;
 	config.priv = priv;
 	config.name = "rmem";
+	config.id = NVMEM_DEVID_AUTO;
 	config.size = mem->size;
 	config.reg_read = rmem_read;
 
-- 
2.25.1

