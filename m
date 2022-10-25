Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB860CD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiJYNRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiJYNRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87211E4E63
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666703869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MAsS6j5/KUgYwehdScWVOm+WWLh2WflTE+nFerqwEQQ=;
        b=iRyHF6+3Wo5qhZvrZrOFIIJvWvxzDHHFUnIz9duFD5JxHgQVhcj5j8IrhP6kFAl9BPQ4xr
        CodUYcMURRqLLTshL3p/0RVXsVLPAUFJAsrSfju0jJx/4dm0lWUcaTRTMHK4EDuv87UksT
        hcmg+Kz0OCajr+MjXbHuMUTWtK+WanU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-3i9hSQetNHyKsM1G9Lodnw-1; Tue, 25 Oct 2022 09:17:47 -0400
X-MC-Unique: 3i9hSQetNHyKsM1G9Lodnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 270621C0878D;
        Tue, 25 Oct 2022 13:17:47 +0000 (UTC)
Received: from jtoppins.rdu.csb (unknown [10.22.17.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65B19C15BAB;
        Tue, 25 Oct 2022 13:17:46 +0000 (UTC)
From:   Jonathan Toppins <jtoppins@redhat.com>
To:     linux-kbuild@vger.kernel.org
Cc:     dzickus@redhat.com, kheib@redhat.com, jtornosm@redhat.com,
        ihuguet@redhat.com, Ivan Vecera <ivecera@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next] kbuild: add ability to make source rpm buildable using koji
Date:   Tue, 25 Oct 2022 09:17:30 -0400
Message-Id: <5b59fdb7db34f5292b1d138939c6b70b2b2039dd.1666703850.git.jtoppins@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 scripts/Makefile.package | 10 ++++++++++
 scripts/package/mkspec   |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 8bbcced67c22..e0830a870394 100644
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
+	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE) -ts $(KERNELPATH).tar.gz \
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

