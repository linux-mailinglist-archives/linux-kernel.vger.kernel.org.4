Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B75FA243
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJJQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJJQ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:56:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593541A3B7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:56:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y100so16742654ede.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7Lu1f1l8aXMTq6jYWIMcge3Ms0HY5uTYXjKT0lkG14=;
        b=LdYp7um8bF6F6J2/ysqRXdpaB/GcUaACZwguVsd/lWFeKR5yqORlsqxo6VVPuIdbZX
         8MzHwUbPmzzcc7CmQMUnPdA4nuBBdYe0g/oi4UkUQi1l9o7AYYrjOlYtKZslj+a5AYWm
         7AJIlTxmecC0t1wLZEDQALOBCWDzg2io6FNoRFO+u2cy48X/SzgJo1Z3y+eGGm5MbSUx
         CqW3pcwbDyA+j1aVP83PhOHJldBExhBhzDnFl3WpkRFzgjvw3kLIkyTKpRsRrDJQFzHm
         1Tn0PxLKnZlgvj65SIi3Jo2jJ4CjKOmnworW807rhEzXV73FU8/v2QA7fJShX5iprBwc
         Adeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7Lu1f1l8aXMTq6jYWIMcge3Ms0HY5uTYXjKT0lkG14=;
        b=CJLcBZqLck9M6N8+9ghsMXVX9v2g4QcUaXtjP2D5/LZHyuXXLC28Bx/kaVBmVev5fO
         OmwJk0rHSrJTETfvs9h3WVfycKsfl2SIrrn3XPv92+ESrIrxb+mIVr4VucsmG0c3nmy+
         zQJJZ3ScaxfKoBEXMEseab3rTEi3/zo9o6glikTO9hHaMN4DR1w6S1eEiHxdyajAuFRU
         vKJhmT5HzS1xCW8ejxtyr9KMxN1Sv5i/sVUmF62Hw8hfAcXTugAklUvNIjdq8NZE96Ja
         inkJ3Adidc1Su4dpKTx29PJ+EHImULWKtkRKb05cv3MY5k+JVKUYHjIgIma07V314UvS
         fn/A==
X-Gm-Message-State: ACrzQf3dancX2u3juMqM+zJvmdGreDoAg8H/H4L2g2zfIDUhnP6U/sBD
        +3Dkvg1VCAEv7FMFeuKjbiw/5idE4c/cHA==
X-Google-Smtp-Source: AMsMyM58qI4dbIReL01Jn7Qnhfzbiwj1Ich+dGPNyfXeeRhnC8kqCfu5V3IuGczHks/A+CaU1+u/Tw==
X-Received: by 2002:aa7:cc8e:0:b0:457:23db:f0cc with SMTP id p14-20020aa7cc8e000000b0045723dbf0ccmr18818781edt.122.1665421015814;
        Mon, 10 Oct 2022 09:56:55 -0700 (PDT)
Received: from arch.localdomain ([111.119.183.43])
        by smtp.gmail.com with ESMTPSA id a1-20020a50c301000000b004580b26e32esm7421429edb.81.2022.10.10.09.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:56:55 -0700 (PDT)
From:   Mushahid Hussain <mushi.shar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     samuel.thibault@ens-lyon.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>
Subject: [PATCH] Speakup: fix a segfault caused by switching consoles
Date:   Mon, 10 Oct 2022 21:57:20 +0500
Message-Id: <20221010165720.397042-1-mushi.shar@gmail.com>
X-Mailer: git-send-email 2.38.0
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

This patch fixes a segfault by adding a null check on synth in
speakup_con_update(). The segfault can be reproduced as follows:

	- Login into a text console

	- Load speakup and speakup_soft modules

	- Remove speakup_soft

	- Switch to a graphics console

This is caused by lack of a null check on `synth` in
speakup_con_update().

Here's the sequence that causes the segfault:

	- When we remove the speakup_soft, synth_release() sets the synth
	  to null.

	- After that, when we change the virtual console to graphics
	  console, vt_notifier_call() is fired, which then calls
	  speakup_con_update().

	- Inside speakup_con_update() there's no null check on synth,
	  so it calls synth_printf().

	- Inside synth_printf(), synth_buffer_add() and synth_start(),
	  both access synth, when it is null and causing a segfault.

Therefore adding a null check on synth solves the issue.

Signed-off-by: Mushahid Hussain <mushi.shar@gmail.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index f52265293482..73db0cb44fc7 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -1778,7 +1778,7 @@ static void speakup_con_update(struct vc_data *vc)
 {
 	unsigned long flags;
 
-	if (!speakup_console[vc->vc_num] || spk_parked)
+	if (!speakup_console[vc->vc_num] || spk_parked || !synth)
 		return;
 	if (!spin_trylock_irqsave(&speakup_info.spinlock, flags))
 		/* Speakup output, discard */
-- 
2.38.0

