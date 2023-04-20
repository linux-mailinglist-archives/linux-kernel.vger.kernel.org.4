Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE926E9ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDTRgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDTRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:36:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F393C33
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:36:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec81779f49so717303e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682012180; x=1684604180;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEo0hOP+4EzVSa57OUL4y0mZxsJ42wWcIgxghc5v7lw=;
        b=UdyKIghuEIC4kBqeOY262FqzGehUhT77YHph85THwrNi6oh375Xc29bzaUs6lUIZ3K
         1gVcvwci49UyckZYBpcHGbhrjuxagRC3b/j4xdgyTOo414k3upnwX9hlvPCIdNl8DXrv
         7LXNPRmXLbgHI4pnL1rN7860e8JRS5P6cZCfu9sP05/MsOE0AxeUIm8jdJCgVMoomMgO
         bcw81tnNsdNIKBLkTLZCWFUHP7Mnm3aUZ0oOD+SY4+qWf4YU+Xs/rw8c2h/rHMWQ9B9T
         DeVRQ+/+eZqams/otuEV8xCYT2nPUJBvHtcH8roTk4uM+Srpyvu8a/GXehTUJcz3mulK
         RYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682012180; x=1684604180;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEo0hOP+4EzVSa57OUL4y0mZxsJ42wWcIgxghc5v7lw=;
        b=ho6BfqIPp9aKuyz3Cnwld8DMPHTr8rduNBr7DsMCybtjNMuaGaNGUdSvZ9dGOZQs6Z
         PumQBD8pNH4A23i3MLofMQZR4PnsXgZyjoR7qqR0asekOP61wTKxs+qB+b5VbtkvnaOx
         /Zo1f3El1nGP34e9TZowcaAvAj2psGU+/pjDrntUG18BBcEUI6N4jt+TbJREuVp8u3QK
         dM5EpIQq8hXLdWdQ4aAGeggqF9d7/vsWwsIEeSa/iwS7TlDZBURjTIWiujju05P1J+w9
         LIfpHRtaHSq9CPloryEAqo5AwY5DSuSaj2oFCi7PLj7TVlNyXcJdsJ/QogB6msQ8Hl71
         tM6A==
X-Gm-Message-State: AAQBX9eX7qrcnv/Ct6przDGto9BW3K6tgKC7CEaDWVuF9XUe6JPdPN2a
        VLRr4qsgyeDoXAGbSdYvxuva/w==
X-Google-Smtp-Source: AKy350aDSjDgwzBaje60JMDuf/O/xigysGBey/XJ9UXij7NhzVjbBIUcAxdKsOxbZR2kliqF4JDT6w==
X-Received: by 2002:ac2:428b:0:b0:4eb:4523:d2e6 with SMTP id m11-20020ac2428b000000b004eb4523d2e6mr566317lfh.24.1682012180569;
        Thu, 20 Apr 2023 10:36:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id l16-20020ac25550000000b004edc16dbdfasm281336lfk.119.2023.04.20.10.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:36:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 0/2] Introduce RPM Master stats
Date:   Thu, 20 Apr 2023 19:36:16 +0200
Message-Id: <20230405-topic-master_stats-v6-0-2277b4433748@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABB4QWQC/4XOwWrEIBAG4FdZPNeioyZrT32PUsrojhsh1UVta
 Fny7jV7K4Hm+A8z3z93VqlEquzldGeFllhjTj0MTyfmJ0xX4vHSMwMBSmhheMu36Pkn1kblozZ
 slTsEIdFisOrC+qHDStwVTH7qp+lrnvvwVijE70fT23vPU6wtl59H8SK36b8di+SCSycDwqisN
 ep1jglLfs7lyjZvgWMDumGk7wvk3SDFzlDHhuoGeAcOdQBhYWfoY0N3Q4Mc1QDB+9HuDHNsmO0
 Pkt6e8ewGRX+MdV1/AcuW0djaAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682012179; l=2745;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DZp2v9pevQ5ivoAeN7EGRYK3NshI/MQs8UffJB8xO/Q=;
 b=ASwadp6efjBTWYvFXZ8uVJxW2S3mBzal9xqZRsdzqrdJHoCMvJHDBGEUTZikWN6QgSgsJ1El+V0A
 NVdeAnEJD86cL7gAT43kgSwYnEahqPwFwBdA1DswPdRGoLDsMcds
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 -> v6:
- pick up tags
- fix 'decisons' -> 'decisions' typo

v5: https://lore.kernel.org/r/20230405-topic-master_stats-v5-0-2e1c98a8b63e@linaro.org

v4 -> v5:
- pick up tags
- uintXY_t -> uXY
- driver.name = "rpm_master_stats" -> "qcom_rpm_master_stats"
- use dev_err_probe for debugfs file creation fail
- use PTR_ERR(dent) intead of -EINVAL for debugfs file creation fail

v4: https://lore.kernel.org/r/20230405-topic-master_stats-v4-0-4217362fcc79@linaro.org

v3 -> v4:
- Use "data" instead of "d" for naming local struct master_stats_data *
- Add "qcom_" prefix in the debugfs path
- Add "Qualcomm" prefix in MODULE_NAME
- Make the struct __packed__ to avoid padding surprises
  (even though it looks like there shouldn't be any, by eye)
- use IS_ERR for checking debugfs_create_file return value instead of
  nullchecking, that apparently changed..
- Use -ENODEV instead of -EINVAL when a MSG RAM handle is not found
- Add missing of_node_put() after of_parse_phandle()

- Vastly improve the documentation bit

v3: https://lore.kernel.org/r/20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org

v2 -> v3:
- rename rpm-master-stats.yaml to qcom,rpm-master-stats.yaml

v2: https://lore.kernel.org/r/20230405-topic-master_stats-v2-0-51c304ecb610@linaro.org

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

 .../bindings/soc/qcom/qcom,rpm-master-stats.yaml   |  69 +++++++++
 drivers/soc/qcom/Kconfig                           |  11 ++
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpm_master_stats.c                | 163 +++++++++++++++++++++
 4 files changed, 244 insertions(+)
---
base-commit: 67d5d9f013d6c3829383c08162939cabff14fccc
change-id: 20230405-topic-master_stats-ba201a9af93d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

