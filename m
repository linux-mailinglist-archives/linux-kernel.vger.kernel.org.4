Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629B86E2256
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDNLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDNLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:37:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88909768D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:37:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o1so23003183lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681472240; x=1684064240;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/9ZLcQ7BaIQmTGagXCMoy3R4toJhTlvDVJPYTyT18w=;
        b=eaH9mu67mR8FHIL79HcP2KJtJ4i0A2CcT5NCb/0Ii04uADgGxmvKvn4YtKB1Q/yZ3C
         BX6heWk3grnEISo0XLULllzGOgwEfCNOwCwujDwXDObJa/cnsjuChBrlNq2XNMczp0YV
         T5NtK5OJbtqXSIm8BubNDhOT1sdGmqdK73vkStY4eZx2ROpEcCW2vhFLEQNCIdg72G8h
         41ijLSngS9dRPGkIIKEzvU2Llx8AdoGuuctvNkovnkNigdpaA273NefQkDW+QMtXiPFq
         I9MIroyKTZh1coEnLSK13WXRjb/hoY5zVYDYNwClhKMAgWN+kF/Ded7hjGp+86SW1MKN
         gnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681472240; x=1684064240;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/9ZLcQ7BaIQmTGagXCMoy3R4toJhTlvDVJPYTyT18w=;
        b=G9tMeW2O//QBmIl5/8IEEW1mDpYKYYINohW/DhYcPuse1PnWXlp3/HMS8A6WRIFNzU
         18fRUK0fzIbjRjsgh7bDlkX5CwuUR5xP4FeN72vGrEANrgqIwZT32YR6viaTEe2ltSzD
         +wrNlo9adGKZ5/QWr8PIC8uT5rYqJvfwlJRu6RXy35aKoXZ7iS+Mw8p66GZhSrxCIgh1
         oxgHiuurSexjpcmskzxM78txeQAciez65o2sbmrlY2l0+I5x8koO0jUN0iBAImNBeeXV
         TCNH3YH6L6vp5hXutcUEAQ71f9grwpdwPE2uT6QOWTtnJfJVs+06CcsqMKLmjgs/dqAB
         Or5A==
X-Gm-Message-State: AAQBX9elW5vY+FDuYQVIaa0VO45MaNkVJc3Z/Ihdtbgz2vG0QQnnnfxO
        nC8ehKBJRQL4tS7/SPFJGDI+WA==
X-Google-Smtp-Source: AKy350YmsiMkHBJ6TVyaK80sSphJltOAGMDo07HkTL4x5Oj8Tpydm+QB4hdQ1CH69U2GoTyxcZ5hJw==
X-Received: by 2002:a05:6512:1319:b0:4dd:9eb6:5b4c with SMTP id x25-20020a056512131900b004dd9eb65b4cmr2213540lfu.0.1681472239744;
        Fri, 14 Apr 2023 04:37:19 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id y5-20020ac24e65000000b004ec83bc3e43sm756946lfs.192.2023.04.14.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:37:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/2] Introduce RPM Master stats
Date:   Fri, 14 Apr 2023 13:37:16 +0200
Message-Id: <20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOw6OWQC/4WNyw6CMBREf4V0bU0fosGV/2GMuS0FmmBLbmujI
 fy7F3ZudDmTmXNmlhx6l9i5mhm64pOPgYLeVcwOEHrHfUuZKaG0OIia5zh5yx+QssN7ypATN6C
 EhAa6RreMjgaS4wYh2IGu4TmOVE7oOv/aTNcb5cGnHPG9iYtc25+OIrng0sgO1Ek3Ta0vow+Ac
 R+xZyuvqP8MRYxaWho4a45SfDGWZfkAwH0mZg4BAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681472238; l=1607;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bYhUT+QZfTHYEXm+V8m5IT1o+SVPkkDJanucj8gz9sI=;
 b=QfjJWk1kN4OUM7t/aBRyvtZK/1Fuxetu8pG1e4EuE2nH3qkvC4FR/KoTmb7iwt2ftxIYCv36PrJN
 Bs0z+rBgA6YGIAgRlMPr3ByNcaXF2ms3zCqCRra+hs/F8I+8Hqqa
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

 .../bindings/soc/qcom/qcom,rpm-master-stats.yaml   |  53 +++++++
 drivers/soc/qcom/Kconfig                           |  11 ++
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpm_master_stats.c                | 160 +++++++++++++++++++++
 4 files changed, 225 insertions(+)
---
base-commit: e3342532ecd39bbd9c2ab5b9001cec1589bc37e9
change-id: 20230405-topic-master_stats-ba201a9af93d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

