Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA626E4F59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjDQRh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDQRh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:37:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA31BD1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:37:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x34so13863086ljq.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681753074; x=1684345074;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7j5v37v0cFJe7eIrc+n1ZxsUusKsgN3Q+vl+g9FMbE=;
        b=VjVQ822cU597IWSHWdLmAs6ETCwssHLxrmNUrhOndk5vY/7Q/320F7otHSk34LxBuH
         t3vnLA/5WF88Nvr9NmlKAbiryq+F7PKg6Im8E5Ez7b+uwlCyPG2Jru4ppJN3xr6tTL59
         tisKCW2sYQFwwUUx1Wxa1MNwsMYJjo4XZaCCuwTxiedSjsnrlcM8kcPGCgJVFfwBe+vc
         aVHLTqmRXJ3ZxOHY+bSd4F7BjKyU74tYlEvyH08dmn1DDKeEoENQkzhXtHXuTDi/Cu2I
         haJj9g1zSqS6KQdtYab7M8qgw35CDxMy5H47c7jdBnxfOP5pw6Ed5dzt1WqARIWtdRGH
         tjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753074; x=1684345074;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7j5v37v0cFJe7eIrc+n1ZxsUusKsgN3Q+vl+g9FMbE=;
        b=CJJutNI2fLy2+bcy070SaujZ7P/YqYDJXkcRK9V/CYGwV0TkrFX+n/esGWrWzWHn83
         +BquwW8cZnUPwDMxAC96rue9i1str2AEgfpsvz2fl2ACAAVL+woLOg18AQdLLjDQGouC
         W/qXsy0gt1ZeOyNzronWG1/WaVtQo4bJZE6CTcZuTbaQZXakCdUgIo7epKNOjTEiP1UO
         uL9rlUtwoMKFwjUAitkWkQ0xJDyEZUOpT/Eh93RJ/OEdHbvnNsA/Awcnk3O+b1TM7zmb
         OQ0ZtCHQewTgdDiDq2p3flqAVTBxVOvI21PKoM0Zka3C2HRAFxSwrNB0BmbWAzGx76/Q
         Q6VQ==
X-Gm-Message-State: AAQBX9fZkBKdftHzFO0JNZsl/k7vh0u+66L2jjV7TPb4ybxaGAOY/FjJ
        zoVVpUXsprZgwsGWxdtnrQlDBQ==
X-Google-Smtp-Source: AKy350Z3wav47/0RzLKAWuUWjHeacDm9uPT3vn2i4OgQfNDZgObom7Olj7tmklR7GOhnI7/sGlUElQ==
X-Received: by 2002:a2e:8896:0:b0:2a8:bdda:87f3 with SMTP id k22-20020a2e8896000000b002a8bdda87f3mr1473807lji.31.1681753073776;
        Mon, 17 Apr 2023 10:37:53 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id h13-20020a2e900d000000b002987088bda4sm2191329ljg.69.2023.04.17.10.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:37:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 0/2] Introduce RPM Master stats
Date:   Mon, 17 Apr 2023 19:37:51 +0200
Message-Id: <20230405-topic-master_stats-v4-0-4217362fcc79@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO+DPWQC/4XNQQrCMBAF0KtI1kaSSavElfcQkUlM20BNShKLU
 np3p+5EsMs/zH9/Ytkl7zI7biaW3Oizj4FCtd0w22FoHfc3ygwEKFGJmpc4eMvvmItL11ywZG4
 QhESNjVY3RkWD2XGTMNiOquHR93Qckmv887N0vlDufC4xvT7Do1yufzdGyQWXRjYIB6V1rU69D
 5jiLqaWLd4I6waQUUtLD86avRQ/hlo3FBlgDRisGhAavox5nt8SjrT0UgEAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681753072; l=2265;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XrAEFoYbGavRPeKk7KK+IVW8Jgm3IU8DzAiHjb+PNRA=;
 b=p4IjNdeAgFb1YAAcIo122wBfDyx7Rxz88aP5J/w9WLb2jxOcIpcRiPX4qjuUwHM5bfbRUgwOVTro
 Ukq6nLVnCdmHYzgFxcEuDPWxtUGmYgkvlcFf6MRLNtCYW325c2S5
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
 drivers/soc/qcom/rpm_master_stats.c                | 162 +++++++++++++++++++++
 4 files changed, 243 insertions(+)
---
base-commit: d3f2cd24819158bb70701c3549e586f9df9cee67
change-id: 20230405-topic-master_stats-ba201a9af93d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

