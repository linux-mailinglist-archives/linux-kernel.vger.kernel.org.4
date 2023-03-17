Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACAA6BF27B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCQU2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCQU2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89902A616B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679084880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsYNbSh5zaQpqPToVrw2INmBUKfltsbn27ZhrwN66l0=;
        b=bGWVKGWvrcbadStpkpb1OHnBuEuhkUn7jUc5A2jt1i1eZ+GyQD6sAdI3VMsXBkwR9J9Sna
        9+pXYE3sIg/mZvE/cpPboLnj6Qo0ZowN9SoEjk8yTwpbFN3eu/K/BCoGrjv8DAOG29wlmc
        9mPR3ondoqqSXoW2atT7HuwAx9A04Wo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-BMu_1d4VN-CdyMOrQPqmSw-1; Fri, 17 Mar 2023 16:27:57 -0400
X-MC-Unique: BMu_1d4VN-CdyMOrQPqmSw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C41153806737;
        Fri, 17 Mar 2023 20:27:56 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12E05492B00;
        Fri, 17 Mar 2023 20:27:56 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] uapi nbd: add cookie alias to handle
Date:   Fri, 17 Mar 2023 15:27:47 -0500
Message-Id: <20230317202749.419094-4-eblake@redhat.com>
In-Reply-To: <20230317202749.419094-1-eblake@redhat.com>
References: <20230317202749.419094-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
response back to the request).  Many client-side NBD implementations
(both servers and clients) have instead used 'uint64_t cookie' or
similar, as it is easier to directly assign an integer than to futz
around with memcpy.  In fact, upstream documentation is now
encouraging this shift in terminology:
https://lists.debian.org/nbd/2023/03/msg00031.html

Accomplish this by use of an anonymous union to provide the alias for
anyone getting the definition from the uapi; this does not break
existing clients, while exposing the nicer name for those who prefer
it.  Note that block/nbd.c still uses the term handle (in fact, it
actually combines a 32-bit cookie and a 32-bit tag into the 64-bit
handle), but that internal usage is not changed the public uapi, since
no compliant NBD server has any reason to inspect or alter the 64
bits sent over the socket.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: swap order of anonymous union and add comments to list favored name
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

