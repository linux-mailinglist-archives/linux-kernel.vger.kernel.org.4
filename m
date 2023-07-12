Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0678E74FF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGLGmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGLGmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5706F0;
        Tue, 11 Jul 2023 23:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62172616E1;
        Wed, 12 Jul 2023 06:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9393C433C9;
        Wed, 12 Jul 2023 06:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689144142;
        bh=CJX8SlHepZCFBu+LS4vVyP3RzICxchrVKsWPVGHPYpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6Gie6O9A3O459QBabIn//QM15zKQA/tPiBY12tiUfnPVO6GDmsVZpUqPBFQHPY5t
         pAH5De2DsESSlJPIgf9jk871/t/HnaQwO8WEO5KtUq9RNcbfV2b/hIR+Hu4PSCAaAB
         Wluw0VFct/Ppnkj4dFWTpP/dkhTr01XNyUY+ikIrMCA/zba3n2q+ADdBvAoIJ99MqZ
         omwXLBUADJ4m1mQ9DlqONBuBqBpxYj/q+S3Jbp/Rxh1W0Ssx7mz/1KvHwrho1MZK8Z
         IZsvRvaVdgXqDOhfvFQymzROAC7u6Po3RQN/gd3PHVfXgtBy2pqDCwAncFJAu1JFFS
         Dx85An/jWdHbw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/4] n_tty: simplify and sanitize zero_buffer()
Date:   Wed, 12 Jul 2023 08:42:14 +0200
Message-ID: <20230712064216.12150-3-jirislaby@kernel.org>
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

* Make 'tty' parameter const as we only look at tty flags here.
* Make 'size' parameter of size_t type as everyone passes that and
  memset() (the consumer) expects size_t too. So be consistent.
* Remove redundant local variables, place the content directly to the
  'if'.
* Use 0 instead of 0x00 in memset(). The former is more obvious.

No functional changes expected.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 1599012f20c8..c1859ae263eb 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -158,13 +158,10 @@ static inline unsigned char *echo_buf_addr(struct n_tty_data *ldata, size_t i)
 }
 
 /* If we are not echoing the data, perhaps this is a secret so erase it */
-static void zero_buffer(struct tty_struct *tty, u8 *buffer, int size)
+static void zero_buffer(const struct tty_struct *tty, u8 *buffer, size_t size)
 {
-	bool icanon = !!L_ICANON(tty);
-	bool no_echo = !L_ECHO(tty);
-
-	if (icanon && no_echo)
-		memset(buffer, 0x00, size);
+	if (L_ICANON(tty) && !L_ECHO(tty))
+		memset(buffer, 0, size);
 }
 
 static void tty_copy(struct tty_struct *tty, void *to, size_t tail, size_t n)
-- 
2.41.0

