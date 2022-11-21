Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B42632731
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiKUPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiKUPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:00:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6589D2DCD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669042142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8s15f6YbiNJZ1KFlIgHMjRgcF6TQvT9XGT2eZS0P2qA=;
        b=HvxRcP4l4ekoEITPWCGaehxXFdBHWUkpkV864404ZbiczR9IyZe8QpQ3UHJI3Jz/n4nIaj
        dzrjdaMW2KvipDnFL39ubcP3qx2MNu8facY3KTFjYt3/x3/IPHoRlrXBib+bJkSTIwK067
        GLO1BFrnvhoVcRG2ZjkqwjPNdWOihlQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-IAA0qnkINS2XAe7m2x-rvg-1; Mon, 21 Nov 2022 09:48:59 -0500
X-MC-Unique: IAA0qnkINS2XAe7m2x-rvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A01F51C008A5;
        Mon, 21 Nov 2022 14:48:58 +0000 (UTC)
Received: from jtoppins.rdu.csb (unknown [10.22.10.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84BFE2027062;
        Mon, 21 Nov 2022 14:48:57 +0000 (UTC)
From:   Jonathan Toppins <jtoppins@redhat.com>
To:     linux-kbuild@vger.kernel.org
Cc:     masahiroy@kernel.org, dzickus@redhat.com, ihuguet@redhat.com,
        ivecera@redhat.com, jtoppins@redhat.com, jtornosm@redhat.com,
        kheib@redhat.com, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH next v2] kbuild: add ability to make source rpm buildable using koji
Date:   Mon, 21 Nov 2022 09:48:45 -0500
Message-Id: <d6d5ce3169da8559cd20d20889849546cc69be50.1669042125.git.jtoppins@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Vecera <ivecera@redhat.com>

Changes:
- added new target 'srcrpm-pkg' to generate source rpm
- added required build tools to spec file
- removed locally compiled host tools to force their re-compile

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
Acked-by: Íñigo Huguet <ihuguet@redhat.com>
Tested-by: Ivan Vecera <ivecera@redhat.com>
---

Notes:
    v2:
     * updated UTS_MACHINE to be $(UTS_MACHINE)-linux
       suggested by Masahiro Yamada

 scripts/Makefile.package | 10 ++++++++++
 scripts/package/mkspec   |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 8bbcced67c22..1290f1c631fb 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -62,6 +62,16 @@ rpm-pkg:
 	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ta $(KERNELPATH).tar.gz \
 	--define='_smp_mflags %{nil}'
 
+# srcrpm-pkg
+# ---------------------------------------------------------------------------
+PHONY += srcrpm-pkg
+srcrpm-pkg:
+	$(MAKE) clean
+	$(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
+	$(call cmd,src_tar,$(KERNELPATH),kernel.spec)
+	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ts $(KERNELPATH).tar.gz \
+	--define='_smp_mflags %{nil}' --define='_srcrpmdir $(srctree)'
+
 # binrpm-pkg
 # ---------------------------------------------------------------------------
 PHONY += binrpm-pkg
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 70392fd2fd29..dda00a948a01 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -33,6 +33,8 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
 --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
 --exclude=.config.old --exclude=.missing-syscalls.d --exclude=*.s"
 
+test -n "$LOCALVERSION" && MAKE="$MAKE LOCALVERSION=$LOCALVERSION"
+
 # We can label the here-doc lines for conditional output to the spec file
 #
 # Labels:
@@ -49,6 +51,9 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	URL: https://www.kernel.org
 $S	Source: kernel-$__KERNELRELEASE.tar.gz
 	Provides: $PROVIDES
+$S	BuildRequires: bc binutils bison dwarves elfutils-libelf-devel flex
+$S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
+
 	# $UTS_MACHINE as a fallback of _arch in case
 	# /usr/lib/rpm/platform/*/macros was not included.
 	%define _arch %{?_arch:$UTS_MACHINE}
@@ -80,6 +85,8 @@ $S$M	against the $__KERNELRELEASE kernel package.
 $S$M
 $S	%prep
 $S	%setup -q
+$S	rm -f scripts/basic/fixdep scripts/kconfig/conf
+$S	rm -f tools/objtool/{fixdep,objtool}
 $S
 $S	%build
 $S	$MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
-- 
2.31.1

