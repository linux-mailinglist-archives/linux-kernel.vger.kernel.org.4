Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258FB695F25
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjBNJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjBNJ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:28:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD8252AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:27:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m10so6012487wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/B47bE8TEfIlwi0qudqXOToGhOOwF+9/IKyL/OBYwwM=;
        b=HtB+4uy0R7dSoCt090raVGS7qvZQvx5WrbILkZZ7CvFAhcke1jWlvYFE5RWmLJwMpO
         t4nwDEdKSNv4rDaJmARvtEOFimeuZFq4V2siLywcwJexjfFxeW6nNajv95w6js9sS0QO
         bFepuDxhqsvTjvYsN44TOI3YzPWr70DS7WdQMMu4XE1GuryMWVUWrrGC4aoSFgz10qfl
         y8u8B7/UGL3lG+OGaWropHipixel0L/E6bBtq8lDK5wI5qrh+xg90YcQMka9PAxQsykB
         t/3WpwtTobfW5lxNSypVaJHEq+XVte43EDbt2y7YSnvnwrbhyEYPyysdZQvBzzHwAJfU
         Ec8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/B47bE8TEfIlwi0qudqXOToGhOOwF+9/IKyL/OBYwwM=;
        b=syRgidr6zfZLPAsh2XptulWesF3rhJA/tBUiXr3DKOhQB3wjIG/DZKO8rz+uD6GmWs
         7acAIFVM4ZjDscfTHFC2b1hhGNyyBisNHFsr3oa13oOdTV2Ap9IKPFAc91LJj1fy64vl
         EBpSVECkpTfGMwKnikKGu3+fDIehxp9rhQ8Cu5pLarpBUpfSqllfAYV1afaikeahVj/H
         XnUvSLa3xVaemVMQoLl2LtKumIhifaxH/Gnma+ybxovJ3ukm7+jRJlKWYYe7VGpZI9Lz
         1wkKlg7yo0jlB2l8ICNjNIWYzped/MUDH6hgBJ/PzFZAIncvy0msF1iRPmI5BOplZA0l
         KAkw==
X-Gm-Message-State: AO0yUKWgK0vWI8JvYSh7GwwdsNr5UBbZ1D3ebmyxAK5c8Zj3hnRMOigA
        uFl5uOggOIj7obAIQjhxbuz8BA==
X-Google-Smtp-Source: AK7set/4H2SVEASkO1eQtPPR2W2rsKOI0syaJ8qp8ORtqLlai90YCKXoISxAgAZt/UopwFfDxi5NmA==
X-Received: by 2002:a5d:6182:0:b0:2c5:48bd:d494 with SMTP id j2-20020a5d6182000000b002c548bdd494mr10170683wru.29.1676366838305;
        Tue, 14 Feb 2023 01:27:18 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4b:bef:7edd:1af1])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b002c4061a687bsm12687602wri.31.2023.02.14.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:27:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 0/2] arm64: qcom: add initial support for qcom sa8775p-ride
Date:   Tue, 14 Feb 2023 10:27:11 +0100
Message-Id: <20230214092713.211054-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Bjorn,

I'm resending this because it's been discussed with Qualcomm that we need to
drop the watchdog node from the DT. Please don't apply the previous version.

I've also dropped the patches you already have in your tree so these are the
two remaining.

v3 -> v4:
- drop the watchdog node from DT
- drop the watchdog dt-bindings patch
- drop the patches already in Bjorn's tree
- collect tags

v2 -> v3:
- reorder properties (reg always first, etc.)
- tweak node names
- remove properties filled in by the firmware

v1 -> v2:
- lots of improvements all around the place to make the dts pass dtbs_check
  (with some additional patches fixing bugs in existing dt bindings),
  make dtbs W=1 and checkpatch.pl
- move board-specific properties to the board .dts file
- ordered top-level nodes alphabetically and sub-nodes by the reg property
- fixed licensing
- set #address-cells and #size-cells to <2> in the soc node and update sub-nodes

Bartosz Golaszewski (2):
  dt-bindings: mailbox: qcom-ipcc: document the sa8775p platform
  arm64: dts: qcom: add initial support for qcom sa8775p-ride

 .../bindings/mailbox/qcom-ipcc.yaml           |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |  47 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 805 ++++++++++++++++++
 4 files changed, 854 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p.dtsi

-- 
2.37.2

