Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44A76DD54E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjDKIYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDKIYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:24:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061F4236
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:22:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 90-20020a17090a0fe300b0023b4bcf0727so7137179pjz.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1681201375; x=1683793375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IpxUF5lPw5fH1v9GXstfYnEROMjPbDed/M3WOXixapU=;
        b=cWu5zeNKGveJkZyiAQ2eJEzyk9Z1bgZABL/DL4qd/p/mnaIy2dJ1vq3k0moD4u6TiK
         fMnNSlR49Ew9nZRJ4mf+xjT22EwB2OVZpxusyoDvynf6MM2S24PVOCVIhlhCEtFVjvyd
         2SqMLcAWDlXqM1rpnsPz6KiJVZOJiFvF+2WOqOaB85XoV5hoaBidreXGrnft6wDVzOjz
         RBoYq/sozNJFzoqZR7x/DPkimOnCxd1n6HcVAH8sFi9asEzDOpKEwad1DacPqR51i4Ux
         xeOHKj58iARqpyUnO7y1AZTL/n490mnFw99/6ZtvMmXBbQrrX7XLwCAEvQ4FanlORsiB
         bYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681201375; x=1683793375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpxUF5lPw5fH1v9GXstfYnEROMjPbDed/M3WOXixapU=;
        b=WVfmzGMuvM5axZKMrH846gD2dCxpJzVkm5lZp2GGBPT++kZUH/ZZpi8p/QoQR83eq8
         ieDDLMNIBRdcPYKPwgLqBjHhU5nRFfvO2C/UvCm0kD68TnTZi2PfWwx+qHPdYykS0riS
         3rG3tk746IFnj9E8plmKp2n+4Bmzd60ybJQLh6x5RNs8ODp+fLhW9CXruMUVYLNw2ZHF
         s6SY+VCoe2KreNNkYpQ0VDqNujBREZSjsqeM4JDOVOCJFvHPCdEmoMsRwtwu5AoBTcyT
         aucRl2+AA6Mb1KOv2SVUwepWnKJx/wQdELNmwwkeGjcba2dB4Nnn0TsmdsJVXH1aUPDV
         O0Mg==
X-Gm-Message-State: AAQBX9f2VdRhSuw1fbFSW4DETkuHZ4Hz9FzuZBMeedMI1LHTxX3wAqck
        +HfQw6AE/+7Qdollzjh+0TUBmw==
X-Google-Smtp-Source: AKy350b0nqklIctCdZglTxe4v/+TlWgmr4obZvOfg9n6YFmtBop8TII2GX8zcLdfRJqoxp/zJDtWaA==
X-Received: by 2002:a17:90b:4b92:b0:23f:7649:f011 with SMTP id lr18-20020a17090b4b9200b0023f7649f011mr2721652pjb.43.1681201375110;
        Tue, 11 Apr 2023 01:22:55 -0700 (PDT)
Received: from ubuntu-yizhou.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id h1-20020a17090a9c0100b00233d6547000sm8684374pjp.54.2023.04.11.01.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 01:22:54 -0700 (PDT)
From:   yizhou.tang@shopee.com
To:     neilb@suse.com, tj@kernel.org, wufengguang@huawei.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tangyeechou@gmail.com, chunguang.xu@shopee.com,
        yue.zhao@shopee.com, Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2] mm: Fix memcg writeback for rt tasks
Date:   Tue, 11 Apr 2023 16:22:48 +0800
Message-Id: <20230411082248.1020719-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tang Yizhou <yizhou.tang@shopee.com>

In domain_dirty_limits(), the calculation of the thresh and bg_thresh
variable needs to consider whether it's for global dirtypage writeback
or memcg dirtypage writeback. However, in the rt_task branch, the
accumulation of both variables only considers the global_wb_domain,
which seems strange to me.

I find the accumulation was introduced in the commit a53eaff8c119 ("MM:
increase safety margin provided by PF_LESS_THROTTLE"). IMHO, realtime
tasks are given a higher page cache limit because they require higher
responsiveness, but we also need to consider whether the writeback of
realtime tasks occurs in the global dirtypage writeback or in the memcg
dirtypage writeback scenario.

Later Neil said he didn't know what was wanted for realtime in the
commit message of commit a37b0715ddf3 ("mm/writeback: replace
PF_LESS_THROTTLE with PF_LOCAL_THROTTLE"). I guess he made this small
mistake since the commit a53eaff8c119 ("MM: increase safety margin
provided by PF_LESS_THROTTLE").

Fixes: a53eaff8c119 ("MM: increase safety margin provided by PF_LESS_THROTTLE")
CC: NeilBrown <neilb@suse.com>
CC: Tejun Heo <tj@kernel.org>
CC: Fengguang Wu <wufengguang@huawei.com>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
v2:
Rewrite the commit message.

 mm/page-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 516b1aa247e8..7d92de73360e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -419,8 +419,8 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 		bg_thresh = thresh / 2;
 	tsk = current;
 	if (rt_task(tsk)) {
-		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
-		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
+		bg_thresh += bg_thresh / 4 + dtc_dom(dtc)->dirty_limit / 32;
+		thresh += thresh / 4 + dtc_dom(dtc)->dirty_limit / 32;
 	}
 	dtc->thresh = thresh;
 	dtc->bg_thresh = bg_thresh;
-- 
2.25.1

