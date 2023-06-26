Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444C173E29C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjFZO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjFZO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:58:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1545101;
        Mon, 26 Jun 2023 07:58:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b7f68f1c9eso14437055ad.2;
        Mon, 26 Jun 2023 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687791488; x=1690383488;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hmh8wbv8PZygexgxnyH4qZ7wQNevvIr6Du0+ni35xCo=;
        b=qZnXvzcd2hJ3+aXJpt7yZh25TZGXjgiAXbclTWSXY9GxefrudhkGjH3O4YrdJ57bTv
         Q16QNuuMiSmjVZVWfCmJPzsrm2wxNiBOc/WphyZRbSz78TWdRHdlWkI77Le3b8DD0yfJ
         Qs+rAgQJeA3zJ/6NUimnZ1gRk6hDdm95g9rZCu234V2Cx2L477PuAInbgzpLUXokIxIJ
         ZiLhJVfFT5G4tJkvLxQMzGDZXAkDAa3ebu0IkFOyckaQLz1wqMBuO/b4goacTHrfbYp+
         exZlcHyawxmP/068E+Q6swe+BWptcsP2Jicops8TTxYEtGwe8SNg1PIvB3xYSPLAvPkb
         h32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687791488; x=1690383488;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hmh8wbv8PZygexgxnyH4qZ7wQNevvIr6Du0+ni35xCo=;
        b=Jn92gbupaQMLTvDymqHKOjFm1MkXCWe/CMPEVHlby88c4T+2klBbAebIMReKp41Mwa
         vw1CT85Gjz2FKUMPkRe/2vNNzEQ9+qg+Zry5Xnpt6WUsLISE4fgDsnYm1AsAf1RgXvLH
         Lpuu724kYz07F+J3gC9e3TauLTD4DSI/ZBQnpJrUIctN4gF1wWWixrznH3cEkullJENL
         Yx/5G69Qs+FfcAZldyKlVR0o/Eu0YY8QRnfy+RTMYFWf2dmJQDYtgk8tSiiO2kOXFVar
         sfQ+tixP217WUV9iDrPy36VC4M/guQo1rLTguVZqR41wysAPwVoI38yh4HaFXnE66JIe
         gk/g==
X-Gm-Message-State: AC+VfDyV4mQKtFiIRpNjd+1x4xJ4Ur2c+LxE+IcMA1YvRVsbjRvTaM1D
        NhSQRhgsC8mGyzAWkDe6kG4=
X-Google-Smtp-Source: ACHHUZ6+/UHdi5peXrr2q6q5paiSAe744S/gQ1FkDR6baMkvQ+7IrFOjVgV2aptlE+PekUaFm/3Yyg==
X-Received: by 2002:a17:903:188:b0:1b2:4b28:793c with SMTP id z8-20020a170903018800b001b24b28793cmr9013547plg.29.1687791488320;
        Mon, 26 Jun 2023 07:58:08 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902821400b001b1a2bf5277sm4313303pln.39.2023.06.26.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:58:07 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cyeaa@connect.ust.hk, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2 2/2] gpiolib: cdev: Fix &le->wait.lock deadlock issue
Date:   Mon, 26 Jun 2023 14:57:56 +0000
Message-Id: <20230626145756.30696-2-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626145756.30696-1-dg573847474@gmail.com>
References: <20230626145756.30696-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softirq lineevent_irq_thread() could deadlock on &le->wait.lock
if it preempts lineevent_read_unlocked() which acquires the same
lock but not disable irq.

Fix the potential deadlock by spin_lock_irq().

Fixes: dea9c80ee672 ("gpiolib: rework the locking mechanism for lineevent kfifo")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f768d46bdea7..a2c108f172f2 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1858,28 +1858,28 @@ static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	do {
-		spin_lock(&le->wait.lock);
+		spin_lock_irq(&le->wait.lock);
 		if (kfifo_is_empty(&le->events)) {
 			if (bytes_read) {
-				spin_unlock(&le->wait.lock);
+				spin_unlock_irq(&le->wait.lock);
 				return bytes_read;
 			}
 
 			if (file->f_flags & O_NONBLOCK) {
-				spin_unlock(&le->wait.lock);
+				spin_unlock_irq(&le->wait.lock);
 				return -EAGAIN;
 			}
 
-			ret = wait_event_interruptible_locked(le->wait,
+			ret = wait_event_interruptible_locked_irq(le->wait,
 					!kfifo_is_empty(&le->events));
 			if (ret) {
-				spin_unlock(&le->wait.lock);
+				spin_unlock_irq(&le->wait.lock);
 				return ret;
 			}
 		}
 
 		ret = kfifo_out(&le->events, &ge, 1);
-		spin_unlock(&le->wait.lock);
+		spin_unlock_irq(&le->wait.lock);
 		if (ret != 1) {
 			/*
 			 * This should never happen - we were holding the lock
-- 
2.17.1

