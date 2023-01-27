Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E371967E2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjA0LSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjA0LSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9916AE5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h12so4642392wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+cl5Ym56wJ7OQnEfR1Yodsc3crTZ07l528z+P6rSd8=;
        b=ZCk9RMRGU7mfV6M8jd8TyoAUAnvKfA+DqMIC8dbPwZn9PUgxug7ZKvfBJN3N4gYsMM
         P9nDANJ0ErJiri6z/vDAL0OkNiJo8tMluVx0SQ0uu+q9ltK2vyFDXpejNT8Ffli8pfQd
         uflc1MpIfDgUZCDKVU+m+3WF3GxX0alv8BsUZvP6SohTpLHPonOUaJ3YLhMOarp7/tZ6
         90kG3ArApiM6gV766VOEfm4GnWlA5jjCZ34fGWkx3dKaAeLP1l3oE2LnrNDjtH/UU7T6
         76f721nxJfegLo85a26pwx8GV/W0hshL/dYMtwJMASKtjeEUr8MqxVwNdXxZfvPG5JQL
         9qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+cl5Ym56wJ7OQnEfR1Yodsc3crTZ07l528z+P6rSd8=;
        b=V67WQ+LBV7f1HG2Wlz5rI61rSBFW9scxWYulZf+ndOPqAmNzRMRGSSDKyBgSzW2ctV
         We/lhQeAjgTN6fjpfy9yKcbHfG6ZgW2qmt0EsZ64MsnyM5UGvGJKaYR/IZleoBN3Mef7
         ROsvVBPF/Obc96CWyT43QwPx6Gvria8osHFkDuNIsWIw69lGspWcVNYz2HJksKsV9ZOQ
         MLXqnCN06d/HbvdCkpAPEfONxzFe0oTiMDXbPRTdRJ2Zl80BTQhgTNK8i2BqPWiSeXI2
         rhYifl6+FAP/Cq8BGyaqq3omRO8bnDF9lRFnrvOg7gC0EzBodfMzruxwzcK1pFLDYheb
         FFKQ==
X-Gm-Message-State: AFqh2kovnZjJ2DZYO1C07NSwrVTpig7sanAXdY+wc/c0FyfroqjYHN7I
        dbZBNBiluVm4tJ2Row47lJnOCQ==
X-Google-Smtp-Source: AMrXdXuxz0t8hxboZZNJCTrExpfdhtVWbV9V/6K/Yet3q974fbR9FLgjLVMTJcs/cYtDHAedhARJcg==
X-Received: by 2002:a5d:6b01:0:b0:2bd:fd81:b503 with SMTP id v1-20020a5d6b01000000b002bdfd81b503mr35610704wrw.1.1674818271277;
        Fri, 27 Jan 2023 03:17:51 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/37] net: add helper eth_addr_add()
Date:   Fri, 27 Jan 2023 11:15:36 +0000
Message-Id: <20230127111605.25958-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Add a helper to add an offset to a ethernet address. This comes in handy
if you have a base ethernet address for multiple interfaces.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/etherdevice.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index a541f0c4f146..224645f17c33 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -507,6 +507,20 @@ static inline void eth_addr_inc(u8 *addr)
 	u64_to_ether_addr(u, addr);
 }
 
+/**
+ * eth_addr_add() - Add (or subtract) an offset to/from the given MAC address.
+ *
+ * @offset: Offset to add.
+ * @addr: Pointer to a six-byte array containing Ethernet address to increment.
+ */
+static inline void eth_addr_add(u8 *addr, long offset)
+{
+	u64 u = ether_addr_to_u64(addr);
+
+	u += offset;
+	u64_to_ether_addr(u, addr);
+}
+
 /**
  * is_etherdev_addr - Tell if given Ethernet address belongs to the device.
  * @dev: Pointer to a device structure
-- 
2.25.1

