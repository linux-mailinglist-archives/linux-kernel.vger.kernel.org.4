Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD36711527
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbjEYSog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbjEYSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D1213A;
        Thu, 25 May 2023 11:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CE4E64576;
        Thu, 25 May 2023 18:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9C6C4339B;
        Thu, 25 May 2023 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039923;
        bh=jLmy0YIwg00FZkrO7Sqc6l+FN8D/FAERohoER1j45xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUztNPPP3pgKz5139bHYsZHDgmpbTo1BP0PeqzoqdNCSur7QOGih1J2c9vprezuOE
         Wtvx8kl8DIwea0Qrme9KDzR9kJFCQI3KfLQi0HC4sn+l2KjXppmMunkRCVAQM1/sgC
         ZfmZ9jLDYO7poDlNPvVKPxcBHjKgGskc8IVA9z319TyEgbDBvhyv7n59S80phULBWf
         f3TcRZRP/Mulh0UDY3+TlMXyM5ze9EZhefZBikNS9zDm2ZADqaFmdGS0XKp6/Qi9ff
         DAmdfyw4O37sKHRiXM3B4x7w5Ld0lygtkydQPqax3vsE2Qj8oEJ7GoK8eJNWdhE4E5
         qoKBaU0ZwR6Zw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 53/57] ceph: silence smatch warning in reconnect_caps_cb()
Date:   Thu, 25 May 2023 14:36:03 -0400
Message-Id: <20230525183607.1793983-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
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

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 9aaa7eb018661b2da221362d9bacb096bd596f52 ]

Smatch static checker warning:

  fs/ceph/mds_client.c:3968 reconnect_caps_cb()
  warn: missing error code here? '__get_cap_for_mds()' failed. 'err' = '0'

[ idryomov: Dan says that Smatch considers it intentional only if the
  "ret = 0;" assignment is within 4 or 5 lines of the goto. ]

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 54e3c2ab21d22..1989c8deea55a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3938,7 +3938,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	struct dentry *dentry;
 	struct ceph_cap *cap;
 	char *path;
-	int pathlen = 0, err = 0;
+	int pathlen = 0, err;
 	u64 pathbase;
 	u64 snap_follows;
 
@@ -3961,6 +3961,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	cap = __get_cap_for_mds(ci, mds);
 	if (!cap) {
 		spin_unlock(&ci->i_ceph_lock);
+		err = 0;
 		goto out_err;
 	}
 	dout(" adding %p ino %llx.%llx cap %p %lld %s\n",
-- 
2.39.2

