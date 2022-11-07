Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9161E9D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiKGDqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiKGDqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:46:38 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D88EDFB3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 19:46:38 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h193so9323520pgc.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 19:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vi6KNoCVyd0JV4nK6JqIvAeRayzRh1VIWWEjG9auUw=;
        b=JjraB2MYa54b8K+Y9CTvOVAajmMF+MTQU68jaqu2lZBZ4wJ+yH9J9MyHiveDOgOcvF
         e+QwjBE1pv6IChUlAq6zjdHa2YDGOmHizBc7dJk1+hYJ+mj7R8EtPLYb1epR/h6RTqaP
         4fZmXemGi0lQF96zUnrns+Lzq1PkfpH76rkko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Vi6KNoCVyd0JV4nK6JqIvAeRayzRh1VIWWEjG9auUw=;
        b=3mZlOFO5JnPNAAh0FM1E7UM2o+fEYsJwrV+j48RaDLgUuo6jamIa4Z3TO4Y0HJ213y
         1ts+ObL+7/kviH6+2OsINjPR7rVFbtJ90AJFRrSrX5YKZIdjBT/iGLA8Xjer5UnGpclC
         VoGnQzP7J7dHqu3tZznFSm3HbhBHVnvwvPOtnhDCwXEVJDU79BDSSWCS8iFm6fd2AeYg
         2gu+oLSFHbBvzPV1GyMvDIEIk0C7LQc1kPQW/CXrhRkUtE888nkPHuFZVrpgCCX2ZqNO
         drXOsMZ4qOEM5dZ1o6fzUQeutq4i23/9wia3peSaeu7DA5OtWc+Xb5R1lOFJoFIaKpaN
         P7Dw==
X-Gm-Message-State: ANoB5pleWrJ7ltspflIuHALEEAupYmctcndg8z4bVu1GdfS4XReBll3h
        7441wLDlzvgHlaX7lRmWYVC7ng==
X-Google-Smtp-Source: AA0mqf54aZDxuPlw93SOZMEfSxlmZ5fBqa/huyQIfbQiVrlPqFLmVp8ro0HkbVG2h6NzLQTbnhT2oA==
X-Received: by 2002:a63:2018:0:b0:470:77ae:6c50 with SMTP id g24-20020a632018000000b0047077ae6c50mr3053184pgg.97.1667792797814;
        Sun, 06 Nov 2022 19:46:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ebd200b00176b63535adsm3776277plg.260.2022.11.06.19.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 19:46:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] tty: Move TIOCSTI toggle variable before kerndoc
Date:   Sun,  6 Nov 2022 19:46:35 -0800
Message-Id: <20221107034631.never.637-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; h=from:subject:message-id; bh=J8nMrpDBJd4u0osmWDl+MV4SJ2abhPXa2LWHR9LUhQA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjaH+aHaWUg+FJRFLC2kQLE+Ond0vr65KcaYO1x2Iw JXWtHv+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2h/mgAKCRCJcvTf3G3AJgLXD/ 9JhTNZbBPj638pVgvPGpK5NDjoJcU51juulnPZokP3NKIqyr47KDCwpLh1ZKYlhTg4i+Rq7C0eDYbs x4Il/99IS9kj3lo2k07cNBB7LD6QEsem5+6HnL2+yMJfkMvRPRdryZBxxl5LuXhWAWvznAkbqGTUxt NtGGbHYaZTrIyYtnT9zfoKaaHrlpbdBBucVedVYcjO5kIfeIgqm0cOBfef70HePmvwj0JNUL63ehiT mgTnU4VYidM2yeOeeh87a7AGSGKdRM9/MR57APEBRwz4uTrfbw26F0uOii14ks2kB+iGDcZZfujY+R goplH+ETwrxUwr/V+JjDQ3hW83qzisevsxE0N6xhJASVn/LE0SjXiXmi0OfPptbq8uHa5a2vbYpXMv swtVIVXNhVrrtyqyMUTNlr0SasytZ5TwtHFbxA8DkhLYA/Cfo0ivntXmR6JySccOuBdmWAUA1yCLd3 o3a61H+EsfxBVpQEpOYFFzFdKmM4fDCOK+x4Wv+BJQpssBptktYNWlTV0Ohq1vVujfZWbUuSpqC+P+ 13sDi98GKeIJA1M4o3HfeIH8VKEIzYvrBe9/7bUN8/ftQamE2fy+++0QUa6vO7Lxa4lLaIMFC7+Lbn Gr3HtQbRYJFB2DQCDmrKGbUYd4nI1U78XCoSG8sohWn/CqXk/lEpwvT7Mvzg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable "tty_legacy_tiocsti" should be defined before the kerndoc
for the tiocsti() function. The new variable was breaking the "htmldocs"
build target:

drivers/tty/tty_io.c:2271: warning: cannot understand function prototype: 'bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI); '

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/lkml/20221107143434.66f7be35@canb.auug.org.au
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index a6a16cf986b7..24ebcb495145 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2255,6 +2255,7 @@ static int tty_fasync(int fd, struct file *filp, int on)
 	return retval;
 }
 
+static bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI);
 /**
  * tiocsti		-	fake input character
  * @tty: tty to fake input into
@@ -2268,7 +2269,6 @@ static int tty_fasync(int fd, struct file *filp, int on)
  *  * Called functions take tty_ldiscs_lock
  *  * current->signal->tty check is safe without locks
  */
-static bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI);
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
 	char ch, mbz = 0;
-- 
2.34.1

