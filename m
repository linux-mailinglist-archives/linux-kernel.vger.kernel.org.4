Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE56E79A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjDSMXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjDSMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:23:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C0E50
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:23:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q21so4582729ljp.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681907002; x=1684499002;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvSDQyWj5f7txFAaXfGbFGlFj80hp9DwoTE4MYUMfaI=;
        b=qQXEVp3KKH6Du+RXV3eFlXBV5WmXao+AQpZ70WoxPKDUZDClEb9+50HtcFx2Z0LJhY
         U7eEfIGGzpRAC8P5IGgETSEYany5RpjRFYz2T8PUkuio7dmEIV6pPQrFijiGEreD39b7
         Mk4vfA0KWDPkZquu3X+SDLLMR0mGqTAC4Z3VEyW0HiP9IkfGy+ebioIyzFEuwh3/KAao
         mrZWtijKQva4B2vuyvw4tpxQMa7t6LyxKi10+EqNCsl4GqYzpypZiMJk6aSDLmZ8yvzg
         G/pzCTbK9KAk2/5E/Abf900QD0kOrE8LhmYzUex9f83N+5CKN0ue7tu4+fzujK83K0Qy
         gNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681907002; x=1684499002;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvSDQyWj5f7txFAaXfGbFGlFj80hp9DwoTE4MYUMfaI=;
        b=LIsxutOVQ7z20+pCwItz0a5OGt1mDRqU+QMhwuxVMpRsdZh32YjhEuh43AuWYjaXIu
         +rDcbBuZym6jmkQf/ROgg+s6CXVaB8WhEfA6Wu67nJVmjpesRa1AR2lQD0g/TxUlXXzt
         VdpqnL8szz1S+hixyIlVGXLO5JpfZo17brZmyYstxzZ9e0CmVXkJkXCRuAWclM21yWbL
         mn4TKRtdbPC+xjXMAgba24q/qCRx0npOiZWE1g3sdt/WeG9ZwlouFcJ9nMaeDiPXNshp
         1ClYdvZINVzvyOQOYN/KguZTp5Bh2+x961n6fKEtLhJdBGLRo3KA4Y4gsX51rdrp7Zne
         XM4g==
X-Gm-Message-State: AAQBX9dTgf2DcQuiU+9VQmlyqHGT8EQZY9Dj6Z04DDhzzpJu7rW78FSZ
        B6CQ98EWUh7L3oCVlXL/9dcKmA==
X-Google-Smtp-Source: AKy350YctxTOqV88ACpaBhsr8dT+ngoxxLJTPBKjze0bRc2AdDbM4iKjM4iKXe2jpw3pVyk7E5VoVA==
X-Received: by 2002:a2e:9b58:0:b0:2a7:8301:a968 with SMTP id o24-20020a2e9b58000000b002a78301a968mr809901ljj.12.1681907002262;
        Wed, 19 Apr 2023 05:23:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id a23-20020a2e8317000000b002a79d7ceb93sm2925550ljh.9.2023.04.19.05.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:23:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v5 0/2] Introduce RPM Master stats
Date:   Wed, 19 Apr 2023 14:23:19 +0200
Message-Id: <20230405-topic-master_stats-v5-0-2e1c98a8b63e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfdP2QC/4XN0coCIRAF4FcJr39DR7fF/6r3iIjRtBU2DbWli
 H33pu4iaC/PMOc7D1Z9ib6y/9WDFT/FGnOi0P2tmBswnTyPR8oMBCihRcdbvkTHz1ibL4fasFV
 uEYREg8GoI6Oixeq5LZjcQNV0HUc6XooP8fZe2u0pD7G2XO7v4Um+rj83JskFl1YGhF4Z06ntG
 BOWvM7lxF7eBMsGkNFJRw/e2Y0UX4ZaNhQZ4CxY1AGEgS9DLxuaDA2yVxsIzvXmw5jn+QnLN5L
 llgEAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681907001; l=2588;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vst71VT1XxXM0DP8FwVpxSkBNbeYnYkFdFEDddcpBLE=;
 b=BFtLTW3/iZpy/yhAJGrGCAu8CttzFDJb0tjON8E9/a3Uatd/zLrnfDRLM1M4kEvakebpr/AWGjtr
 A8sZ6pdLB+ric4O7HTz2+87pECKqLftYnzaAHmKmnvmdm+gW7Wp5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

