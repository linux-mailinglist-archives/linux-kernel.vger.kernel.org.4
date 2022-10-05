Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709BB5F4D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJEBvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJEBvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E6F67CB7;
        Tue,  4 Oct 2022 18:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A96FF61561;
        Wed,  5 Oct 2022 01:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950DFC433C1;
        Wed,  5 Oct 2022 01:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664934706;
        bh=wOaLX9hy7w+bjpE2Xl5yxqyIXCOpVqaKuZ4ptujsPE4=;
        h=Date:From:To:Cc:Subject:From;
        b=ZvKZ9NcdziYRDfTGtNb3WeWIjIlM0RUYLnNTUvFa/BeU16lrPaD+Rvqx58ZFa+zT2
         adkwaCetZMKwh8lwQhKQVmdgZN/9CtFZ0wLUMJE6l5qytXlwaZ2OCyfMNci1F203+0
         d8ydbYMXCylkH0Ep3bj4ZQQ3K4lCt+dED3JGed0UgFqTk99+dCxUd6RXQJBMgIKhpe
         kxAmoGbLAHxVcdo1qbKvlkthFzLwawYbfYXdld2HWKHX7YUtACL0lcQ0gE71GOjL/1
         zadah1PtUGkQ3baQQfGWknTHYEyOvCgXEX7e2MuddefcIO+ddJzNw0DjuZ45H5drXF
         HZlqotXn1Jp2Q==
Date:   Tue, 4 Oct 2022 20:51:39 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] cifs: Replace a couple of one-element arrays with
 flexible-array members
Message-ID: <YzzjKyHDuFoQAVCu@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element arrays with flexible-array
member in structs negotiate_req and extended_response, and refactor the
rest of the code, accordingly.

Also, make use of the DECLARE_FLEX_ARRAY() helper to declare flexible
array member EncryptionKey in union u. This new helper allows for
flexible-array members in unions.

Change pointer notation to proper array notation in a call to memcpy()
where flexible-array member DialectsArray is being used as destination
argument.

Important to mention is that doing a build before/after this patch results
in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/229
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/cifs/cifspdu.h | 7 ++++---
 fs/cifs/cifssmb.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
index aeba371c4c70..d1abaeea974a 100644
--- a/fs/cifs/cifspdu.h
+++ b/fs/cifs/cifspdu.h
@@ -483,7 +483,7 @@ put_bcc(__u16 count, struct smb_hdr *hdr)
 typedef struct negotiate_req {
 	struct smb_hdr hdr;	/* wct = 0 */
 	__le16 ByteCount;
-	unsigned char DialectsArray[1];
+	unsigned char DialectsArray[];
 } __attribute__((packed)) NEGOTIATE_REQ;
 
 #define MIN_TZ_ADJ (15 * 60) /* minimum grid for timezones in seconds */
@@ -508,13 +508,14 @@ typedef struct negotiate_rsp {
 	__u8 EncryptionKeyLength;
 	__u16 ByteCount;
 	union {
-		unsigned char EncryptionKey[1];	/* cap extended security off */
+		/* cap extended security off */
+		DECLARE_FLEX_ARRAY(unsigned char, EncryptionKey);
 		/* followed by Domain name - if extended security is off */
 		/* followed by 16 bytes of server GUID */
 		/* then security blob if cap_extended_security negotiated */
 		struct {
 			unsigned char GUID[SMB1_CLIENT_GUID_SIZE];
-			unsigned char SecurityBlob[1];
+			unsigned char SecurityBlob[];
 		} __attribute__((packed)) extended_response;
 	} __attribute__((packed)) u;
 } __attribute__((packed)) NEGOTIATE_RSP;
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 7aa91e272027..7a808e41b1b8 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -465,7 +465,7 @@ CIFSSMBNegotiate(const unsigned int xid,
 	for (i = 0; i < CIFS_NUM_PROT; i++) {
 		size_t len = strlen(protocols[i].name) + 1;
 
-		memcpy(pSMB->DialectsArray+count, protocols[i].name, len);
+		memcpy(&pSMB->DialectsArray[count], protocols[i].name, len);
 		count += len;
 	}
 	inc_rfc1001_len(pSMB, count);
-- 
2.34.1

