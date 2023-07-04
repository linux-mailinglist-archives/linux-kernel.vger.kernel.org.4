Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A77747A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 00:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGDWU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 18:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjGDWUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 18:20:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF38E7B;
        Tue,  4 Jul 2023 15:20:21 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 170DB1EC0411;
        Wed,  5 Jul 2023 00:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688509220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=DYR9hAz3rDQalm/RdUseeoijBoiPmBCuez9RUze2Jmk=;
        b=AewNkijxRaoyWaJPvJF6Ea7RnZQQJR6BRKs3onT1XCjy1rT3+X1c1ALSb9wr7uBOsqVMO6
        2naHj7OP/QR6suQkt2yzk5/722T6s+7Rdvk+AETUoUfMGXOhWgcV5KbO7zVOYsfPZBXZZr
        GzN2e3PlVoObTOEUUGyhNODLkQdE8lI=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yi7bw3IKtw5u; Tue,  4 Jul 2023 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688509216; bh=jL6uSfBqNDPocAax2P6VBh9QZjlwPpa5/eC7tTGcSuA=;
        h=From:To:Cc:Subject:Date:From;
        b=dSJxX6hP6I0eMV+X+3UTunv3irjEQIEhRES5RMR4pbbBhhbrBznYTqc1I02a/zVNx
         9cyEksmAQDLRBS1mdChoqBaQSNvINxSek6zN8n9JAKXjfD5tzU6UItPy4wf0tuW4ju
         npX3sUQEcTPmNG0qbLkLawVcdayzsoVV3OyC9Nf0LuKULlfS8/+acFFE8zTasvBg//
         YEFF3ml50yFLcNh8R2MlcowGfNtH+iUjTk5DW2HZaW67Rd38qw7jPzwY0ksZSqZL5d
         W/PakyDt0ZuoAvudhXtuzUCWub8voioD4P90k34h8YFWrYGb8n+1GHLVI2BUr7H4Jv
         dNU+uTqm5pp5EP1ARXV8h+yZGdJsL1j4qbOv8iXjuYitWbsSBo9vIdPOSADnIpwECF
         NQnT1ZB7JaMbn3HMFJZS3Q6EftC0e0u+fyPfBeju9NecP+iVtNWsFmy0iM0nkDm29W
         1fGRcOX+CBj9sj20F+oQEtIyPlQvIV95AsynatRvjufV7HjBQ2xjwtyYJEvRegRgJV
         AxRF2nEAryYywo5mFZG22eAiQWXnAqt1v751rqbBG16cIJBfedhpW7H8tV7MzvPJ2g
         RhgYRIQ4wcIJbjhM3d0I1rGm3IEorDQCVsyui7RI4kmcrIGWbvVxJS0Glakmtyb3HQ
         kGyZO+UqZ1vux1osFZM41JJ8=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34E0B40E0191;
        Tue,  4 Jul 2023 22:20:14 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kbuild@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] kbuild: Enable -Wenum-conversion by default
Date:   Wed,  5 Jul 2023 00:19:51 +0200
Message-ID: <20230704221951.7396-1-bp@alien8.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

This diagnostic checks whether there is a type mismatch when
converting enums (assign an enum of type A to an enum of type B, for
example) and it caught a legit issue recently. The reason it didn't show
is because that warning is enabled only with -Wextra with GCC. Clang,
however, enables it by default.

GCC folks were considering enabling it by default but it was too noisy
back then:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D78736

Now that due to clang all those warnings have been fixed, enable it with
GCC too.

allmodconfig tests done with: x86, arm{,64}, powerpc{,64}, riscv
crossbuilds.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 7a5a175f708f..428132b3d6dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1082,6 +1082,9 @@ KBUILD_CFLAGS   +=3D $(call cc-option,-Werror=3Dinc=
ompatible-pointer-types)
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   +=3D $(call cc-option,-Werror=3Ddesignated-init)
=20
+# Warn if there is an enum types mismatch
+KBUILD_CFLAGS	+=3D $(call cc-option,-Wenum-conversion)
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS +=3D $(call cc-option,-fmacro-prefix-map=3D$(srctree)/=3D=
)
=20
--=20
2.41.0

