Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC27C63C25C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiK2OVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiK2OVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:21:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3369332;
        Tue, 29 Nov 2022 06:19:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 029916173B;
        Tue, 29 Nov 2022 14:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B01BC433C1;
        Tue, 29 Nov 2022 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669731550;
        bh=uJPiwdwJsKJrj0aLRgLDAxov3eoorN/oySmxEBKYv6k=;
        h=From:To:Cc:Subject:Date:From;
        b=YcE+psTZizF5AHGsTKbo/hA6EpqzvwNtcJVybbEINiDl+FLTWPgEuQG+FppYEu5cS
         3r9pI+4xMBtpFaOI8yukvvfLwuHBgbsvwD6Ngel0bkOoCnnvwZ/L6uZ1nSzQmMAWhp
         kAYDMF3HND5ZuPCUTPyTDg88NDptTRzi/n+HBO7htn/KvfeQcq+sxFItvmim1qagMp
         OKluhNDWgOB6PK5vqMoBFuDF+YZugQJ0mt6x86WhQuHTtKWq4pSdVlVNq6d1BGXRzR
         YS9fZq3eyJVSdz9bTsKIZK0SgobFduPPOYBF8BWj6SqzHzPMrkPdByQByvGqR5NMKz
         PXNDLYav1oESw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p01S2-000402-Tq; Tue, 29 Nov 2022 15:19:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: xr: avoid requesting zero DTE rate
Date:   Tue, 29 Nov 2022 15:18:57 +0100
Message-Id: <20221129141857.15363-1-johan@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the requested line speed is B0 (hangup) there is no need to use the
current speed in the line-coding request. This specifically avoids
requesting a zero DTE rate when the current speed is B0, which could
potentially confuse buggy firmware.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index f3811e060a44..fdb0aae546c3 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -749,8 +749,6 @@ static void xr_cdc_set_line_coding(struct tty_struct *tty,
 
 	if (tty->termios.c_ospeed)
 		lc->dwDTERate = cpu_to_le32(tty->termios.c_ospeed);
-	else if (old_termios)
-		lc->dwDTERate = cpu_to_le32(old_termios->c_ospeed);
 	else
 		lc->dwDTERate = cpu_to_le32(9600);
 
-- 
2.37.4

