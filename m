Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5674F3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGKPp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjGKPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB295
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689090296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YbWTeU1PSY53BYBv0g/QJEl8QodT4t6R2l7/kEZ8Rmg=;
        b=T1az/EgyTILtcIWd3TNoKVlmZIfCn47l5BNp+kgPwDZKdK2tss4TDzE9awBjUZ0YPtww4p
        K8Kkme/0EF97+M2zwbtq4YwqjfGQnPJ9FWMfUNDooZtdyG10XAPQzjeFoR7Dg0RBX6glou
        41A1AqixzvjeQHP5sZJQt9eCereLFEs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-W7MyiY4zNFWDpOZFhCt0Wg-1; Tue, 11 Jul 2023 11:44:53 -0400
X-MC-Unique: W7MyiY4zNFWDpOZFhCt0Wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 212B81C2BD67;
        Tue, 11 Jul 2023 15:44:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B39B200AD6E;
        Tue, 11 Jul 2023 15:44:51 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, bluca@debian.org,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
Subject: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Date:   Tue, 11 Jul 2023 11:44:49 -0400
Message-Id: <20230711154449.1378385-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*Important*: this is just an RFC, as I am not expert in this area and
I don't know what's the best way to achieve this.

v2:
* add standard "sbat,1,SBAT Version,..." header string

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
 arch/x86/boot/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9e38ffaadb5d..6982a50ba0c0 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -83,6 +83,9 @@ cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
 
 $(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build FORCE
 	$(call if_changed,image)
+	@$(kecho) "sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md" > linux.sbat
+	@$(kecho) "linux,1,The Linux Developers,linux,$(KERNELVERSION),https://linux.org" >> linux.sbat;
+	$(OBJCOPY) --set-section-alignment '.sbat=512' --add-section .sbat=linux.sbat $@;
 	@$(kecho) 'Kernel: $@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
 
 OBJCOPYFLAGS_vmlinux.bin := -O binary -R .note -R .comment -S
-- 
2.39.1

