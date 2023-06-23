Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B197573B781
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjFWMhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjFWMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945671FE3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687523789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dtGrfm495E45d+YHItqZvu/mH6EDCO2k98c0kIi0BvU=;
        b=XDoWvXTR+oMzWCyiQ45iUv55hcu/WMw48FYZmf7BxhXAQPYo2gyWUfd199ttUABb+IX5h/
        v5HId7egTsaLRfb5uNuy2oyc6aIToPbU6MnM9wGtnZpR2B4fSxoCvrAihQFd5OAW5D+6RN
        1ZLYmrGdgJtuKvOQDHoHCy4p5DyAcAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-8i2q_hhINHGWIFsi3Xo9cw-1; Fri, 23 Jun 2023 08:36:26 -0400
X-MC-Unique: 8i2q_hhINHGWIFsi3Xo9cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F032C8E44E1;
        Fri, 23 Jun 2023 12:36:25 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55FDFC1ED97;
        Fri, 23 Jun 2023 12:36:25 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [RFC PATCH] x86/boot: add .sbat section to the bzImage
Date:   Fri, 23 Jun 2023 08:36:22 -0400
Message-Id: <20230623123622.4126234-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*Important*: this is just an RFC, as I am not expert in this area and
I don't know what's the best way to achieve this.

The aim of this patch is to add a .sbat section to the linux binary
(https://github.com/rhboot/shim/blob/main/SBAT.md).
We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
to revoke authorizations to specific signed PEs that were initially
considered as trusted. The reason might be for example a security issue
related to a specific linux release.

A .sbat is simply a section containing a string with the component name
and a version number. This version number is compared with the value in
OVMF_VARS, and if it's less than the variable, the binary is not trusted,
even if it is correctly signed.

Right now an UKI is built with a .sbat section containing the
systemd-stub sbat string (upstream + vendor), we would like to add
also a per-component specific string (ie vmlinux has its own sbat,
again upstream + vendor, each signed add-on its own and so on).
In this way, if a specific kernel version has an issue, we can revoke
it without compromising all other UKIs that are using a different
kernel with the same stub/initrd/something else.

Issues with this patch:
* the string is added in a file but it is never deleted
* if the code is not modified but make is issued again, objcopy will
  be called again and will fail because .sbat exists already, making
  compilation fail
* minor display issue: objcopy command is printed in the make logs

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 arch/x86/boot/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9e38ffaadb5d..65ff6fcf5372 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -83,6 +83,8 @@ cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
 
 $(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build FORCE
 	$(call if_changed,image)
+	@$(kecho) "linux,1,The Linux Developers,linux,$(KERNELVERSION),https://linux.org" > linux.sbat;
+	$(OBJCOPY) --set-section-alignment '.sbat=512' --add-section .sbat=linux.sbat $@;
 	@$(kecho) 'Kernel: $@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
 
 OBJCOPYFLAGS_vmlinux.bin := -O binary -R .note -R .comment -S
-- 
2.39.1

