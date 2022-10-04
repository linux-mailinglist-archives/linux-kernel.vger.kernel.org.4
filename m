Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA85B5F3CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJDGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJDGYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:24:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8452F2ACE;
        Mon,  3 Oct 2022 23:24:41 -0700 (PDT)
Received: from lenovo.Home (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C351660226B;
        Tue,  4 Oct 2022 07:24:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664864680;
        bh=nsD45MICY1/StpyRVxzsvj75lhf0v0C421rqzuUFNa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEnZSOFoQ2rnZp7yXzHzzaqbX7xsDO5IUpE35W2lVt65jBHeiyKmRZ2CmskD0Zhee
         0CndLFDxCMO8jXVKgYX9isnMY42PrJyktpyNIV28Tpi2qr4JW1D3A+3PpFCFrFBUCi
         wUxO5TufnwWktwIIPITbA4v2Z7T556mLJqtfjOYaeNthSQuZIVO3FOjUyGhMwLKkiZ
         OPD1acL16lv8wnoeemwpR4X1/3vAL4yQQPWtDrvPxwoNLDu2iBcmQOhUZS/Hr+RXyX
         R257m1Vc+H5BH4s91sb2eKkzq4q/PQbEpuWN1tZYP4iDrBLXsqoJhkDC335DB4bcYj
         dPPB4RiVCwuiA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cifs: check returned value for error
Date:   Tue,  4 Oct 2022 11:23:33 +0500
Message-Id: <20221004062333.416225-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221004062333.416225-1-usama.anjum@collabora.com>
References: <20221004062333.416225-1-usama.anjum@collabora.com>
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

smb311_decode_neg_context() can return error. Its return value should be
checked for errors.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/cifs/smb2pdu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 2bf43c892ae6..c6e37352dbe1 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1089,11 +1089,14 @@ SMB2_negotiate(const unsigned int xid,
 		server->signing_algorithm = SIGNING_ALG_AES_CMAC;
 		server->signing_negotiated = false;
 
-		if (rsp->NegotiateContextCount)
+		if (rsp->NegotiateContextCount) {
 			rc = smb311_decode_neg_context(rsp, server,
 						       rsp_iov.iov_len);
-		else
+			if (rc)
+				goto neg_exit;
+		} else {
 			cifs_server_dbg(VFS, "Missing expected negotiate contexts\n");
+		}
 
 		/*
 		 * Some servers will not send a SMB2_SIGNING_CAPABILITIES context response (*),
-- 
2.30.2

