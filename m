Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA486636BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjAJBi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjAJBiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:38:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03B203D;
        Mon,  9 Jan 2023 17:38:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BBE9614A7;
        Tue, 10 Jan 2023 01:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54760C433D2;
        Tue, 10 Jan 2023 01:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673314733;
        bh=0KsXPwa+vpt2uUTuNq9JANlQlF0R1EPm/dJEZEJYJRs=;
        h=Date:From:To:Cc:Subject:From;
        b=MeU5vqR8R1uSRt9MD3bd3OrrRjIKXeUY0UbHixtqY/UGpVkda6zofuFcj9tc2X7ZY
         LGr+WYf3JykV0N+ugVYi+j8TZBz/EtV4zyy6Z81IOB4AFfrdleLPDXFESRi6cJUoS6
         7QKRubuUaS47zGylZ22cekIk2QZyAVjr557j/eqND0TYwj9y8CsH7exppiJU/N61ib
         l9LtIkojiEQyu3cfmUEm8yVgmCTo5ioUILyyr1IdoP7zdmHTvY7PRte0hRNMTCovXb
         EalNqY1wl4iSNJz69le28Y7UsZ3z4+DxUapCoxxSbUOHn5vgRUYMYHkbvyxeSprQwk
         kgvdH0w2y1ZBw==
Date:   Mon, 9 Jan 2023 19:39:00 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] cifs: Replace zero-length arrays with flexible-array
 members
Message-ID: <Y7zBtCZ/eRJCpjBf@work>
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

Zero-length arrays are deprecated[1] and we are moving towards
adopting C99 flexible-array members instead. So, replace zero-length
arrays in a couple of structures with flex-array members.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/cifs/ntlmssp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/ntlmssp.h b/fs/cifs/ntlmssp.h
index 55758b9ec877..2c5dde2ece58 100644
--- a/fs/cifs/ntlmssp.h
+++ b/fs/cifs/ntlmssp.h
@@ -83,7 +83,7 @@ typedef struct _NEGOTIATE_MESSAGE {
 	SECURITY_BUFFER WorkstationName;	/* RFC 1001 and ASCII */
 	/* SECURITY_BUFFER for version info not present since we
 	   do not set the version is present flag */
-	char DomainString[0];
+	char DomainString[];
 	/* followed by WorkstationString */
 } __attribute__((packed)) NEGOTIATE_MESSAGE, *PNEGOTIATE_MESSAGE;
 
@@ -135,7 +135,7 @@ typedef struct _AUTHENTICATE_MESSAGE {
 	__le32 NegotiateFlags;
 	/* SECURITY_BUFFER for version info not present since we
 	   do not set the version is present flag */
-	char UserString[0];
+	char UserString[];
 } __attribute__((packed)) AUTHENTICATE_MESSAGE, *PAUTHENTICATE_MESSAGE;
 
 /*
-- 
2.34.1

