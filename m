Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1CB6FF99D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbjEKSxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbjEKSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:53:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084C24205;
        Thu, 11 May 2023 11:53:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aae5c2423dso86859325ad.3;
        Thu, 11 May 2023 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831184; x=1686423184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctA+VGh2kOJyEKyjSwRtHrOrZKFDYE1YmUqRifhUcQY=;
        b=hlXN1gvmobF0Je9jVGGIrqy0ejPcdWkOScD+rmAwgtq0xmfiih5SUuFBDTvIzzYwBR
         RrfRc5GgZcWgD9aOa9H9dFXmYjXDLCUY3TXp/33qCYMg9N1buQHDyzANh0R/lx9G0LwE
         7zR44Hcg+J68hJMymYmWl/eL8nkY/1OZilYnadl6uPLKiecEn4A06k6TSpqa9xjXST9R
         lr8eiHTSdNZNoA5nAIHijYLFiG3bkF8hEvjYmvBJ2bxbcZH0yXkoTAy6pHzW/MFzHaEn
         w0eOApZ/vf8c+KQEaTSpHPR9XJYbWsSwf4i0P+F0QkoSDXJzXNDpz6fmGIG+D5brinZ2
         rbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831184; x=1686423184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctA+VGh2kOJyEKyjSwRtHrOrZKFDYE1YmUqRifhUcQY=;
        b=iY09DzWS7HCrNd4tXiLLDkcKaoMjF23+DZ+jeAXeQHpliAIv0wlQFTUVpChTmKQ/8p
         Trq0LToLp+ONecIg04RuSKWPZXR8hq+qo4ApuFTA4PrgyOaQt7GQxYZufXOoYW4MLlGM
         Rx/sXtMQhBCQ30x09sm/PoMnygXiuiLxd/ITSzGM3mxgZCBmBfdnwssjH6S1Nz7FTYfq
         CxY/+AAJKOIna7YhWsrb5rGMACQXd02ORj1pYoUQLYcdSdgF8hA6G1iGtKJx/MjTwoB0
         dz2mFw4T8jrdtNVkfRfAQDtF0NCaf8C23jj7q9PL3xOKNtMfXLAypErL6o7xcSzIrWZB
         CtPQ==
X-Gm-Message-State: AC+VfDxFjz8jpz2tJg8ytjuLJ+9uQZ9oqLC8wvFzef/jdqhGYs2JIu4s
        pz/6udUaNpzZx8Oyjd2wIWBIn0LslKI=
X-Google-Smtp-Source: ACHHUZ5//gGGqgjBRnaQ8NIZhlUIr4csEhHPEQzmlyqnWdobR9awbFV/U5flbJWtMPHxDiXZbe4xqA==
X-Received: by 2002:a17:903:280b:b0:1ab:197d:2de1 with SMTP id kp11-20020a170903280b00b001ab197d2de1mr19744403plb.2.1683831183766;
        Thu, 11 May 2023 11:53:03 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:84a:ed9c:4024:c347])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001a980a23804sm6288995pll.4.2023.05.11.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:53:03 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] Input: libps2 - fix aborting PS/2 commands
Date:   Thu, 11 May 2023 11:52:45 -0700
Message-ID: <20230511185252.386941-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
References: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
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

When aborting PS/2 command the kernel should [re]set all flags before
waking up waiters, otherwise waiting thread may read obsolete values
of flags.

Reported-by: Raul Rangel <rrangel@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 14b70a78875d..09eb605364bb 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -478,15 +478,22 @@ bool ps2_handle_response(struct ps2dev *ps2dev, u8 data)
 }
 EXPORT_SYMBOL(ps2_handle_response);
 
+/*
+ * Clears state of PS/2 device after communication error by resetting majority
+ * of flags and waking up waiters, if any.
+ */
 void ps2_cmd_aborted(struct ps2dev *ps2dev)
 {
-	if (ps2dev->flags & PS2_FLAG_ACK)
+	unsigned long old_flags = ps2dev->flags;
+
+	/* reset all flags except last nak */
+	ps2dev->flags &= PS2_FLAG_NAK;
+
+	if (old_flags & PS2_FLAG_ACK)
 		ps2dev->nak = 1;
 
-	if (ps2dev->flags & (PS2_FLAG_ACK | PS2_FLAG_CMD))
+	if (old_flags & (PS2_FLAG_ACK | PS2_FLAG_CMD))
 		wake_up(&ps2dev->wait);
 
-	/* reset all flags except last nack */
-	ps2dev->flags &= PS2_FLAG_NAK;
 }
 EXPORT_SYMBOL(ps2_cmd_aborted);
-- 
2.40.1.606.ga4b1b128d6-goog

