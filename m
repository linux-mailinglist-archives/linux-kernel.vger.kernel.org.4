Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62364D8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLOJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:39:47 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B06B1BEA5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:39:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id DA6A61863D96;
        Thu, 15 Dec 2022 12:39:38 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LOgah4IMWUXS; Thu, 15 Dec 2022 12:39:38 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 84C451863C60;
        Thu, 15 Dec 2022 12:39:38 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E2TjqXzuL3PY; Thu, 15 Dec 2022 12:39:38 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.20])
        by mail.astralinux.ru (Postfix) with ESMTPSA id CAFF61863D96;
        Thu, 15 Dec 2022 12:39:37 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] mm: Add check for NULL for unlocked in fixup_user_fault
Date:   Thu, 15 Dec 2022 12:39:30 +0300
Message-Id: <20221215093930.22026-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check unlocked for NULL before dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d92725256b4f ("mm: avoid unnecessary page fault retires on shared =
memory types")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f212d571b563..905d5fb64c4c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1282,7 +1282,8 @@ int fixup_user_fault(struct mm_struct *mm,
 		 * could tell the callers so they do not need to unlock.
 		 */
 		mmap_read_lock(mm);
-		*unlocked =3D true;
+		if (unlocked)
+			*unlocked =3D true;
 		return 0;
 	}
=20
--=20
2.30.2

