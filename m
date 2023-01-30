Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE468158C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjA3PuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbjA3Ptn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B1172F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675093741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRlDyXKPLMeNzgtxy7Fw1k/Ln61yLUxV1SRBoDuWD4Q=;
        b=Wcj5E2UEpndKyB7dxMxsoHY14MoSxA2pkB3JcfkPwZ1zk2BZWzKwZ8eQDL340NARWYOjGX
        J39vKFH8/xTrVPXjfX2+l/pYXVWgLgXSMfWGVU3bMmZRMvrfI8lF1PdSl/B9IB/XUoQzAK
        Bj4kKSvCpMEQVS+lDFKGotZuIlF1Axs=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-508-js981MfuPROiEGaujnmh7g-1; Mon, 30 Jan 2023 10:49:00 -0500
X-MC-Unique: js981MfuPROiEGaujnmh7g-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-15fe7396eb4so4211488fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:49:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRlDyXKPLMeNzgtxy7Fw1k/Ln61yLUxV1SRBoDuWD4Q=;
        b=ifGiQUpOhmDHihv0oofDcwBf8st0lNKns3VXwJ/YW//JnrV7aje53RDeF2Ob+IF3UO
         jwqv2et3cKpAjhMoGpuaInQQ0krRgL1o+SJYr8p24qBpGgINPaKxGM9OMNJm9kwZ/Roz
         qIeRLOthfQphkHgtfaEnWX36mUUzBqraETiZBOCtwcLljwAnVQFXtnTtsQ5o/HBI5Q7T
         yShWrGmltiEyGRIKtQGIkbY0202XbpdIudzkjFjXlWwqugCfgcsvwh40YdwVELDUvghT
         Onahsdh7iBWJBtEcCjcm/yySIuIrPSvfSUx87j+VUwvAS82bWb7SxXF0nRlcQAtntMhS
         Cciw==
X-Gm-Message-State: AFqh2kqh1BqabTOaN4wby+ixl+u1P0eUDBfIwwQq0qb19O29tayYkVTX
        9HyxMy6fZYAzsdec+5FDiBJ3btkx+y7b2tMpWtUt1Fw5vPxnkMJga5KZOo5ZKgTUoeRRAsuzS7d
        1DIx7euWKF8y30MiHE8WyOanf
X-Received: by 2002:a4a:c305:0:b0:49f:8941:ffed with SMTP id c5-20020a4ac305000000b0049f8941ffedmr21754429ooq.9.1675093739562;
        Mon, 30 Jan 2023 07:48:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtF/MHLgvMCX+knJ4UvMho4BjyD1571KGt8hCsvHeghOqHWHjJDyISzjJkMZy6DLoylQR5e1Q==
X-Received: by 2002:a4a:c305:0:b0:49f:8941:ffed with SMTP id c5-20020a4ac305000000b0049f8941ffedmr21754421ooq.9.1675093739348;
        Mon, 30 Jan 2023 07:48:59 -0800 (PST)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id h3-20020a4ad743000000b0051763fef75fsm2137688oot.37.2023.01.30.07.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:48:58 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bmasney@redhat.com, quic_shazhuss@quicinc.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sa8540p-ride: Document i2c busses
Date:   Mon, 30 Jan 2023 09:48:23 -0600
Message-Id: <20230130154823.117542-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130154823.117542-1-ahalaney@redhat.com>
References: <20230130154823.117542-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Changes since v1:
	* Document i2c12 having a max20411 (Shazad)

In v1 I said i2c12 was not connected, that's not true though (I just
have a board schematic which shows it not connected, but it _is_
connected on the SIP/SOM, which I verified with series [0]).

I debated waiting for Bjorn to sort out appropriate label names over at
[0] (and follow suit in a third patch here), but decided to get this
series out again to clean up the current warnings while that's worked
out. Once [0] is resubmitted I'll submit a separate patch to enable the
max20411 on this board as well!

[0] https://lore.kernel.org/linux-arm-msm/20230130035642.GA464800@hu-bjorande-lv.qualcomm.com/

Thanks,
Andrew

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 6ab4b435c49e..8b7555f22528 100644
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
+		/* To Maxim max20411 */
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
2.39.1

