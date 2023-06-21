Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52487380AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjFUKRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjFUKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:16:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE9C19BF;
        Wed, 21 Jun 2023 03:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6887A614D8;
        Wed, 21 Jun 2023 10:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF978C433CB;
        Wed, 21 Jun 2023 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687342580;
        bh=DBc50eolmnp7GyiCEV1ZK/Q/T32LP3koeS8WDoxsOIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfRPYbc0nGO2Dzu3+KWemjFHN166/ezCgHVX1MIYCqACkmzgTQXgrnf9ZZMaVVUPF
         ugcEzePpMTtKKG90sNQEE+Xsnw9sqVVGwKiXz2ntFFQnYEiE8zX8pN5672xDAmK8Nd
         siSn4bOVncIMEOgsXUMMH++jz/9P2EXuw6ClzOd1R2GHKqDCQJVRpUtzU1YdYGLmPn
         ikKQ6JixHqH960T671T08WJqC/RFbItdHGSy8nar9jUC3Krinur3FC6J6xhAUVZw8e
         w9G6y4GIytBGfjC0K4EuK+wVvNYB08x/Rl8gNV22E4JPpc88iijGr6MYuHEhQPLL40
         0iHHzv4gy+A8g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 4/6] tty_audit: make icanon a bool
Date:   Wed, 21 Jun 2023 12:16:09 +0200
Message-ID: <20230621101611.10580-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621101611.10580-1-jirislaby@kernel.org>
References: <20230621101611.10580-1-jirislaby@kernel.org>
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

Use bool for tty_audit_buf::icanon in favor of ugly bitfields. And get
rid of "!!" as that is completely unnecessary.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_audit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index c6c27acad2ad..6cf8b63368ee 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -15,7 +15,7 @@
 struct tty_audit_buf {
 	struct mutex mutex;	/* Protects all data below */
 	dev_t dev;		/* The TTY which the data is from */
-	unsigned icanon:1;
+	bool icanon;
 	size_t valid;
 	unsigned char *data;	/* Allocated size N_TTY_BUF_SIZE */
 };
@@ -202,8 +202,8 @@ static struct tty_audit_buf *tty_audit_buf_get(void)
 void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size)
 {
 	struct tty_audit_buf *buf;
-	unsigned int icanon = !!L_ICANON(tty);
 	unsigned int audit_tty;
+	bool icanon = L_ICANON(tty);
 	dev_t dev;
 
 	audit_tty = READ_ONCE(current->signal->audit_tty);
-- 
2.41.0

