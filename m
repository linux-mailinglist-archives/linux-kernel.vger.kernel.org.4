Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FB171164C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbjEYTBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbjEYS7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A25D5B86;
        Thu, 25 May 2023 11:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 343D463A20;
        Thu, 25 May 2023 18:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB565C433D2;
        Thu, 25 May 2023 18:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040168;
        bh=TSrvxkW0g7+kGk+o09yxOWdyShj/7aqCd5YMFvMX98Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsZccv1DCuWttXv0+haSC62nCnYzGk83SEfg5y6dki425ZgnsqAS4E7ycKScoNJDb
         ypiHQGFfBkBvnIMbYvXov5YJZGzvSziz/Sa6YKaj7xeC45c462+NNBhuaJb5c3glaa
         QaqILylORDGfgNUUjgxymmT9KgWSAafAsRCYDNwj2eIHaw8GVddDBOlu55VKPAuhjf
         hEjrLB+b99Rp3+/WmaPNXP0OSETmVunZX/4Mzm1NcPTv6xq5J+1eHsMg+80IPpXkWJ
         r2bfu7R/jL4vrVF+Y11i0Q7FjWywsf/q6EHYdN4UWDUj6MWrbt+bxRO8XhQOOtk0Fz
         4LePJyazmv/+w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YongSu Yoo <yongsuyoo0215@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, colin.i.king@gmail.com,
        tommaso.merciai@amarulasolutions.com, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/27] media: dvb_demux: fix a bug for the continuity counter
Date:   Thu, 25 May 2023 14:42:13 -0400
Message-Id: <20230525184238.1943072-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184238.1943072-1-sashal@kernel.org>
References: <20230525184238.1943072-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YongSu Yoo <yongsuyoo0215@gmail.com>

[ Upstream commit 7efb10d8dc70ea3000cc70dca53407c52488acd1 ]

In dvb_demux.c, some logics exist which compare the expected
continuity counter and the real continuity counter. If they
are not matched each other, both of the expected continuity
counter and the real continuity counter should be printed.
But there exists a bug that the expected continuity counter
is not correctly printed. The expected continuity counter is
replaced with the real countinuity counter + 1 so that
the epected continuity counter is not correclty printed.
This is wrong. This bug is fixed.

Link: https://lore.kernel.org/linux-media/20230305212519.499-1-yongsuyoo0215@gmail.com

Signed-off-by: YongSu Yoo <yongsuyoo0215@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvb_demux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
index 39a2c6ccf31d7..9904a170faeff 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -125,12 +125,12 @@ static inline int dvb_dmx_swfilter_payload(struct dvb_demux_feed *feed,
 
 	cc = buf[3] & 0x0f;
 	ccok = ((feed->cc + 1) & 0x0f) == cc;
-	feed->cc = cc;
 	if (!ccok) {
 		set_buf_flags(feed, DMX_BUFFER_FLAG_DISCONTINUITY_DETECTED);
 		dprintk_sect_loss("missed packet: %d instead of %d!\n",
 				  cc, (feed->cc + 1) & 0x0f);
 	}
+	feed->cc = cc;
 
 	if (buf[1] & 0x40)	// PUSI ?
 		feed->peslen = 0xfffa;
@@ -310,7 +310,6 @@ static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed,
 
 	cc = buf[3] & 0x0f;
 	ccok = ((feed->cc + 1) & 0x0f) == cc;
-	feed->cc = cc;
 
 	if (buf[3] & 0x20) {
 		/* adaption field present, check for discontinuity_indicator */
@@ -346,6 +345,7 @@ static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed,
 		feed->pusi_seen = false;
 		dvb_dmx_swfilter_section_new(feed);
 	}
+	feed->cc = cc;
 
 	if (buf[1] & 0x40) {
 		/* PUSI=1 (is set), section boundary is here */
-- 
2.39.2

