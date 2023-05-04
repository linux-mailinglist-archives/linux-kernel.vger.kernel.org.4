Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ABD6F7490
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjEDTvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjEDTuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386F14354;
        Thu,  4 May 2023 12:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83929637A3;
        Thu,  4 May 2023 19:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4B6C433D2;
        Thu,  4 May 2023 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229583;
        bh=eJwsPTF1sGf3gATrqhUnKCreLCEh7/RrYOxXYQr156c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTiOM8aG0GJkKKheOQutnHrnBouYN+967w+IGXgfXxgh16BxRpwAvVOF5c1SvpD9R
         69Kvbtwh9nxhiYo+1Ba0K/UWX/HfvAfe5ABHv2LmaZB6MuX7qfOaqKcjrsybixfc5+
         xi4EgJRFesjDnNWhKZ3RzIK5jiI5SlLVzcGxmHwkCNZ7+DKkj+1VnwkQRA1aiKp1P3
         DvnwyKArVP80YLhO7vznU4+QS+Ca7YOw/87lomQwZY7U6/z/qhQfF/fGBvVqrNG92a
         SJbP/l061SGLg/wjvmeD2xkBu8vpJQYWMQRDiKm/lwmN5zDeA+FV8ufmNJe0dzsn9O
         tVlWDAO8txlXw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Min Li <lm0963hack@gmail.com>,
        syzbot+9519d6b5b79cf7787cf3@syzkaller.appspotmail.com,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 52/53] Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp
Date:   Thu,  4 May 2023 15:44:12 -0400
Message-Id: <20230504194413.3806354-52-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <lm0963hack@gmail.com>

[ Upstream commit 25e97f7b1866e6b8503be349eeea44bb52d661ce ]

conn->chan_lock isn't acquired before l2cap_get_chan_by_scid,
if l2cap_get_chan_by_scid returns NULL, then 'bad unlock balance'
is triggered.

Reported-by: syzbot+9519d6b5b79cf7787cf3@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000894f5f05f95e9f4d@google.com/
Signed-off-by: Min Li <lm0963hack@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 55a7226233f96..24d075282996c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4694,7 +4694,6 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan) {
-		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
-- 
2.39.2

