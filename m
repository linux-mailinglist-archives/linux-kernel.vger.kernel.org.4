Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3DF6E1553
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDMTmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMTmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654E8A4F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681414889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pe0/oi4k+3plRUDjjra5Jf/XI2sf8St247Sf5O8j+8g=;
        b=K4a2WduOJ0U5HM/GwlKgiDV+pwL7xXdFRrO2kTpX2h/fDbfGIiQcXihfVFtO8nFyIyikw2
        ZvDK8oeIQNsp7GUn+Xu/4eGdX7Gv1O7Td1BUW4N6zrpWRBZuy0BsWMkQoaCozAK9L+OV6c
        Ksq1c4VXOvnZpaHs7hj/pplJuA8+Etg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-KgCRLyrHM9qnOzuUPpYaZw-1; Thu, 13 Apr 2023 15:41:27 -0400
X-MC-Unique: KgCRLyrHM9qnOzuUPpYaZw-1
Received: by mail-ot1-f71.google.com with SMTP id t23-20020a9d66d7000000b0069f913914d8so3985354otm.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414887; x=1684006887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe0/oi4k+3plRUDjjra5Jf/XI2sf8St247Sf5O8j+8g=;
        b=A1cZL9cEYrWEJVw3Zo2QAArdhSe7UhW10lQg7MQoDFaLE3jXIEg/CHm1HE3CxVOM7E
         n7gLOaYDR5/LCol0JdBR980AV6WTC0CvVZI4qvT9x63vBMhDad9i4vNrl3lkCqRIYzNF
         katP7+ghaFEeBTFeTBpYjte30g6NdzAU855IoQ+XK4KXrf0iAspSZdOqDm6+D6wxjuk7
         qv53v7pu+SRXirExBwgKxr99/CoDZg8FdMpcLX5hnCS8h2k1mjiM28E3v0SsFl1YyLCd
         EGosJeHnE3W6QyUQbREKRTwT7LglHe9/hgjFuWLRv/upSrloe1AB22XHBtK5B4V1e6Vw
         RIvg==
X-Gm-Message-State: AAQBX9faytDdy0W+8JcuCO08E14RQCG1hd1g8ELXfwUFhZw52yzbQ3Eq
        MkO7tE/CNkidSPsKvO6qQJxP5BT+1VvUwafwLVYdBzzjbcSxO1CoCnQkDdqX9ig9V+i7YPgyrnt
        KLFQRa3v51aE387iYNy0GpHxI9l/wSmp0O+CaysrC7pbLiq1btxyIrjp3UZGWLPpVjTxoXJXB1u
        okBiZt0Lbg
X-Received: by 2002:a05:6808:9a2:b0:377:f784:3332 with SMTP id e2-20020a05680809a200b00377f7843332mr1567420oig.24.1681414886790;
        Thu, 13 Apr 2023 12:41:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350YlwdBnAy6xihkKJw9Nntu9FJ2LoTnC1J6rgKBnqrGWtgp/R0SrzSgYs1pLXe/uellQrAs7aw==
X-Received: by 2002:a05:6808:9a2:b0:377:f784:3332 with SMTP id e2-20020a05680809a200b00377f7843332mr1567402oig.24.1681414886483;
        Thu, 13 Apr 2023 12:41:26 -0700 (PDT)
Received: from halaney-x13s.redhat.com (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id x19-20020a056808145300b003898bec0e01sm966140oiv.17.2023.04.13.12.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:41:26 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sa8155p-adp: Remove unneeded rgmii_phy information
Date:   Thu, 13 Apr 2023 14:40:21 -0500
Message-Id: <20230413194020.1077857-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413194020.1077857-1-ahalaney@redhat.com>
References: <20230413194020.1077857-1-ahalaney@redhat.com>
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

Using interrupts-extended already indicates what the interrupt-parent
is, so drop the explicit interrupt-parent.

The comment about this being the phy-intr is not helpful either, since
this is the only interrupt in the phy node.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

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
2.39.2

