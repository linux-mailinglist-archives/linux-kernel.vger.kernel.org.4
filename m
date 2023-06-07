Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E15726C79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjFGUdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjFGUdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:33:41 -0400
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C951706;
        Wed,  7 Jun 2023 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686170020; x=1717706020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eua5jDRET5Qb3t5nMSLO71rB3j2AsP15aUyCua1keY8=;
  b=NiPbH8o5plkvTC0y6zVqzZ65lRCFTZJnU5C0dE4NP0LKbm2RVVvt+yI4
   L3pa8lqMAqueG4fwl3ruaYehbzqKJ9ppmGXAuwVajwMvyF3yNcb0ga95h
   Ki6xzoH2FefddpYbk0vC8t8YxElTn8IU38bByHCKimHBqQDr0oVqmlIRm
   0=;
X-IronPort-AV: E=Sophos;i="6.00,225,1681171200"; 
   d="scan'208";a="565509297"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 20:33:39 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 4FD9E45CA1;
        Wed,  7 Jun 2023 20:33:37 +0000 (UTC)
Received: from EX19D002UWA003.ant.amazon.com (10.13.138.235) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 20:33:35 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D002UWA003.ant.amazon.com (10.13.138.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 20:33:34 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 20:33:34 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id 58D96273E; Wed,  7 Jun 2023 20:33:34 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>
CC:     <sfrench@amazon.com>, <stable@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paulo Alcantara <pc@cjr.nz>, Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: [PATCH v2 5.4 2/2] cifs: handle empty list of targets in cifs_reconnect()
Date:   Wed, 7 Jun 2023 20:33:33 +0000
Message-ID: <20230607203333.26669-3-risbhat@amazon.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607203333.26669-1-risbhat@amazon.com>
References: <20230607203333.26669-1-risbhat@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paulo Alcantara <pc@cjr.nz>

commit a52930353eaf443489a350a135c5525a4acbbf56 upstream.

In case there were no cached DFS referrals in
reconn_setup_dfs_targets(), set cifs_sb to NULL prior to calling
reconn_set_next_dfs_target() so it would not try to access an empty
tgt_list.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
---
 fs/cifs/connect.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index b5cd3dc479ce..d8d9d9061544 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -513,11 +513,13 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		sb = NULL;
 	} else {
 		cifs_sb = CIFS_SB(sb);
-
 		rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list);
-		if (rc && (rc != -EOPNOTSUPP)) {
-			cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
-				 __func__);
+		if (rc) {
+			cifs_sb = NULL;
+			if (rc != -EOPNOTSUPP) {
+				cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
+						__func__);
+			}
 		} else {
 			server->nr_targets = dfs_cache_get_nr_tgts(&tgt_list);
 		}
-- 
2.39.2

