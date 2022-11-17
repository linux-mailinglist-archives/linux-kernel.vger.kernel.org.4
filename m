Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D759E62D877
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiKQKwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiKQKwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:52:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE3715FCC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668682231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gjXLVyb6zwFPJe/OWlCp49ZVjP/sJNSDFeUY35Ol3A8=;
        b=W6q/bekgWbQSZm44C3hxfB2kt2AUHmuMcmOXoSSFzC2B5nbXPVlzQVmMSQYIJ+gX3O6+bL
        R/FLtYkf6FqHS9l3QpGYHHYiDdAahW1uHpwHjhTl1CwoqXdrjEdqUI5iQY9P+C2LypVg7/
        pCx7EFofAHyrq71FVD34Sinj4LZPFkM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-50snJrewNmGoXzu9R6jxaQ-1; Thu, 17 Nov 2022 05:50:30 -0500
X-MC-Unique: 50snJrewNmGoXzu9R6jxaQ-1
Received: by mail-qk1-f198.google.com with SMTP id w4-20020a05620a444400b006fa24b2f394so1634097qkp.15
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjXLVyb6zwFPJe/OWlCp49ZVjP/sJNSDFeUY35Ol3A8=;
        b=l9bfR6hdDFrBYjv9u6T4sjV4wfNdrw/iMCNb0LWo/92EansSe/6nZOlkvH5rKeqyq0
         L7+iSEtm3ea0pppDjj2pgfw3/dYBXwHt6D7PsRoY4pwjprkLmvpma1RiFgefGYFb75Xu
         NUjPHCXXnj2w88aiMBrQpIUhJ9LAikdIviGhgf/kj43+GnFMsiDKHES1CYSgo+i5UNaW
         URh+MKz0orWKEaN6mZ41Z25L6UgaZMjehZ9SAhjd7e1Q87Dr6xoJINfwrGANLaIozckI
         e8XXzLiHOBqmWvZ7wxI5CgrmT1S2rYFYDO3EltrHiU7nQY93ffKBkC7ZP79ovQMtMwOg
         74qw==
X-Gm-Message-State: ANoB5pm8ZitvCWPaQhlgJZJ6WUQsOExG+AhLIkuVlZ/Wcb9//V9ONVQp
        mchwIzVSOIC2bGuZfWKUjPskH1NSFea5O7/CHcLgNqnncKuMb7Ctbu6JnYLOBIt4+4IrKgRP9VH
        XVk7lqM+mgvnmCN+XJfe+JKP/
X-Received: by 2002:a37:5fc2:0:b0:6fa:9812:42f2 with SMTP id t185-20020a375fc2000000b006fa981242f2mr1057168qkb.754.1668682229904;
        Thu, 17 Nov 2022 02:50:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4RXZjMGaetDJxgafbFUWe5YQR5qu294zU1xPcswkZUjgobAH+kXp2W1odUKDMEVqvGYKrhTw==
X-Received: by 2002:a37:5fc2:0:b0:6fa:9812:42f2 with SMTP id t185-20020a375fc2000000b006fa981242f2mr1057156qkb.754.1668682229703;
        Thu, 17 Nov 2022 02:50:29 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a248f00b006fa9d101775sm236022qkn.33.2022.11.17.02.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 02:50:29 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sc8280xp: add interconnect properties to ufs nodes
Date:   Thu, 17 Nov 2022 05:49:57 -0500
Message-Id: <20221117104957.254648-3-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117104957.254648-1-bmasney@redhat.com>
References: <20221117104957.254648-1-bmasney@redhat.com>
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

Add the missing interconnects and interconnect-names properties to the
ufs_mem_hc and ufs_card_hc nodes.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 6bc12e507d21..17c8dc8d4767 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -856,6 +856,10 @@ ufs_mem_hc: ufs@1d84000 {
 
 			iommus = <&apps_smmu 0xe0 0x0>;
 
+			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
+			                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
 			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_UFS_PHY_AHB_CLK>,
@@ -924,6 +928,10 @@ ufs_card_hc: ufs@1da4000 {
 
 			iommus = <&apps_smmu 0x4a0 0x0>;
 
+			interconnects = <&aggre2_noc MASTER_UFS_CARD 0 &mc_virt SLAVE_EBI1 0>,
+			                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_CARD_CFG 0>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
 			clocks = <&gcc GCC_UFS_CARD_AXI_CLK>,
 				 <&gcc GCC_AGGRE_UFS_CARD_AXI_CLK>,
 				 <&gcc GCC_UFS_CARD_AHB_CLK>,
-- 
2.38.1

