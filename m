Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1F70AA8E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjETSl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjETSlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:41:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76109C5
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:41:20 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2651E3F2EC
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 18:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684608079;
        bh=7AI0vj2c5KjlogOZSOLiFXVCyd1H7zjU9pr3GTen1KY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lfhPTABWXMm0M9QNxz+/HOYxEo1u4P33YiDMYkDXS0l97vSvEl47OQy9++FwNGMar
         Io+vcxclfmPPHirbNN9diyZ6aDmHrfhPv5or27s9ZnRSRNDOjQ1iA9weoXgvsQdixq
         h/xs8bUAoNYfgp/A5r+YiU7IkVehQ4vk91r11z9hNqUP1yh8yJhmm2+LmxhKktbQE6
         YV0OZW6wOO/xtU67J36w7rAQgDJMzrS2iFA9p4T1G1GEKHzaqc/5efsWGfwPCkR2PD
         suVGHU7mmg+C9/0qOSdokP8PCfQD1LgDLTNQ8dlz+6WBbuz6Uj5/Jqw6ZE9VLjQeOE
         3mpgOkRmpOXzg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-96f6e83685eso196393966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684608078; x=1687200078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AI0vj2c5KjlogOZSOLiFXVCyd1H7zjU9pr3GTen1KY=;
        b=jx4Ag/GeVq8jMh7M/VBOkV46mDtWf8aQLKVCwsbHHbdCNzPa4EIazUKrvOM2UblusD
         xFG/tzCPOq2lrhVivPE8kUEuAmclYPjUXfyPKfD/vTTPK1Z8/7C35xmoyD/w02EIVqgl
         ZP+ZAXqA6oc+kGM2l/FLMhaePhHICvBtP5xhFon3DtedNk9dxhrgtQajPft54sCfq3jU
         Y7i8SrvHEMVG8TqM90ORVK7kvWoF67Jt1JWCfmyf8t4zihgR+Wzor1F1k562VHbxNaVB
         +d+oQEiQDJFiINTbKNq63HFP5ebUdplYvMbo6hdpl9NMxD/ds9PcyHoxacbmO7LGehOJ
         rLVg==
X-Gm-Message-State: AC+VfDwEHx/oeux9lfp50CU4Jo7TISBFRIBHIKl2+HcSI3U8V0wdMj2x
        txjy+iEGBkiU61471p66oN3W1MEILqEx0WzGpFc83//vVzcCYqfHjPx4RmmDieBC5bcwEzn4RsX
        /q52ptGUbnPexMaGrnXX0D7ybebczWjOzIVfj1eGjbw==
X-Received: by 2002:a17:907:628f:b0:961:b0:3dfd with SMTP id nd15-20020a170907628f00b0096100b03dfdmr5768128ejc.7.1684608078662;
        Sat, 20 May 2023 11:41:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bU8KiThmUSU1gkKkVsLgEdjohmQGXC442Dp0W428jbmv6EizvNqpf3UWtdJVTxqXZWABedg==
X-Received: by 2002:a17:907:628f:b0:961:b0:3dfd with SMTP id nd15-20020a170907628f00b0096100b03dfdmr5768105ejc.7.1684608078291;
        Sat, 20 May 2023 11:41:18 -0700 (PDT)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-87-10-127-160.retail.telecomitalia.it. [87.10.127.160])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709065ac600b009663115c8f8sm1046294ejs.152.2023.05.20.11.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 11:41:18 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ovl: Kconfig: introduce CONFIG_OVERLAY_FS_DEBUG
Date:   Sat, 20 May 2023 20:41:13 +0200
Message-Id: <20230520184114.77725-2-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520184114.77725-1-andrea.righi@canonical.com>
References: <20230520184114.77725-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a Kconfig option to enable extra debugging checks for overlayfs.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 fs/overlayfs/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
index 6708e54b0e30..fec5020c3495 100644
--- a/fs/overlayfs/Kconfig
+++ b/fs/overlayfs/Kconfig
@@ -124,3 +124,12 @@ config OVERLAY_FS_METACOPY
 	  that doesn't support this feature will have unexpected results.
 
 	  If unsure, say N.
+
+config OVERLAY_FS_DEBUG
+	bool "Overlayfs: turn on extra debugging checks"
+	default n
+	depends on OVERLAY_FS
+	help
+	  Say Y here to enable extra debugging checks in overlayfs.
+
+	  If unsure, say N.
-- 
2.39.2

