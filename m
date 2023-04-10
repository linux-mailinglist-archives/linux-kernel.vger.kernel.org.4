Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077EF6DCA69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjDJSHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDJSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267F5270B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681149981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HA+7lLyZ1oxCrCJupKCuxH2wDIL+IOS4kMpqLjNfmE=;
        b=JKK1D8bMwMRBIGMdURTsRcmVyoSngQKU+fgqBaPnIFjTUBt4ix+RsCv6tLnRZTqXjT6f9n
        L0Q+E97Uig1tI/sXoKlJQ/obX8IhqHxSIAId/jkl/XxcbmkP2HITzo0fPSj1i5vJQ2JMC7
        Yx47mS9EUbJB16zigYbRm8+sY7J0Ry8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-GG4NWdOWPTqtEA-DGsfx5A-1; Mon, 10 Apr 2023 14:06:19 -0400
X-MC-Unique: GG4NWdOWPTqtEA-DGsfx5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E64C185A78F;
        Mon, 10 Apr 2023 18:06:17 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2607492C13;
        Mon, 10 Apr 2023 18:06:16 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] uapi nbd: add cookie alias to handle
Date:   Mon, 10 Apr 2023 13:06:09 -0500
Message-Id: <20230410180611.1051618-3-eblake@redhat.com>
In-Reply-To: <20230410180611.1051618-1-eblake@redhat.com>
References: <20230410180611.1051618-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uapi <linux/nbd.h> header declares a 'char handle[8]' per request;
which is overloaded in English (are you referring to "handle" the
verb, such as handling a signal or writing a callback handler, or
"handle" the noun, the value used in a lookup table to correlate a
response back to the request).  Many user-space NBD implementations
(both servers and clients) have instead used 'uint64_t cookie' or
similar, as it is easier to directly assign an integer than to futz
around with memcpy.  In fact, upstream documentation is now
encouraging this shift in terminology:
https://github.com/NetworkBlockDevice/nbd/commit/ca4392eb2b

Accomplish this by use of an anonymous union to provide the alias for
anyone getting the definition from the uapi; this does not break
existing clients, while exposing the nicer name for those who prefer
it.  Note that block/nbd.c still uses the term handle (in fact, it
actually combines a 32-bit cookie and a 32-bit tag into the 64-bit
handle), but that internal usage is not changed by the public uapi,
since no compliant NBD server has any reason to inspect or alter the
64 bits sent over the socket.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>

---
v2: swap order of anonymous union and add comments to list favored name
v3: tweak link in commit message, add R-b
---
 include/uapi/linux/nbd.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index 8797387caaf7..80ce0ef43afd 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -12,7 +12,7 @@
  * 2004/02/19 Paul Clements
  *            Removed PARANOIA, plus various cleanup and comments
  * 2023 Copyright Red Hat
- *            Link to userspace extensions.
+ *            Link to userspace extensions, favor cookie over handle.
  */

 #ifndef _UAPILINUX_NBD_H
@@ -81,7 +81,10 @@ enum {
 struct nbd_request {
 	__be32 magic;	/* NBD_REQUEST_MAGIC	*/
 	__be32 type;	/* See NBD_CMD_*	*/
-	char handle[8];
+	union {
+		__be64 cookie;	/* Opaque identifier for request	*/
+		char handle[8];	/* older spelling of cookie		*/
+	};
 	__be64 from;
 	__be32 len;
 } __attribute__((packed));
@@ -93,6 +96,9 @@ struct nbd_request {
 struct nbd_reply {
 	__be32 magic;		/* NBD_REPLY_MAGIC	*/
 	__be32 error;		/* 0 = ok, else error	*/
-	char handle[8];		/* handle you got from request	*/
+	union {
+		__be64 cookie;	/* Opaque identifier from request	*/
+		char handle[8];	/* older spelling of cookie		*/
+	};
 };
 #endif /* _UAPILINUX_NBD_H */
-- 
2.39.2

