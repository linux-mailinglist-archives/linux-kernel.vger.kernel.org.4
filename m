Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767A67381F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjFUKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjFUKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C729719AE;
        Wed, 21 Jun 2023 03:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F0FF614F8;
        Wed, 21 Jun 2023 10:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B563BC433CB;
        Wed, 21 Jun 2023 10:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687342577;
        bh=t0EF3q3/QR/P6ZCvJ8zNTv13i5zjB/3psPexq7LNhgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKdIbAfL+30GDkJK5lShtthDH94/jUwHsIyZyji61PqbfxKSGZ9gEpVmvBcefKzCf
         +0M5U2qsIFsqBjzZg9QHVqU/6uBLLStfsqkwZQbSdqhHZTzrIQjRDNCbf2G7mJR7Km
         fd35CGiV4o4LAw/v4KVklqf7c9Xs+iEgOjQMuYmO759KLOAG8DBTUzqKLoTXpilFJz
         WadX/NX9FqNFsEIlBtZaz/woCZM3E2xzO2FDRjfW1BNTmB/VYwmiSG+/BOE0w67ohA
         bE3HMWg7xf+DCVdpwytGpyljGxxwWvopdpQzM1jVlpzH2iL4dpopHs+S2SuVAkHxBm
         wEuER1NSMz8xw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/6] tty_audit: use kzalloc() in tty_audit_buf_alloc()
Date:   Wed, 21 Jun 2023 12:16:07 +0200
Message-ID: <20230621101611.10580-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621101611.10580-1-jirislaby@kernel.org>
References: <20230621101611.10580-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_audit_buf_alloc() manually erases most of the entries after
kmalloc(). So use kzalloc() and remove the manual sets to zero.

That way, we are sure that we do not omit anything.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_audit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index b98b1aef5f6f..43f34465b9df 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -33,16 +33,16 @@ static struct tty_audit_buf *tty_audit_buf_alloc(void)
 {
 	struct tty_audit_buf *buf;
 
-	buf = kmalloc(sizeof(*buf), GFP_KERNEL);
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		goto err;
+
 	buf->data = kmalloc(N_TTY_BUF_SIZE, GFP_KERNEL);
 	if (!buf->data)
 		goto err_buf;
+
 	mutex_init(&buf->mutex);
-	buf->dev = MKDEV(0, 0);
-	buf->icanon = 0;
-	buf->valid = 0;
+
 	return buf;
 
 err_buf:
-- 
2.41.0

