Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB5615651
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKAX5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAX5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:57:40 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820631F625;
        Tue,  1 Nov 2022 16:57:39 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id g13so8700298ile.0;
        Tue, 01 Nov 2022 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79QVVyXFg8UxsRAv7iIJih7AMld9P3iLtMsZBswHoqE=;
        b=q5qrb4vacT3b1cEDSOcuN/m0eNwt7oNmU3Dq2x09izIHg1QSA9i35IM69duVGQKKlQ
         HqR9wvist2TPiMaWuuoN7XKbZ4pvE0mA8DR24LLPrXENpOTeTmxGDmT24knL/CLC31KZ
         NBB5xVNjFrH6XfW7zhwziR+f1sEbau4NyM3L4bqL6xyZ2/y8n5FPo1wtuc0Ogu+iYWFy
         KDuk4c8mqNlfGTmqceT/lCippBBepWn0AuCxFF/uGPB6sXHXtQtoYwzCQwWldVaciZ2e
         zaF1u7G/DSgjEmIkZLDwo60jr1D3BMV48As6DVNvO7iTyqSderbmB5wKcu7Qpdn/apyt
         u80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79QVVyXFg8UxsRAv7iIJih7AMld9P3iLtMsZBswHoqE=;
        b=YYkWFl8H1uXdBOza3JEJbkDG0Dou8FnrC03TTXDfVA3e35TFERSt4rXq4S37dfjtmm
         tXJPqBOxEtUlVDnzmCt6FsOWZwqwcmPPZ4V0Qnr+8e2yRCCvvyAX9Usow+hUfxOfQM2h
         /bAl7IsNgzFbp9cBviG06wBT+g0MXi68lwwSTYs/Wft764/Fz3OMSTZ0TS0JDVU3KPXy
         yZ2Cf7izuXxHERgUjFpVFYODdfE//MuIT2WE762syvZWuLOrGA6Zchjm8i45uG5y/pwI
         hyZiT0HPamG94mOj03BCRfFFNlMQfdkXiF68M0mpRwCyUJV/+WE7GVjHZ6F3mn+AkdiZ
         4kKQ==
X-Gm-Message-State: ACrzQf1059IY10H3btyey+m+P9Mi1ZIiY5ILLKbtEf7J4ltrJb3g48fa
        78IhGguXKvMLIQ9QFUV8LA4=
X-Google-Smtp-Source: AMsMyM5qvwLWgIrPUtRiDcylkN4kx1MzFaJj64axVksnHyx7mknR1a34xP3bW7qkCNcd5Ede9ms/TA==
X-Received: by 2002:a92:7d0a:0:b0:300:b187:cac7 with SMTP id y10-20020a927d0a000000b00300b187cac7mr7699147ilc.178.1667347058181;
        Tue, 01 Nov 2022 16:57:38 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id u6-20020a02cbc6000000b00363fe31cf55sm4446477jaq.40.2022.11.01.16.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:57:37 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 0/4] Initial SDM670 and Pixel 3a support
Date:   Tue,  1 Nov 2022 19:57:18 -0400
Message-Id: <20221101235722.53955-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not apply this series yet. It is only for review comments. It can be
applied once the "qcom,sdm670-smmu-500" compatible string gets added (or
now if you don't care about handling an unnecessary quirk).

This adds the device trees and bindings to support the Qualcomm
Snapdragon 670 and Google Pixel 3a. This patch series, specifically the
last patch, depends on:

[PATCH v4 0/3] SDM670 Global Clocks
  https://lore.kernel.org/all/20220914013922.198778-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] RPMh Support for PM660 and PM660L
  https://lore.kernel.org/all/20220920223331.150635-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 RPMh Clocks
  https://lore.kernel.org/all/20220920223734.151135-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 USB 2.0 support
  https://lore.kernel.org/all/20220922024656.178529-1-mailingradian@gmail.com/T/
[PATCH 0/2] SDM670 SDHCI support
  https://lore.kernel.org/all/20220923014322.33620-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 Power Domains
  https://lore.kernel.org/all/20221004221130.14076-1-mailingradian@gmail.com/T/
[PATCH v10 0/3] SDM670 Pin Control Driver
  https://lore.kernel.org/all/20221014001934.4995-1-mailingradian@gmail.com/T/
[PATCH v6 0/4] SDM670 GPI DMA support
  https://lore.kernel.org/all/20221018005740.23952-1-mailingradian@gmail.com/T/
[RFC PATCH 0/9] iommy/arm-smmu-qcom: Rework Qualcomm SMMU bindings and implementation
  https://lore.kernel.org/linux-iommu/73eee2ed-f8ee-f136-2853-34b27c099644@quicinc.com/T/

Richard Acayan (4):
  dt-bindings: arm: cpus: add qcom kryo 360 compatible
  dt-bindings: arm: qcom: add sdm670 and pixel 3a compatible
  dt-bindings: firmware: scm: add sdm670 compatible
  arm64: dts: qcom: add sdm670 and pixel 3a device trees

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../boot/dts/qcom/sdm670-google-sargo.dts     |  519 +++++++
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 1216 +++++++++++++++++
 6 files changed, 1744 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670.dtsi

P.S.: Thank you to all the maintainers and reviewers who went through
everything and made helpful comments!
-- 
2.38.1

