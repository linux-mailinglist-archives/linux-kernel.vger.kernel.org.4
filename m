Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E7711062
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbjEYQGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjEYQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:06:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE47139;
        Thu, 25 May 2023 09:06:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae74ab3089so11701995ad.0;
        Thu, 25 May 2023 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030810; x=1687622810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7DQGUGKavcUHdAu4oKuYB0d5xaJQooXg9CF7yRpzSQ=;
        b=hM4TiVdYNoQfV2UmZNubJTd7hzS4Wfrry0F33AnppBdUiMm/ms1oHWHrCdVObIlno3
         vvAuyL97m0qiEVZ90DMmPVCAg/iquZ/aeMz7/sPaMMzAylDARsvpxaJsHriTU+hMAZKr
         G7w7sZWKJh/8DzlSWTvrjTue8G+Ns68XYvmBgIhGSsnkY6XxmbZJJjYUQD7b/oTqb3+P
         rxozuMWPeD8MC08f9Dq0rOWHPk/DoA5iZw8wsHPsK7trcILegRFuT87pkiyeQAwISgfv
         +z7a2TKhjAZ5amfigG4I2EiO5k1xZZNWzBfOiuyhVxTspUcVqvzK6NagJ2XLDW66XQkq
         0QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030810; x=1687622810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7DQGUGKavcUHdAu4oKuYB0d5xaJQooXg9CF7yRpzSQ=;
        b=iBgo3PFMLCenQn31xoxDrLwLWEQoMGEWNofu56UgJhhJDLu1S77erDhOkVE7496p2V
         0eTMncQNYcXxxTDKe9TjdG/t0d8XJFuOp+XkSqakusLdebWP9h1uMmRxDH2iVHCrkdLV
         jmB7M77VhZsoaB45Bk4Q9LQ+nKKDf4AaLGPbQXhty2IH521fTHsKPC02hAbvyKkFXbFX
         ZIyKi9nrGNY883Jacg4XY9bygsyzx9FU80XiSeIKpzEFjcOa0CtpeVLT2AS8BtvA5Fms
         jWCNo44v4puxSLlsybC8H5xxtd6snHABX+1zKcrQmvYQIxpTW9jJN/WMUSr9MC323NFO
         ONFg==
X-Gm-Message-State: AC+VfDzVa5gfNgAVpRff1AqFoZ5Lfss3qPXhsIkBM7PaqXE31Av6Qb9R
        3iQ9MiKC7TUtkWVauHAn6k1UZ8PgpJ4UMEj55EM=
X-Google-Smtp-Source: ACHHUZ4NuM4m4pZj6+zg4hB6ziG8zaUZ1JkMGm7eRDfBBu/mCuOq5axvTqfXbmvHLtQZeUvY9SnBWA==
X-Received: by 2002:a17:902:e751:b0:1ac:7f56:de04 with SMTP id p17-20020a170902e75100b001ac7f56de04mr2229139plf.45.1685030809733;
        Thu, 25 May 2023 09:06:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.202])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902b11800b001aad4be4503sm1627132plr.2.2023.05.25.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:06:49 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] crypto: hisilicon - Add HiSilicon ADVCA Subsystem
Date:   Fri, 26 May 2023 00:04:29 +0800
Message-Id: <20230525160446.43800-1-mmyangfl@gmail.com>
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

David Yang (2):
  crypto: hisilicon - Add HiSilicon ADVCA Subsystem
  crypto: hisilicon/advca - Add SHA support

 drivers/crypto/hisilicon/Kconfig              |   11 +
 drivers/crypto/hisilicon/Makefile             |    1 +
 drivers/crypto/hisilicon/advca/Makefile       |    2 +
 .../crypto/hisilicon/advca/hisi-advca-muc.c   | 1536 +++++++++++++++++
 .../crypto/hisilicon/advca/hisi-advca-sha.c   |  658 +++++++
 5 files changed, 2208 insertions(+)
 create mode 100644 drivers/crypto/hisilicon/advca/Makefile
 create mode 100644 drivers/crypto/hisilicon/advca/hisi-advca-muc.c
 create mode 100644 drivers/crypto/hisilicon/advca/hisi-advca-sha.c


base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
-- 
2.39.2

