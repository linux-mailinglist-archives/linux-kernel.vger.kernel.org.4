Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FA56F765D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjEDUGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjEDUE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00318DEC;
        Thu,  4 May 2023 12:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2750463836;
        Thu,  4 May 2023 19:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273D2C4339B;
        Thu,  4 May 2023 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229889;
        bh=xqnVCedNH7mQsCdY9m1JgAgwtMxQ5a73EXkT4swv6VQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJhx0oaRi2u7Q+uffOrFnvnnW218dKI5nW4RbRUeVTbKM5fgTdt/N7cWvmyiIheWi
         O8ndS/hWWMk6j1KpEcQO5Q9lxnqwDfzXj8a1uy22Ojn7ZdLK0ZInF0agpXXpMvpNFH
         1Lay6xo5T4AyCXMzyNQEoqeFYREBTptdOWBYZ8mMUtcxJrVXnQOrV8NBfPR7Er+REX
         8/zlGoKhtqbgHhkgUIykFS5S9wFDcXjK0n2asYpN/rsPSE347IuFxQG1/r0RrA49jI
         ApdKtIwOaG89BabdaPh9oSFszqBjtGACGVBBvoqHcJ7YNd4IlMuFhQmd0xtmhmr1gS
         mq6g7j3xO+ChA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Min Li <lm0963hack@gmail.com>,
        syzbot+9519d6b5b79cf7787cf3@syzkaller.appspotmail.com,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 18/18] Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp
Date:   Thu,  4 May 2023 15:50:40 -0400
Message-Id: <20230504195042.3808716-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195042.3808716-1-sashal@kernel.org>
References: <20230504195042.3808716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 3c559a177761b..5f53e75d83024 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4410,7 +4410,6 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan) {
-		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
-- 
2.39.2

