Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C591D6EB331
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjDUU5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjDUU5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCF31FD9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682110622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCHyO7KsVFQpse/HOUPR50ds379wRgjHgpb+I1FLJjs=;
        b=czaZ2FTbPjm0520ZkVvBFC5UO0aeOjMwfD7c1uvOW+Tndg12m6/NSyJyLtw8/3j5qhIXhr
        PqO8pWh7VJsb8Kj4XW07BmzrjqD7HQEDMvLB543+GR1Zg7gph3S9tRG7rnWCTZ2wFnhAQD
        zNxq6r0CGydAqyXBJkQHqCoqG5rM1hA=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-SQ98A6jPOMmZG5azlLdVOA-1; Fri, 21 Apr 2023 16:57:01 -0400
X-MC-Unique: SQ98A6jPOMmZG5azlLdVOA-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-b8f34ed571bso3724671276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682110620; x=1684702620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCHyO7KsVFQpse/HOUPR50ds379wRgjHgpb+I1FLJjs=;
        b=MhObsBmoKUEh50QmMPYsPJSorr/ezsYPkmKE2KFeNYbgiw0TuF7c0izOYni+jl1eX6
         BCW9e/3pSSkJjHMnzodVGQQO4jWyEuL1nZJKwqjm+y0SeaYAccw2I0lFtxR0piBQ/bw0
         UU3yWc0fnvGZGTK0E2JD56APlvZ0VxwRQTZ2Ko2hq/Auanvrwh64Qty90fP16I9sRxPh
         mARPmZT7Sru8RABXkVNUdgUeyDDm3tvoLxGgV/GsRNkU+ERl4ljbsYaLbnKotq0G4KRL
         PnAW6zswjI/LashJQf02Uk9SJurbQ/77L8Zc3vra3+G9BuZ1nyvSS0ABrIJCklV1wHwl
         PAZQ==
X-Gm-Message-State: AAQBX9dhnGsn/QE/vSHw6L+z8+aFczgnzFcRbEQnop6pdj2WQRoPMUrE
        lS+OkuwvXpMi6hnWnZQ1TeebmT6XA4JaeCKVYPMTF0LJ7SRxpIF4Ghsnp7NLXk1xUbSqdtf6th6
        wqWL7p0IdJcTllaVLxc+X18Rk5HjhbxFe7TbMhX5xKXeYIXy6IuX9uV5dnPGcGV06ALOiKaf/yU
        ui4gw6dm5U
X-Received: by 2002:a25:ad1e:0:b0:b97:b56e:8db6 with SMTP id y30-20020a25ad1e000000b00b97b56e8db6mr3556718ybi.60.1682110620321;
        Fri, 21 Apr 2023 13:57:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4rqY6e3Xy/x6/yshw27j9TDzxWo+pJ+Kpzmmw6FsdnANP5euaf+uvyWc6Ge9omHanCEvu0Q==
X-Received: by 2002:a25:ad1e:0:b0:b97:b56e:8db6 with SMTP id y30-20020a25ad1e000000b00b97b56e8db6mr3556699ybi.60.1682110619973;
        Fri, 21 Apr 2023 13:56:59 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id x67-20020a0dd546000000b0054c0be459dbsm1179999ywd.39.2023.04.21.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:56:59 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v3 2/4] arm64: dts: qcom: sa8155p-adp: Make -cells decimal
Date:   Fri, 21 Apr 2023 15:55:10 -0500
Message-Id: <20230421205512.339850-2-ahalaney@redhat.com>
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

The property logically makes sense in decimal, and is the standard used
elsewhere.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v2:
    * Collect tags
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
2.40.0

