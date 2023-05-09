Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721AF6FD112
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjEIVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjEIVVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317E7EE4;
        Tue,  9 May 2023 14:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1640B63759;
        Tue,  9 May 2023 21:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34832C43322;
        Tue,  9 May 2023 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667220;
        bh=D0inDjh17ucDAvUCWYWlRHkWEI4z5LPZgGMhf9w+PlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OM+PnJ5qxTNhpe1X4+K7E2ATUna/Z5J5zpfqKoN/dAqNimZhjjUJkkwN2g5E+McFN
         QbArfb/UxOF+O9GY+mtQg39Rljeb3XS8JmwC6fsOO6r1vtD7eFtOL+QZJzd0aVS0oV
         q8clvspzUVj7sPEGY2zixI9oh9vpWEx59H28IbQQVilX/2bGkVFHAEntRWixfZU/1b
         Id55WxtEehe2Zev7eNHLa+KndeHvf/87u2ZMYqXqkuilIToRQ5syoCKOhW9q/G8w26
         0wikHTG1eUq8WzhZQgOOG3q42uR9qorHLFLMtP6HY7+ot1mp01lKhqVEUvs0BC6rnU
         J6AvxvjXGl9UQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.2 18/18] cifs: missing lock when updating session status
Date:   Tue,  9 May 2023 17:19:56 -0400
Message-Id: <20230509211958.21596-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211958.21596-1-sashal@kernel.org>
References: <20230509211958.21596-1-sashal@kernel.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 943fb67b090212f1d3789eb7796b1c9045c62fd6 ]

Coverity noted a place where we were not grabbing
the ses_lock when setting (and checking) ses_status.

Addresses-Coverity: 1536833 ("Data race condition (MISSING_LOCK)")
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 985e962cf0858..860e533ad1bf0 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1965,18 +1965,22 @@ void cifs_put_smb_ses(struct cifs_ses *ses)
 	/* ses_count can never go negative */
 	WARN_ON(ses->ses_count < 0);
 
+	spin_lock(&ses->ses_lock);
 	if (ses->ses_status == SES_GOOD)
 		ses->ses_status = SES_EXITING;
 
-	cifs_free_ipc(ses);
-
 	if (ses->ses_status == SES_EXITING && server->ops->logoff) {
+		spin_unlock(&ses->ses_lock);
+		cifs_free_ipc(ses);
 		xid = get_xid();
 		rc = server->ops->logoff(xid, ses);
 		if (rc)
 			cifs_server_dbg(VFS, "%s: Session Logoff failure rc=%d\n",
 				__func__, rc);
 		_free_xid(xid);
+	} else {
+		spin_unlock(&ses->ses_lock);
+		cifs_free_ipc(ses);
 	}
 
 	spin_lock(&cifs_tcp_ses_lock);
-- 
2.39.2

