Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9996EAD0D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjDUOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjDUOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D9F1700
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682087744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UCQL2D9su8wjwOrs6IuTNGHSeQSL9lst6CDlj1GlHvQ=;
        b=PKZudY8O6yePEMi7xcs26xcIEvvBWW62N64xsnRuX67eF0RvSam4qgi6X/C9zJ3561pWUv
        kIsUwIO3E7oiEsRTWCS5X2/ouCiWMcTiO0y/sFbU+Ys2AxD6CocPOArrkHid3wAqXfkkgb
        RJC+q3sVYwEOLQ9cdh398OrkrOhSmKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-HjtImQA4Nzy9mg_o0W6siw-1; Fri, 21 Apr 2023 10:35:41 -0400
X-MC-Unique: HjtImQA4Nzy9mg_o0W6siw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 084BC101A54F;
        Fri, 21 Apr 2023 14:35:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ACFC1121318;
        Fri, 21 Apr 2023 14:35:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Ekaterina Orlova <vorobushek.ok@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <158286.1682087739.1@warthog.procyon.org.uk>
Date:   Fri, 21 Apr 2023 15:35:39 +0100
Message-ID: <158287.1682087739@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you apply this, please?  It can probably wait for the merge window if you
don't want to apply it now as it only affects building the kernel.

Thanks,
David
---
From: Ekaterina Orlova <vorobushek.ok@gmail.com>

ASN.1: Fix check for strdup() success

It seems there is a misprint in the check of strdup() return code
that can lead to NULL pointer dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4520c6a49af8 ("X.509: Add simple ASN.1 grammar compiler")
Signed-off-by: Ekaterina Orlova <vorobushek.ok@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>
cc: James Bottomley <jejb@linux.ibm.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
cc: linux-kbuild@vger.kernel.org
Link: https://lore.kernel.org/r/20230315172130.140-1-vorobushek.ok@gmail.com/
---
 scripts/asn1_compiler.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index 7b6756a8c15d..4c3f645065a4 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -625,7 +625,7 @@ int main(int argc, char **argv)
 	p = strrchr(argv[1], '/');
 	p = p ? p + 1 : argv[1];
 	grammar_name = strdup(p);
-	if (!p) {
+	if (!grammar_name) {
 		perror(NULL);
 		exit(1);
 	}

