Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA85C70151F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjEMHn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 03:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjEMHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 03:43:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49D273D;
        Sat, 13 May 2023 00:43:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64359d9c531so8109933b3a.3;
        Sat, 13 May 2023 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683963835; x=1686555835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcUJ2CE5Wu113tG/GDgAYSmXKbkEEJm0H8VDNYsDl+s=;
        b=O1xV9PonVSBFFzyRLM6xv010yjVa4NgU8Eu18/b8WChpjN9f8ZkGmAECwxqv7jq9D6
         el8VNYhNd8owXUxhyd/HKyEWPPrnRH/t087fxXQedwr/Ufk68kyP2cJcuqIsD2doQN5i
         7AdIp3GJRqyRcuSbUuVzKK6suVvmuYqeWmlL7Hnzuo0lBRubQVmxOQNjDwDHIM1ctMgF
         zHDv/ggSr7ILGTIQ1C5Fjx0d2dmJkowSFrcs+Gwm8STqzmL3xcnTZEmNLASpI956Czv8
         SmiuPXV6orVfIt+gyH2qyF3F2qW30vLeMIJcZw45QB9pxWzYSmJAUE1IfQjWSG9n/7fc
         khAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683963835; x=1686555835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcUJ2CE5Wu113tG/GDgAYSmXKbkEEJm0H8VDNYsDl+s=;
        b=JbYX6yrSTk2ReaajTQ4+oaosvieaU402DTaDrVXgzKRDC6Q+ohKXL98QXMd8Hk78eY
         E7Mvx4pzWlA90JY6jJBN6JkBpXsSpWEKugB1a8FMNeJMnigKiyMAceiToqEC/f5RiRcO
         +0am56WU03STf/HZ8n1+T/xlxYssvMTqfqUI47mEoNE5VMr1mgzmhvZ3FbWsJKi1Jv3i
         YPJQeE2kQ7Qd/iqIpYYxE2jynYd10pBMCDpL3AbRTBOG2LRXc0ontl03vESNh1UCFNdd
         b6uRfxaDyXxJt757wQ8qoQlvGpnZXwxBXSlqNg4KRm9xtTmhQQS4bR9+yDXXxSB7vG/f
         FemQ==
X-Gm-Message-State: AC+VfDxRLP+M+tdjmOCLOkv6JXS1lxBS/6v2nZbPO0W/0AC9rVSzl1QB
        DFYJfQ8TaQ0GvjI+tjMz7vYp9pfM8w0FQtpVNlU=
X-Google-Smtp-Source: ACHHUZ4e0OyfA8rnWZsAtKADV29YrjaRGWVqwm3g+ybr6oKj7NAR3YvzpM7ovceXoGtVYG3flLa83Q==
X-Received: by 2002:a05:6a00:2396:b0:646:6c71:ee13 with SMTP id f22-20020a056a00239600b006466c71ee13mr24964740pfc.24.1683963835065;
        Sat, 13 May 2023 00:43:55 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id u19-20020aa78393000000b006242f4a8945sm8128895pfm.182.2023.05.13.00.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 00:43:54 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] crypto: hisilicon - Add HiSilicon ADVCA Subsystem
Date:   Sat, 13 May 2023 15:43:20 +0800
Message-Id: <20230513074339.266879-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
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

HiSilicon ADVCA Subsystem contains various cryptographic devices, including
symmetric key ciphers, hash functions, RSA algorithms, as well as key
ladder and OTP memory.

This series adds symmetric key cipher and SHA algorithm family driver.

This series is based on Hi3798Mv100.

David Yang (2):
  crypto: hisilicon - Add HiSilicon ADVCA Subsystem
  crypto: hisilicon/advca - Add SHA support

 drivers/crypto/hisilicon/Kconfig              |   11 +
 drivers/crypto/hisilicon/Makefile             |    1 +
 drivers/crypto/hisilicon/advca/Makefile       |    2 +
 .../crypto/hisilicon/advca/hisi-advca-muc.c   | 1527 +++++++++++++++++
 .../crypto/hisilicon/advca/hisi-advca-sha.c   |  644 +++++++
 5 files changed, 2185 insertions(+)
 create mode 100644 drivers/crypto/hisilicon/advca/Makefile
 create mode 100644 drivers/crypto/hisilicon/advca/hisi-advca-muc.c
 create mode 100644 drivers/crypto/hisilicon/advca/hisi-advca-sha.c


base-commit: 9a48d604672220545d209e9996c2a1edbb5637f6
-- 
2.39.2

