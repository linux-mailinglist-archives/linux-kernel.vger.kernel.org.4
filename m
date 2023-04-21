Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A76EB336
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjDUU57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjDUU5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F207D210E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682110628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0Mtszdjlm4MgVhkShoWxFcn7UkV33phtqGTpiHGGr4=;
        b=LUYvOPhmW8Sc++QZlT3OHZq4Anqy8Hyw9HGK3daLrLtO/oxRXU8nISo21hEGNNYQ9Lz5LF
        i3lawb8Vy922Fp3y1e9DLCJtGo/4GwLGl28p7NWiEwjyr9mCpckkM2+0WwVcrvgr3lFTeu
        id7VoT+yv1VxpZaR2MRHeCxLv56TBNA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-CIYI-8YUO6eLUTJkiznN8Q-1; Fri, 21 Apr 2023 16:57:06 -0400
X-MC-Unique: CIYI-8YUO6eLUTJkiznN8Q-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-54f809d82bcso33640717b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682110626; x=1684702626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Mtszdjlm4MgVhkShoWxFcn7UkV33phtqGTpiHGGr4=;
        b=MEMXLA0MR2l/N+MfCPg/SWonWCuYAZd0865D+peerTzQNgIngC2shFBbZgYlY6u2wI
         A8eCfqEms0Mfam7shODOpXmCZcVvMuR7bm7D4AhIiQtTf+ZcAG2tDsrjPUlf1BaAhVEP
         6GwcmzOEodReaYyenTqnt28yOgfLf3REksYd4ht4UlMtKJdE7phngyIMNDk4Ko/RDabI
         ytz+/RB8wA9C8DnUpo6UbWJ7pGDv7v/RcmnHeNkqBUmFIC9SPLdyQ6uRlTjy45g74+cB
         VA4xC8/C8ELiRq2gKPUmUQ4W+co4hmGsUxA2LL9xsRDVwEm68p9v2NYzn5g5PJx/XAlI
         USVA==
X-Gm-Message-State: AAQBX9fPDliSsHr53OtTPWlncHyvM4OtrZW0lHQ5eftdGaSEwe1N3atx
        UBL/zkgbY//kfPmPx+V8+dvkmfu+YuDOdZmyjphDKY0V7zCECZMxLtmYQvJ8qRapg3ipdXfPziY
        nvoONVa1Dy8KioVKIOXv+3Zk5eQlfJmBEch3rEoVOd1JkfcjQGhBD+vr9L3Kt3TlPVfQ33oip2/
        M8qs2cuCXx
X-Received: by 2002:a81:6c44:0:b0:556:1182:958a with SMTP id h65-20020a816c44000000b005561182958amr2790573ywc.24.1682110626014;
        Fri, 21 Apr 2023 13:57:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350YQDiTLclCcBihczFE91vxXgq6wBX1hK5ylVIS+7QncrEBEYfPYI8ILhGObrfq57VG337mb4w==
X-Received: by 2002:a81:6c44:0:b0:556:1182:958a with SMTP id h65-20020a816c44000000b005561182958amr2790554ywc.24.1682110625659;
        Fri, 21 Apr 2023 13:57:05 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id x67-20020a0dd546000000b0054c0be459dbsm1179999ywd.39.2023.04.21.13.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:57:05 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v3 3/4] arm64: dts: qcom: sa8155p-adp: Remove unneeded rgmii_phy information
Date:   Fri, 21 Apr 2023 15:55:11 -0500
Message-Id: <20230421205512.339850-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421205512.339850-1-ahalaney@redhat.com>
References: <20230421205512.339850-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using interrupts-extended already indicates what the interrupt-parent
is, so drop the explicit interrupt-parent.

The comment about this being the phy-intr is not helpful either, since
this is the only interrupt in the phy node.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v2:
    * Collect tags
Changes since v1:
    * New patch (Konrad)

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index ac52a8dfeba1..b65e0203d783 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -361,8 +361,7 @@ rgmii_phy: phy@7 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0x7>;
 
-			interrupt-parent = <&tlmm>;
-			interrupts-extended = <&tlmm 124 IRQ_TYPE_EDGE_FALLING>; /* phy intr */
+			interrupts-extended = <&tlmm 124 IRQ_TYPE_EDGE_FALLING>;
 			device_type = "ethernet-phy";
 		};
 	};
-- 
2.40.0

