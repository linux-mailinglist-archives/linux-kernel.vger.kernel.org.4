Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B636D9B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjDFOur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbjDFOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:50:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85B9B76E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:49:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o20so38024356ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680792563;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BykCbxMnV8xY/L0TeIGnWsTlJZykkp54pxXItibgVMI=;
        b=bzcxnNOrZ/v8KjAn5QTkCjkv2xsBrprdN0ZPQnvTmXvx3saTlY5fRUGTfcXsjwC4VZ
         zfiy289Lc0i4JKh1ryTOVYB6nzy3HWcVYVT1qaKDJ7N8wdTJJGCmZTdSMOEataSfjmyc
         dwiH6DubwESI9Wgkr1KfBJQy1fHaNpkEa112/ejG5MTAnh6gkP8ofSGvRP+rU0051NgD
         74Kg9jzm417DZplf5dUT/iVxOVnHECTfjJrfv+hp1GOwxU+dv/HqSsIRs/pIhHPhN2dG
         1h0WRdJdoULFGjbIBT4FZGoeMe51Z0ZuuxQf9wAfYaD8EfEluf4oOUqGDVqWtvVAeOaC
         JpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792563;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BykCbxMnV8xY/L0TeIGnWsTlJZykkp54pxXItibgVMI=;
        b=L66pUR2iUlbTp7MgvEbiGzuga/KT0Lm5n/rIyXC3Wi9vwHiW6Z0KK+K1mareUt/PLg
         sFxTVnVtK+sthvSYw8P7mmtAyzqFFK0VFF+fO1Gsx2KZL8b8fxlse11kWR9ljFCEXRSb
         vN2OGURTI+ZTi4B8lKINHiFDPHnjhazhIYamxfMSnBpAsM1fZM2Ex4XEwyR9kohn+ysi
         xrF3/ugS3kAUrEogk9RamDw3tja2jxuL1FCvPP6NXF4UoXSQAgoC0RTv2+CDScA8Ug3v
         /MYiytEmeKpnAkxvZl11XnQE7cSb1ruRZp4Sxz+7rBO70lgkifG0SUiQfMYv3ISSCRyB
         5gxA==
X-Gm-Message-State: AAQBX9e8qJstXDc1nhw+5t99AvPOAX1+FFbi90sQ9z7+6BodW2RTARrd
        m2wFGNPYjpzb/0gD5kC/PeUm9IpDBIHh1rZQ8hw=
X-Google-Smtp-Source: AKy350b5h5kUeGuocJdzthBYcl+xKoO0yWIimhKZwRNRmXiqk8Pv/UqGiCjoKYVn4i+LWKCs/efSbQ==
X-Received: by 2002:a2e:980b:0:b0:2a0:202c:93b3 with SMTP id a11-20020a2e980b000000b002a0202c93b3mr2961979ljj.49.1680792562985;
        Thu, 06 Apr 2023 07:49:22 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id w24-20020a2e9598000000b002945b851ea5sm313864ljh.21.2023.04.06.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:49:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] Introduce RPM Master stats
Date:   Thu, 06 Apr 2023 16:49:16 +0200
Message-Id: <20230405-topic-master_stats-v2-0-51c304ecb610@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzbLmQC/32NWwqDMBAAryL5bkoelZJ+9R4iZaNRF2wiu6m0i
 Hdv6gH6OQPDbIIDYWBxqzZBYUXGFAuYUyW6CeIYJPaFhVHGqouqZU4LdvIJnAM9OENm6cEoDQ4
 GZ3tRQg8cpCeI3VTS+JrnIhcKA76PU9MWnpBzos8xXvXP/n2sWiqpvR7AXK1ztb3PGIHSOdEo2
 n3fv4ZxWfbKAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680792561; l=1442;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vE0OGMBNrSqfCScZ+a+rfWEWnobdzfFLE66cO2LhQH4=;
 b=gH3/TVC1wazdVX4ZO9yqscgw8jfn3H6yoiXQQOc5AqJTI0OM7RYxMpJsF4VE59xIz7Qj7HWbIhWb
 xGWFAHEjASBdtaH1YYFSFzoq/e3X9jrk1E5i5V2Mtkiin3SjwGLU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Drop the `-` in /properties/compatible to make our entry be of the
  correct type [1/2]
- Change %s to %d for printing out the iterator [2/2]

v1: https://lore.kernel.org/r/20230405-topic-master_stats-v1-0-1b1fa2739953@linaro.org

The RPM MSG ram includes per-subsystem low-power mode entry/exit/
residence/etc. statistics which are very useful for trying to debug
what I'd call "SoC insomnia", or IOW the plaftorm refusing to drop
the voltage rails to a minimum and gate the non-critical clocks.

This series adds a very short and simple driver to query that data
and expose it through debugfs.

The base used for writing this driver is:
https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.9.14.r1/drivers/soc/qcom/rpm_master_stat.c

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: soc: qcom: Add RPM Master stats
      soc: qcom: Introduce RPM master stats driver

 .../bindings/soc/qcom/rpm-master-stats.yaml        |  53 +++++++
 drivers/soc/qcom/Kconfig                           |  11 ++
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpm_master_stats.c                | 160 +++++++++++++++++++++
 4 files changed, 225 insertions(+)
---
base-commit: e134c93f788fb93fd6a3ec3af9af850a2048c7e6
change-id: 20230405-topic-master_stats-ba201a9af93d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

