Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888DE67A29E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjAXTZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjAXTZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:25:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E744ED03
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674588266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cO6b+dBIzWhUJ0Ot0Nn16J8i3J9gyi8QLbDA6Oroy1E=;
        b=DeAsX+n/63HqrBdA5mZeRMilh6iRwA8XHa+0Ks7zxzyEhFNNdEYFwnj9PJr0mGx0Y4Kg5r
        2cF59erv58VbhFF2+1kJ9cHE4arrWP62TgL7MAV32S/eWgE+VF8Bnlyymp8f929p9VG/iK
        Ro6rxTaMrQo4o5sT+bE4oEIYvGWUpfY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-6ThUOcfsMS6ARbZjCtz_Jw-1; Tue, 24 Jan 2023 14:24:22 -0500
X-MC-Unique: 6ThUOcfsMS6ARbZjCtz_Jw-1
Received: by mail-ot1-f71.google.com with SMTP id q9-20020a056830018900b006865e3f13c4so8192596ota.23
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO6b+dBIzWhUJ0Ot0Nn16J8i3J9gyi8QLbDA6Oroy1E=;
        b=sBMIpsJFpVGPgZddxm2EB+M0kMkdAX7ZaNxKDwEBNuKyLI3qOfjw/teIL6nUckqpXC
         Fj1lATgnJCEnHebcLBUHwQ6fIRghqGP4yiPJyI/qY8kpx9v6l6koobNjhmQoV8Y9cNaK
         wXERCyUJeGnWj9yQvfMihs3rASTodXO0pGYQXg1t52/dli/tD3u5MFX7cZgyiwgWdmvt
         NrmFMvaCji+KDZeUBSgILp5g6b5VZ2pgcSdAvW64C8QAG5M9MDMIqW7OS+otMtZ0ZO9W
         5w0Rttx7ap/o4JekomWtKcsU/gnuie8tueRDxWxfvTly68EvJHnbknyrnSnLMSApS3wC
         6OyA==
X-Gm-Message-State: AFqh2kouKy7t+c5x1RTBJLExShdOssh35F6UJ36qfpfzTSxEm01u91CZ
        5DccNQoc1FdgJzW+5D9Kf8gJfGUvwA0iFtLLD0ZUYCQDcisLHXv3YFui/sSaVHqN8uiI0xDJcEm
        VJQUCqLyz7frCPeEVLwyBP12p
X-Received: by 2002:a05:6808:300e:b0:364:f962:afd1 with SMTP id ay14-20020a056808300e00b00364f962afd1mr15578562oib.56.1674588262029;
        Tue, 24 Jan 2023 11:24:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtXJqXdze5ERKsi/TEq4I3Qn8MLneaaxsNGXIqSS/Q8exKfwqcnDFs/GLX78SPVbd3lckA+0A==
X-Received: by 2002:a05:6808:300e:b0:364:f962:afd1 with SMTP id ay14-20020a056808300e00b00364f962afd1mr15578541oib.56.1674588261773;
        Tue, 24 Jan 2023 11:24:21 -0800 (PST)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id r21-20020a056808211500b0036e3bb67a20sm1388024oiw.38.2023.01.24.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:24:21 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bmasney@redhat.com, quic_shazhuss@quicinc.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 2/2] arm64: dts: qcom: sa8540p-ride: Document i2c busses
Date:   Tue, 24 Jan 2023 13:23:51 -0600
Message-Id: <20230124192351.695838-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124192351.695838-1-ahalaney@redhat.com>
References: <20230124192351.695838-1-ahalaney@redhat.com>
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

It isn't obvious in the current devicetree what is connected. Go ahead
and document what's on the other end.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Not sure if this sort of patch is actually welcomed or not but I went
through this exercise (for the prior patch) and thought it might be
useful to document.

Shazad, this also highlights (unless I misread things) that i2c12 has no
use for us, right? If agreed I can remove it but sorting through the
lore links that provided all this it seems like at the time it was
desired to be added.

Thanks,
Andrew

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index cb9fbdeb5a9e..3478ab91fe73 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -317,6 +317,7 @@ &xo_board_clk {
 
 &tlmm {
 	i2c0_default: i2c0-default-state {
+		/* To USB7002T-I/KDXVA0 USB hub (SIP1 only) */
 		pins = "gpio135", "gpio136";
 		function = "qup0";
 		drive-strength = <2>;
@@ -324,6 +325,7 @@ i2c0_default: i2c0-default-state {
 	};
 
 	i2c1_default: i2c1-default-state {
+		/* To PM40028B-F3EI PCIe switch */
 		pins = "gpio158", "gpio159";
 		function = "qup1";
 		drive-strength = <2>;
@@ -331,6 +333,7 @@ i2c1_default: i2c1-default-state {
 	};
 
 	i2c12_default: i2c12-default-state {
+		/* Not connected */
 		pins = "gpio0", "gpio1";
 		function = "qup12";
 		drive-strength = <2>;
@@ -338,6 +341,7 @@ i2c12_default: i2c12-default-state {
 	};
 
 	i2c15_default: i2c15-default-state {
+		/* To display connector (SIP1 only) */
 		pins = "gpio36", "gpio37";
 		function = "qup15";
 		drive-strength = <2>;
@@ -345,6 +349,7 @@ i2c15_default: i2c15-default-state {
 	};
 
 	i2c18_default: i2c18-default-state {
+		/* To ASM330LHH IMU (SIP1 only) */
 		pins = "gpio66", "gpio67";
 		function = "qup18";
 		drive-strength = <2>;
-- 
2.39.0

