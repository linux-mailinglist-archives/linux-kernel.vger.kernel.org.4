Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BD463A1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiK1G5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiK1G4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:56:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE70314D33
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:56:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso13076020pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0i5FnGtAyUdXHK2FlC9FSrG4zlAkz9wSIjLcDDoXAZk=;
        b=a/6HoTcL1zuzUON09BSQMLWi2k3H0eZUDilcSOnZmquae2nxOF+Cdoxg+rc7y83seR
         JfHQevfftLkUrjdjBP6WUfsMfaXxqpBqQpxnWd/f5xJLxuemjLLT+QWG4cj0MifHpvTh
         0sd+19wozLmy55GSfyXo6By4zN9AHrXRrl79u/zKwqKZUicKUcvgHwVZlpuY/7KbKXAG
         qYn7H0zVF08kWOBoabiBkjzYAtkjauu8eMDkdktd1twN7emp8+OAakn8ecPHFTx64d39
         /+FJOn9D6P9cP0f0mmTMWPBsSUDeecGAi78FSBPEVjwdjXvslR1IiWgg/aG4b7OoQXNM
         Hh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0i5FnGtAyUdXHK2FlC9FSrG4zlAkz9wSIjLcDDoXAZk=;
        b=RGaDnAX5LpR5iHjbRUFUxGFW1+njkpCCippEOaAv1Oz2gJtmDOm4wC27eZq5W7vorl
         2lXcBb+25B9TLmaF1/7aQdQgZX/Ffs22B2URicxIop258rNpb+lw9DJ04Mwy6PdLPkld
         mbUa4/cOtDyvHI/pj2feFm97P4x7W6xoDGbFgO6GW5fklOFAPx+1gLZnyAQh/YlgD/+h
         sWEyIe4haMU999fUq4BwFZVluXelMjdNqml3ShSPgSsdHtDta/lgoEo4ULsCakWn2F2m
         yVYFtafadU31cc7w0IUjSFaE41xTuMktc+hoQvb4MqH7R6w+H2Y5PNzXVBYfV6OsvDsf
         sySQ==
X-Gm-Message-State: ANoB5plizS/AFxxkDuhlVCLMbYKOuXz2ma0lRJrT/Q9oiMeFXkDf1FOC
        Xe29p8ikc84Oe7jjzVl4HFBELw==
X-Google-Smtp-Source: AA0mqf7r5iGtp26frzuqz3uEh/kGydQGdD2CkgviwDpOPELRN8cnzhhwSS+GFCRhNtNyFzNYlpLb3g==
X-Received: by 2002:a17:902:b613:b0:179:c436:4528 with SMTP id b19-20020a170902b61300b00179c4364528mr35881926pls.102.1669618590400;
        Sun, 27 Nov 2022 22:56:30 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79a48000000b00574d38f4d37sm4466333pfj.45.2022.11.27.22.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 22:56:30 -0800 (PST)
From:   "haifeng.xu" <haifeng.xu@shopee.com>
To:     brauner@kernel.org
Cc:     ebiederm@xmission.com, oleg@redhat.com, keescook@chromium.org,
        tglx@linutronix.de, peterz@infradead.org, elver@google.com,
        linux-kernel@vger.kernel.org, "haifeng.xu" <haifeng.xu@shopee.com>
Subject: [PATCH] signal: Initialize the info in ksignal
Date:   Mon, 28 Nov 2022 06:56:06 +0000
Message-Id: <20221128065606.19570-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
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

When handing the SIGNAL_GROUP_EXIT flag, the info in ksignal isn't cleared.
However, the info acquired by dequeue_synchronous_signal/dequeue_signal is
initialized and can be safely used. Fortunately, the fatal signal process
just uses the si_signo and doesn't use any other member. Even so, the
initialization before use is more safer.

Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index d140672185a4..b9b0c8c620e7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2693,6 +2693,7 @@ bool get_signal(struct ksignal *ksig)
 		/* Has this task already been marked for death? */
 		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
 		     signal->group_exec_task) {
+			clear_siginfo(&ksig->info);
 			ksig->info.si_signo = signr = SIGKILL;
 			sigdelset(&current->pending.signal, SIGKILL);
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
-- 
2.25.1

