Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41A75EC090
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiI0LIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiI0LHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:07:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424B44A122;
        Tue, 27 Sep 2022 04:05:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8B14821E87;
        Tue, 27 Sep 2022 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664276732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nl/CWuFt/XhPYNdKRVer+oirWRrEHCRaaK1Ncyhziys=;
        b=yHCz5AaYdxLJxyl6UVokv5cd7np7F1Az4In4JOsrB1KEg+/i3ttgiC2ITCXmJUM1FOQFXv
        Hz6vHxUD+MRY2cMOPLBq8WiWYfNmmOyTjdbqonVF/kb+tUfHgmnYSpG4maaD+2y5xLcOPY
        AIYb/0VJQy1Lqrjr2Qibi0TTwL6T+NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664276732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nl/CWuFt/XhPYNdKRVer+oirWRrEHCRaaK1Ncyhziys=;
        b=K6ay8fBT3PTIe41sjQ6qb1twFqH1VvYRV4zB5aefk1vEbp0+NKtrml/vg3x/JcNdJGZPd1
        v2V3BBrLyPVgwmAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 581582C162;
        Tue, 27 Sep 2022 11:05:32 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] tty: serial: allow pxa.c to be COMPILE_TESTed
Date:   Tue, 27 Sep 2022 13:05:28 +0200
Message-Id: <20220927110528.12815-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no issue compiling pxa.c even in the SERIAL_8250=y case. So to
cover it in the usual configurations, add "|| COMPILE_TEST" there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2a18a42a5004..cf7324215916 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -427,7 +427,7 @@ config SERIAL_PXA
 
 config SERIAL_PXA_NON8250
 	bool
-	depends on !SERIAL_8250
+	depends on !SERIAL_8250 || COMPILE_TEST
 
 config SERIAL_PXA_CONSOLE
 	bool "Console on PXA serial port (DEPRECATED)"
-- 
2.37.3

