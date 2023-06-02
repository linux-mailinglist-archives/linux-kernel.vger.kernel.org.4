Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFBB7200F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjFBLzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjFBLzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:55:06 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1BF1A8;
        Fri,  2 Jun 2023 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685706878; x=1717242878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0NfMqRU9yhxmvM+iGSJczBKuYku1/L+ddjdiE0oaavY=;
  b=kBJCcR+WDLzY/y9dySo8AF5JjisvR2IdjM4Ha2DtzqOkTdXqpYizQN05
   DeYuatT1GQF6n0gZMvqLtV11HeFQLz4hygWc0/Zf7hJ4yzuK9OyquLBPu
   mlkl/AZgZ68l2f2G0dwf0KlGtGxY2nc+0k6dsY/ipMFruUV50Ud5nHhwR
   5pSMFRpvVxqbEPfimkaWDst3IOUWFQW66GUc6Q/ybmjHFF/NKCnjSKi6I
   bCE5DZCckFOosiRWK3/VJ9NnmNi/nIR08EwNIZXQKZ5WxvWn5Xu8Js6NG
   HmypEHCwoU2THMLtGN86ciJ6DmQ0FgZxpu45LrnTUyLVwcuGHyqnsJO6i
   w==;
X-IronPort-AV: E=Sophos;i="6.00,212,1681164000"; 
   d="scan'208";a="31246994"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 Jun 2023 13:52:41 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 02 Jun 2023 13:52:41 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 02 Jun 2023 13:52:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685706761; x=1717242761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0NfMqRU9yhxmvM+iGSJczBKuYku1/L+ddjdiE0oaavY=;
  b=RY2yUqKp7kCCBJXzxw8QUxLDnUU1bcO6HELiHEcoOMFLf0/t6jeLJ1Zd
   o4G+30SJgbUQc4hPI0D2izEMvl92qbeEDhtKgEtMIufZnE5QNXPHxwTXA
   GSCxx+0YGXOzKNudMXcZq8X0VaEBbJ/1QhF7roMipDSaRtV6cUwSuq5gX
   GlhU+I4zy6In0fRKS/HhUvH3UL6wO2lnDNGQsF3nXBwn+KkJzb4BQedem
   qwAceopcXaVAIwd0wUTKm/aKHiFRCOKyk8eUgqQKM7wlvzqOUJDm+s4+p
   Uq3siTP5slXDcmDo08JqZSau3tkoxhfxUa5SBBYa9qjDi5x+tovX5nKyC
   A==;
X-IronPort-AV: E=Sophos;i="6.00,212,1681164000"; 
   d="scan'208";a="31246993"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Jun 2023 13:52:41 +0200
Received: from localhost.localdomain (unknown [192.168.66.223])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 8B52F280088;
        Fri,  2 Jun 2023 13:52:40 +0200 (CEST)
X-CheckPoint: {6479D7FA-2C-AA2CB662-E129E996}
X-MAIL-CPID: 2E05E409D839B4ED1AB3D8DA2C10A9CF_3
X-Control-Analysis: str=0001.0A782F1E.6479D809.0001,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] spi: add support for generic linux,use-rt-queue flag
Date:   Fri,  2 Jun 2023 13:52:01 +0200
Message-Id: <20230602115201.415718-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of requiring per-driver support to handle the message queue with
realtime priority, add handling for a linux,use-rt-queue DT flag to the
generic SPI controller initialization.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/spi/spi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9291b2a0e8871..f069f1aef5378 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3185,6 +3185,11 @@ int spi_register_controller(struct spi_controller *ctlr)
 		ctlr->mode_bits |= SPI_CS_HIGH;
 	}
 
+	/* Run message pump with realtime priority */
+	if (ctlr->dev.of_node &&
+	    of_property_read_bool(ctlr->dev.of_node, "linux,use-rt-queue"))
+		ctlr->rt = true;
+
 	/*
 	 * Even if it's just one always-selected device, there must
 	 * be at least one chipselect.
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

