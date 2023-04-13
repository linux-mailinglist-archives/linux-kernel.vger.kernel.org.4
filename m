Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643A06E154E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDMTlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjDMTlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD448A42
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681414841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHh16MFI12gMsfqbehl6umAoFEnRY63CfuAwT9OzHsk=;
        b=bZrxEiEm75MBvPigtPxAp0OViO3BIvxsCN7j56hiRWmv4NRTBa3TOv9wWdSOf56wMac2iP
        Z/FTC0IwGih5cFAWwxHe/PfDsd4kCv5flXX9dIyvPJlKOk9fNOBauVv8rD3U4dhzRQeL9M
        sLOwX1xb3R6bv0u7LoqXMA72rKZiwls=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-jpizK84NOrOgjJEkjP7zbQ-1; Thu, 13 Apr 2023 15:40:40 -0400
X-MC-Unique: jpizK84NOrOgjJEkjP7zbQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1843667dbbbso8032509fac.20
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414839; x=1684006839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHh16MFI12gMsfqbehl6umAoFEnRY63CfuAwT9OzHsk=;
        b=ih09W1/cW2frLczP7nR2bCJQbqt/DCLiRHnZZGIzjm28HxQCzUYCE9k9/1BawCj2C2
         Bt9jRC8PWfB5tUVU+9/5iT4u+cmL486cdBnn6iBbUmNtp3C7a5/ol3IbgeL0uAs+LRuW
         0VvIBvxj2Oro6uVMi8c+OsExgMQ82DO1nzEWArUBqItf81G5dHM2NQNm7rJ9s8v1cvA7
         Gryb+/MsN3UYgiIW5TVdkYkZ0fiIIDhGca2wUiucARJcVEKLBMozXWGAks/x1gimVNzE
         Q1kWDenz75gggDo1mTEueTfsQkuh+Hj7hkUqUlFYRmirX8mmpBktghFY9I0lXcZOq8WY
         /maA==
X-Gm-Message-State: AAQBX9dFhkewUXZoVzPt7A56U7tBFc8LyIFulR/cx7liHuDAVj8Ej6qz
        aAZw/z+5wgAW9jN2e1BoryFd65UJ3/nyWbswu3rChQ/gjTFQzydFBHHwmWxHhERzBhoqqhL0naY
        sAVVXVFw8kjVMG7dXaY9bW9eFE+tTK8RAJjxjMgb09yDD7k/yF/B73SrYjOOAWucPWh4vZLbUpb
        aPzotkuVtl
X-Received: by 2002:a05:6808:4046:b0:389:4ea4:7a59 with SMTP id cz6-20020a056808404600b003894ea47a59mr1472120oib.33.1681414838979;
        Thu, 13 Apr 2023 12:40:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350bWufTE+ePpSscH/Va3pVkErpxbVW3rmbXpnUl6PIFkY+rrCsQ+ppVWMagLa8KFfSBI9GvSpA==
X-Received: by 2002:a05:6808:4046:b0:389:4ea4:7a59 with SMTP id cz6-20020a056808404600b003894ea47a59mr1472106oib.33.1681414838685;
        Thu, 13 Apr 2023 12:40:38 -0700 (PDT)
Received: from halaney-x13s.redhat.com (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id x19-20020a056808145300b003898bec0e01sm966140oiv.17.2023.04.13.12.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:40:38 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sa8155p-adp: Make -cells decimal
Date:   Thu, 13 Apr 2023 14:40:19 -0500
Message-Id: <20230413194020.1077857-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413194020.1077857-1-ahalaney@redhat.com>
References: <20230413194020.1077857-1-ahalaney@redhat.com>
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

The property logically makes sense in decimal, and is the standard used
elsewhere.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v1:
    * New patch (Konrad)

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 029b23198b3a..ac52a8dfeba1 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -353,8 +353,8 @@ &ethernet {
 
 	mdio {
 		compatible = "snps,dwmac-mdio";
-		#address-cells = <0x1>;
-		#size-cells = <0x0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		/* Micrel KSZ9031RNZ PHY */
 		rgmii_phy: phy@7 {
-- 
2.39.2

