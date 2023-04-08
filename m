Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF06DBD42
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 23:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDHVky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 17:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDHVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 17:40:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408584C01
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:40:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e2so1477353wrc.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680990047; x=1683582047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1r1SnOX6wBN2nHGoU3kualPj54nGeQSAaKXS+XIlZkY=;
        b=bBHCoWqCZjmRMr/6jc1rmR8Zb3K5vch/8ZNshCg45bdBET0jkywDKUWqGOJiRN2Z8B
         X4s3n6cRGmlKcNQfE65/c9k15VqfINbbSEi+w0fFsPOyau57izi4gZHjRELdirmkOcqS
         b/MGT5prRycMjYmnmUm7uXaNiYZUaBUvMf+bJOPztSwftxdAjr4yS7ae5FoEKcxn8qc/
         JDrouNcvioskloCtX1qRiDEb+JKBUDRk1sivUHgDEKNzmWDVHl8/ojePIAmAktLC/62R
         6QoHzgqQnSMuVxwyHSG/qNDjTiR1QKk75H+ztg+h4NggiFsBGTBDJA56pE5roG/+1uw2
         CWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680990047; x=1683582047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r1SnOX6wBN2nHGoU3kualPj54nGeQSAaKXS+XIlZkY=;
        b=FYHRNnfQNpxHAjdd8j1P40nTsNDWz4IVbvR2wD30Q2e9xfBfk00JKgCrgxkrhNwZUB
         6LnoY1g4MfUl8NhxBC8vW2EmWv0TBegqwrd/o3zWBBHA1/jUZHfoxupp5NmK6kRqaGTD
         3hKyraBKALw50lxYxn9PdflHRE9f6tKOpWksdQs3TW+HotFyX2o8nUalvbHmFkCuxsFp
         uMcqZ5N03d4VfcQtiyLLOD/m+VgZN/Q+tdT3U+rhX5A0xSgZCiRdwrimKePAymlnNu3Y
         phFpSXzCFMtXxK5p3FEDmgZ1wuzZheKSUs0s6TGmuIOqj5Uzta+earsFCnWIOOf3kZEI
         +u2A==
X-Gm-Message-State: AAQBX9eKF95jpWpcBo1gIS/qvbNOY4wEk/lPUX9bmAprIKi5tfuQ/64x
        fuu6KxtX9Pm6RgkR7cNbwIPEhQ==
X-Google-Smtp-Source: AKy350YFShjn4hELK46QnNTz06X559nncDEtCLRY2NKWt5Icc+qKjSwPyUFsi9Ob6YNkuINvGr+6TQ==
X-Received: by 2002:a5d:50d0:0:b0:2ce:ae4c:c429 with SMTP id f16-20020a5d50d0000000b002ceae4cc429mr3829849wrt.4.1680990046639;
        Sat, 08 Apr 2023 14:40:46 -0700 (PDT)
Received: from localhost.localdomain ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d4ec6000000b002efb6e0c495sm3061377wrv.91.2023.04.08.14.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 14:40:46 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v7 0/3] Add dedicated Qcom ICE driver
Date:   Sun,  9 Apr 2023 00:40:38 +0300
Message-Id: <20230408214041.533749-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As both SDCC and UFS drivers use the ICE with duplicated implementation,
while none of the currently supported platforms make use concomitantly
of the same ICE IP block instance, the new SM8550 allows both UFS and
SDCC to do so. In order to support such scenario, there is a need for
a unified implementation and a devicetree node to be shared between
both types of storage devices. So lets drop the duplicate implementation
of the ICE from both SDCC and UFS and make it a dedicated (soc) driver.

The v6 is here:
https://lore.kernel.org/all/20230407105029.2274111-1-abel.vesa@linaro.org/

Changes since v6:
 * Dropped the patches 1, 3 and 6 as they are already in Bjorn's tree.
 * Dropped the minItems for both the qcom,ice and the reg in the
   qcom,ice compatile subschema, in the ufs schema file,
   like Krzysztof suggested

Changes since v5:
 * See each individual patch for changelogs.

Changes since v4:
 * dropped the SDHCI dt-bindings patch as it will be added along
   with the first use of qcom,ice property from an SDHCI DT node


Abel Vesa (3):
  dt-bindings: ufs: qcom: Add ICE phandle
  scsi: ufs: ufs-qcom: Switch to the new ICE API
  mmc: sdhci-msm: Switch to the new ICE API

 .../devicetree/bindings/ufs/qcom,ufs.yaml     |  24 ++
 drivers/mmc/host/Kconfig                      |   2 +-
 drivers/mmc/host/sdhci-msm.c                  | 223 ++++------------
 drivers/ufs/host/Kconfig                      |   2 +-
 drivers/ufs/host/Makefile                     |   4 +-
 drivers/ufs/host/ufs-qcom-ice.c               | 244 ------------------
 drivers/ufs/host/ufs-qcom.c                   |  99 ++++++-
 drivers/ufs/host/ufs-qcom.h                   |  32 +--
 8 files changed, 176 insertions(+), 454 deletions(-)
 delete mode 100644 drivers/ufs/host/ufs-qcom-ice.c

-- 
2.34.1

