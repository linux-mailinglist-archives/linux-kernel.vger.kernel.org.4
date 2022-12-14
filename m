Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E064CEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiLNRMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiLNRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:12:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FE826568
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671037919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KGReCTY92sW4eCJTIrgAB3lo0my0hNp6y4ogvcT9V4A=;
        b=biYjYjX/oXeQGQ+/GsXMZ+6dPCEzd5dP2MTQjpleUhTJpF3bwwuD/TuPaYkWcBP8G4Y8hn
        Ga/PsfU6O+Ka0+GozFy8Vkyoky9tpg6rLLc/D9QacRPCqFjL6e2Uok3asCWJcsXLcA01N0
        P3VvJOklSvL5NM0cE//9r5lXlshCyoo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-mr0WbqxUPg6BeBrussbQrQ-1; Wed, 14 Dec 2022 12:11:58 -0500
X-MC-Unique: mr0WbqxUPg6BeBrussbQrQ-1
Received: by mail-yb1-f197.google.com with SMTP id v195-20020a252fcc000000b007125383fe0dso377200ybv.23
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGReCTY92sW4eCJTIrgAB3lo0my0hNp6y4ogvcT9V4A=;
        b=jl543MiM8xr0Iz8wGmQnmRfH4xGXzcZiCLrju249BoP52ZoR3OeWgjq85x3VGQsDfr
         ecFMYPV+Uw/mHmNETujm4304CB+kmcYcVAfvRrw9z3zuhj4lZUcHRNNIdt7cQbSIomnb
         epGrCLZGkUvSTdII12EIQXSnkXaaYEhl7b3VXvXWvXyK6SPnEQH3hj1ylLlXyD6437a0
         Us7LZ07yGRrsjjF9PF2uTCoCQc6RJ6HRjRKyR4tUetaIaxoh540P64Tgm2xAJ4PmqVPx
         8NANkuOnouMmIq9unPn/BXJs1K3U7nlPAqTr5/TtDu+XFGeoBnaFI867BcUqOko3D1vL
         EPwg==
X-Gm-Message-State: ANoB5pnB4ACa6e4px4LeUMMnGI4lnHWccnIfHw0fipFn1EAPszp+tbml
        Q87tisO2F3VsX4rl8TBdCg5BJ6/FZVB8ZezIcJpzNFY8TYIAJwDN46tXhyXJWl9DtjdSdEZ1So7
        5czeJi/QG7H1ErQBTVw+IJ40h
X-Received: by 2002:a05:7500:5d87:b0:ec:6820:4e82 with SMTP id fg7-20020a0575005d8700b000ec68204e82mr2227487gab.73.1671037917680;
        Wed, 14 Dec 2022 09:11:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6PqYOzBOifnm/ejg1UfiWKL6kNn2wSa/oOIe30mlxLcjjHX/pwGMHebi3pueMk8BXNZ8aRwQ==
X-Received: by 2002:a05:7500:5d87:b0:ec:6820:4e82 with SMTP id fg7-20020a0575005d8700b000ec68204e82mr2227448gab.73.1671037917276;
        Wed, 14 Dec 2022 09:11:57 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t30-20020a37ea1e000000b006eef13ef4c8sm10305477qkj.94.2022.12.14.09.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:11:56 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v2 0/7] dts: qcom: sc8280xp: add i2c, spi, and rng nodes
Date:   Wed, 14 Dec 2022 12:11:38 -0500
Message-Id: <20221214171145.2913557-1-bmasney@redhat.com>
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
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 162 ++--
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 178 ++---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 725 +++++++++++++++++-
 5 files changed, 985 insertions(+), 183 deletions(-)

-- 
2.38.1

