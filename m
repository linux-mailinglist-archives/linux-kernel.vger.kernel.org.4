Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52C86F39C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjEAV01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjEAV0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F426212E
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682976330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8n1iKzbSEbcRTyERJXwfTcGMwG21ns2eb1EhMK8ImtQ=;
        b=X6QwbJE+EqWM/j3iF4hhv3bRBePhos7xWntNPdzLe4dQSd5ZEU+5k2ycHZ/dS+29hiysZY
        d9qe6Pt9tUR7BVeKBuxJl7Lum5rr9c9+HfJhWuQy6UUSg5yLK6618c2aVWAFlFQkDf5CqD
        GAdQNW8PqmvuzjMm61+4HGZSpHQFvG8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-SQW-zLymPpCi3X7pbIumlw-1; Mon, 01 May 2023 17:25:29 -0400
X-MC-Unique: SQW-zLymPpCi3X7pbIumlw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-38d6100e2e8so503301b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 14:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682976328; x=1685568328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n1iKzbSEbcRTyERJXwfTcGMwG21ns2eb1EhMK8ImtQ=;
        b=K1Ahq2DdXmgjDld71AiTp2h+0T3vnRTV10F6ekB9kuqyeksp6Y1RUyNJiERbX46IBc
         swEEUSYJyRcvtKmZhNsa8x9EaMcrhiXxmD2G9lpQENUlFUVIsi9uEW47Od7d1jHwzV6t
         53r5MLEHYd4wIY4RVzF5VO2KIGKany3eyOXc4S0ExzDwdvIz9ZAQF1/ALyD8K3L1G52y
         CBmy2FpNAojxeVRSF7MUbRMK2zkmAWWIhOINlw0J9vtDgZbSs+PjudVZI1EotDSVe2on
         F6lAAaSqr8WqU0FeGPQTL9cv40pdlCipgLH5mSY+caZzVcfF6HkcTydS1W3fA9jnLdCj
         y26A==
X-Gm-Message-State: AC+VfDz4RDQQwmv8NrfGfl4vUnsJ4WlrJ6fD9aPIISDPZNvzI/MWTHhW
        TlCRwzaEPKUvVlHAs3MyLoWgySsRpbpHCgiPSm/AK8qi6mP0sXBtm/VRrkLIpKRyHLz1iqG8vcx
        Oeff6H09TfMrQA3YpPW7T7siXYjmZTXo7sVIa6dL6+ULi7dm+CC8OPHFAAEVKeUQnVa1Erevdnl
        16cOUC7GWX
X-Received: by 2002:a05:6808:3096:b0:390:983c:4ab1 with SMTP id bl22-20020a056808309600b00390983c4ab1mr6117866oib.42.1682976328518;
        Mon, 01 May 2023 14:25:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xKd0hSXYgwrrx7dYRkQ/OFyeE0kBY0kJvUuw2acvC3o4uOA025xxiX27bG2NBLyZMIKhc7g==
X-Received: by 2002:a05:6808:3096:b0:390:983c:4ab1 with SMTP id bl22-20020a056808309600b00390983c4ab1mr6117841oib.42.1682976327429;
        Mon, 01 May 2023 14:25:27 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id q5-20020acac005000000b0038756901d1esm11911385oif.35.2023.05.01.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 14:25:27 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v4 3/4] arm64: dts: qcom: sa8155p-adp: Remove unneeded rgmii_phy information
Date:   Mon,  1 May 2023 16:24:45 -0500
Message-Id: <20230501212446.2570364-4-ahalaney@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501212446.2570364-1-ahalaney@redhat.com>
References: <20230501212446.2570364-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes since v3:
    * None
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

