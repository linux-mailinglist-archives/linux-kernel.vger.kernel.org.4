Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B821267A29A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjAXTZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjAXTZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E1F4DCD9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674588257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4WB4RVNTtSVsWxg/OWT04rDFXeCGeyIjYVVHkWC7fDo=;
        b=azfhh8mNktYLYOagdLG9L+N+ccBDjJ1WMEH08xLVANBBG9LIQCJUrH6Z7jwYhcSQPX8nVv
        Hz358VR2dDb6TxtRwqvb22c6HDzodAm3Bg1RdmSAjZLnBsDbkBcfUBXM1BndqShjJn22gA
        yjVC4q4K4Zbi0DFx0x4soG9r89pt3rg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-fAzV8nvJOL61M3SWs_CrPw-1; Tue, 24 Jan 2023 14:24:15 -0500
X-MC-Unique: fAzV8nvJOL61M3SWs_CrPw-1
Received: by mail-ot1-f72.google.com with SMTP id by2-20020a056830608200b00683e3e829d5so8170133otb.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WB4RVNTtSVsWxg/OWT04rDFXeCGeyIjYVVHkWC7fDo=;
        b=oP0cr8ZxCB2psjojf8/EErx7Z0ZtBODSgzUFIqXYMAItZYQ4Wu17UG/bRq8tcLCX5N
         8gbPUtVfTQHYBW91xcuy2Ca6gaHFHZ9Si0UxY6CZ6EVr3BigHOjdRBTr0W5QXYbZRvuk
         BoGWKlkLaXd+ddqNAFep3WFmTVOQ6VTdVW4b6K2bl2kyYn6yUWwDVFtjlo8RpYod4OTH
         IjkELCKbgstkxCbD8OwTpvNEkrY+owHa+UBproDc8ZEIgpIgjmuNasdBlpycTeKpQWrG
         q4tn2Eu7SIrkutsBQOCMhRhGrM/h1RR4rjhMe32nolWq7MsLKrrolRuD6J/ATQS+ksxo
         xxsg==
X-Gm-Message-State: AFqh2kpdJ3eRpDwj+gtPIdLT76r4CSym0e9EFmVx9+0qGq73mScoWYkr
        Fm1pw98tz47uAR/vuiD2x+PbWn5t0rDADue2Mc3j+7sNP+DqYme5nhKCSTZer7F7p0wqPelUIjX
        Uv8wrET4J5WJoJ6/GICWycUpP
X-Received: by 2002:aca:5c02:0:b0:360:d307:c23c with SMTP id q2-20020aca5c02000000b00360d307c23cmr22861283oib.25.1674588254901;
        Tue, 24 Jan 2023 11:24:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsog8kKzcxuE4ReEeDYYDwpVwYcFmeuMgO4j1ffGvei1d7DVnAfGxHfb0us4boOewGQ1yPGEA==
X-Received: by 2002:aca:5c02:0:b0:360:d307:c23c with SMTP id q2-20020aca5c02000000b00360d307c23cmr22861275oib.25.1674588254579;
        Tue, 24 Jan 2023 11:24:14 -0800 (PST)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id r21-20020a056808211500b0036e3bb67a20sm1388024oiw.38.2023.01.24.11.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:24:14 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bmasney@redhat.com, quic_shazhuss@quicinc.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 1/2] arm64: dts: qcom: sa8540p-ride: Fix some i2c pinctrl settings
Date:   Tue, 24 Jan 2023 13:23:50 -0600
Message-Id: <20230124192351.695838-1-ahalaney@redhat.com>
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

Some of the pinctrl groups were invalid for the selected pins. Select
the proper qup group to fix these warnings:

[    6.523566] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio135" for function "qup15"
[    6.535042] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio136" for function "qup15"
[    6.597536] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio158" for function "qup15"
[    6.597544] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio159" for function "qup15"
[    6.597991] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio0" for function "qup15"
[    6.597996] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio1" for function "qup15"

Fixes: e073899ec3e1 ("arm64: dts: qcom: sa8540p-ride: add i2c nodes")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index eacc1764255b..cb9fbdeb5a9e 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -318,21 +318,21 @@ &xo_board_clk {
 &tlmm {
 	i2c0_default: i2c0-default-state {
 		pins = "gpio135", "gpio136";
-		function = "qup15";
+		function = "qup0";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
 
 	i2c1_default: i2c1-default-state {
 		pins = "gpio158", "gpio159";
-		function = "qup15";
+		function = "qup1";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
 
 	i2c12_default: i2c12-default-state {
 		pins = "gpio0", "gpio1";
-		function = "qup15";
+		function = "qup12";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
-- 
2.39.0

