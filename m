Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481C4738097
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjFUKQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjFUKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0610FF;
        Wed, 21 Jun 2023 03:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E57614FB;
        Wed, 21 Jun 2023 10:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E68C433CA;
        Wed, 21 Jun 2023 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687342583;
        bh=hjwp7ItGmHIggbX9Pd6LvtVbXVqDEOR8otZ+Y4JaTu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNvkdiF4FusRU1x/rqIMyQ2ujF5y1MPWfSO9o0oEqlpV0XUXUd37+A9SraY/aNTFr
         UOsxhdWmZuFgvnpDmWEEtW3IiMSzN906hBDGtvwYfQJk9CBG+Px7x1F97Sk0WDKAEp
         IKCfdLkf9BWKD4QlK5rIJf+0dsrApspERH7kXbeJ0ng4U/e5oBSR3EByiGZ406B53c
         ac0+whiE4mwjcHuUVqrolEX4d+RTaUqC8JL8qmcunl+hfMX3W8M5r0DKvBEbdmrI8P
         yGnKKTbEeMx+2aVTKCkVHleHi6xrw1eidMXnsV4Cda+hNE80MBvATXhgR5cyjKisr+
         seiJ0y1csL0CA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 6/6] tty_audit: make data of tty_audit_log() const
Date:   Wed, 21 Jun 2023 12:16:11 +0200
Message-ID: <20230621101611.10580-7-jirislaby@kernel.org>
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

'data' are only read (passed down to audit_log_n_hex()), so they can be
const -- the same what is expected in audit_log_n_hex(). Only a minor
cleanup to be consistent.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 5cbe28ac1763..24d010589379 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -59,7 +59,7 @@ static void tty_audit_buf_free(struct tty_audit_buf *buf)
 }
 
 static void tty_audit_log(const char *description, dev_t dev,
-			  unsigned char *data, size_t size)
+			  const unsigned char *data, size_t size)
 {
 	struct audit_buffer *ab;
 	pid_t pid = task_pid_nr(current);
-- 
2.41.0

