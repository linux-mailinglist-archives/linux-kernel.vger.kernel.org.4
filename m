Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157816E5A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjDRHlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDRHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:40:57 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D311761AB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:40:54 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id 51D49FF814;
        Tue, 18 Apr 2023 07:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1681803653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scpDFCwV6aTtfRwsoCgon3HntVUYCshBYgDIy4kWdfQ=;
        b=QaLRavhTSSyccEemL1jrJWuohZsPZyAELIB+BA9O47tihXuUeuJEFYnuk8xHbm10ccusKK
        nXIgHgc4bZVPWF7CsbQdTwXJR54kSxGpVbLKc6Jms7m66ekRRCdCMQb4id2rbBd+uDwr6h
        FWgJPScBzcLoDjoMrUWsgTCzqldOIYQrJ5pnrM0NhF+wTT4Ru2PCIMdKHNkIEQdIRiJonq
        exAsnEqiz9i66Z/CunnZ8jHi8nA9hEU2/3ZVi4g8yraIXu1AphNRHi6w8SRwWWGgtyffnn
        GmyfQevD8kPCpCM8+3SXiW5WXXjUFCRnyzDUUPp0XXz+KXRfNkSqGwDPPw28PQ==
From:   Roman Beranek <me@crly.cz>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Roman Beranek <me@crly.cz>, Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosp.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] clk: sunxi-ng: a64: prevent CLK_TCON0 being reparented
Date:   Tue, 18 Apr 2023 09:40:04 +0200
Message-Id: <20230418074008.69752-4-me@crly.cz>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20230418074008.69752-1-me@crly.cz>
References: <20230418074008.69752-1-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON0's source clock can be fed from either pll-mipi, or pll-video0-2x,
however MIPI DSI output only seem to work when pll-mipi is selected and
thus some restriction have to be put on reparenting CLK_TCON0.

Functionally, there's no harm to other TCON0 users (LVDS, parallel RGB)
in also forcing them to settle on pll-mipi. The parent will be assigned
during boot based off of tcon0's DT node.

Signed-off-by: Roman Beranek <me@crly.cz>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index dd6212286dcd..ac9bf4e316bf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -533,7 +533,8 @@ static const char * const tcon0_parents[] = { "pll-mipi", "pll-video0-2x" };
 static const u8 tcon0_table[] = { 0, 2, };
 static SUNXI_CCU_MUX_TABLE_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents,
 				     tcon0_table, 0x118, 24, 3, BIT(31),
-				     CLK_SET_RATE_PARENT);
+				     CLK_SET_RATE_PARENT |
+				     CLK_SET_RATE_NO_REPARENT);
 
 static const char * const tcon1_parents[] = { "pll-video0", "pll-video1" };
 static const u8 tcon1_table[] = { 0, 2, };
-- 
2.34.1


