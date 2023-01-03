Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017E065C604
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjACSXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjACSXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:23:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E3613D17
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672770161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dXN+iwTAky/hQnAq9Ze2DnhL71IN/xoRsZsRe2CrJTs=;
        b=M5MMj3IJGA92WwAg3PbS4lAcTQwttTtQQhKUllzsOX9ypmyHEPZ1fcgApLWaHdPoty4Cvv
        1Gc9/Z28Q68Z+0txnoFn+LgA6psTk0vzD7lsmlWUhq6KC8d7DQMuHOui58oa3BN7pyLdWa
        YFDwom0cvSMqGZq5EwcXtho1dDbwFa4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-uZd9k2YZN0qv-Fe1q5a_zw-1; Tue, 03 Jan 2023 13:22:40 -0500
X-MC-Unique: uZd9k2YZN0qv-Fe1q5a_zw-1
Received: by mail-qt1-f197.google.com with SMTP id fp22-20020a05622a509600b003ab920c4c89so6546743qtb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXN+iwTAky/hQnAq9Ze2DnhL71IN/xoRsZsRe2CrJTs=;
        b=nOETtplKBEKFF4v+hQL13MLTaQEzML16aZ4m/UBDD3hNElh/KK8P7EQuECcwqM555L
         JRNCuPupKz4EGLobheeC8IkSCzfnGDypFIkniSXgnnxi3v0BFoQDB8CC98vt0+3Vnz3s
         6vPNjZwa+mseIVA+CKMOaMG490Epl1Tct4wQTi8+XvdoAUmMPDPL3DtpoQVfdNljWXbP
         4AmhC2Yh4SDjPYrzMAGmgHUWuLtMkYeD1rBP6iQkod9EsI4CqDiLHh05rQl9bAoGa3Eo
         AZfRb42OzhM07aI8iv4xcgQoL2hfYDg61FmL0fW4LVuIxLgPD16f1MKDJhluyPpZE++i
         GS9w==
X-Gm-Message-State: AFqh2koiLzCFp5S/mmdo0rnK9eM4mGBgrZTI/X7ZxUEYKsIeG8+447tl
        COqtp2LFcX08O1gVzTpipEmhC9opZyicZKOmhgN4R7IyGAQQRms6l2WIJd0uZ5ZPKhJ4lJNnvMe
        gcXkM6QZAKMiFgdGyHJlCn1nt
X-Received: by 2002:a05:622a:228e:b0:3a8:325:47e with SMTP id ay14-20020a05622a228e00b003a80325047emr66678646qtb.54.1672770159498;
        Tue, 03 Jan 2023 10:22:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXub5NzQ2j/75OxfSInB2hex9yllMZo6Yl0IrtyqbJqH5GfKqe71sEpRa+ROqGOtJ8TGIOM2xQ==
X-Received: by 2002:a05:622a:228e:b0:3a8:325:47e with SMTP id ay14-20020a05622a228e00b003a80325047emr66678630qtb.54.1672770159296;
        Tue, 03 Jan 2023 10:22:39 -0800 (PST)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a450d00b006fba0a389a4sm22819675qkp.88.2023.01.03.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:22:38 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.co
Subject: [PATCH v4 00/10] dts: qcom: sc8280xp: add i2c, spi, and rng nodes
Date:   Tue,  3 Jan 2023 13:22:19 -0500
Message-Id: <20230103182229.37169-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the i2c and spi nodes that are missing on the
sc8280xp platform and cleans up the existing nodes. Since I am already
making changes to sc8280xp.dtsi in this series, I also included a change
to enable the rng node for this platform as well.

Note that this series needs to be applied on top of:
[PATCH v5] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
https://lore.kernel.org/lkml/20221213095922.11649-1-quic_shazhuss@quicinc.com/

Changes from v3 to v4:
- Move the #address-cells and #size-cells properties below the reg
  properties. I also updated the DTS binding examples. (Johan)
- Add missing power-domains property to spi nodes (Johan)
- Collected R-b and T-b tags.
  Steev: You added your T-b to the cover letter of the v3 series. I only
  applied your T-b tag to two of the patches in this version that were
  appicable to your x13s i2c test.
- Introduce patch 9 that adds aliases for i2c4 and i2c21 to x13s and crd
  DTS files

Changes from v2 to v3:
- Reordered rng node in patch 7 so that it's sorted correctly by address
- Since I respun the series, I made Konrad's sort order suggestion to
  the state nodes since I'm making changes here.
- Collected R-b and T-b tags.

Brian Masney (10):
  dt-bindings: qcom,*-geni: move #{address,size}-cells on i2c/spi nodes
  arm64: dts: qcom: sc8280xp: move #{address,size}-cells on i2c nodes
  arm64: dts: qcom: sc8280xp: rename qup2_uart17 to uart17
  arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to i2c21
  arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to i2c4
  arm64: dts: qcom: sc8280xp: add missing i2c nodes
  arm64: dts: qcom: sc8280xp: add missing spi nodes
  arm64: dts: qcom: sa8540p-ride: add i2c nodes
  arm64: dts: qcom: sc8280xp: add aliases for i2c4 and i2c21
  arm64: dts: qcom: sc8280xp: add rng device tree node

 .../bindings/i2c/qcom,i2c-geni-qcom.yaml      |   4 +-
 .../bindings/soc/qcom/qcom,geni-se.yaml       |   4 +-
 .../bindings/spi/qcom,spi-geni-qcom.yaml      |   8 +-
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  12 +-
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts     |  91 ++-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 162 ++--
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 183 ++---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 749 +++++++++++++++++-
 8 files changed, 1022 insertions(+), 191 deletions(-)

-- 
2.39.0

