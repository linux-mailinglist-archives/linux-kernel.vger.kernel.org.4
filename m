Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8CF5BB56A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIQB7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:59:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F618E9A1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:59:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so2769173pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6iHNPWsxhSPJ60C2d/7Z7dQc4knYyK+JHQ1YhZpS8no=;
        b=j9uZrmIx/znR1c29a4bp1PeXXWyPMjRRwFWtYIe6QPPnd9mHYE1ZoM9aQPuDxLoAvn
         TGbPyRscWVtuMRM8TQzBSi6DI1+rDGF2TOrdlh8Pdf5PCRT7yauvctLAh+nkq/VUbmHn
         6UtEkM3cM0NZ80VLFM2C2kA3kgdV/tZPx756L4ZUXg8yjyXRxkNUboFcotCnX2X6EaEH
         aSHVyN/cPKAH6IxMLq4zvN0reEQ9IeFQLeAmn4HjeF1ijIJqnxeGf6/A0yG2XAd6URqz
         0Lfy5+gXe2YqRTrCz3SLmjnQ1lmVBViLOYj2Jv8khPvsPi9yQk2fFd9PPeyOYI7PLE/W
         9dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6iHNPWsxhSPJ60C2d/7Z7dQc4knYyK+JHQ1YhZpS8no=;
        b=oHUDlwVmc1oiPNV42m4R6tlGhbVH0YZuv8mkaRfp8JbCezutjxGrwEixqbb5lyC3MO
         jXKJxrHqblnl6andAYQCQn3Ck2lA47Xscr8zwa9ELfWocHVIGdWlPXv10Uu1k9WqLnBL
         iis+co3ZAUDG1fWFk0aHIMkO71fbF/6JRsPuyqiT0V+Mze9rf+gqi3yzn5uwq1raw4uc
         JLJIgYPLhVcXgqHz+TYaA8geR+VgtNHdbtwiXY/uX4tyjIyB/8qBaNVIdM8cyxDgqZ99
         pSXgTyF0dRs+VsOt0doROChaeyoYuVP4mNWJ14s/xmCaebLloxss1D02LtTwXdNKb+69
         gbCw==
X-Gm-Message-State: ACrzQf0QPPlL1jdcfvuYbZ0Xq4wXo8gkFeLMEor3sL8fvkBeXNMtrrto
        ZYSiLNb4SYW2G8CGK4EeQ6jC52yosG8j2A==
X-Google-Smtp-Source: AMsMyM7IGZeGNJ6fYXjOchhkaYIeUNxJ8SO21oqmrU4ZMqU5ymFTTEod6WB6emXxPwzAr0vkayBIew==
X-Received: by 2002:a17:902:ced2:b0:178:3ad0:2672 with SMTP id d18-20020a170902ced200b001783ad02672mr2547728plg.155.1663379948087;
        Fri, 16 Sep 2022 18:59:08 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id mz16-20020a17090b379000b001fffbad35f6sm651409pjb.44.2022.09.16.18.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:59:07 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tony.luck@intel.com, ccross@android.com, anton@enomsg.org,
        keescook@chromium.org, john.ogness@linutronix.de,
        rostedt@goodmis.org, senozhatsky@chromium.org, pmladek@suse.com,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] kernel/printk: check return value of console_trylock()
Date:   Fri, 16 Sep 2022 18:58:52 -0700
Message-Id: <20220917015852.3833820-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Check the console_trylock() return value in case it fails.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 kernel/printk/printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a1a81fd9889b..2c6a0484315b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2937,7 +2937,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	 * context and we don't want to get preempted while flushing,
 	 * ensure may_schedule is cleared.
 	 */
-	console_trylock();
+	if (!console_trylock())
+		return;
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL) {
-- 
2.25.1

