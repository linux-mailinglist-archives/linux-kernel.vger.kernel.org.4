Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4356526F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiLTT36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiLTT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE56F1A391
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671564547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3YLjYErwg7EvBoz0cMAo1uE15YEC6M/l/3SjEzl4Lqc=;
        b=J2edcaV6n159UbXAXWTam2RPml8OT1DiZ+h76fqA3rrcyR0NEeibiyVzoYwm68ncApdSaT
        19TtP07Os56wOKbg8A4TIJeK/3rEx0mE/gUdfV0czb0MpTslzyH32MZXSPecTM4ShT45I0
        13lIQH1TgM9DlbLbfPwzQZ+Z18Kod5o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-Z0pOIvnhPEyqWWHM-cOO4A-1; Tue, 20 Dec 2022 14:29:03 -0500
X-MC-Unique: Z0pOIvnhPEyqWWHM-cOO4A-1
Received: by mail-qk1-f199.google.com with SMTP id bj4-20020a05620a190400b006fc7c5d454cso10051657qkb.14
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YLjYErwg7EvBoz0cMAo1uE15YEC6M/l/3SjEzl4Lqc=;
        b=DCxnWEANP7drAKItEDmYYWgX+ic4BbqjEeqlmxdiAoiMJhwPGTZjaB4ionGZ5f3NlK
         8u8XhTaq8goAJSuTL1g7DSAqocIwVGDr0AaBEUkIKdf4/38pJaodzJmAs74u6GtVdVJ1
         yGLe5Jh3EEzlfhFMUrWCom0k7b2539V1v2heAaJxjbDn3fFHxMk0YCr5cHRE4wIWb0BA
         rYk8pEaLZUN1DNFSYRcFmw7Fp3L29qi+1Ezs8hfs1/jvXksYwmenVAxrK026B2jt3anK
         O3gc9vjmS/MVPuR2bP1iOsfVh0d3v4qR/u7KuizAZZfQs+gloxPlMiYr9qv1jHiKivEJ
         0bkg==
X-Gm-Message-State: ANoB5plp//mkC6wTIGcOWs1Mw57qVi4Efu+ZBD1hRb1YNfKUcz7ywJAk
        t9+C3/kqnq514+z+S7fGX0ypjrc+nGyv+3Dmo6MDGxO6b2ym3qhZnfFwnEbU57UXZ7S2X5sBmMZ
        zkI3x3hxs28kzjNbV0CeuS6FG
X-Received: by 2002:ac8:5196:0:b0:3a8:2ccb:f55d with SMTP id c22-20020ac85196000000b003a82ccbf55dmr33658251qtn.33.1671564542752;
        Tue, 20 Dec 2022 11:29:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6pwikIa2ZHDhIzurqur8k4+IJVtBcz5T2noYSvSQJEBGCbtOgyvU+eSZ0sdDbpJLmYpUZt7w==
X-Received: by 2002:ac8:5196:0:b0:3a8:2ccb:f55d with SMTP id c22-20020ac85196000000b003a82ccbf55dmr33658230qtn.33.1671564542469;
        Tue, 20 Dec 2022 11:29:02 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id gd15-20020a05622a5c0f00b003a82ca4e81csm744348qtb.80.2022.12.20.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:29:01 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v3 0/7] dts: qcom: sc8280xp: add i2c, spi, and rng nodes
Date:   Tue, 20 Dec 2022 14:28:47 -0500
Message-Id: <20221220192854.521647-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
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
sc8280xp platform. Since I am already making changes to sc8280xp.dtsi
in this series, I also included a change to enable the rng node for this
platform as well.

The first three patches in this series are new in v2 and rename one node
at a time to try to make the review easier. Each patch has a changelog.

Note that this series needs to be applied on top of:
[PATCH v5] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
https://lore.kernel.org/lkml/20221213095922.11649-1-quic_shazhuss@quicinc.com/

Changes from v2 to v3:
- Reordered rng node in patch 7 so that it's sorted correctly by address
- Since I respun the series, I made Konrad's sort order suggestion to
  the state nodes since I'm making changes here.
- Collected R-b and T-b tags.

Brian Masney (7):
  arm64: dts: qcom: sc8280xp: rename qup2_uart17 to uart17
  arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to i2c21
  arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to i2c4
  arm64: dts: qcom: sc8280xp: add missing i2c nodes
  arm64: dts: qcom: sc8280xp: add missing spi nodes
  arm64: dts: qcom: sa8540p-ride: add i2c nodes
  arm64: dts: qcom: sc8280xp: add rng device tree node

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  12 +-
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts     |  91 ++-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 160 ++--
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 178 ++---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 725 +++++++++++++++++-
 5 files changed, 983 insertions(+), 183 deletions(-)

-- 
2.38.1

