Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816D606517
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJTPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiJTPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:51:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396821B90FE;
        Thu, 20 Oct 2022 08:51:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so2685621wmc.4;
        Thu, 20 Oct 2022 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54fd/0yen88eFOEGtvTo0HIRTRehsPlXZmjj7D9lRYM=;
        b=AYzEUOOvgKrh8OY79DYRWSgwx6N8g/vR6J3zOIQt1gL8WOjDLWAvK0msuxAhyjy8H5
         gggcBJuxspkS1/wgrQLT9gieS4kFqu/mJAgZ91Qbp9fsYRwVSSdVjymrhQOpRcfHFyrs
         vNRr0nHhoAQ+F8gPsOe5wA8m7xO+PAeHiFT3p0gr84lf5L/rtvXxecm4lkmf8I+c2Toh
         2iNtwXaKtllOhvTEnCy8jnkFj3p8ozL9gV+oeNG/AXBMdhpeiy36hxivHZN0IEx6e6Fw
         5Fpi5LiZdrRHQMMbr9nRKNAjvE+yYYa1ZFS3CvKJEAZ++wOhbYVd2+1kidN34KTWWFyZ
         FD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54fd/0yen88eFOEGtvTo0HIRTRehsPlXZmjj7D9lRYM=;
        b=bFpCd6txKIsCYOdo9RQx292AGuDTLgwWP7IldpdxKjB8BgE/V2a82KeXcQ5mvU7eoA
         SrNjf258FHSYw5g/oKffjx/3bohbnsTSWFL4etuJyntjhmMCfTkmXWek7QWpAnlm9qeq
         ihtFzT8u858xCqI2+VMgyBMVVlnAeeMxNsGqFO5+YfxbQ7kukMOi2eW1CMms8yYqWy2C
         98o8Qx8YJzLVlsTnbTt/QXuLkqoYeO5/Gp9QeXh9GYW/g3LPGCLvONmWE7UU0vh5vQDY
         DjvQnHvCTHwunKKlsTwcPIs6sDKzUdrZUe6E0YAmOl5XJ6Np7z4Ljn4Zn4VQCL1iuYp4
         2EUw==
X-Gm-Message-State: ACrzQf3jQhfsei/+jAHvASx6INqiaz7SRou86Y6u9AeN2P+pkGGKDZXT
        5WGHSMWBrhv/3O4ezgn/O2q90TGUDt+xUA==
X-Google-Smtp-Source: AMsMyM4kwoM78oquyzfzXtDeD8DlaN+JrS1iv5KYcCC4O7CgALTGucAn/e7/srb06hAYQjUkLMB/vQ==
X-Received: by 2002:a1c:f60d:0:b0:3be:708b:c96c with SMTP id w13-20020a1cf60d000000b003be708bc96cmr31458957wmc.168.1666281074889;
        Thu, 20 Oct 2022 08:51:14 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c4e1500b003a83ca67f73sm31645wmq.3.2022.10.20.08.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:51:14 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Song Liu <song@kernel.org>
Subject: [PATCH v2] raid5-cache: use try_cmpxchg in r5l_wake_reclaim
Date:   Thu, 20 Oct 2022 17:51:04 +0200
Message-Id: <20221020155104.9485-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
r5l_wake_reclaim. 86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg (and related move instruction in
front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Fix garbled subject line
---
 drivers/md/raid5-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 832d8566e165..a63023aae21e 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1565,11 +1565,12 @@ void r5l_wake_reclaim(struct r5l_log *log, sector_t space)
 
 	if (!log)
 		return;
+
+	target = READ_ONCE(log->reclaim_target);
 	do {
-		target = log->reclaim_target;
 		if (new < target)
 			return;
-	} while (cmpxchg(&log->reclaim_target, target, new) != target);
+	} while (!try_cmpxchg(&log->reclaim_target, &target, new));
 	md_wakeup_thread(log->reclaim_thread);
 }
 
-- 
2.37.3

