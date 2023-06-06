Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C172387B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjFFHMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbjFFHMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:12:01 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C099FE5A;
        Tue,  6 Jun 2023 00:12:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-650c89c7e4fso5878604b3a.0;
        Tue, 06 Jun 2023 00:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686035520; x=1688627520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xi9E9SO98JEhVRc3ceJK1WNia9dtNCms5uByHfdXEZY=;
        b=fxn3f2KfczVPjr0NrdvAlW8AevRF2ix0N8SObLJcPKN+bV9SX0L5hl6zP20gEXVTHG
         ev9c/XHKlLid+3wYR6UgcXSRJpGOFpTHcKhHjhAh275uaAwSEEORdFynDSixBcvBKpiW
         5I9EmrY5nySLEMY/P5jcFtYxYk0eUb2mk7k+bNFQ3Qt6ZYgdJRIfWJMSbW7eI4oWbcDS
         q+i1Gfz9m2V9o9dg8sWi7dG89G+FCHB2hDfv9XgaHocalh5tDt3o50m8ibcCRCz32pzB
         2TtFHMNnTowdI60YTLjqkDXEbt+6ZW03iqFE8KACDrd/jtaHbwGT59FaPGnDhvg5P3Z+
         vK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686035520; x=1688627520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xi9E9SO98JEhVRc3ceJK1WNia9dtNCms5uByHfdXEZY=;
        b=hzA3rAuyAbxhGkW3Y8l+7FfnJ1ArpdP/BUgBoC+a3NRlHW8rZCFDsgJDXzYFoJViIc
         RiwZA5VBLnm8ry7HbUW5aCX4U3BzzbYFGnSZCGylwkTDJt/QCJjiqf+KeaDj7yOmmEkY
         Kd7y4Rid3nGYLjShzb5zBod5fXiqlc48/nM9ewqkzx90TLkDkkXaZ/Be2/h6QVugh3I3
         6sm8EBS49pYYvtWFyszqe4SeWEU6Rc1lhQGvvQy/7RwtLRAOD5wooVTf+N1RJgNPIMT0
         40+/GY2VoWYvMpZGRKA702Xuef9vjouIEIhLfX64NdOvmT2DY5QYnUHV44TQ9QvBGHMC
         2dSQ==
X-Gm-Message-State: AC+VfDygg+mOrDA5m+BLNJb8+3x0L6xmbu6FwX3W6jSZwqHDadgxoK+k
        of58UynT0hyX53IcXerZFE4Y1j5vQbkogMkx
X-Google-Smtp-Source: ACHHUZ5dT3hltXDwjBHbeemOfUtq99YVhaJYoHKeKv3HYv/ccyprH9+OQAAg1yBC/jgDEsb/NO8/hA==
X-Received: by 2002:a05:6a00:1ad1:b0:652:fbee:84df with SMTP id f17-20020a056a001ad100b00652fbee84dfmr1486168pfv.0.1686035519962;
        Tue, 06 Jun 2023 00:11:59 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id f25-20020aa782d9000000b0064d74808738sm6127247pfn.214.2023.06.06.00.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:11:59 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] crypto: hisilicon - Add HiSilicon ADVCA Subsystem
Date:   Tue,  6 Jun 2023 15:11:10 +0800
Message-Id: <20230606071128.375567-1-mmyangfl@gmail.com>
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

v2: sorry, I accidentally skipped v1.
v3:
  * use devm_reset_control_get_optional_exclusive
  * disable clocks if init failed
  * put device reset when removal
  * implement import function for sha device
  * fix typo reported by test bot
v4: fix sparse warnings

David Yang (2):
  crypto: hisilicon - Add HiSilicon ADVCA Subsystem
  crypto: hisilicon/advca - Add SHA support

 drivers/crypto/hisilicon/Kconfig              |   11 +
 drivers/crypto/hisilicon/Makefile             |    1 +
 drivers/crypto/hisilicon/advca/Makefile       |    2 +
 .../crypto/hisilicon/advca/hisi-advca-muc.c   | 1530 +++++++++++++++++
 .../crypto/hisilicon/advca/hisi-advca-sha.c   |  659 +++++++
 5 files changed, 2203 insertions(+)
 create mode 100644 drivers/crypto/hisilicon/advca/Makefile
 create mode 100644 drivers/crypto/hisilicon/advca/hisi-advca-muc.c
 create mode 100644 drivers/crypto/hisilicon/advca/hisi-advca-sha.c


base-commit: f8dba31b0a826e691949cd4fdfa5c30defaac8c5
-- 
2.39.2

