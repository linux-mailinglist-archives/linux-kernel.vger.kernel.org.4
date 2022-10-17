Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B85D601151
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJQOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiJQOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:41:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83756612F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:41:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b12so16373671edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGzz9vQihkHLYuMDwQK6thgYE3qPewiwBTfTU2VGOHA=;
        b=GGI054dt/nH/X5fLQ6HzXMyw76tZaZ/ExJKRpHQhcyS3kGKNkKsLX6YHP0m6RAkZA3
         ZcrEaUZC4Ij19TF2/y3zLlFEwlJlzW07A27qPq/155DDEIY4B+D/hmcMxdZ7f+gZSdMC
         sArwLPCQlMiPiME5Z+MYVTT0aUFm+aNChRxEY5zquAK0t+OOPp7SsgXJvl9/zaNA/1f8
         6PcUlpst1jSxVyhPKJdp3qBs9xH9+G7sAh1YprxTDU1Ohe8aLaJa2VUfDi5u+tYtc9VB
         eDEoerRLObfDSNt7Sxv9pckdIVRx/3oNLZFUnX6Nh5jZIEt7ek7vibQNpfrwoT4qzgH+
         NHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGzz9vQihkHLYuMDwQK6thgYE3qPewiwBTfTU2VGOHA=;
        b=ojAspNMb4L46kEw19r6a2AagvkgSlA9T/FSVf1yznFNBI/rDhs61Tn598w5beJoxHt
         f/TD78mUvw3vHafZI/D+0rcApNHB8RFeLSROOzV2T/9PnWeNVQDBX0qV50P7+fNO1KmE
         Ffr4mwLBkGtreZ40TwRJbMVbhSaBWOX7MNCT9qm3xt7I8dQl44ex38HhYehSp8Ssf3Mm
         8JZY6d4/Q9c99TefITs9Sysmh+UDwzFIrtNEUwg5dSBLr2xVwrsknAUQ/UyKGLLj9di4
         3psPRsBWgHG882P0TGDMqcEE2np3S58wRbhDr7rayHhVyjLMYBT6Ho7d5pJVSnZY71T1
         hTKQ==
X-Gm-Message-State: ACrzQf1/jWVdhAmKjm423nblyeCbZBMiqblyuZZnWWgMpFu/6WBzvI1S
        nVrztzAfofakZgQfO5kI45kA88Kg/ZlP5A==
X-Google-Smtp-Source: AMsMyM6JELYBC/QVM0l7MGmjeDbyZjHrtbjK/+wCRdhxsYPuDVdEazAtCPeJStP/tQiM7TyEjlwMbQ==
X-Received: by 2002:a05:6402:2546:b0:45d:8bff:7afc with SMTP id l6-20020a056402254600b0045d8bff7afcmr5571700edb.302.1666017678387;
        Mon, 17 Oct 2022 07:41:18 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id dn2-20020a05640222e200b00459cf672a65sm7469144edb.71.2022.10.17.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 07:41:18 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH RESEND 1/2] ucount: Fix atomic_long_inc_below argument type
Date:   Mon, 17 Oct 2022 16:40:48 +0200
Message-Id: <20221017144049.3404-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017144049.3404-1-ubizjak@gmail.com>
References: <20221017144049.3404-1-ubizjak@gmail.com>
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

The type of u argument of atomic_long_inc_below should be long
to avoid unwanted truncation to int.

Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index ee8e57fd6f90..74f5b4959feb 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -212,7 +212,7 @@ void put_ucounts(struct ucounts *ucounts)
 	}
 }
 
-static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
+static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
 {
 	long c, old;
 	c = atomic_long_read(v);
-- 
2.37.3

