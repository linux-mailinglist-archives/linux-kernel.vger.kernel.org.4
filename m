Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE06D334C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDAS7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDAS67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:58:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C75265A9
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:58:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso15805722wmo.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 11:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680375534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQco7Dhnho/ct6vSSMXl7joYIfw/17rmQm56sqleYIY=;
        b=mvbgNMC7G8aZnq9RyROnbbcJ9AJfsspHKmolhCfpGxpVtt0bv9TjOoPQy5eB8opITs
         d5V0XULFuEdq619vM6KA56OwV6nZMVSRNbMQgUD3gLKVEpD9NkGTc8jrP6K5FOpKuoa0
         tRGFFRvprWjC6ABO+byMJmznp6LS9TKo+cY5tnYPNzks/fbLv4VDR9LhNyftJki9+eHQ
         FKBEHsq76I1uq8aHz+DTvt3X7F0iYk2dP9jgpRZtNrER6Ansni036WqnWqmBVcWkodSf
         xm78SDfGQRSYYiNryzs7l7rWGo/+RSqR6WnAliyHVDiNqyD895ovh4QyJq9eyw/Fo5xT
         8+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680375534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQco7Dhnho/ct6vSSMXl7joYIfw/17rmQm56sqleYIY=;
        b=jDjtSsaSCmajD6bi1NVHOBQO7XlGibvq7v7L5Nv3IbknfWLlZxKQsll+2BHB0DcMgK
         5TmJypd8cVwtHWmJqi3Wv63jM1y7sdUmmY4wMcaw7Bhf5Jz8SVJKLig/9WeoC2svNQT5
         AJj6BEMLro7DaVZsD43g78xfMeRBktNpzNZSTuLpToYrlgHnOmWRxbfZBKdIiAf01rre
         YMPrArDPbhmwpRmiajXQDH3c/QJwNfc3DY/mh6IMivipcL9hiLcXKTg7cK1Pno/jRqLh
         4p9zIL/xXVBxiHduKfzH+9FZOwGffjDbNNvscBcVZyXTtcfdcfIYQYJ5ee97i5lkNFc0
         zD3w==
X-Gm-Message-State: AO0yUKURUYPjZM0UyzL1aUYOI16M4XDN4Nl95gZVJXndIE489wFILCUJ
        mEjyuOkv9rlXmPXWdDvOMQw=
X-Google-Smtp-Source: AK7set9jehyRRySo2ooJLVHNOtLf8engQYv/q9RklhJ3RucoTx6+JrJyd9t1Xla+tXXr2+ltH2tK1w==
X-Received: by 2002:a7b:cd0b:0:b0:3ed:2f1a:883c with SMTP id f11-20020a7bcd0b000000b003ed2f1a883cmr25249999wmj.14.1680375534707;
        Sat, 01 Apr 2023 11:58:54 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id s17-20020a05600c45d100b003ed51cdb94csm14017463wmo.26.2023.04.01.11.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 11:58:54 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Deepak R Varma <drv@mailo.com>
Subject: [PATCH 4/5] staging: rtl8192e: avoid camel-case <dot11RSNAStatsCCMPReplays>
Date:   Sat,  1 Apr 2023 23:58:43 +0500
Message-Id: <3b179b52e00b398a22cd491e8fc61d4e0edd2a3d.1680375200.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680375200.git.kamrankhadijadj@gmail.com>
References: <cover.1680375200.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel coding-style suggests to not use mixed-case names. Fix
checkpatch issue by changing the variable name from camel-case to
lower-case.

Suggested-by: Deepak R Varma <drv@mailo.com>
Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index e8a3bc94efdc..1783a2eaae66 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -36,7 +36,7 @@ struct rtllib_ccmp_data {
 
 	/* .11 RSNA stats for CCMP */
 	u32 ccmp_format_errors;
-	u32 dot11RSNAStatsCCMPReplays;
+	u32 ccmp_replays;
 	u32 dot11RSNAStatsCCMPDecryptErrors;
 
 	int key_idx;
@@ -264,7 +264,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	pn[5] = pos[0];
 	pos += 8;
 	if (memcmp(pn, key->rx_pn, CCMP_PN_LEN) <= 0) {
-		key->dot11RSNAStatsCCMPReplays++;
+		key->ccmp_replays++;
 		return -4;
 	}
 	if (!tcb_desc->bHwSec) {
@@ -376,7 +376,7 @@ static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
 		   ccmp->key_idx, ccmp->key_set,
 		   ccmp->tx_pn, ccmp->rx_pn,
 		   ccmp->ccmp_format_errors,
-		   ccmp->dot11RSNAStatsCCMPReplays,
+		   ccmp->ccmp_replays,
 		   ccmp->dot11RSNAStatsCCMPDecryptErrors);
 }
 
-- 
2.34.1

