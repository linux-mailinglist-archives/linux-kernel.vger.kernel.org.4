Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80472836D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjFHPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFHPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A52D5F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686237312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/3w9oyHcHeuXmqT1TkLSNVHo+F4uoLMw3KpXpP7tVL8=;
        b=eJz9M6jp0IVFHpA//yyLi2K98+f1zJf2Hu1i+n8AFwn4q7DD9er3GiRPzRc5Ul7sq3OYJZ
        vUZrjv/YLpAapZMjs7hD0pxw6XEPUBhQJoCtmp+iqCSlaOvtWnpLrsXBfbCy4YBgSD/4wp
        N+Ql+UNHDST28OT0mxLSoY/6HVd9ePU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-1LtaMsEfNDKBOh9S0kPYgA-1; Thu, 08 Jun 2023 11:15:03 -0400
X-MC-Unique: 1LtaMsEfNDKBOh9S0kPYgA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4282C3C0F424;
        Thu,  8 Jun 2023 15:15:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36EF0492B00;
        Thu,  8 Jun 2023 15:14:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
cc:     dhowells@redhat.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] build: Deal with change in "make --no-print-directory" behaviour change
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2427603.1686237298.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 08 Jun 2023 16:14:58 +0100
Message-ID: <2427604.1686237298@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro & the kbuild crew,

Here's a patch to fix a change in make behaviour in make-4.4.  It's almost
certainly the wrong solution, but it works for me for now.

Note that I tried just adding "--print-directory" to the $(MAKE) line afte=
r
the line I added, and that does seem to work - but it then prints a lot of
additional "entering directory" lines (though they all seem to be the same=
).

David
---
Emacs (and probably other IDEs) parse the "make: Entering directory" lines
in the build output so that they can correctly resolve relative pathnames
in messages from the compiler.  However, a change in make has broken this.
I think it might be:

        [/usr/share/doc/make/NEWS]
        ...
        Version 4.4 (31 Oct 2022)
        ...
        * WARNING: Backward-incompatibility!
          Previously if --no-print-directory was seen anywhere in the envi=
ronment or
          command line it would take precedence over any --print-directory=
.  Now, the
          last setting of directory printing options seen will be used, so=
 a command
          line such as "--no-print-directory -w" _will_ show directory ent=
ry/exits.

Doing a kernel build now only prints the directory passed to the "-C" flag
if present and no other directories.  This includes any build directory
indicated with "O=3D".  So if I do:

        make -C /my/data/linux O=3Dbuild

I see:

        make: Entering directory '/my/data/linux'

and all the path in messages emitted by the compiler are prefixed with "..=
"
- but then doing "M-x next-error" in emacs will prompt emacs to ask where
the file is rather than jumping to it because it can't find it.

On the previous version of Fedora with make-4.3, an extra line is emitted
by make:

        make[1]: Entering directory '/my/data/linux/build'

and that was sufficient for emacs to be able to resolve paths.

Fix this by manually printing the missing line.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Masahiro Yamada <masahiroy@kernel.org>
cc: Nathan Chancellor <nathan@kernel.org>
cc: Nick Desaulniers <ndesaulniers@google.com>
cc: Nicolas Schier <nicolas@fjasle.eu>
cc: linux-kbuild@vger.kernel.org
---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 836643eaefee..7f7c75087626 100644
--- a/Makefile
+++ b/Makefile
@@ -223,6 +223,7 @@ $(filter-out $(this-makefile), $(MAKECMDGOALS)) __all:=
 __sub-make
 =

 # Invoke a second make in the output directory, passing relevant variable=
s
 __sub-make:
+	@echo "make[1]: Entering directory '$(abs_objtree)'"
 	$(Q)$(MAKE) -C $(abs_objtree) -f $(abs_srctree)/Makefile $(MAKECMDGOALS)
 =

 endif # need-sub-make

