Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FAC6733A6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjASI1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjASI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:27:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB5A677B3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:26:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id az20so3709587ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSZwz/ZTlMLiExcToVQuiT8oFan8UFZmwdNwvgwFSac=;
        b=mNTM5AJg7ui9JlnhPVh3p6lzm3E55W75nfZxBi8IvEEpPbHDiegLCmh+CXKeCF5t9W
         TW8matPBQKEDx68vOjbsaW7yPt6BS4mYQag7t+ozR8ajyxrgnWrgOOy89r5j0LZZvhU0
         AORRebrGfwjOsie1UN/kT5ntEZOeEdK+biynWNsWWUNJYzbpl0ha6e/jKGJfBGXdqIZX
         mCqWa/gFqQuMpdTayCqdDjzT0bs9sgmvBBGUfAazeVUDd33fidQYsqv5c0UQSjQUGo7B
         IrFTbPJ7db5H4HM6YXvptJUMUe6HczD0yDDPwEdLfTfOMfNSaiwAu5sE2fgEW0eDwqai
         kAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSZwz/ZTlMLiExcToVQuiT8oFan8UFZmwdNwvgwFSac=;
        b=oOiLiooBYKjCkG9IUZlZxBASxv07h1CYDGFiJf418AbZP4JnUE2QhoEiG8RyZGuLQo
         T4uP+jCNKtcRYiZsL8VfXwjrRxiQjzcJbzJmAhl5SJIKb5kFLmcZCxRxeKJqy+wayus/
         Xwb3Ic14bqIFhO5eZAcMq7vQ6PYtS4vrYWbbiJPBOZDwYzV8Z7inWHtnPUoa02mu8qvH
         ukQ/Xtlzkl7hkJT1DLBc5NSqMLyKoqymFcy3eRIYjeT9uD2a5I+6sCypFt+tiTrsZCi4
         PcK2I34y5rMeEq/cbarfJgg44OTCebHu+m53uBvWMc+V2LXD7I4Y5XEvzDz+FGrNXezt
         fTsg==
X-Gm-Message-State: AFqh2koQK71RmQx8HIucjvco8AQJc5SLiepFhPgExyqBblbjqvgvSjHW
        A9roj1cHJOSp/eT7rBnBU6HU2AqCuv+xwA==
X-Google-Smtp-Source: AMrXdXvfg1vygnOMkKjLYzjsXW/AFJ8TnYJAeatzVZsI3JwuD7syj+4F7Nrh1j18lKH3lwTqsbUGJQ==
X-Received: by 2002:a17:906:f299:b0:7c0:fd1a:79ee with SMTP id gu25-20020a170906f29900b007c0fd1a79eemr10108518ejb.63.1674116805805;
        Thu, 19 Jan 2023 00:26:45 -0800 (PST)
Received: from localhost.localdomain (2a02-a420-f-f912-a404-9692-a1f8-1c00.mobile6.kpn.net. [2a02:a420:f:f912:a404:9692:a1f8:1c00])
        by smtp.gmail.com with ESMTPSA id ov38-20020a170906fc2600b0084d4733c428sm13417193ejb.88.2023.01.19.00.26.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jan 2023 00:26:45 -0800 (PST)
From:   Semen Zhydenko <semen.zhydenko@gmail.com>
To:     linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Cc:     Semen Zhydenko <semen.zhydenko@gmail.com>
Subject: [PATCH v2] Fixed typo in comments
Date:   Thu, 19 Jan 2023 09:26:40 +0100
Message-Id: <20230119082640.90793-1-semen.zhydenko@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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

To change one typo in kernel/time/timer.c
Typo is "aquisition" proper spelling should be "acquisition".

Signed-off-by: Semen Zhydenko <semen.zhydenko@gmail.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..6430c00b05a9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1324,7 +1324,7 @@ static int __timer_delete(struct timer_list *timer, bool shutdown)
 	 * If @shutdown is set then the lock has to be taken whether the
 	 * timer is pending or not to protect against a concurrent rearm
 	 * which might hit between the lockless pending check and the lock
-	 * aquisition. By taking the lock it is ensured that such a newly
+	 * acquisition. By taking the lock it is ensured that such a newly
 	 * enqueued timer is dequeued and cannot end up with
 	 * timer->function == NULL in the expiry code.
 	 *
--
2.37.1 (Apple Git-137.1)
