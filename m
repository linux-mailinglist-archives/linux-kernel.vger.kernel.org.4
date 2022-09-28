Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585EF5EDAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiI1Kz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiI1Kzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:55:32 -0400
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 03:53:53 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6873140F4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:53:53 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1664361955;
        bh=4jcq0VaC/iDXcd4j2uJ4w0vNny9swybKQkCYoOfOC5k=;
        h=From:To:Cc:Subject:Date:From;
        b=Qa9qhGRLkpREYaE4iLS0o/hjjWX1Wzj56X+39n6KNg7ShMYFrVzF8pjEQanUDQN6G
         nEsK1vk4b/wpIHEGpsP0RUwqY3tZwKYK2NsszSf2Rkgg0KtQZRFsWaB0/26T4IfWmt
         GcMAWT34lxZGkIJcdcufgZASwm73J8WloKwbbC94=
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@amadeus.com>
Subject: [PATCH] tmpfs: ensure O_LARGEFILE with generic_file_open()
Date:   Wed, 28 Sep 2022 12:45:35 +0200
Message-Id: <20220928104535.61186-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664361931; l=887; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=d66fuy49WyqPJLzFDKOViGXYieS8rDSH8RKJPKnQnVU=; b=a8GADzUi4rhImJ18q5ENvGnE0+4c+H6JL0fbYL7u3mDoLpE4BpFBjsL/oBthgtnwVGEBUnzCk44H 5YLhloXkC2HEYVLv9fvjqfeZgv0Hzkh9R/YXEfnk4E+VlUbnN1Ze
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <thomas.weissschuh@amadeus.com>

Without this check open() will open large files on tmpfs although
O_LARGEFILE was not specified. This is inconsistent with other
filesystems.
Also it will later result in EOVERFLOW on stat() or EFBIG on write().

Link: https://lore.kernel.org/lkml/76bedae6-22ea-4abc-8c06-b424ceb39217@t-8ch.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@amadeus.com>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 42e5888bf84d..902c5550fabc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3876,6 +3876,7 @@ EXPORT_SYMBOL(shmem_aops);
 
 static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
+	.open		= generic_file_open,
 	.get_unmapped_area = shmem_get_unmapped_area,
 #ifdef CONFIG_TMPFS
 	.llseek		= shmem_file_llseek,

base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
-- 
2.37.3

