Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843F673ED5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjFZVwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjFZVv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE830D6;
        Mon, 26 Jun 2023 14:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B276C60F9C;
        Mon, 26 Jun 2023 21:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DFFC433C9;
        Mon, 26 Jun 2023 21:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816246;
        bh=cbGjMdaDsxqsSeLpAF6lSUG3DBJMOuNAfT8moyKl0UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmftMww8mWoqptxK5qq1RSHeww02Zz+ze3mBjkYQ7Ik/fVjs4GP2bjanQ+w85eMvc
         F4imtafJN57lSmH25xoMGRaJ++7ciRaNvW9aFI+sK3v4vfopMFJUKp0iFizTR9G7Mt
         /MKIlen+cFfRpNv+gNPGQKQ5FA2MhWUa4+0pCaie/c9tfboFCIINphmW7ZugCaDhDz
         7FzUEixJjpbRZ1/hfHFyIvM1oRtm9nr+0F6v95LE/jqOKMBop68r93GDcrpYCUwWRG
         8wwIdfVjJ5VGXEJWlngOmcF9z/oDMpbH2WLiGZZfbKR1Yib8mFHZrSw6IKw6JRr6TU
         dGTxlcgmh+9Lg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, pc@cjr.nz,
        lsahlber@redhat.com, dhowells@redhat.com, ematsumiya@suse.de,
        pc@manguebit.com, vl@samba.org, metze@samba.org
Subject: [PATCH AUTOSEL 6.1 07/15] cifs: fix max_credits implementation
Date:   Mon, 26 Jun 2023 17:50:23 -0400
Message-Id: <20230626215031.179159-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215031.179159-1-sashal@kernel.org>
References: <20230626215031.179159-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
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

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 5e90aa21eb1372736e08cee0c0bf47735c5c4b95 ]

The current implementation of max_credits on the client does
not work because the CreditRequest logic for several commands
does not take max_credits into account.

Still, we can end up asking the server for more credits, depending
on the number of credits in flight. For this, we need to
limit the credits while parsing the responses too.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c |  2 ++
 fs/cifs/smb2pdu.c | 32 ++++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 759a7d7b3ddfe..4fd377185c2ca 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -34,6 +34,8 @@ static int
 change_conf(struct TCP_Server_Info *server)
 {
 	server->credits += server->echo_credits + server->oplock_credits;
+	if (server->credits > server->max_credits)
+		server->credits = server->max_credits;
 	server->oplock_credits = server->echo_credits = 0;
 	switch (server->credits) {
 	case 0:
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 537e8679900b8..36739ea5036db 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1312,7 +1312,12 @@ SMB2_sess_alloc_buffer(struct SMB2_sess_data *sess_data)
 	}
 
 	/* enough to enable echos and oplocks and one max size write */
-	req->hdr.CreditRequest = cpu_to_le16(130);
+	if (server->credits >= server->max_credits)
+		req->hdr.CreditRequest = cpu_to_le16(0);
+	else
+		req->hdr.CreditRequest = cpu_to_le16(
+			min_t(int, server->max_credits -
+			      server->credits, 130));
 
 	/* only one of SMB2 signing flags may be set in SMB2 request */
 	if (server->sign)
@@ -1907,7 +1912,12 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	rqst.rq_nvec = 2;
 
 	/* Need 64 for max size write so ask for more in case not there yet */
-	req->hdr.CreditRequest = cpu_to_le16(64);
+	if (server->credits >= server->max_credits)
+		req->hdr.CreditRequest = cpu_to_le16(0);
+	else
+		req->hdr.CreditRequest = cpu_to_le16(
+			min_t(int, server->max_credits -
+			      server->credits, 64));
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
@@ -4285,6 +4295,7 @@ smb2_async_readv(struct cifs_readdata *rdata)
 	struct TCP_Server_Info *server;
 	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
 	unsigned int total_len;
+	int credit_request;
 
 	cifs_dbg(FYI, "%s: offset=%llu bytes=%u\n",
 		 __func__, rdata->offset, rdata->bytes);
@@ -4316,7 +4327,13 @@ smb2_async_readv(struct cifs_readdata *rdata)
 	if (rdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(rdata->bytes,
 						SMB2_MAX_BUFFER_SIZE));
-		shdr->CreditRequest = cpu_to_le16(le16_to_cpu(shdr->CreditCharge) + 8);
+		credit_request = le16_to_cpu(shdr->CreditCharge) + 8;
+		if (server->credits >= server->max_credits)
+			shdr->CreditRequest = cpu_to_le16(0);
+		else
+			shdr->CreditRequest = cpu_to_le16(
+				min_t(int, server->max_credits -
+						server->credits, credit_request));
 
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 		if (rc)
@@ -4526,6 +4543,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 	unsigned int total_len;
 	struct cifs_io_parms _io_parms;
 	struct cifs_io_parms *io_parms = NULL;
+	int credit_request;
 
 	if (!wdata->server)
 		server = wdata->server = cifs_pick_channel(tcon->ses);
@@ -4643,7 +4661,13 @@ smb2_async_writev(struct cifs_writedata *wdata,
 	if (wdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(wdata->bytes,
 						    SMB2_MAX_BUFFER_SIZE));
-		shdr->CreditRequest = cpu_to_le16(le16_to_cpu(shdr->CreditCharge) + 8);
+		credit_request = le16_to_cpu(shdr->CreditCharge) + 8;
+		if (server->credits >= server->max_credits)
+			shdr->CreditRequest = cpu_to_le16(0);
+		else
+			shdr->CreditRequest = cpu_to_le16(
+				min_t(int, server->max_credits -
+						server->credits, credit_request));
 
 		rc = adjust_credits(server, &wdata->credits, io_parms->length);
 		if (rc)
-- 
2.39.2

