Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D09742E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF2Ufy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjF2Ufw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:35:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D712D30DF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so18539031fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688070948; x=1690662948;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=roO8YrYj9iIU3EjCKgeaxJFuC8MlkPexoI9WwcBfk4M=;
        b=aL7DwfgqS2nZOiWfMRKgRg8GCSGzlLizCKplh1fLS7f0H0fS9RRyV871dMs8WEpx6O
         w2yXTGUAqCaC4PQ4CyZ6Wc07E/VzuxRZMu5S3YL1y7OHJCBS0fu0DFmco7gDPNyz1XJL
         ZyRB+h+o6KOPBJpUbV/o8vmFXFaH8fLdq1WCNby99S+hpY6hSaYbclB/VXz9P3t3ouKj
         zmCzSJfOkn5Urm2mTYCi6chGG6rBubDwoGWAm3nUK6z6XxAiJuyLFFnK96TKahXHgQzb
         UcYsOdaZonTln2aa+cWXjc+6wBy5uoit5M1ysqAUf8XPnygDkQ0rR5C8qvKO4AHxbnQM
         VUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688070948; x=1690662948;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roO8YrYj9iIU3EjCKgeaxJFuC8MlkPexoI9WwcBfk4M=;
        b=NazFe0sivwPfbUedqftgTmBVNFvXhJVUBcPQPNZ2JH77qGceZLmDw8DoKOxi7G8hMZ
         OzDNOHHYQEgCGKtoN/AtUM6cfVjcOLsDjo4YcOJ9SV/EhKxNOYXmTo7L1MuVKSjjLYdg
         qKz9Dn1PDuJSCdzxF9vCU6Y4BpoxH1HnXrV3jRRsLDvFTYfRnip10l5UQQXn7QF0sWXS
         J/HaDbFyfzN8zRAKSNITEh1lxaJvaxv/Kn9lNuIA/yg7z811TJNOOnx/eL6hfBmHlQP8
         skwusTo7K7naffUavftoj/ZK447tMJQMkxLicmjg4PtRC9qOwydmEIuxnT9o2nvGqFPm
         eG/Q==
X-Gm-Message-State: ABy/qLYtAfJLiIdoIjpV6JZUT/Gj8NUdpBbO7AHAnzAI1LvOLJ2i0xle
        qhyaAWPJ/2jfXquQDQqcvZxyig==
X-Google-Smtp-Source: APBJJlHmYuIe4jmQmUOHf4LS1a4x4RFAsAsgFkB5nTh0ZJKctX3XwebQ8qIYR4nQuF0TAC/qNt9f0g==
X-Received: by 2002:a2e:9059:0:b0:2b6:9f95:46d9 with SMTP id n25-20020a2e9059000000b002b69f9546d9mr545726ljg.46.1688070948029;
        Thu, 29 Jun 2023 13:35:48 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id k3-20020a2e2403000000b002b6b849c894sm1136008ljk.111.2023.06.29.13.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:35:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/4] Qualcomm REFGEN regulator
Date:   Thu, 29 Jun 2023 22:35:40 +0200
Message-Id: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzrnWQC/3WNwQ6CMBBEf8Xs2TVtEVBP/ofh0OICm5CWbJFoC
 P/uyt3jm8ybWSGTMGW4HVYQWjhzigrueIB28LEn5KcyOOMKU7kLzmniFoW6niLacxdMqCtnbQm
 qBJ8Jg/jYDirF1zhqOGmZ3/vHo1EeOM9JPvvlYn/pn/XFokHrKiqvZV0QhfvI0Us6Jemh2bbtC
 3Xqv2i+AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688070946; l=1730;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=o6C8T/LQ49ia1cOEpHXglcMRSGrmiGdpXmYAdGtJ7Z4=;
 b=Ex0q08xmxL6AcV018TpSZ/b4gyImH8vj9XCXXL2F+XrwzPusRQOEc3gsYGh6Q8WErt/Xl22a6
 YSziOTXpLASAMFu25y+vL3MkzJtUXbIUQz/3N+4VTUznwyJ2mRR5a7+
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

Recent Qualcomm SoCs have a REFGEN (reference voltage generator) regulator
responsible for providing a reference voltage to some on-SoC IPs (like DSI
or PHYs). It can be turned off when unused to save power.

This series introduces the driver for it and lets the DSI driver
consume it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Remove "|" from bindings description
- fix 'renegator' typo
- define number of 'reg'
- adjust reg= to size/address-cells = 1
- fix regmap usage
- use C++ comments for the header
- remove now-unused struct qcom_refgen
- use common helpers for sm8250 refgen (simple bit ops)
- add missing FIELD_PREPs (small brain forgot regmap_update_bits
  doesn't do shifting)
- pick up tags
- Link to v1: https://lore.kernel.org/r/20230628-topic-refgen-v1-0-126e59573eeb@linaro.org

---
Konrad Dybcio (4):
      dt-bindings: regulator: Describe Qualcomm REFGEN regulator
      regulator: Introduce Qualcomm REFGEN regulator driver
      dt-bindings: display/msm: dsi-controller-main: Allow refgen-supply
      drm/msm/dsi: Hook up refgen regulator

 .../bindings/display/msm/dsi-controller-main.yaml  |   4 +
 .../regulator/qcom,sdm845-refgen-regulator.yaml    |  57 ++++++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |   2 +
 drivers/regulator/Kconfig                          |  10 ++
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-refgen-regulator.c          | 154 +++++++++++++++++++++
 6 files changed, 228 insertions(+)
---
base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
change-id: 20230628-topic-refgen-14fb0b762115

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

