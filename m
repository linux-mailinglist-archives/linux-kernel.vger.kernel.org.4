Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE764B52A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiLMM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiLMM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:29:06 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5341DDC1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:29:04 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q71so10305643pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6B2uCXhwS8UcOxHSVMu84gj0hLuyx0nL5YZCYMXlNbI=;
        b=GxvydUusQloT11Q4kIxBsIZkyi+0z3i9DcsvxchXOG9AMb18+uEjdmO/sM6vCWz9TP
         ww57Jhgx8llazHhg1dVP07lRvY6PM5+PIJqLTfF7vNhhkVyXCuQBkQ6h/Fz3CGh3URjW
         BIW3rEsTIM/Yo+usn28sAJ0jZaYAsu1OfnIm5J6qG0RS/6a7y4f33EYFtvzxYxNVFAmG
         cp3rR+msN/qGgx5JQbKrqHSRyxdmg4BIxah7HWcuP930UD/lsMa5JvU2bWc0j2Ns8zZv
         gbMvk63mH/lyniuw1Sopq277j/Kq4S1zMwE+g5Dc6hYlBLNIJbpmYvdxADpV4Ndr65KS
         bPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6B2uCXhwS8UcOxHSVMu84gj0hLuyx0nL5YZCYMXlNbI=;
        b=5amLLDsyLrCx7RqakN10TeqQDZ+2Zk3Xxa7AF4ap1iEPGJziqc9hkz/U8kE/dEitRk
         xi6JhsXOjRjBsGk86XYlEANhWDmsl0WOrL3PdjlCKvgvFThddkyNvP8C4gItgoC5JGiw
         EnSdSvKA28VG5zFDHyrjGmpfWkanOqD8j9CAKG1QD6YYfXrrwXhw1jPUoEVRIPJpCPxa
         wsTwGbrAO+AnLRxUo2dP5GVjy/i1/sB7HSgzbm8p0QlAB3M6hbjO481AbutA5qzJ4X6X
         oGf/6KypdVHMkLA/VFzeydj0NQ3viOBkpSZMCrf2RIwz4CI57lf2iUIZqtS+PQaHJR6I
         qwhA==
X-Gm-Message-State: ANoB5pkt1JhuB9zH5uM8rOHJW0JN/F7LuHVolO1SU9xPtLJKIGGPFXGi
        kPW58O66U1y/yQ8HGxn7CS0c0Q==
X-Google-Smtp-Source: AA0mqf5wGzHlxevuKvZLX4cMgfWkGo5uzzVzFm6E2mKP6BYKfxRAQtuK8zx6RdswZl5YbOjEUNxqlw==
X-Received: by 2002:a05:6a00:1711:b0:576:c2f0:d6a1 with SMTP id h17-20020a056a00171100b00576c2f0d6a1mr19952530pfc.8.1670934544111;
        Tue, 13 Dec 2022 04:29:04 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:4bad:5c3:ab51:3d81:6264])
        by smtp.gmail.com with ESMTPSA id y10-20020aa793ca000000b0057555d35f79sm7602468pff.101.2022.12.13.04.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:29:03 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     vkoul@kernel.org, linux-phy@lists.infradead.org
Cc:     shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org
Subject: [PATCH 0/3] Add Qualcomm SM6115 and SM4250 USB3 PHY support
Date:   Tue, 13 Dec 2022 17:58:40 +0530
Message-Id: <20221213122843.454845-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for USB3 PHY found on SM6115 and SM4250 SoCs.

Bhupesh Sharma (3):
  dt-bindings: phy: qcom,qmp-usb: Add SM6115 / SM4250 USB3 PHY
  phy: qcom-qmp-usb: Fix QSERDES_V3_RX_UCDR_PI_CONTROLS init val
  phy: qcom-qmp-usb: Add Qualcomm SM6115 / SM4250 USB3 PHY support

 .../devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml   | 3 +++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                      | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.38.1

