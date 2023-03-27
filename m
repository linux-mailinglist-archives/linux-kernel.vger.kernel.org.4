Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4366E6C9A90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjC0Eel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjC0Eej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:34:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5CC4ECB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:34:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-545e529206eso18391137b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679891677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPVKlHs8rdxB8UK5BU2ADWdalnh8Q9IQfmw/DaMpLMc=;
        b=Hn0rFABF3w227/orfbWGzUmPI0QrILbuKF4wmvZ1wwW31KwSk1UudgpTAnvdn8NDVw
         Bg3SAYFLkqHAyYO6DXbcqvBMQyaKa/gBDRp2MgrS+AVSE0w9/bXEBv299glKl0mh4f+A
         s1oKfbKa8KBvExwwWcrx/Yl8TEl8FKg4VekK6sSsDOFJlFvS+9dwRTFomCl8Dis17fp8
         azxWvEk0dluGeI4guR8j7AwrZunEBHrkTATiAIWn1Wt6qHlM/wxddCsCjfzHjpD6Rrc+
         c83vKqcUJz6ij//ltyzYO/+/JJRcCz9fBKpg2BADknUuAugmCTMFjvoVPdpwW/wk5U5o
         P6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679891677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPVKlHs8rdxB8UK5BU2ADWdalnh8Q9IQfmw/DaMpLMc=;
        b=V+hJRRCee5e9ub+5OYb0hwcPPILZcwlO5ioI4sus32CLjyLbnkxsFvf402WLpfVDuV
         m8/p+HtL1oUoN5nkIhAXaT982DYOciEAvalRrx+sSUM5yRsgrCzX1/ZOpNtL7dXFD1nl
         Y0YvMu0vLQ9acNZgTuWKcN1e98d9m4rEoPW2ZASKQxnh83Z5Rpa1poZrtENlVGY7VQAX
         ucFQsGA81u0qzRIxsvWVMnuWpTtLJQdQUcmazDoaL45Ipwy0fOdXWWkPWVFA17YgNDd6
         8WQyUDRKcHLTkvlMUSUjXzJrBIZA6UPMLarCqDc1l5OXsDxqDVOwTUvNFAyIJgxT9Bwq
         3iBA==
X-Gm-Message-State: AAQBX9dGv9zE4tSQuodnK951UI2uZmEJ9H7OOZ6TL5ojmIc/7yB7F/jP
        QGMyi1eDWpdSCnsGnj/xXrx2fBwRwptJNw==
X-Google-Smtp-Source: AKy350ZgmAqvY+rvLG19P9MAICkhUZ57zTI/O1tDGw1hxJxsyZslVjt8Pv8bjnoIxbeCQYY0wRo2IE8XeB5MCw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:168d:b0:b26:47f3:6cb with SMTP
 id bx13-20020a056902168d00b00b2647f306cbmr4767786ybb.4.1679891677537; Sun, 26
 Mar 2023 21:34:37 -0700 (PDT)
Date:   Mon, 27 Mar 2023 04:34:04 +0000
In-Reply-To: <20230327043405.881645-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230327043405.881645-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327043405.881645-2-joychakr@google.com>
Subject: [PATCH v4 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for AxSize = 4 bytes configuration from dw dma driver if
n_bytes i.e. number of bytes per write to fifo is 3 or 4.

Number of bytes written to fifo per write is depended on the bits/word
configuration being used which the DW core driver translates to n_bytes.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..b3a88bb75907 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -208,12 +208,17 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
-	if (n_bytes == 1)
+	switch (n_bytes) {
+	case 1:
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
-	else if (n_bytes == 2)
+	case 2:
 		return DMA_SLAVE_BUSWIDTH_2_BYTES;
-
-	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	case 3:
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
-- 
2.40.0.348.gf938b09366-goog

