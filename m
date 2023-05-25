Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9877115A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbjEYSqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242490AbjEYSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:44:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A77D19B0;
        Thu, 25 May 2023 11:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2AE60BDB;
        Thu, 25 May 2023 18:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929ACC4339C;
        Thu, 25 May 2023 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039972;
        bh=/aQHJrkPZV+ML/j/omdPFfLwhiWitT9bbB2gtn71rlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDv+AbTJ6ou3PgoVuZ8+IMBUB0pIxYaZqzppS1Zq75ammNiE35vY3HH/x/nt6rx1Q
         wfn5AMELJFaOh3Ur5LkjRL88rA63NOVII2ZDM56Mc8b3vrwOauA5hJ6yKsQK0Ap3pQ
         TVprZShNKiFNbeBwRgLg13OYX+KV4RtNQ3VIGZDH0RY1jdPnFQ5Z1oJa+Kwv4CAdxh
         XQT5FnjPogMKLU6Aa/DzgRY0reuHFA7ytNDdaPGfMdgl247Xn0uucYsp4t+iYV6VLC
         g4049h8L0GUNkGOGDEV4ZFqaPw5dJCMJU3Wrbfwfz+BAMXOTOEKOZwGWFUU8OQe9eN
         yF5HjZifWehAg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YongSu Yoo <yongsuyoo0215@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, colin.i.king@gmail.com,
        hverkuil-cisco@xs4all.nl, tommaso.merciai@amarulasolutions.com,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/43] media: dvb_demux: fix a bug for the continuity counter
Date:   Thu, 25 May 2023 14:38:20 -0400
Message-Id: <20230525183854.1855431-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 5fde1d38b3e34..80b495982f63c 100644
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

