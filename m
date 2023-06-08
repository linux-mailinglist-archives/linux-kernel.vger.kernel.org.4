Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048617280CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjFHNCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjFHNB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:01:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44DE50
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:01:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6563ccf5151so518645b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1686229316; x=1688821316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CczotM/yiFejXKQ5wSdLM5OKy5Qv4X9z1E65EJBS8FU=;
        b=FMmfi3P7cp8pDZDeTVq3gFRD4893tsmBekCgNT7PIzRedsKSenwLvtSCcMLiPBmcZm
         MfZsC5nnFcwu80++w8Hp1mUkkhns0uhSczNxQYqsGCAqLqKfMHDdJPFtCHLw3Iv5+oss
         DdM72SfUU9WedtD6aBw/tUklKrai3tUlgFBvxPrxw2l5P5zH0sVOJD+ZrBx9NhHhgYGo
         L8BMVO/4dEubC8sPMean52JC5EFh0VmRP4pUbpM0auGnGokkR6q7fyPDkFAMtgGojIru
         nUVGXY4l+Ydhzs9EgVvMtNjGI5cBVvR9UC7HNiM5E0pOJcy1dYOh8uAhZ+l/linwwWvB
         j+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686229316; x=1688821316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CczotM/yiFejXKQ5wSdLM5OKy5Qv4X9z1E65EJBS8FU=;
        b=ii3zapDGjHgN+dPsTe30FTs91vVGkzi7D6o1pqgLLCc//TFHFrB7PdRhYa/lpHgb0y
         pm9FKeRydGdqhkgvbKWGCdFAr4+psnEQucSHZ34UMiAPUAqgd1+rZ5bIqUOhiQMU3yuV
         7BTQIjTy+QxiXRyz2sWDl6j1EKxJdOfenq/OugBbHzBuSQ/Ulwj8Hb1Seq8UkJ3l3Rqt
         jOlp+DnFBIzE4I2Lw76U634PiYHmIqqE7shUpdJMnmgEuQAvfGr0Mb86VrYoBoWelm+L
         N3K148PrWkW+kmoL/nOG6NNU7OMt8eR712QkT8FhcT9mvOala5b11HiKKsyoSUlLZHjL
         AANw==
X-Gm-Message-State: AC+VfDyLBlkBthKTOKp0tniQJ4Lq7Da5wXyq8zsuBy53qRgsQ5Bdd+YN
        7QMH7to6kbKCz4jswT2+zfEtaA==
X-Google-Smtp-Source: ACHHUZ5FZ8HnjKLIhnJ64OdZnmQDd5zyMQJ4d14uUFTPZUOMs76T97WSzEpFSBJzrSROXCpvZllh8g==
X-Received: by 2002:a05:6a00:1250:b0:659:7d45:a52c with SMTP id u16-20020a056a00125000b006597d45a52cmr9689573pfi.30.1686229316533;
        Thu, 08 Jun 2023 06:01:56 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id g12-20020a62e30c000000b0065438394fa4sm1111371pfh.90.2023.06.08.06.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:01:56 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v4 0/2] Add ili9882t bindings and timing
Date:   Thu,  8 Jun 2023 21:01:45 +0800
Message-Id: <20230608130147.2835818-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Ilitek. The ili9882t touch screen chip same as
Elan eKTH6915 controller has a reset gpio. The difference is that
ilitek9882 needs to use vccio-supply instead of vcc33-supply. 
From Dmitry suggestion, it would make more sense to distinguish the
binging of ili9882 and eKTH6915.

From The datasheet specifies there should be 60ms between touch SDA
sleep and panel RESX. so we can add the 65 ms delay in i2c_hid_core_suspend.


Changes in v4:
- PATCH 1/2: Remove compatible items and add reset maxItems.
- PATCH 1/2: Refer to the panel description in Doug serias[1].
  [1] https://lore.kernel.org/all/20230607144931.v2.1.Id68e30343bb1e11470582a9078b086176cfec46b@changeid/ 
- PATCH 2/2: Set a "null" to ili9882t_chip_data for vcc33-supply, then using dummy regulator.
- Link to v3: https://lore.kernel.org/all/20230607133458.4075667-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 1/2: Introduce bindings for Ilitek.
- Link to v2: https://lore.kernel.org/all/20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/2: fix ran make dt_binding_check warnings/errors.
- PATCH 1/2: remove oneOf,just enum.
- Link to v1: https://lore.kernel.org/all/20230602140948.2138668-1-yangcong5@huaqin.corp-partner.google.com/

Cong Yang (2):
  dt-bindings: HID: i2c-hid: ilitek: Introduce bindings for Ilitek
    ili9882t
  HID: i2c-hid: elan: Add ili9882t timing

 .../bindings/input/ilitek,ili9882t.yaml       | 66 +++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-of-elan.c         | 33 ++++++++--
 2 files changed, 92 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml

-- 
2.25.1

