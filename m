Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4632C74FF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjGLGmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjGLGm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9910EF;
        Tue, 11 Jul 2023 23:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D625F615BC;
        Wed, 12 Jul 2023 06:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0DCC433CB;
        Wed, 12 Jul 2023 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689144144;
        bh=Qb5Il4Ai3jz4ymmAYs7Bq9ZdwscdsCLE+1C9yMaXeVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=As2rNQVfalJRMvLFNrtv1VrG5i7f59JwKdMVkYfEN0aTq5+AVknDuK7Gmqre9vg+z
         YSJ19JB5AE75G37Clf3Ed5e0HxDWJjnJ1j1gdlRRfdIU2pXMO05SEFbLBL1JJvoNka
         iYomw+cAJjBHZeDngNFwbWlhZujNFQweWMOmg+13Tb58KcpQy+ZFyLCMGdUQjUDDCU
         STiVOMdGvJD9t0Gc3V6bUcXImDEsHNfFSiyxxFpbw1uWYFVBX+zPpHjyHTaF0sO/ab
         0GXmce6yxw7+P0Lr8A+a3WOU71hL42kL4e+tz6vkd7Fb961a1ijO9BpQaQZgHTXWBH
         z1zqZNjI/Pztw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/4] n_tty: pass ldata to canon_skip_eof() directly
Date:   Wed, 12 Jul 2023 08:42:15 +0200
Message-ID: <20230712064216.12150-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712064216.12150-1-jirislaby@kernel.org>
References: <20230712064216.12150-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'tty' is not needed in canon_skip_eof(), so we can pass 'ldata' directly
instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index c1859ae263eb..bab7005ef520 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2053,9 +2053,8 @@ static bool canon_copy_from_read_buf(struct tty_struct *tty,
  * EOF (special EOL character that's a __DISABLED_CHAR)
  * in the stream, silently eat the EOF.
  */
-static void canon_skip_eof(struct tty_struct *tty)
+static void canon_skip_eof(struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	size_t tail, canon_head;
 
 	canon_head = smp_load_acquire(&ldata->canon_head);
@@ -2153,7 +2152,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 			 * releasing the lock and returning done.
 			 */
 			if (!nr)
-				canon_skip_eof(tty);
+				canon_skip_eof(ldata);
 			else if (canon_copy_from_read_buf(tty, &kb, &nr))
 				return kb - kbuf;
 		} else {
-- 
2.41.0

