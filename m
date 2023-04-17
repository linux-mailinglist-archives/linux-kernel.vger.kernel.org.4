Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB956E5045
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjDQSce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDQSca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:32:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E1D5BA9;
        Mon, 17 Apr 2023 11:32:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso48579505e9.0;
        Mon, 17 Apr 2023 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681756324; x=1684348324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4YNVJ1w+vvWtBhyJacg7ThJY3eItiKrh9c7uHCON5k=;
        b=NKaKiRjeXq13ldR2/Z3SBgBwizf2PrbSwm0CIs1DXiM+xJe7iS/pDayh0Sieu+9VZr
         ixYZ76ujbT2Xqh2hCGWbda9TuJDMJSjlT3llP4PKfET6LEjlN276g2lG2fpXBpTYyF5D
         RZrB2yV+wdHT4/Ycm0MJTwt8BHML2PPlQNpf6GZVT0qEIw7AFWDa8JTLBw2/9PBBudKx
         L6lXqzantdwuIv/jTh3lRVqyDvkN4/q/XYGwhbDetX2MUeUgib21sTI5vvyGUI0Ldcwg
         7w+UnDSGoF6jNRNshPTInoIFD0M8QkjD4/5hx1EA8/6kspRwOKJdEIHq8llw/tSpKxV+
         Xhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681756324; x=1684348324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4YNVJ1w+vvWtBhyJacg7ThJY3eItiKrh9c7uHCON5k=;
        b=hocpH70qAbtUHRzglA4nqsT0h5T4dkVTEKEWalhobnFkzajZjXSwOoP61WAOG/Kcx0
         p0YghXH1m8QiKc3YnNFM6KlFdLMnSZV25VWOohwUSIgyjKyTXq+mLqBJt8uwUkQxf6x6
         MrTjjsKU1bzkmWm9pH8BcdFOOYifj76iA8Uoe5MUTCJgWVBramx19SceX0dLFf27kpbM
         oBIbymTaeRjoqD1En6UI2qIp/9UGL0LSm1MbZxw8n8ridmDkKJ5+RaewUUJwOVPyUHVn
         snmV6IrC+PzzaO/lqZoy6yYeNlOjtgxtF6C/xz4U3+66NX9kS2TiPRjjHfLqQ17g9Q16
         YUQg==
X-Gm-Message-State: AAQBX9e633imHhwg5tfxXQxhz1ko87LDDn54l3ztcHqWcnBWleACm8b/
        CEKeeKpv8+pIjYCw2OLQ3mE=
X-Google-Smtp-Source: AKy350Zd5BGbH215d2p+Du8/P88Y/ax7rMkxA3hJJ1frp4sH/jroFTse5HTwSM2SELpby/VCDpuhIg==
X-Received: by 2002:a5d:6b89:0:b0:2fa:88d3:f8b8 with SMTP id n9-20020a5d6b89000000b002fa88d3f8b8mr2934553wrx.12.1681756324398;
        Mon, 17 Apr 2023 11:32:04 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b003f1738e64c0sm3797419wmq.20.2023.04.17.11.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 11:32:03 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] speakup: Fix spelling mistake "windo" -> "window"
Date:   Mon, 17 Apr 2023 19:32:03 +0100
Message-Id: <20230417183203.54388-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/accessibility/speakup/i18n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/i18n.c b/drivers/accessibility/speakup/i18n.c
index d62079b1661f..554bf81f2c1c 100644
--- a/drivers/accessibility/speakup/i18n.c
+++ b/drivers/accessibility/speakup/i18n.c
@@ -31,7 +31,7 @@ static char *speakup_default_msgs[MSG_LAST_INDEX] = {
 	[MSG_CURSORING_OFF] = "cursoring off",
 	[MSG_CURSORING_ON] = "cursoring on",
 	[MSG_HIGHLIGHT_TRACKING] = "highlight tracking",
-	[MSG_READ_WINDOW] = "read windo",
+	[MSG_READ_WINDOW] = "read window",
 	[MSG_READ_ALL] = "read all",
 	[MSG_EDIT_DONE] = "edit done",
 	[MSG_WINDOW_ALREADY_SET] = "window already set, clear then reset",
-- 
2.30.2

