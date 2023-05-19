Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61269709DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjESRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjESRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E719A3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684516887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2KKXfGDHxrX+6XLdqChQuTj9B0h9lQtkKNegqRI3p6E=;
        b=dowl3uz1qy5reIHD8vdLlRZYl5H488JdhFTSjwZiP1EFmgDu9N0iAumPwLiULCQm5cml5z
        x1fpjObxSU+ca+0TYEfwnsvA/Wt82uXXAfWpAeHmEkIB4vaZ1sHKo8DPdWuT+nyymjZd3W
        f8+I8x0q1rtJnPKwzeXJXrtllq7eC8s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-OtPTiJeUNUe2Hj4TZRRGtg-1; Fri, 19 May 2023 13:21:21 -0400
X-MC-Unique: OtPTiJeUNUe2Hj4TZRRGtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 712A785A5A8;
        Fri, 19 May 2023 17:21:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA3C640D1B60;
        Fri, 19 May 2023 17:21:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: Allow the cache to be non-root
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1853229.1684516880.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 19 May 2023 18:21:20 +0100
Message-ID: <1853230.1684516880@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    =

Set mode 0600 on files in the cache so that cachefilesd can run as an
unprivileged user rather than leaving the files all with 0.  Directories
are already set to 0700.

Userspace then needs to set the uid and gid before issuing the "bind"
command and the cache must've been chown'd to those IDs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 82219a8f6084..66482c193e86 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -451,7 +451,8 @@ struct file *cachefiles_create_tmpfile(struct cachefil=
es_object *object)
 =

 	ret =3D cachefiles_inject_write_error();
 	if (ret =3D=3D 0) {
-		file =3D vfs_tmpfile_open(&nop_mnt_idmap, &parentpath, S_IFREG,
+		file =3D vfs_tmpfile_open(&nop_mnt_idmap, &parentpath,
+					S_IFREG | 0600,
 					O_RDWR | O_LARGEFILE | O_DIRECT,
 					cache->cache_cred);
 		ret =3D PTR_ERR_OR_ZERO(file);

