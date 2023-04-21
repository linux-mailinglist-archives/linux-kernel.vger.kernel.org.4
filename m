Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F16EB339
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjDUU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjDUU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1922D10FA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682110631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHdC3CO7d7h9QJ4WwIQBRA4b+ojZKpdU+4dGZcHHyn8=;
        b=eNhQ1nwu47euN4OrU8fCxy88LZ8TT/dc71LGIPKoiYk41NxLPrprKvZ2Qyu6jXnbxHZ/x3
        wFjNPyyzrvUejx5IbdU9JBb/ldfCYkyWF97g7xAS/xsXu6NAdBBTW0sdV3m8wTpiL+ww6b
        Y/GwnFXX9OgqSvdbmfZ6zG8oMqDhSnQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-LwpPLiYGNTu6a-SDt-_9Jg-1; Fri, 21 Apr 2023 16:57:10 -0400
X-MC-Unique: LwpPLiYGNTu6a-SDt-_9Jg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-54f8fcad732so33503657b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682110629; x=1684702629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHdC3CO7d7h9QJ4WwIQBRA4b+ojZKpdU+4dGZcHHyn8=;
        b=KbFrxX/gednwqs+PIHFi0Z8fzImi86Wt3e+0cAuOVPRn4KA6DEbqD4uwPmxHWws+qF
         kt3HwVCTbh6UkNHpSNd/1polHCcVRZeQC3BRPc64PvEBGMVdbZPv+fX8qynzBSK5i8b/
         InbexxRd2kKVKiDjajFrbKeLUaMUSfb9R9tMPf5UoRTeToVYf4l6MKCE2eV6D/swtKOB
         4ztjR8S8ylC5Vs6RmYUq0akgtII9gCyUqzESKz6FaBz6OzV81OsPrYRQ1FIQCBsC+jb5
         K2gQ7nPP8qd9L5lVzbgMF+btI8rfjrJcw0TVm9VgDhnOKTXu42YrWlrUphitWN8hrw9b
         Lh6w==
X-Gm-Message-State: AAQBX9fDupois1G4HZvNkYTk9+jvFQrUp3njrBsEWxDLsyhW+fw5twyN
        eZ4VWzemySMi90IAMvfrXImANnsZH92gesr78FfG08qvJ9SBFmlhRbRrvcUPRVL5XozSXorC+K9
        9qq3fs9nTijtHp4K12csx2Wo+oYkOkHqQMXkOzfB3XpRI0ztt+WyMMAYQPFoQPNpnUi0NsW/CQ2
        txlSYRDw4v
X-Received: by 2002:a0d:e80e:0:b0:552:9fae:d0b with SMTP id r14-20020a0de80e000000b005529fae0d0bmr2961334ywe.16.1682110629269;
        Fri, 21 Apr 2023 13:57:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350YhmtU533lQoik67y8f8UrJHdl4W7EW+ZwOU08LNuM8hqNta/4muproajIhj5BU+Xb9HkSvqw==
X-Received: by 2002:a0d:e80e:0:b0:552:9fae:d0b with SMTP id r14-20020a0de80e000000b005529fae0d0bmr2961319ywe.16.1682110628977;
        Fri, 21 Apr 2023 13:57:08 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id x67-20020a0dd546000000b0054c0be459dbsm1179999ywd.39.2023.04.21.13.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:57:08 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v3 4/4] arm64: dts: qcom: sa8155p-adp: Move mtl nodes into ethernet node
Date:   Fri, 21 Apr 2023 15:55:12 -0500
Message-Id: <20230421205512.339850-4-ahalaney@redhat.com>
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

The mtl nodes aren't evaluated unless they're under the node with the
compatible. Move them so they're now evaluated in case future patchsets
modify them incorrectly.

An example of this can be seen in the link.

Link: https://lore.kernel.org/linux-arm-msm/20230414145844.wyg6pt623pzqwh5l@halaney-x13s/
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v2:
    * New patch (me, after realizing this on another platform)

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 46 ++++++++++++------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index b65e0203d783..02d04ce877c9 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -47,29 +47,6 @@ vreg_s4a_1p8: smps4 {
 
 		vin-supply = <&vreg_3p3>;
 	};
-
-	mtl_rx_setup: rx-queues-config {
-		snps,rx-queues-to-use = <1>;
-		snps,rx-sched-sp;
-
-		queue0 {
-			snps,dcb-algorithm;
-			snps,map-to-dma-channel = <0x0>;
-			snps,route-up;
-			snps,priority = <0x1>;
-		};
-	};
-
-	mtl_tx_setup: tx-queues-config {
-		snps,tx-queues-to-use = <1>;
-		snps,tx-sched-wrr;
-
-		queue0 {
-			snps,weight = <0x10>;
-			snps,dcb-algorithm;
-			snps,priority = <0x0>;
-		};
-	};
 };
 
 &apps_rsc {
@@ -365,6 +342,29 @@ rgmii_phy: phy@7 {
 			device_type = "ethernet-phy";
 		};
 	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <1>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <1>;
+		snps,tx-sched-wrr;
+
+		queue0 {
+			snps,weight = <0x10>;
+			snps,dcb-algorithm;
+			snps,priority = <0x0>;
+		};
+	};
 };
 
 &qupv3_id_1 {
-- 
2.40.0

