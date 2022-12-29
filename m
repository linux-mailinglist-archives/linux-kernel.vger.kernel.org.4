Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F8A659074
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiL2Sen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiL2SeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:34:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F835E00
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:34:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id fc4so46783879ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=no1oGPAMfu3UahXnB9UWch8Dq0drmE2MoF9HYiX8qdk=;
        b=UOKiv/x5GxHnqKLebOv1jT3ZNQxPq6pUKmOVI7sLyGpIfUuysrgzPwgQmg0Bn+aebi
         nsISs40nbm/jyVM/05Ja2AjJsZ61e5cYzAHTcWA2GnHdpVv5JM/gBoA+LEV3mIt6vLLZ
         oSu5/g1R68M/tKev9P921yTq40WDmaezcHLfM7qTGC85CjJ3OOwIQxRFoF+qvZNRSAl3
         oZ/qdjT+gT+W2+M2BhnUEtlSwGlnL4N8wmqLuCgymEZyO+Vs/BBFQqW7++Dp/PeCHYxR
         ZlX90yqUztobRNLeUbNuG4jcD9BciS5+YxLIjs2LUa7eSY4CxAqEqvWDNAvcwCA8FrOP
         dhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=no1oGPAMfu3UahXnB9UWch8Dq0drmE2MoF9HYiX8qdk=;
        b=U70VUvEaDedlDgnlHtUWH/UpAjNESvXna/jzMfIsuo4ES3iE6nCPSFaUORHxtldaU/
         G+4qE6CasF0ZQiCIw1cGOSwU6qHfUIsV88811cbjrH/XcH/8v+OwRqyZ/ZCgJJHDZBMR
         3YCtxuXZipR3C/KuEatqpS1Gucxnm1jQ/cZbdKRWC27ou12hWXTc64orfHEr485gKfot
         IOFsV0A+Bx6vQEh2czGBuRJi7XyPRPG5uinp4hXoPY76XbVkgfA1UVMP8Xipueu8glPe
         naSf/QjK//x7SGHdQa9w2Jxv+5ooP2pKsmdL3NdVzIV8Y+vcvuZBJt0eCsSihKIBgdXF
         11Qw==
X-Gm-Message-State: AFqh2kqxv0S2kONdaFE+FefR9ke7cY6GTLwYlaVzu64V4aSKTYmJrdUQ
        vsRLmddSADlveDRZ2794Q4J+Sg==
X-Google-Smtp-Source: AMrXdXuYnpHFOzlOs0ES03vrrItmdl43Pa8Zm5EPbxnp1GEMInsgQcyjSZj5ETUig0M6DAHHggbxaw==
X-Received: by 2002:a17:906:a14c:b0:7c0:b4bb:919 with SMTP id bu12-20020a170906a14c00b007c0b4bb0919mr29432888ejb.10.1672338852751;
        Thu, 29 Dec 2022 10:34:12 -0800 (PST)
Received: from planet9.chello.ie (2001-1c06-2302-5600-12a8-8cf4-e3f6-f90f.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:12a8:8cf4:e3f6:f90f])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709064e5600b007c0688a68cbsm9013936ejw.176.2022.12.29.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 10:34:12 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/2] qcom: Add a method to manually toggle the DP pullup on HS USB PHY
Date:   Thu, 29 Dec 2022 18:34:08 +0000
Message-Id: <20221229183410.683584-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:
I'm clearing out old patches in my tree and opted to rework the naming of
the relevant flag to align with the downstream name. Also the original set
was sent against a .txt description which has now moved onto .yaml.

I haven't retained Rob's Acked-by since its +18 months and the
Documentation patch applies to .yaml now not .txt

https://lore.kernel.org/all/20200528223458.GA804610@bogus/T/#mb20456db4a3d1cf608bb6335a1b6fa9dda8cb0cb
https://android.googlesource.com/kernel/msm/+/android-7.1.0_r0.2/drivers/usb/phy/phy-msm-usb.c#2736

V1:
On an MSM8939 we have a system behind both a type-c controller and a USB
Hub. VBUS is not connected to the PHY and no GPIO is available to signal
VBUS state to the USB controller and PHY.

In this case we've used USB role-switching to transition between
host and device mode.

The current code in qcom-usb-hs only touches the VBUS pullup control bits
if we have an extcon but, setting those bits is still required on the
example I gave of the MSM8939.

This series takes the downstream concept of a DT driven flag for the VBUS
pullup bits and applies it to upstream in the poweron/poweroff path of the
PHY.

I've opted to unset the bits on PHY poweroff though in downstream the bits
are only ever switched on if the flag is present, downstream never switches
the bits off again. I think though, setting the bits off on PHY power-off
is the right thing to do, so I've done it.

Bryan O'Donoghue (2):
  dt-bindings: phy: Add qcom,dp-manual-pullup description
  phy: qcom-usb-hs: Add qcom,dp-manual-pullup logic

 .../bindings/phy/qcom,usb-hs-phy.yaml         |  7 ++++
 drivers/phy/qualcomm/phy-qcom-usb-hs.c        | 36 +++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.34.1

