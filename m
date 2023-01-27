Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7667E1E6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjA0Kkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjA0Kkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:40:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070A020D0F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so5111163wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYJvr99cP9kiWdGsOjtHmMWazTKg88I7EF9li1KLGiI=;
        b=tIl158BB3zmei3Jz4W1AvsmTYGvs69CokydhRAdle9XNxxt1lybHqwM2rhHcMwHAzr
         T4beNqnoeGgZUiVh7DeQ8YvJH4ayw+MbWuhezjlJ3wZ1xlGgl4NhWap8ENHVvrgmNgta
         DIsLoldgEs1q2GQBXWH97PzGZwa2M+QDx5kNbqpDUQOWvS/M5UXX5qufFdliz1rXPFmq
         0GY6xShhcdCOZ3V2jg67Qnhb5QCxGWbWALxabhROXFVB7k4EuxwPUoGkdZBcnrrpRfzp
         /8I9EcmxF1TNIHSX9bI1agcSGG4HL5/HcpXhBDlTVLAiNG5IlbUX7eHBsyHRE1zy3oIy
         bGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYJvr99cP9kiWdGsOjtHmMWazTKg88I7EF9li1KLGiI=;
        b=0na18RInzOMmcx5b3ttiRC2FLSwEfAcq4a6kUZ5i9ulTg+cQ3dASwQQTMqBMiw0tjy
         FiaLtAxzf9axsMDyj5zDAETyli1lFik9g4+d4K6GUF2C97Cg3PQGf6yMOBLoh+kw+JHY
         /J4mCmqV1fb6FJUgFDGj1f9fuc9hQDnmG5FsMFUH31kkgKowd71yTHTBOvfPoBhE1QE3
         yP/O+Y1bDh/9h2WIQw15pyiCUWZZb58sSgGfS3iluYpzT3BrcH3WR5SeZkNHyzk5s8qY
         8+AHPAm4rc/t4Ew8FpnfHTBXEFzByhu+7ol2PjQp1geLq6hDsxe2+0Nc/bzIfBix20WC
         zO2A==
X-Gm-Message-State: AFqh2kqvFifLZ+7GfWKlANLjkUiRs94aV1cxtyaX/CNjQeFugG6phc/n
        pgVcpipJZQU+TG8RX2kMaOw+Nw==
X-Google-Smtp-Source: AMrXdXtfH2nWnyDUzTJ7bA640o2MR7/AyQtnW41GoxWTfL39EvuVLSVS/kkPIJOY+TcKqa7KIHNl2w==
X-Received: by 2002:a05:600c:1c01:b0:3da:fc07:5e80 with SMTP id j1-20020a05600c1c0100b003dafc075e80mr40939470wms.12.1674816021602;
        Fri, 27 Jan 2023 02:40:21 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm1619787wmc.31.2023.01.27.02.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:40:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/10] nvmem: fixes for 6.2
Date:   Fri, 27 Jan 2023 10:40:05 +0000
Message-Id: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi Greg,

Here are some nvmem core fixes around nvmem provider device register
and error paths.
Most of these patches have been in next for 2-3 weeks.

Am really not sure if you are taking fixes late in this cycle.
In case you are not could you please apply them for 6.3

Thanks,
Srini

Jiasheng Jiang (1):
  nvmem: brcm_nvram: Add check for kzalloc

Johan Hovold (1):
  nvmem: qcom-spmi-sdam: fix module autoloading

Michael Walle (2):
  nvmem: core: fix device node refcounting
  nvmem: core: fix cell removal on error

Russell King (Oracle) (5):
  nvmem: core: initialise nvmem->id early
  nvmem: core: remove nvmem_config wp_gpio
  nvmem: core: fix cleanup after dev_set_name()
  nvmem: core: fix registration vs use race
  nvmem: core: fix return value

Samuel Holland (1):
  nvmem: sunxi_sid: Always use 32-bit MMIO reads

 drivers/nvmem/brcm_nvram.c     |  3 ++
 drivers/nvmem/core.c           | 60 +++++++++++++++++-----------------
 drivers/nvmem/qcom-spmi-sdam.c |  1 +
 drivers/nvmem/sunxi_sid.c      | 15 ++++++++-
 include/linux/nvmem-provider.h |  2 --
 5 files changed, 48 insertions(+), 33 deletions(-)

-- 
2.25.1

