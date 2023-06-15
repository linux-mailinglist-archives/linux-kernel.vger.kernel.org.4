Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89126731AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344950AbjFOONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344910AbjFOOMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:12:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3277C2683
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:12:46 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FE4O1N019435;
        Thu, 15 Jun 2023 09:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=AjGNsoyoK5D+RJq6nyibBF7s8NAROrXXFDradtiR7EE=;
 b=cToN3yGLlHYejStDOuS6sTL8/BmqCwQuEn+N30FJvc6ckt8QbzGmjLMQsmFk7smlBEQN
 07TOSvGxCBrZwfrC7pCLx5OrnHF7Ow6LDkPOlL8lqzXfAxoCZHFlAOj01kPWqzbYpu7z
 UdpNQ0YiybPlYaDcE3xKKouYzRPZRc9OEeiTR9cNGM6PGvAVq3PWa8N3WUQkqTVglY0j
 D8PK+/yDt6eYhepp20pkcAQzvdWFtQy+TPly0IoDDTqaOUmSFdVvezj96XoYwmkTDFS7
 mg7JYQXvg3ZyJtZTHlZSwmUMI+RT5IuXKbztpvbC9k0jnXQ/72BEgMPScmGScdxaMqlk fA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3r4pk0d8fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:12:10 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 15 Jun
 2023 15:12:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Jun 2023 15:12:08 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 28DAB11DC;
        Thu, 15 Jun 2023 14:12:08 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] soundwire: stream: Make master_list ordered to prevent deadlocks
Date:   Thu, 15 Jun 2023 15:12:08 +0100
Message-ID: <20230615141208.679011-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230615141208.679011-1-rf@opensource.cirrus.com>
References: <20230615141208.679011-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mnNUJZBw1Evo7A57D6VUzeGSGj1bzS74
X-Proofpoint-GUID: mnNUJZBw1Evo7A57D6VUzeGSGj1bzS74
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always add buses to the stream->master_list in a fixed order.
The unique bus->id is used to order the adding of buses to the
list.

This prevents lockdep asserts and possible deadlocks on streams
that have multiple buses.

sdw_acquire_bus_lock() takes bus_lock in the order that buses
are listed in stream->master_list. do_bank_switch() takes all
the msg_lock in the same order.

To prevent a lockdep assert, and a possible real deadlock, the
relative order of taking these mutexes must always be the same.

For example, if a stream takes the mutexes in the order
(bus0, bus1) lockdep will assert if another stream takes them
in the order (bus1, bus0).

More complex relative ordering will also assert, for example
if two streams take (bus0, bus1) and (bus1, bus2), then a third
stream takes (bus2, bus0).

Previously sdw_stream_add_master() simply added the given bus
to the end of the list, requiring the caller to guarantee that
buses are added in a fixed order. This isn't reasonable or
necessary - it's an internal implementation detail that should
not be exposed by the API. It doesn't really make sense when
there could be multiple independent calling drivers, to say
"you must add your buses in the same order as a different driver,
that you don't know about, added them".

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/stream.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 93baca08a0de..d77a8a0d42c8 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1150,7 +1150,8 @@ static struct sdw_master_runtime
 *sdw_master_rt_alloc(struct sdw_bus *bus,
 		     struct sdw_stream_runtime *stream)
 {
-	struct sdw_master_runtime *m_rt;
+	struct sdw_master_runtime *m_rt, *walk_m_rt;
+	struct list_head *insert_after;
 
 	m_rt = kzalloc(sizeof(*m_rt), GFP_KERNEL);
 	if (!m_rt)
@@ -1159,7 +1160,20 @@ static struct sdw_master_runtime
 	/* Initialization of Master runtime handle */
 	INIT_LIST_HEAD(&m_rt->port_list);
 	INIT_LIST_HEAD(&m_rt->slave_rt_list);
-	list_add_tail(&m_rt->stream_node, &stream->master_list);
+
+	/*
+	 * Add in order of bus id so that when taking the bus_lock
+	 * of multiple buses they will always be taken in the same
+	 * order to prevent a mutex deadlock.
+	 */
+	insert_after = &stream->master_list;
+	list_for_each_entry_reverse(walk_m_rt, &stream->master_list, stream_node) {
+		if (walk_m_rt->bus->id < bus->id) {
+			insert_after = &walk_m_rt->stream_node;
+			break;
+		}
+	}
+	list_add(&m_rt->stream_node, insert_after);
 
 	list_add_tail(&m_rt->bus_node, &bus->m_rt_list);
 
-- 
2.30.2

