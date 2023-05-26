Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89527125AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbjEZLg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbjEZLg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F56DE47
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685100902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IMHlvlz6CKzHL2wE0mYlxFl6H+erPJBHzeUTjMW5vZI=;
        b=MreF9fvn3bdfhGCMadFhejZHtoJjxkBxyfmn1p+AWGlr4g7Qij47Hh5hb+QPUlxXhf1wol
        RsUJ9OQhJFX23hL6IrJJc6BmwvKtJriA6wsF+s1XBmvrStKawkb1YoHodAYJswphaUYSXN
        oYahEGOWBi5mav3FkCrGRgXXN5w9JpU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-Fq5P_uGwNgawY86m8cYzKA-1; Fri, 26 May 2023 07:34:58 -0400
X-MC-Unique: Fq5P_uGwNgawY86m8cYzKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB1AA801224;
        Fri, 26 May 2023 11:34:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE04240CFD45;
        Fri, 26 May 2023 11:34:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
cc:     dhowells@redhat.com, Kenny Ho <Kenny.Ho@amd.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Andrew Lunn <andrew@lunn.ch>,
        David Laight <David.Laight@ACULAB.COM>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Truncate UTS_RELEASE for rxrpc version 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <654973.1685100894.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 26 May 2023 12:34:54 +0100
Message-ID: <654974.1685100894@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    =

UTS_RELEASE has a maximum length of 64 which can cause rxrpc_version to
exceed the 65 byte message limit.

Per the rx spec[1]: "If a server receives a packet with a type value of 13=
,
and the client-initiated flag set, it should respond with a 65-byte payloa=
d
containing a string that identifies the version of AFS software it is
running."

The current implementation causes a compile error when WERROR is turned on
and/or UTS_RELEASE exceeds the length of 49 (making the version string mor=
e
than 64 characters).

Fix this by generating the string during module initialisation and limitin=
g
the UTS_RELEASE segment of the string does not exceed 49 chars.  We need t=
o
make sure that the 64 bytes includes "linux-" at the front and " AF_RXRPC"
at the back as this may be used in pattern matching.

Fixes: 44ba06987c0b ("RxRPC: Handle VERSION Rx protocol packets")
Reported-by: Kenny Ho <Kenny.Ho@amd.com>
Link: https://lore.kernel.org/r/20230523223944.691076-1-Kenny.Ho@amd.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Kenny Ho <Kenny.Ho@amd.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Andrew Lunn <andrew@lunn.ch>
cc: David Laight <David.Laight@ACULAB.COM>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
Link: https://web.mit.edu/kolya/afs/rx/rx-spec [1]
---
 net/rxrpc/af_rxrpc.c    |    1 +
 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/local_event.c |   11 ++++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 31f738d65f1c..da0b3b5157d5 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -980,6 +980,7 @@ static int __init af_rxrpc_init(void)
 	BUILD_BUG_ON(sizeof(struct rxrpc_skb_priv) > sizeof_field(struct sk_buff=
, cb));
 =

 	ret =3D -ENOMEM;
+	rxrpc_gen_version_string();
 	rxrpc_call_jar =3D kmem_cache_create(
 		"rxrpc_call_jar", sizeof(struct rxrpc_call), 0,
 		SLAB_HWCACHE_ALIGN, NULL);
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 5d44dc08f66d..e8e14c6f904d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1068,6 +1068,7 @@ int rxrpc_get_server_data_key(struct rxrpc_connectio=
n *, const void *, time64_t,
 /*
  * local_event.c
  */
+void rxrpc_gen_version_string(void);
 void rxrpc_send_version_request(struct rxrpc_local *local,
 				struct rxrpc_host_header *hdr,
 				struct sk_buff *skb);
diff --git a/net/rxrpc/local_event.c b/net/rxrpc/local_event.c
index 5e69ea6b233d..993c69f97488 100644
--- a/net/rxrpc/local_event.c
+++ b/net/rxrpc/local_event.c
@@ -16,7 +16,16 @@
 #include <generated/utsrelease.h>
 #include "ar-internal.h"
 =

-static const char rxrpc_version_string[65] =3D "linux-" UTS_RELEASE " AF_=
RXRPC";
+static char rxrpc_version_string[65]; // "linux-" UTS_RELEASE " AF_RXRPC"=
;
+
+/*
+ * Generate the VERSION packet string.
+ */
+void rxrpc_gen_version_string(void)
+{
+	snprintf(rxrpc_version_string, sizeof(rxrpc_version_string),
+		 "linux-%.49s AF_RXRPC", UTS_RELEASE);
+}
 =

 /*
  * Reply to a version request

