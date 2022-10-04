Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7428D5F3CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJDGYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJDGYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:24:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4741120;
        Mon,  3 Oct 2022 23:24:38 -0700 (PDT)
Received: from lenovo.Home (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 037C0660225F;
        Tue,  4 Oct 2022 07:24:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664864677;
        bh=e7N33XmmW7DJXwdVzcj7bT09AaYcxc7AS55NGR1APok=;
        h=From:To:Cc:Subject:Date:From;
        b=jw/oCwLcKbVwJb24RT2XEeOQkE80heVoZsJoWzwUFbWARHXH+VzQL3lp7cFYjXo0L
         Ami50vmN1nhLy103aTWy4uqEyJNnQtx4PJqyAHWHiNbck7uX9eGoBV3tIaxx5frDlN
         tI3bV02fFATt+1F8qjNcPQT6vgH874VOehWH6YYtAWh248AgcjoXZ5daWBY7hXAaKd
         DUcDDJlAeNmWsPPgKdrhYrmaxQu75CHSNf/G+fRd312j8Cid2LkFw2pT6YmM1oA5D8
         WPEmMZrZTaBHsfZrKe6JxBrprfpnZ0cb5F+dCQz+LOjLpp36CRRwGtmyrgVv++qhVQ
         POBS/BhDIZzZg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cifs: remove initialization value
Date:   Tue,  4 Oct 2022 11:23:32 +0500
Message-Id: <20221004062333.416225-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't initialize the rc as its value is being overwritten before its
use.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 0600f0a07628..2bf43c892ae6 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -879,7 +879,7 @@ SMB2_negotiate(const unsigned int xid,
 	struct smb2_negotiate_rsp *rsp;
 	struct kvec iov[1];
 	struct kvec rsp_iov;
-	int rc = 0;
+	int rc;
 	int resp_buftype;
 	int blob_offset, blob_length;
 	char *security_blob;
-- 
2.30.2

