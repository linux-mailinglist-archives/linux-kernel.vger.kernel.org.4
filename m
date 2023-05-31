Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E93D717B92
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjEaJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjEaJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:16:40 -0400
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 02:16:39 PDT
Received: from forward205c.mail.yandex.net (forward205c.mail.yandex.net [178.154.239.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6344E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:16:39 -0700 (PDT)
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by forward205c.mail.yandex.net (Yandex) with ESMTP id B3A004855C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:11:07 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 6A18760154;
        Wed, 31 May 2023 12:11:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qAJGDoUWteA0-60oBuF1U;
        Wed, 31 May 2023 12:11:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685524263;
        bh=Qz/zvm20YVew2wSgw5i22oMjX2ajjyiRSg99gIkAk5U=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=vyI+vSv0afDp9Y2BQdQpMBCvp96NnGv/IK4M+oAL86RQjUiJM4RFoOLQ/mb0Re2yN
         1Fvunllgf9fInYnys//5n6h1+ekkelTaYqatfYfT5+68j/oQYC/R3vUdf4tCkdFnuP
         BFTmiZudvrhkWJajUy/IfOV01qp0xp/P9jmtuDqQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
Subject: [PATCH] x86/vdso: provide prototype of __vdso_getcpu()
Date:   Wed, 31 May 2023 12:10:27 +0300
Message-Id: <20230531091027.70434-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include asm/vdso/processor.h to fix the following 'make LLVM=1 W=1'
warning:

arch/x86/entry/vdso/vgetcpu.c:13:1: error: no previous prototype for
function '__vdso_getcpu' [-Werror,-Wmissing-prototypes]
__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
^

Signed-off-by: Dmitriy Antipov <Dmitriy.Antipov@softline.com>
---
 arch/x86/entry/vdso/vgetcpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index 0a9007c24056..66edca964a9a 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/getcpu.h>
 #include <asm/segment.h>
+#include <asm/vdso/processor.h>
 
 notrace long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
-- 
2.40.1

