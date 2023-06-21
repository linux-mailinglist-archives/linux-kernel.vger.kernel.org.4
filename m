Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4337381D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjFUKQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjFUKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D1D19A5;
        Wed, 21 Jun 2023 03:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D44CC614F0;
        Wed, 21 Jun 2023 10:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9B5C433C9;
        Wed, 21 Jun 2023 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687342576;
        bh=11Ude6JWACvWtTFWg1oYhYS4qyMJAJHJEtjni1SdwG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4ehPnHa0tzB431PC0EfNwXOcvrf9ZsVu+rkYydgiyxbVAejq9Tx4MfIKKYhTyObi
         tCy4u3+GbFrAnDTJ1TkylxNydlgzbBpsysgR6zJ7V3oBssbFSjkyJHVsS4Mb/My9cA
         +KW+6wqMsUwt00ViS+3qz7qkrfACZJwKnMMz2lzVsTJSzCBn078vAKzKgvzznpNN0+
         TcLFNxA1vT96J/I8laUCKty1YdXXb86nq6a9oYhL/kPw+lhvYXjEztSv6EwNhSH+Mk
         cQyesvIYgf2d4egMUbSJBf5Hkd7Ih09GmVmydrIxP0dcw0P29nLJzt+UgjnAX6xpKK
         AFuWH5GIUN8dQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 1/6] tty_audit: use TASK_COMM_LEN for task comm
Date:   Wed, 21 Jun 2023 12:16:06 +0200
Message-ID: <20230621101611.10580-2-jirislaby@kernel.org>
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

This is the preferred way of declaring an array for get_task_comm().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index ca7afd7b2716..b98b1aef5f6f 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -69,7 +69,7 @@ static void tty_audit_log(const char *description, dev_t dev,
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_TTY);
 	if (ab) {
-		char name[sizeof(current->comm)];
+		char name[TASK_COMM_LEN];
 
 		audit_log_format(ab, "%s pid=%u uid=%u auid=%u ses=%u major=%d"
 				 " minor=%d comm=", description, pid, uid,
-- 
2.41.0

