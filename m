Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6F65D544
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbjADONe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239547AbjADOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:12:52 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1F624A;
        Wed,  4 Jan 2023 06:12:51 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q190so18054420iod.10;
        Wed, 04 Jan 2023 06:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGDfPcMh2o9V23BmewOoC5pZ8xD/PzamwtTk3JNsF7k=;
        b=oTS8GOu+0AE3ZzWfBR6dXlTD/jm461Ob8GNmglyv2+Q2VLKA3DvOKEOQGNTGaHmh5S
         1+eNFbGzRfz+M3VIlq9/11s13JD8FoBiY3CY9vs8vrZ5iqdpz61yJQhit91vxM0tvqeS
         uaTrcszYCIRAxSBlW8oM18oVSY9XHQf8KR1YhWMl83fYB7kq8VO5M4lZGn7pIJYlGjxh
         OPKBbh2u/0gtr56PRYBCZbdElVklwCXZhDhsC/XghjoWbtN81FKmaqim/A21HxDJy271
         qdK7QjpXj9YUetD9eZRXWkoE9SY2wlxB9zTh41UJWtmruu8GzLaTyQ1lJwrtNkCAvGQh
         B/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGDfPcMh2o9V23BmewOoC5pZ8xD/PzamwtTk3JNsF7k=;
        b=Vo1dIIMM0XgaX0VrAJqBndslWfwsk8I80l7/2fSBSmWIZwjiunC9pyQgmR2RjokusT
         2mmQpOOgN2EZsv1lDvPiSui4pCZ4BTK4M5bnTtRNQOkN7pBeP6sVPfeQFfEjlVQJ8gq6
         V8FIk2kpn9F0sCARBtTcnlmZfWFbrjaZCbHM+B9WX7h5U5G2/j4dPKpG8K1ss/XUchaR
         hN/M5norFXrj8NLDBZ+REW+sSRSshKW3RBoomC8zy5PXnGpPet+KMbWGl4hiZhCa5ig9
         iKm9lMM3MeqmLmy/K+VQk63SycZrPOJdXypq54GNp4cP114YFIchnj6Mn4CXPoQzmvxx
         D0PQ==
X-Gm-Message-State: AFqh2kqJtWaFXrUH8exRGE+G8V4aErg5WaYQUqR6/yVdAdLJSPMVnXb5
        yO5oD5UrJUx09JB0jApNA+dTAhtJaeI=
X-Google-Smtp-Source: AMrXdXul3k0/RgRmpytrVMFtZ+mQRiNXaufDBlXhmVI3E58Mg5yCfGK3Jn1P7HeD6rCOg1wKnmDWXg==
X-Received: by 2002:a5d:8b4b:0:b0:6ee:f9e1:423a with SMTP id c11-20020a5d8b4b000000b006eef9e1423amr31354433iot.11.1672841570492;
        Wed, 04 Jan 2023 06:12:50 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:58ca:a321:54c8:c288])
        by smtp.gmail.com with ESMTPSA id ay28-20020a056638411c00b0038a5af5e831sm11353451jab.100.2023.01.04.06.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:12:50 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Revert "arm64: dts: renesas: Add compatible properties to AR8031 Ethernet PHYs"
Date:   Wed,  4 Jan 2023 08:12:43 -0600
Message-Id: <20230104141245.8407-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104141245.8407-1-aford173@gmail.com>
References: <20230104141245.8407-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 18a2427146bf8a3da8fc7825051d6aadb9c2d8fb.

Due to the part shortage, the AR8031 PHY was replaced with a
Micrel KSZ9131.  Hard-coding the ID of the PHY makes this new
PHY non-operational.  Since previous hardware had shipped,
it's not as simple as just replacing the ID number as it would
break the older hardware.  Since the generic mode can correctly
identify both versions of hardware, it seems safer to revert
this patch.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
index d3fc8ffd5b4c..1eb713530878 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
@@ -59,8 +59,6 @@ &avb {
 	status = "okay";
 
 	phy0: ethernet-phy@0 {
-		compatible = "ethernet-phy-id004d.d074",
-			     "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-- 
2.34.1

