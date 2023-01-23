Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5313678411
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjAWSFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjAWSEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:04:52 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3448421F;
        Mon, 23 Jan 2023 10:04:49 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4DB12641DF7;
        Mon, 23 Jan 2023 17:58:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 978BE641ECF;
        Mon, 23 Jan 2023 17:58:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674496724; a=rsa-sha256;
        cv=none;
        b=1Ggyp8gC6IxDBGnQUMw+pGkiFOhzZZgq8big6vOge/eAAazp2pJPPj6ovA+o+7dfdp0zA2
        ZXsQSO75O+b7bEylBZEC5yl+ODHzFMNCRCAe7AgW3F+UW0nnEDEqNbrebVx6efG6VjFRq5
        AnJENdtfAiy22n5RBi8nuPOk+n8lASYN+GoGyWySW1dDDmhaHBZb4UX9alXntU5Zvq19RH
        QCgVhwGxtsSsNY6WxBSRQ5lALUw6PLi3K3bNO5xmUhe9tLnSI5wD6X3h/Xknw/lxuIAarY
        5hqgBB3K+68c6uKjmR3rl9PgBVd66qr1UmmpE4VbryoCpH7p6bhif6gSraheQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674496724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=UklrNt/RN+54aaIDk4F5mKXRmBIU//hy7Ueqk16w5R0=;
        b=MInsk7TYoP+nFLC2XA3Ox35fQSxhw39ktL11cMVwsPeDNjOvLuu2dspT4gCqXn4pOQLaQH
        0PGuw1O+8QasA1cOEuqTfZjQ8iboKCdtF3rFNlnOU7Wx3YXdBxy14RChRsky38N2nnzvsh
        JBUeSxdb9LJsXgID5Orun+6KrlXL5fy+fhts0Onuhr/XJO0Gt5sKpil4/l4Zbr2mXFcoDp
        0JGJuxDoL6BnxUEpmNfkB6madxmdLJ572R5KWY4XPAKwFzAqH2+D5DPuYe+qpDH5iHYRnY
        xyTJGOb8AZU1uaBaxKdb5+P5yU7y/wEs03XrjhAUSeNEvSYOzXHv4bAmjc1xwA==
ARC-Authentication-Results: i=1;
        rspamd-7cf955c847-fl9rx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Name-Occur: 563c0d213d670cc0_1674496725106_3431940781
X-MC-Loop-Signature: 1674496725105:3905830636
X-MC-Ingress-Time: 1674496725105
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.40 (trex/6.7.1);
        Mon, 23 Jan 2023 17:58:45 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4P0yX358VpzM8;
        Mon, 23 Jan 2023 09:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674496724;
        bh=UklrNt/RN+54aaIDk4F5mKXRmBIU//hy7Ueqk16w5R0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=FKfcOKT9J+XoFz4KtYifygqu/wJtK9QUnD8SdiIDcaJF0umKupUqfzG7ta6iEC9oU
         uLX4tChu16KVNKiZkv8SyP6lLJZHxNIAmghJB91T2U0Gy+CimTRsuQzPcCJIAeqlrT
         IM3YNbkFsus4RwtmCitLK0rSSZs8wPHijMe5AadaVyRxNXd4BjXTeEdi/fasSBfK32
         LRumDPuZ5AvgRabKWJLXLgYzhjPpyNGT74ljn8K1yTGE4ej5tIQJwr/k1vJu+GA5bt
         TZqa4Vyqz+ly3bqx+LF6cmA9xYdxEUQGKa4uIXaYIob+Xv0FxZ5lxGkX+UEPN4flEo
         9N1A3xUK2EhtQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     mingo@kernel.org, peterz@infradead.org, bigeasy@linutronix.de,
        dave@stgolabs.net, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kernel/hrtimer: Rely on rt_task() for DL tasks too
Date:   Mon, 23 Jan 2023 09:32:05 -0800
Message-Id: <20230123173206.6764-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123173206.6764-1-dave@stgolabs.net>
References: <20230123173206.6764-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having dl_task() is redundant, trivially simplify.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3ae661ab6260..8336c2618ec1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2089,7 +2089,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	u64 slack;
 
 	slack = current->timer_slack_ns;
-	if (dl_task(current) || rt_task(current))
+	if (rt_task(current))
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-- 
2.39.0

