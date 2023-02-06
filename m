Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886BD68BA1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjBFK2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjBFK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC21EBC8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:24 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so8371184wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+cl5Ym56wJ7OQnEfR1Yodsc3crTZ07l528z+P6rSd8=;
        b=rYAmi04ikihq2pYTYtal+Kbg/qcy9Xlw1eH5vh8/eoAQqryD3KK82Rqdcvb5XbfqEF
         TUJ8i5DPNRoKCym4B9NeR8i1vkLlYC4Bl506EyJDhyGJBNE7SjChymjYlN5Xc+treSh1
         nncFp4RbeihZ4Idxf2RzQ/NwRM0CWRAwYwKWasbF08SuW0Ya4/WuQ6r2fBjURHDZo1nC
         M3wCa1Xk8SJjjWA7CN2DFBmZmofwaXZ9o7VJ19rRdpxEdro3Bz2idQajuDHntgtCIMIp
         Ivz0DJFInnUDz5vQHoIueDWo/kJA5dVhtZC0ABYKEXzdBDTl82StvyHG19hn4eH9tU3W
         2BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+cl5Ym56wJ7OQnEfR1Yodsc3crTZ07l528z+P6rSd8=;
        b=TvxYASKSBfdrSd5GM4pIlagx0U1UoHZ6R78qPDCuNLG4iCu14bS8yoIFnsmO99XOjc
         +PACt0LRuWBFSZCskYnrTSl7TpypWlZPlDUjwnNhH+80PyXaoKprtmU76qkMqaEsBQZF
         pGq+PLS84QcEOsSn1QO+s7ChJeI41jvr60yxkcpcjXFaw7DpdmRyWx0Y3RBGTHzVO2cp
         zMNuRbC8CALibldhLkkO8trC7iRQ3Cxlvaj7XBAiPU1/V15roRGzPIulmERnJnLMVum3
         jrwSqbtKEwucck8zKW87avzJG+VbRFtXL+zVXZaL59yCWrMdBd4EaGXl34svUs0zp2lc
         T72Q==
X-Gm-Message-State: AO0yUKU0oAtj8n2Z/sKqh1lKI+fSU/r08jFpWNJfwtoXk8Retu1TBYlb
        N3Lh6EUWr7eB7ds1fCZt3qNQyw==
X-Google-Smtp-Source: AK7set8bLyJf74k+8GqZ03t23nXD0FvX3cHMWeKf0axU0qbupjbLJmX6hCJXm1xQ3pecDouqeUHcCQ==
X-Received: by 2002:a05:600c:3110:b0:3df:ee64:4814 with SMTP id g16-20020a05600c311000b003dfee644814mr9845095wmo.20.1675679303345;
        Mon, 06 Feb 2023 02:28:23 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 08/37] net: add helper eth_addr_add()
Date:   Mon,  6 Feb 2023 10:27:30 +0000
Message-Id: <20230206102759.669838-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

