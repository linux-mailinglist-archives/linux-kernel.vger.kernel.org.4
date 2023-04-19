Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700E26E732F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjDSGZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjDSGZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:25:07 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0AB72D45;
        Tue, 18 Apr 2023 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ev0iO
        zag+i9qMKa+8ZXpBQVtIc2vDR7hLqzGU0Ksojk=; b=EAiSYUQibU/LVu7jXJeMr
        B0MFVq4/8RJ1NevqPt8eNVq+umeqxcdajlCKSgpISE8LM++bD+BnPoRrYB09E0cJ
        dV2vm+tyIxsDJSRVcn1FTQdQJTR6IIXtrR65jsreJBuJ05wkpzuHcFHirNiMQf18
        9QWCpWLpug4bJQViyGcdKI=
Received: from jiwei-VirtualBox.lenovo.com (unknown [111.205.43.230])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wC3Hv9JiD9k7lSgBQ--.999S2;
        Wed, 19 Apr 2023 14:20:57 +0800 (CST)
From:   jiweisun126@126.com
To:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, sunjw10@lenovo.com
Cc:     jiwei.sun.bj@qq.com
Subject: [PATCH] kbuild: rpm-pkg: fix rpm-pkg build error
Date:   Wed, 19 Apr 2023 14:20:56 +0800
Message-Id: <20230419062056.7964-1-jiweisun126@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3Hv9JiD9k7lSgBQ--.999S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF15uFW5WryxJF1kKF1DGFg_yoW5JrW3pw
        s3urZxGa1UKF95A3WUCw4rW3y7XryDKF4UWa48Xw18tryqyFyIvanrKFWrJr9Iqa48t34Y
        gr1DuF18KrW7CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5CztUUUUU=
X-Originating-IP: [111.205.43.230]
X-CM-SenderInfo: 5mlzvxpvxqijaw6rjloofrz/1tbiXw9WjWIxn4SuHgAAsz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiwei Sun <sunjw10@lenovo.com>

The following error will trigger when building rpm-pkg
$ make rpm-pkg
  SYNC    include/config/auto.conf.cmd
  HOSTLD  scripts/kconfig/conf
  UPD     include/config/kernel.release
  UPD     .tmp_HEAD
  ARCHIVE linux.tar.gz
sh ./scripts/package/mkspec >./kernel.spec
rpmbuild  --target x86_64-linux -bs kernel.spec \
--define='_smp_mflags %{nil}' --define='_sourcedir rpmbuild/SOURCES' --define='_srcrpmdir .'
Building target platforms: x86_64-linux
Building for target x86_64-linux
Wrote: ./kernel-6.3.0_rc7-47.src.rpm
rpmbuild  --target x86_64-linux -rb kernel-6.3.0_rc7-47.src.rpm \
--define='_smp_mflags %{nil}'
Installing kernel-6.3.0_rc7-47.src.rpm
Building target platforms: x86_64-linux
Building for target x86_64-linux
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.QtGSXP
+ umask 022
+ cd /mnt/datapart/rpmbuild/BUILD
+ cd /mnt/datapart/rpmbuild/BUILD
+ rm -rf linux
+ /usr/bin/gzip -dc /mnt/datapart/rpmbuild/SOURCES/linux.tar.gz
+ /usr/bin/tar -xof -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd linux
/var/tmp/rpm-tmp.QtGSXP: line 40: cd: linux: No such file or directory
error: Bad exit status from /var/tmp/rpm-tmp.QtGSXP (%prep)

There is linux.tar, not linux, and the linux.tar.gz is create by the following
 quiet_cmd_archive = ARCHIVE $@
       cmd_archive = git -C $(srctree) $(git-config-tar$(suffix $@)) archive \
                     --output=$$(realpath $@) --prefix=$(basename $@)/ $(archive-args)
Here the $@ is linux.tar.gz, and $(basename $@) will be linux.tar,
The above fact is the cause, so use $(basename $(basename $@)) to get the right directory name.

Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 scripts/Makefile.package | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 4d90691505b1..3718ecdf9edf 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -49,7 +49,7 @@ git-config-tar.zst = -c tar.tar.zst.command="$(ZSTD)"
 
 quiet_cmd_archive = ARCHIVE $@
       cmd_archive = git -C $(srctree) $(git-config-tar$(suffix $@)) archive \
-                    --output=$$(realpath $@) --prefix=$(basename $@)/ $(archive-args)
+                    --output=$$(realpath $@) --prefix=$(basename $(basename $@))/ $(archive-args)
 
 # Linux source tarball
 # ---------------------------------------------------------------------------
-- 
2.27.0

