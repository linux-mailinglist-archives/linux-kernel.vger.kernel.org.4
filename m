Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9022C6807C5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjA3Iso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbjA3Ism (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:48:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E5912F3D;
        Mon, 30 Jan 2023 00:48:05 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso10376267pjb.4;
        Mon, 30 Jan 2023 00:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN176PLvjJF0nSpMtEIYwjcbJii9Pi8z010fzWsc/60=;
        b=cXscAbh4RSxdbroBR42HnHiwk8gyb6/G0Apxu4SW9Jmzw5WVnzUvlSDjFBYI+6lTLg
         GUG6F2Uh6UBESCc7yA5ZWTy7WHrPB1j02p2honxyrfZVdEwlSmsFWYFNXnPGsuKekclY
         irbwu4Fl6EMnyxScskWMBSWOBajRyNf0zWoeqSSWHHkADM1JxzJBkpHVA2ZQpqavy3MC
         zt1sFhh1Ff4yVJ67H4Q2wCtWN1j/PWhxFHAcXiAtpbGbKry3hGMjgUyUaSI94INbL2mQ
         k1JZHOE+qHuz/19Tp3AxxN62cLUTQqD7TkfM4K8NlXrGvo6xQ18Fpz6eKPaISDl+ERsm
         zQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN176PLvjJF0nSpMtEIYwjcbJii9Pi8z010fzWsc/60=;
        b=bPcEesBZRXBJ7j+y5bKxMfW45du43aoZi2vYase5EI9bTyEFG5vUJIFJcL719C96dP
         MwjzUd1vq2NRGI+ih/YKqb0cowQ0zCdeVEfmDrjIGhKO6o+yGsiU91xfibpUAs8WU+Su
         3sEuukEVu7pyMj6USbbcsltxfp1Q0iFzNAjVlODo720EGizYUJoonmfST+Hroqjmt/ZC
         EQxCKznLUUs2Jdc+OWJ4GAQJEgPbaAGg2RiMC5mqx4TDWwPeT9DcIEhF0stkGGhoSEeu
         vtFqryg9paemEWYrSEWl2dyq1gnEr3r7XyThKMX7FN4ykz0au3mblw0TnJXxJpdvqtQF
         oo/g==
X-Gm-Message-State: AO0yUKW/qJhtvoNiV0F7j/Y6wuKcah6vrvvUDX/5pkNBVC55ENvJM8Xq
        rbnOR4uSsjv3ekmCiPoDqsI=
X-Google-Smtp-Source: AK7set/vioIUEgQdnlPNA7bRxAloD9WEu/M5QxMbbZIHlOYs9+i/NPVX2D7Lmax2DyrWZbiZ6Wb05w==
X-Received: by 2002:a17:902:e312:b0:195:efa7:d54e with SMTP id q18-20020a170902e31200b00195efa7d54emr6247255plc.12.1675068484622;
        Mon, 30 Jan 2023 00:48:04 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id ix1-20020a170902f80100b00192d9258512sm7205284plb.154.2023.01.30.00.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 00:48:04 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v5 1/4] ARM: dts: amlogic: Drop superfluous dr_mode in usb node on odroid C1
Date:   Mon, 30 Jan 2023 08:47:40 +0000
Message-Id: <20230130084744.2539-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130084744.2539-1-linux.amoon@gmail.com>
References: <20230130084744.2539-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop superfluous dr_mode="host" as it is the default in meson.dtsi

Fixes: 3325f3e4534c ("ARM: dts: amlogic: Used onboard usb hub reset to enable usb hub")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v5: none
v4: neww patch
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 941682844faf..1097b35b7a49 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -368,7 +368,6 @@ &usb1_phy {
 };
 
 &usb1 {
-	dr_mode = "host";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-- 
2.38.1

