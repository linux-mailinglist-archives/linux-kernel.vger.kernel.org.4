Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7D5BEB91
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiITRGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiITRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:06:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6B57218
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC84BB80C71
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AC2C433C1;
        Tue, 20 Sep 2022 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663693602;
        bh=a+Fz+U8XFKE/8Y/m5KUO/F39hIifthMNxM3Gkg79UMk=;
        h=From:To:Cc:Subject:Date:From;
        b=StxjC5rfsirc2P9HeJ2plS5TEQodghzaeOtxVqyNGZrv4UGlVyz6bcU1CtMNUdJVV
         5BKqLMEohg2tcU3iZnFI7jZaPR/KgTJnUOpgY/5vCfg3mZargxuQlWjoM8BW/aTfPS
         0yO99kUOaSVvgfPBfRh5lAQu9f/hvXiGz1TUQVPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] lib/vdso: use "grep -E" instead of "egrep"
Date:   Tue, 20 Sep 2022 19:06:33 +0200
Message-Id: <20220920170633.3133829-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049; i=gregkh@linuxfoundation.org; h=from:subject; bh=a+Fz+U8XFKE/8Y/m5KUO/F39hIifthMNxM3Gkg79UMk=; b=owGbwMvMwCRo6H6F97bub03G02pJDMman8Xnf3umkVXUpfyEYcbqmICLcievTT/7bs9JlVZD5x+5 jHKtHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARw+UMc0XsKht1+YSfX7M/2n3M4I RN654VzQzzNM60rVlZ36J1dv40vzC5+gbV2X+uAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of grep claims the egrep is now obsolete so the build
now contains warnings that look like:
	egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the vdso Makefile to use "grep -E" instead.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
index c415a685d61b..e814061d6aa0 100644
--- a/lib/vdso/Makefile
+++ b/lib/vdso/Makefile
@@ -17,6 +17,6 @@ $(error ARCH_REL_TYPE_ABS is not set)
 endif
 
 quiet_cmd_vdso_check = VDSOCHK $@
-      cmd_vdso_check = if $(OBJDUMP) -R $@ | egrep -h "$(ARCH_REL_TYPE_ABS)"; \
+      cmd_vdso_check = if $(OBJDUMP) -R $@ | grep -E -h "$(ARCH_REL_TYPE_ABS)"; \
 		       then (echo >&2 "$@: dynamic relocations are not supported"; \
 			     rm -f $@; /bin/false); fi
-- 
2.37.3

