Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95AF68BE8D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBFNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjBFNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6561F4A1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bk16so10382906wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+cl5Ym56wJ7OQnEfR1Yodsc3crTZ07l528z+P6rSd8=;
        b=hNyOPh9k+ioWrpArqXwn8leHfx0tRugeEFdqswjt4vumT7yAguVtyBt9GOnbQZzWA/
         W7f6EWWXHrga24+/tVNEwNznt+n9DuY3MwysnUDe4ut0jK8LvnpGN6ehUP82t5tLXaIC
         ZzqclXU71IRzD23CEo45WhpKwfK2GPLbChIkiH9RRkGztxZ9ASTue+WCKOnQ8Ab7d6a7
         0uatxjl49iHi6I6Emo6zPrri9QW9KUWpyKUvGB/vwLP5gKZraTpbggBi3cp0xGxOo5Rl
         syRo4bdV012Ahjf6fGIOOViFPnKUKnY1JLeqN+IZt4FUqAbN1BVckkHb+2ZmPYdiCWlx
         1UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+cl5Ym56wJ7OQnEfR1Yodsc3crTZ07l528z+P6rSd8=;
        b=k0/cVDxd7h7yV+IivFdyWdZAjHfxGP/eDtjCaEBCs6iP7RYk2+fbo72zLhz/nHn9W0
         tLJ6YULGl01RtsnpJn72Lj8X6r3zDHRUmi2/jGrZOVrTCvTkp6/Ek/2Kk7NNPbhtR6ww
         NCrkVoKIePaAlzmqdDeE3wo0PadnxCq6G84BsrfYw55/G4Ha8KaB8z6/FnBY5lvTEmUc
         vmRs7d9fEBFg6raVTlcLVRAEV85YAI5aHhZBvPaIR2Lo5P6JRR55iw8X9rV7eQ1Sc1RS
         yHWq9wAP/oOzH/tta7Ghd5cFNG9gt9d4xI5EHRhh97UENX9hvfGna/pA95IqRzjRKS1b
         6Hxg==
X-Gm-Message-State: AO0yUKUmmTBgkk7fyELrDNJJDAh/U9Ibq7yVL/YfavyKMnXhl0FKKOwD
        XrQhkEW3zzcxKoRe+UzZtV1h9w==
X-Google-Smtp-Source: AK7set9LLx/YHmimLRa9yBqS5L/CBBE9ByHi5JaNSBTWDHVl8XCIG5VLYYxagh/5cH/Xn2gPnsYbug==
X-Received: by 2002:adf:9c8e:0:b0:2c1:28dc:1561 with SMTP id d14-20020adf9c8e000000b002c128dc1561mr16263048wre.44.1675691054594;
        Mon, 06 Feb 2023 05:44:14 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:13 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 08/22] net: add helper eth_addr_add()
Date:   Mon,  6 Feb 2023 13:43:42 +0000
Message-Id: <20230206134356.839737-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

