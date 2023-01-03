Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EAB65B984
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjACDB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACDB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:01:26 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC33260F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 19:01:25 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y19so12209216plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 19:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=quBw/ujluJ3rNnNfMKVBDJsfvvRIe1fyf1oyveqm1OY=;
        b=cw0B54keqMMjfjxXPvdfSKFtAdV/6qIqyYsFyMs4XcQgoJ2uSMZCmgxe0U6eaGD4RD
         J3v4V6eSIrgzEmSWmGPnzo97IafNF2fuEa0ZqyaiKtLF4hHd7pkHa24bsEdPoI7iVSXb
         +SsWCPw0kOUCmARlNVq9CwkAXgL41NlRhFt5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quBw/ujluJ3rNnNfMKVBDJsfvvRIe1fyf1oyveqm1OY=;
        b=S2/be+G6hLQjnscE5EmEKT+qh/lmxHaUDIILGYE7G3BuSsKgG4DvamkLQzBbDsvmdk
         h8j0djWAHj8CVOUFdhai+fxq7tM5ioq2EoIP+nbXf0MTJGbsRx5rfgLipmxpN2OTHhzo
         zH24sLHSWqXNovHyj6HD3gwezUR5HWp7D19V2vYbyeU2GkU6P6X+TiimU69Ge6bv2g10
         MRG9B7SVFIhZzaOqtehs1mLQyeIkaEnJOwntq4S9RC/ArEG5ZegAQsES33udqAbHZVS4
         UUZG2eYDcH9g/ZY5xuCnkwFR+3ZEBnNj9NTwIallgNiXq65cBGwQlPzvUUZPvuHf3WQY
         bGow==
X-Gm-Message-State: AFqh2kr9yS8zd8N5NjQiJ0eO63tKl3jbg8/rdOC2JqPlkpCZG2H222rp
        LhCbGwmWB06qpprrjL8prf0uQw==
X-Google-Smtp-Source: AMrXdXt935vls5I/dh5pfohSB68qQnrMTZKGec2ZB29xqw7PU84GxyU26mWB1gff7duNesjBIZ4rQg==
X-Received: by 2002:a17:902:ecc1:b0:192:760f:c35e with SMTP id a1-20020a170902ecc100b00192760fc35emr40224986plh.53.1672714885008;
        Mon, 02 Jan 2023 19:01:25 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:270a:35ec:5bc4:b90a])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902c60a00b001869b988d93sm20838638plr.187.2023.01.02.19.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 19:01:24 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: correctly handle all next_arg() cases
Date:   Tue,  3 Jan 2023 12:01:19 +0900
Message-Id: <20230103030119.1496358-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When supplied buffer does not have assignment sign
next_arg() sets `val` pointer to NULL, so we cannot
dereference it. Add a NULL pointer test to handle
`param` case, in addition to `*val` test, which
handles cases when param has no value assigned to
it: `param=`.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e290d6d97047..70c412eb6c1f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1140,7 +1140,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
-		if (!*val)
+		if (!val || !*val)
 			return -EINVAL;
 
 		if (!strcmp(param, "algo")) {
@@ -1824,7 +1824,7 @@ static ssize_t recompress_store(struct device *dev,
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
-		if (!*val)
+		if (!val || !*val)
 			return -EINVAL;
 
 		if (!strcmp(param, "type")) {
-- 
2.39.0.314.g84b9a713c41-goog

