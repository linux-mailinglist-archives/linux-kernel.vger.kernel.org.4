Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3A6589C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiL2Gm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiL2GmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:42:22 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3489FAE0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:42:20 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s187so16499235oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ke6drZ+UWK1KTmMIerl9sTzLh5swNNgIhEk6sbJwwA=;
        b=frN1xp38sPqi7kkpY0Y5VQFpp9VZWVElgpRHYyBgeN9Ja1KGY9HQ1ZqVmX7qefaV0+
         iir0jUUUrp62OOWgaM51/aXxGjIXBnGSHp7HIMDAmcATptn8Se15lar6im26TUyNqTl0
         8Xkikq1JEUEGtyrXWUPyG3zL+FK+LymaIm+i8uONuYztKygvzU8wUcDMtsMOyQr4OyT1
         LMW1/DLCyQKTdoBR/XCrCKnER/3lhM7zLukGJJiEapgxDTbtRuwk3ftVcwp2mJcBt1cz
         +bRmGPbHUr094eGzZxaY8YjhyVlzD3kdFcLcYBHxrDn4DoSWGkXn6+kZ1kqFOdRwe2wx
         5gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ke6drZ+UWK1KTmMIerl9sTzLh5swNNgIhEk6sbJwwA=;
        b=QBSrVRd2UJQPQZh9wGC7jhYbPhg0/P8OGDU1UMMqWZYohMJ1aZXfN964EmXW2GzCl1
         l37jK5uugzo+zjYmj1NTXCj/rAmzSya8ZI9fMao//ZOJjg3phqLkA12Ph8utXpmSnSYp
         RAIzLfcq16Mb7tUzFmWaTiXmtwv3CwK0B+rKfoPvO3cnu+KiYl5sXRATNDVokUBHexhy
         dsZ4wV7CW+fys8Sv51t3xrtQfwhbBJGhdwk1rCe4R/oYJfUcJCatTQZVAeL8SAXPGLeZ
         m45d+PO6aHuU51efpHzHnW55inSAmI2tX5wEqeZgWfvv5KHfzWlvpSfd2zDsu8iVbeIT
         LElw==
X-Gm-Message-State: AFqh2krfD0ME4Er1oisgnxHN6PSCk3uEw6Hx4JQR2wuLT5iio/7oKoHo
        3l1wzgBxyhRCJjdXVE/UuJY=
X-Google-Smtp-Source: AMrXdXs48f3S7mdAEcHD6Xebq446QOF/kyasJRFspaYxyJll6yORKTm1+UnBTAUX8ytbxMIuBNPV6Q==
X-Received: by 2002:a05:6808:28e:b0:35e:cdd7:d8fe with SMTP id z14-20020a056808028e00b0035ecdd7d8femr12947331oic.53.1672296140159;
        Wed, 28 Dec 2022 22:42:20 -0800 (PST)
Received: from protoss.cs.ucr.edu (protoss.cs.ucr.edu. [169.235.26.60])
        by smtp.gmail.com with ESMTPSA id b24-20020a056808011800b0035b99bbe30bsm7755351oie.54.2022.12.28.22.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Dec 2022 22:42:19 -0800 (PST)
From:   Hang Zhang <zh.nvgt@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hang Zhang <zh.nvgt@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: vt: add some NULL checks for vc_data
Date:   Wed, 28 Dec 2022 22:41:53 -0800
Message-Id: <20221229064153.23511-1-zh.nvgt@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vc_selection(), do_blank_screen() and scrollfront() all access "vc_data"
structures obtained from the global "vc_cons[fg_console].d", which can
be freed and nullified (e.g., in the error path of vc_allocate()). But
these functions don't have any NULL checks against the pointers before
dereferencing them, causing potentially use-after-free or null pointer
dereference.

Prevent these potential issues by placing NULL checks in these functions
before accessing "vc_data" structures. Similar checks can be found in
other functions like vt_console_print() and poke_blanked_console().

Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
---
 drivers/tty/vt/selection.c | 3 +++
 drivers/tty/vt/vt.c        | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 6ef22f01cc51..c727fd947683 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -319,6 +319,9 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
 {
 	int ps, pe;
 
+	if (!vc)
+		return 0;
+
 	poke_blanked_console();
 
 	if (v->sel_mode == TIOCL_SELCLEAR) {
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 981d2bfcf9a5..00f8fdc61e9f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1493,6 +1493,8 @@ void scrollback(struct vc_data *vc)
 
 void scrollfront(struct vc_data *vc, int lines)
 {
+	if (!vc)
+		return;
 	if (!lines)
 		lines = vc->vc_rows / 2;
 	scrolldelta(lines);
@@ -4346,6 +4348,9 @@ void do_blank_screen(int entering_gfx)
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int i;
 
+	if (!vc)
+		return;
+
 	might_sleep();
 
 	WARN_CONSOLE_UNLOCKED();
-- 
2.39.0

