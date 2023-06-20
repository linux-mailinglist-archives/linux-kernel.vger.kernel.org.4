Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55293736B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjFTLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjFTLlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:41:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CBEA1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:41:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so1646136e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687261258; x=1689853258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJfdnRF9Vl6raSksJddU5E+UCkdBzgf8ixFIV7tG5Fw=;
        b=aCHgr6eVSbF0sSWS5KVz9OjzuyyOGXqeZUBI0EscRJLFniU0QgYOewzKkCo2rbRrx8
         ijBX2GBsdGtOaWilHopc/qpeNyp6ZgmM/8dFQPmUE3Rtvzj+9l9NhwhMAB6dax5F+hTu
         6kahIyVtuf4p69CJYbUfyrXFSVXC4gFGziL6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261258; x=1689853258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJfdnRF9Vl6raSksJddU5E+UCkdBzgf8ixFIV7tG5Fw=;
        b=HhmYlYih86WmQLY47qVOoUUF5OhCWj0grRVy1XLaj+Nkl6RNoiygjoBhVEfevSXiHL
         VEnI0yxZcR4FhbV3ywxJzbyzhrRBrup3LkBI+NVRF9Eua192LOr2qq1cplwN/ucIJhZ3
         zOJGieTDsBaYoTXW7o6DoVXTo66F9V2kvPXlLj0HUEGs6rEC6Z70Ag9UvcDgzEVoU7Sq
         gMkBCdvVYv+KWwx+jqbmEx29mGR51ErhsSVjPP8VM4IbBaiV5BAPX87iIa/N+D9oX3Ng
         DnpXAK4PARJ8XwlVPdiKpDImewGZe/qc511t75mfbRGs1bdTyPnYgBqZ1WCgPlNjvzt+
         Q8oA==
X-Gm-Message-State: AC+VfDzS7eopl4GOYFkvJmyEVGyn+sGiT8+ss8qpnAibNql/XT1hI5c+
        Fe7coeIJIcqWGrhW5Tuk3AasGA==
X-Google-Smtp-Source: ACHHUZ6aWAoO8+VPVomym/NUP8XMNnTvJPPQS+D3kdspQ2LETykVC5sXLHUYealrRYHrLzJsXjIZxA==
X-Received: by 2002:a19:8c14:0:b0:4f8:7333:d1fd with SMTP id o20-20020a198c14000000b004f87333d1fdmr3097994lfd.34.1687261257806;
        Tue, 20 Jun 2023 04:40:57 -0700 (PDT)
Received: from localhost.localdomain ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id d12-20020ac2544c000000b004f84162e08bsm329879lfn.185.2023.06.20.04.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:40:57 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: dsa: microchip: add ksz_prmw32() helper
Date:   Tue, 20 Jun 2023 13:38:53 +0200
Message-Id: <20230620113855.733526-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used in a subsequent patch fixing an errata for writes to
certain PHY registers.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/dsa/microchip/ksz_common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 2453c43c48a5..28444e5924f9 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -582,6 +582,13 @@ static inline int ksz_prmw8(struct ksz_device *dev, int port, int offset,
 			mask, val);
 }
 
+static inline int ksz_prmw32(struct ksz_device *dev, int port, int offset,
+			     u32 mask, u32 val)
+{
+	return ksz_rmw32(dev, dev->dev_ops->get_port_addr(port, offset),
+			 mask, val);
+}
+
 static inline void ksz_regmap_lock(void *__mtx)
 {
 	struct mutex *mtx = __mtx;
-- 
2.37.2

