Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16816D4E7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjDCQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjDCQ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:57:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E655C2121
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:57:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id le6so28642554plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1680541035; x=1683133035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9I4ZecVy3fyI5IuMltEzbGksbXr8pR/9Hr3PJxym5iU=;
        b=XmQVOz2Xhpolkz4zevRlPrIc+tQ0fY2gz/ZTUCzNXxqkEfrwR/QL8KORuXXMp790lq
         zkZ5DE/AM7GAPeSWGKlX2oyAzBQKtGJ9Wz1g8y7ZyiDh0UYFzK3q8IO6/h5IpwIk1ReB
         r67F+8Jr/nf0B/fO2BVExZCemduSPCRuELQdyR9YIjKWsl87VLQ1au6KIhednBBTuldW
         zlPyheEvwYDVA+Jxm5MhCqpIcb9tdZI+rGb3PecNo3DKPA0Z6n6hfifeVV/HlK/0t11e
         XGfyPW6dnpokfbQU7nwRNqZzpQRLcUiRCflODlYZjHEoMEamKj71wlASBhfdI8jNosPS
         VCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541035; x=1683133035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9I4ZecVy3fyI5IuMltEzbGksbXr8pR/9Hr3PJxym5iU=;
        b=Krp3bFULQ2S3djL45Bzcl8awMTbFuqqJ7JaYaLmqA6BTgrX/mrcl9C+aWNdg9rmHzr
         ch+Ij6M35sKVgOsDFh6hpRuOxf27J47BTxGqJP8FdRINdimVt5Hqs0cqJE0xu7tH/ZHS
         CgJpR9HYuGXkBFO0k/eiaxsk1Qd6QKBdCSPYrDUpKei8hirJfMwe0othbsJUJtMqbpuw
         iLbf5IH+2jAwtAhL1Q69/Ezhoaw743aher4fitNb19Rub3iTMT1NXfevGleyX/rExseg
         BZyRjmh2qVyMrZE61d4FHgqpJDzri8Kjhh8cbIsF5V7+O/iYaoHFXWQ38P43k1p5iCd9
         1Ptw==
X-Gm-Message-State: AAQBX9eR97Dh69tt22VMImKzQFdEJ5v7bso3C+nVNeuelcHckFFfXfW3
        3JXbPt87hlQ8GtjphWNpL0Yrig==
X-Google-Smtp-Source: AKy350ae5OzaFUvcdIZgoTF5QLkExG4f5r/Td4iepGkhfYBxHkjAeoNxR++h1WDCi8Fo3fZbyBdIjw==
X-Received: by 2002:a17:902:f985:b0:1a1:d24f:a5f6 with SMTP id ky5-20020a170902f98500b001a1d24fa5f6mr34306766plb.46.1680541035066;
        Mon, 03 Apr 2023 09:57:15 -0700 (PDT)
Received: from ubuntu-yizhou.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001994a0f3380sm6828494plw.265.2023.04.03.09.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:57:14 -0700 (PDT)
From:   yizhou.tang@shopee.com
To:     neilb@suse.com, tj@kernel.org, wufengguang@huawei.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tangyeechou@gmail.com, chunguang.xu@shopee.com,
        yue.zhao@shopee.com, Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] mm: Fix memcg writeback for rt tasks
Date:   Tue,  4 Apr 2023 00:57:08 +0800
Message-Id: <20230403165708.352841-1-yizhou.tang@shopee.com>
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

Neil said he didn't know what was wanted for realtime in the commit
message of commit a37b0715ddf3 ("mm/writeback: replace PF_LESS_THROTTLE
with PF_LOCAL_THROTTLE"). I think we need to distinguish between the
global writeback and memcg writeback in domain_dirty_limits() for the
rt tasks.

Fixes: a53eaff8c119 ("MM: increase safety margin provided by PF_LESS_THROTTLE")
CC: NeilBrown <neilb@suse.com>
CC: Tejun Heo <tj@kernel.org>
CC: Fengguang Wu <wufengguang@huawei.com>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
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

