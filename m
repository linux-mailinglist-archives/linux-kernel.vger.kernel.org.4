Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477068B12B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 19:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBESLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 13:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBESLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 13:11:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D6F1717B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 10:11:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x9so1614394eds.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 10:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9iC9rYGO1NxkyXBlHxYR3oaUdA/dc5frr4F69pLNUE=;
        b=PvTYHq5gP1Y0bWf6iA4IydkMPLQFBb9qu5fq7gSuVShHB+ZHGu4I3Sy/gvQJrqIaCX
         I6zJvOkMf0L1LKBFaKcYfi1O9CPuyUSb58RwiWZal4cLysw83vHTwn6Sfe7mZ2DzI2U2
         w0Y+PLhHhteNQPbyOjQqBNmXmlCrs7C7/zW89j+/kEyZ1wJqF9l2BJuXuSRQ0PZBzYTa
         X/tiAoK9qDr4U7wcGcW8LnC1hQYjRTf800cRhm/9oeShAmsJEY8TvDWSrnWEAtzBjbXx
         C8ZTLEs4p2XEv7QbHzRORE/nnJx71He7kF4TtcxoaUhOwSvMd9lMgJL84QzrwXKiw752
         l/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9iC9rYGO1NxkyXBlHxYR3oaUdA/dc5frr4F69pLNUE=;
        b=IRSCt++WhF+0WApZZwSR+O30GUlEiRcAoV1VdbJbHLUs+7PAwt6/7+GN/QrntHgDFV
         10+MbRdn1Q1tF8yWjGtmYn81hF9UDZws9AKBqxsvmyMvaiVmcHkxYlU9rvTmQXUwNPbK
         fRyHO4ddX+yx9H/zaPC7Fa4yQkph5TqvCHJF3lQNc/AyVIxK0CKfSBDLVqzQvjdJfl2X
         JifbZiFZpXRQZggz4OVF2bN7X5CkRaV7MoNvEv8CDdQs+Gwytz57I7DZYWdypFfD16bf
         0NYCY98DXvIOkzRvZA5AKciyaqC3nkkO/4Rm2hUgLv0WGruULN4eT/hFQnQuCmtmlbhW
         UAYw==
X-Gm-Message-State: AO0yUKWEQviPI6DxbvJLwSzbYpFRQYc+PZfi2G9Y96o29d+vvqbwWdBf
        vwHbwgx6nZGdaq+UCldDerE5pxYEP5M=
X-Google-Smtp-Source: AK7set+S6JE2lqNlUyK7fG+fMPNAD3aHNYmFFjcJ34S2QDAfwiHJlFNBxRqfc13RD2/VCF7mrAi8Bg==
X-Received: by 2002:a50:9ec7:0:b0:4aa:9f02:98f7 with SMTP id a65-20020a509ec7000000b004aa9f0298f7mr5600960edf.0.1675620703140;
        Sun, 05 Feb 2023 10:11:43 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id bl11-20020a170906c24b00b0088d0b51f056sm4332928ejb.40.2023.02.05.10.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 10:11:42 -0800 (PST)
Date:   Sun, 5 Feb 2023 19:11:40 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: vt6655: Macro with braces issue change to inline
 function
Message-ID: <Y9/xXHvOAwfqoDxn@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
as '(iobase)' to avoid precedence issues" changed to inline function. In
relation to this, names of the callers of macro are also modified to call
this function.

Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
---
Changes in v3:
	- Whitespace error from checkpatch fixed

Changes in v2:
	- Macros with one statement that is to call 'iowrite8' function changed
	to inline function as reviewed by gregkh@linuxfoundation.org.
	In relation to this, names of the callers of macro are also modified
	to call this function.
---
 drivers/staging/vt6655/card.c    | 3 +--
 drivers/staging/vt6655/channel.c | 2 +-
 drivers/staging/vt6655/mac.h     | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index a6ff496b01b6..d2d122dc16d8 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -643,8 +643,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_72);
 	/* Set to Page0 */
-        vt6655_mac_select_page0(priv->port_offset);
-
+	vt6655_mac_select_page0(priv->port_offset);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index e9a44bcebe32..60b445c38424 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -121,7 +121,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
 		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
-	        vt6655_mac_select_page0(priv->port_offset);
+		vt6655_mac_select_page0(priv->port_offset);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b9a7ca0fe604..ae3064303691 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -539,12 +539,12 @@
 
 static inline void vt6655_mac_select_page0(void __iomem *iobase)
 {
-        iowrite8(0, iobase + MAC_REG_PAGE1SEL);
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
 }
 
 static inline void  vt6655_mac_select_page1(void __iomem *iobase)
 {
-        iowrite8(1, iobase + MAC_REG_PAGE1SEL);
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);
 }
 
 #define MAKEWORD(lb, hb) \
-- 
2.34.1


-- 
Thanks & Regards,
Guru
