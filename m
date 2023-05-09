Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2F6FBFD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjEIHCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjEIHB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E09A2688;
        Tue,  9 May 2023 00:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACEBF62A2E;
        Tue,  9 May 2023 07:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25C0C433D2;
        Tue,  9 May 2023 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683615715;
        bh=9k++FdR+6rYCFlA3FaCYqkc/1LNnURTanvKd2FGb3I4=;
        h=From:Date:Subject:To:Cc:From;
        b=qAE2IQ6/3Kr6cA1tjAfJjzkqJww1WVtG16AXt40kVwldqlU6xjW7UEzegHSKzexLN
         YuTRgeBqIvehm4UDCH2FHrSpM+ewDgE7Huz89ZKLbg9vviU8HlBxlmTjvuUBGNEJ6M
         SthkHvH+p7rjjaVQaabaN2rK7jP1DjhJ9XVYhBFRw+baBh2j+cJ8lII2oRPyFovaNA
         FnXh07sI1aKzDXm5TOmmDRY3z5vZhQfhsbf1K3zdfOMkNdpdoTLaM6VK1nHijKMdyZ
         VvOv1QMwDj06fgSw3vfKMTIvFzm0nf2ENaAasJcqQceIJehmKfwWGSHEbR/vIHf91w
         m15CAZe1Bm/tA==
From:   Simon Horman <horms@kernel.org>
Date:   Tue, 09 May 2023 09:01:50 +0200
Subject: [PATCH] parisc: kexec: include reboot.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-parisc-kexec-include-reboot-v1-1-78a155a8a0a4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN3vWWQC/x2NwQ6CMBAFf4Xs2U0qChh/xXjYlqdsbFqyBUNC+
 HcbjzOHmZ0KTFHo3uxk+GrRnCqcTw2FSdIbrGNlal17cZ278SymJfAHGwJrCnEdwQaf88KdDG7
 ory168VQLXgrYm6Qw1UZaY6xyNrx0+y8fz+P4AcfbVS2CAAAA
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     Baoquan He <bhe@redhat.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        kexec@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include reboot.h in machine_kexec.c for declaration of
machine_crash_shutdown and machine_shutdown.

gcc-12 with W=1 reports:

 arch/parisc/kernel/kexec.c:57:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
    57 | void machine_crash_shutdown(struct pt_regs *regs)
       |      ^~~~~~~~~~~~~~~~~~~~~~
 arch/parisc/kernel/kexec.c:61:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
    61 | void machine_shutdown(void)
       |      ^~~~~~~~~~~~~~~~

No functional changes intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 arch/parisc/kernel/kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/parisc/kernel/kexec.c b/arch/parisc/kernel/kexec.c
index 5eb7f30edc1f..db57345a9daf 100644
--- a/arch/parisc/kernel/kexec.c
+++ b/arch/parisc/kernel/kexec.c
@@ -4,6 +4,8 @@
 #include <linux/console.h>
 #include <linux/kexec.h>
 #include <linux/delay.h>
+#include <linux/reboot.h>
+
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
 

