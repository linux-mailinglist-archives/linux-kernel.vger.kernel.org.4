Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C265B850E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiINJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiINJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:34:43 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0838F4456A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:30:03 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f20-20020a9d7b54000000b006574e21f1b6so1406492oto.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date;
        bh=tEmOpEKJPPId5/5e7VK6fU7xewiMp+LJy1T7t+SMohw=;
        b=dk0zJXozE7vaTeyEYimEEZbr7kEbku/z+3FM1ohgYk1EEFHQ3tEoAHfyNEBRfMBWDZ
         54HEUXmMR+nL7ymzmUvPeM0nfZGI6S72v9cs1gYWh4G4uMjkh9JCxOJIAbjQlh9gwM/J
         BIUgMUWXTDV4LNHf50oPkNuVX9bwtV5PxgaJimGusuYmpklJYfBYXWIleiV5VbJorTk8
         sgXIS+mneXyZAzDK6lxQ+GPZMnNmIFx8MZsIObEN2dsaZui9mqKc1sABpM9JGUGVTZGA
         E1Y3sGYf2LRb/uOaF7O52qMmuHty4G9IJ5wDT95UAbg3ykQrSh4FB1n0d4mdCR4i44UY
         M68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tEmOpEKJPPId5/5e7VK6fU7xewiMp+LJy1T7t+SMohw=;
        b=QEgn8Z3fYjzCmMnl/IsCxw5aZk7BiWjmgHZNLInaPCuVNz+QGDQaHcDqRF9vuYkZtV
         e1eJOgpvSwUPIGDn9WAzifzxPXfHqFonnNburygpM0gNNuvH8RXvG26Ye8fKtWVZYrne
         7IHpo/d5erwzyKfvvYscReoQzH1UaHZfoz1P531hXItfJUenC4QUEtsPFPTyrtI0XvbA
         lVjThierD9mS/TtQI61TmZHLm6WWHuVKdBKVEflp+wxmI8cspOqErHq0IpoCOnc9XKaq
         VS5fZjO2GrpfMqvd9ynfb8V5pW9+4l6huuwL3cnN/ixmfZh7RFS7W+0AJCv8r9TZGMWk
         8PIw==
X-Gm-Message-State: ACgBeo35vWWIXuEfJHXMXrKlIfZUrNqH1GZN3/2fVKCjN1+j/o7U4lbT
        3Q7rC3n1O92Y97kto+cqI+Y=
X-Google-Smtp-Source: AA6agR5U9ZumhOIi+C19PTThqZffGsgvVaONQ3Sof6OQ0Eu0jPkyt+QTIJj98fVhxuEWE4BR3Asfvw==
X-Received: by 2002:a05:6830:3906:b0:654:a43:b212 with SMTP id br6-20020a056830390600b006540a43b212mr12291873otb.317.1663147802357;
        Wed, 14 Sep 2022 02:30:02 -0700 (PDT)
Received: from haolee.io ([2600:3c00::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id i27-20020a4a6f5b000000b0046d91d5285asm6366350oof.39.2022.09.14.02.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 02:30:01 -0700 (PDT)
Date:   Wed, 14 Sep 2022 09:29:59 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     hannes@cmpxchg.org
Cc:     surenb@google.com, peterz@infradead.org, zhaoyang.huang@unisoc.com,
        haolee.swjtu@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] psi: fix possible missing or delayed pending event
Message-ID: <20220914092959.GA20640@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a pending event exists and growth is less than the threshold, the
current logic is to skip this trigger without generating event. However,
from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
our purpose is to generate event as long as pending event exists and the
rate meets the limit. This patch fixes the possible pending-event
missing or delay.

Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9711827e3..0bae4ee2b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -539,7 +539,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 
 			/* Calculate growth since last update */
 			growth = window_update(&t->win, now, total[t->state]);
-			if (growth < t->threshold)
+			if (growth < t->threshold && !t->pending_event)
 				continue;
 
 			t->pending_event = true;
-- 
2.21.0

