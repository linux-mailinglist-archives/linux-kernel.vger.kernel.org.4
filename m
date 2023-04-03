Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739E56D45A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjDCNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjDCNZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:25:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21B1166D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:25:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so117332488edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680528306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zwlbtwLCLCchB8nq5AAOLgMV4f8t/gppXcqkdT8DK04=;
        b=pNpOc5UBRVM7xKwNZ05L/1+9p2I+X8x71uwXah0iO4oOIl84ZAQ0jI2xgtdzv3XYom
         zxxxKoce2CpdBH6UjXdAzQt0TFKT1P+mBzNQO8d/vzU/j2zVNNHDWEYvQayhLbeuJjOh
         AjCSluJq1ucWutPTGosRty025C0yFwTVx0CTwEVct6OZqtt3MZKjKiTESlmmrfjD4hrV
         4uLHcQ6qonHPbtTvuDVAk1Q2m27QTIdyuokGFl7xMq5VoAreVnC0caHgEawH3plX3cpk
         f3ymmh9lC1NVo2cbfY3VuXdAfHt8r3AH1KqmWt9adX9eoE2fgi6vdIu90vP6Qu2+9m0d
         Uz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680528306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwlbtwLCLCchB8nq5AAOLgMV4f8t/gppXcqkdT8DK04=;
        b=iADUv9xnuLoA8Bny7DTKBPBwAOyrYmyrX2A5s1Zm4+/U9NwW+yA+E3fE6sJ9b8q17R
         TFdWzQJBHDI8F19CjYdEKfcVJK3cwqp5DLSwqMCx2wwSGgfVzPCnk/r1oikcVEMzpkVf
         xNNr/HwoV6dL9ggOyDABokPnG7/7ysZXtOBo9abU7MKrTEuQ1SDIIgdtvd6aHjHWmrNZ
         Ta12IuJ0BEeI0iLqgFlbFtgDlfFBs2lI861mFPHpUT/33HtOXkv7SsvkIHDv6vZkiHwv
         sMhpIc8XyKfGdlRmd4SytW0nJOlIdH05OgvkKHD0iD57D0qG31LbwFfWciGRw1n9ylOQ
         V3vA==
X-Gm-Message-State: AAQBX9fSOlE0VAUYVeuX5NImezMTTAo83GDNbBgb8tdAPL0yDRcDtQlH
        ExvjDuH6PgPbQ3/fvgnZAmm63A==
X-Google-Smtp-Source: AKy350aeVlKvxHOBVGpIs3CVXzCPJj+2MS1w0lytghRx33dtBHAD01KiVk7McA482UxmdKHdmQm9cw==
X-Received: by 2002:a17:906:9f04:b0:944:8c30:830d with SMTP id fy4-20020a1709069f0400b009448c30830dmr28617784ejc.42.1680528306580;
        Mon, 03 Apr 2023 06:25:06 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906229200b00930ba362216sm4658489eja.176.2023.04.03.06.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:25:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/7] soundwire: qcom: add support for SM8550 (Soundwire v2.0.0)
Date:   Mon,  3 Apr 2023 15:24:56 +0200
Message-Id: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
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

Hi,

Changes since v1:
1. Patch 1: Increase maxItems to 16 for port-related properties.
2. Re-order patch 1 and 2.
3. Patch 3: Drop unneeded semicolon.
4. Patch 5: Fix lang typo in subject.

Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  dt-bindings: soundwire: qcom: add Qualcomm Soundwire v2.0.0
  dt-bindings: soundwire: qcom: add 16-bit sample interval
  soundwire: qcom: allow 16-bit sample interval for ports
  soundwire: qcom: use consistently 'ctrl' as state variable name
  soundwire: qcom: prepare for handling different register layouts
  soundwire: qcom: add support for v2.0.0 controller
  soundwire: qcom: use tabs for indentation in defines

 .../bindings/soundwire/qcom,soundwire.yaml    |  41 +-
 drivers/soundwire/qcom.c                      | 387 ++++++++++++------
 2 files changed, 289 insertions(+), 139 deletions(-)

-- 
2.34.1

