Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4964945E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLKNI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKNI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:08:56 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1602C6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:08:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d3so9416586plr.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kv8kcpsRmLiddotvQaawoolO0sTJlYruTgtBrstc49M=;
        b=QGDmQTi7v4M3a7gz51ftuLvf7RjAIYaG1giqRYlNplDgqd5Ht3ui0pI27p4XSkFXp3
         3pV2jiGAU2pty/bxepurgOg6+ZMj72xVu1X/uDW8Jz66aT4XPKcw9i2X/89+BZA4f9aT
         BW/e6Rz4S8rZtSucGl0zqLXdr1AO2HbdegbXbcTY7DHh6zDbH43KJgNG92rSbyATAhf0
         lz+X6vz/xoXvvCzd3E0uMr6UXTWuazmj1qsodwYnvggQ1ba4IrGAQBD5IhHXUFJN3VCu
         vbg9oRtD8yh9Ngc7ba1EAEUEepfC4UWnz5YxN/OJx8OIs2SmEaXl0Q33mjYQJLvqfguo
         sYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kv8kcpsRmLiddotvQaawoolO0sTJlYruTgtBrstc49M=;
        b=KoA3qNUnYhi6Kw0YjeHaLb8lXJEPKbXvQmANe/pJBgnX0MAQM2TDaLZh7y3gQfh+Tb
         H3qItwA6sR2gtZ55/jOrX7N3AIFTDNzJ4aBaM9MIrQTxo61oJMuLRusG1RNKCX19OygX
         eNeXSITJs4ILDNReq2+OA2oUoVArrFc+ynKm331fThrjWxfgaR9jtbkGPJa/hCeI8yvj
         Y2Sk1qFgELYlxdyDrc/z/mqgPLTGzOXcLsLn0/xLqfAweh91SsVdHkX1gxaGXEZf0YKC
         MGmtEi9RtSYrZvHtd5CEJhjrXhWnBcLtQIjtRzm+tZZ0NtcRWsRnTGwGeke1n1r4uuR8
         PSOw==
X-Gm-Message-State: ANoB5pnjYGKIv4hjYzZA7CiT1fHwvxHaH4LyFDnew1pT3fOvSOGi7UZd
        do9SAz3UtpStzjCeZ1Kq7Gs=
X-Google-Smtp-Source: AA0mqf5dEJCsGXsJcaoyYUPof4dNDixAgjIjDfw5onXGgeaF5n9lTtSPKNVvNY0kQNjFbQWHWlScEw==
X-Received: by 2002:a17:902:c18b:b0:189:8e01:c72a with SMTP id d11-20020a170902c18b00b001898e01c72amr13026193pld.17.1670764131738;
        Sun, 11 Dec 2022 05:08:51 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b00186b549cdc2sm4315412plk.157.2022.12.11.05.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 05:08:51 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH v2] f2fs: reset wait_ms to default if any of the victims have been selected
Date:   Sun, 11 Dec 2022 21:08:41 +0800
Message-Id: <20221211130841.113959-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-foreground gc mode, if no victim is selected, the gc process
will wait for no_gc_sleep_time before waking up again. In this
subsequent time, even though a victim will be selected, the gc process
still waits for no_gc_sleep_time before waking up. The configuration
of wait_ms is not reasonable.

After any of the victims have been selected, we need to reset wait_ms to
default sleep time from no_gc_sleep_time.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/gc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f0c6506d8975..d7a9d84ba57c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -141,6 +141,10 @@ static int gc_thread_func(void *data)
 			/* don't bother wait_ms by foreground gc */
 			if (!foreground)
 				wait_ms = gc_th->no_gc_sleep_time;
+		} else {
+			/* reset wait_ms to default sleep time */
+			if (wait_ms == gc_th->no_gc_sleep_time)
+				wait_ms = gc_th->min_sleep_time;
 		}
 
 		if (foreground)
-- 
2.34.1

