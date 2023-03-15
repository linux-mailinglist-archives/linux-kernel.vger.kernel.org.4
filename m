Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6F6BAF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjCOLVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjCOLUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:20:39 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A4C1E1E2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:20:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a32so19045887ljq.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678879217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUIBQeZLD1/U/OTUld+6Gx5O9QYoGGbr9KxfQ5s0UqY=;
        b=AItDdog7vDad4NG6hg0wN8/WcKP89JIGr1xI+3j+EwGdAurYhg8Ub8UL5PsSJCsAyC
         PtZIDR/4hWCq4sWavs2eMChzAUrgSFQNBKChOYytijclhgcuVJctvVkn+AkS0Fe/R5Lr
         MY2ERby+IbCllKs+XFajCoG3znoZVNLpkLN9x2hRWLawQfuDrEoBTrcct+CoPJaKoE9I
         U1gLZqN7Oqsa/4c/FUVDANoZBs/EUzJ1HAwbAzqutvUBLT/pe/Zduy2GiljK1rzM7IV3
         S7nUieDROgBF+XAyOI1bcxm5pUab2eK73lRolJqrhAyUe61hIohCi+4Xpy18AgEw3qqS
         gmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678879217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUIBQeZLD1/U/OTUld+6Gx5O9QYoGGbr9KxfQ5s0UqY=;
        b=6IjUW/kMX7vNcZRvi0XO0gZBAjlNAbTJ8z5O085P4Ddcp6OwJnJooe1w7QPRmUiW5/
         IxjDSfS46aDbMT8XXwoBruJXxIe2OkNQ1ix2KyjZrRzJl5FTaAV8/oklHHOzluabs6eM
         DuOiDMe1F1ye+2oRkLAs4zkRBS9mdz3RlU6msJ3egtZRqIoaP11InAV8EOHFsMVgCxvF
         kRDyW1BUNiOhqTk+ZBAKznXJCkO4/xZRSPYmqUi+aiWOxI0QhGwbMJ6wDQEBlSCytuKY
         Cmk45F1X5+sWBHY0SAWDmyYzYSzNHnoto3xCPVEwgYQEIDBrqxh1lsHHb1d1Ne/+IgEs
         8icw==
X-Gm-Message-State: AO0yUKWTJ8qXpvCouZ+vA0kfI85hZXZg7Tt05bL01VFYD8UA/0T5XheZ
        +kvb/I9Y2mpVbUq+pCHNRDbWvw==
X-Google-Smtp-Source: AK7set/yBNSJIoaShXOc1c2uObsDThrYX2WB5Cd0hELWCCOdsKTmpHWENUh9MuGZuqSad5bOW/xHXg==
X-Received: by 2002:a2e:be9a:0:b0:292:8283:2c03 with SMTP id a26-20020a2ebe9a000000b0029282832c03mr989045ljr.51.1678879217212;
        Wed, 15 Mar 2023 04:20:17 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id k2-20020a2e92c2000000b00295da33c42dsm817410ljh.15.2023.03.15.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:20:16 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        djwong@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        leejones@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 2/5] ext4: fsmap: Check fmh_iflags value directly on the user copied data
Date:   Wed, 15 Mar 2023 11:20:08 +0000
Message-Id: <20230315112011.927091-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315112011.927091-1-tudor.ambarus@linaro.org>
References: <20230315112011.927091-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct ext4_fsmap_head is the ext4 internal fsmap representation of
struct fsmap_head. As the code was, the fmh_iflags validation was done
on the fmh_iflags value of the internal fsmap representation. Since
xhead.fmh_iflags is initialized with head.fmh_iflags and not changed
afterwards, do the validation of fmh_iflags directly on fsmap_head data,
it spares some superfluous initializations in case the user provides a
wrong value for fmh_iflags.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2: new patch

 fs/ext4/fsmap.c | 2 --
 fs/ext4/ioctl.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index cdf9bfe10137..7765293bfa5d 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -635,8 +635,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	int i;
 	int error = 0;
 
-	if (head->fmh_iflags & ~FMH_IF_VALID)
-		return -EINVAL;
 	if (!ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[0]) ||
 	    !ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[1]))
 		return -EINVAL;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 2b412f1cbc10..77b0198a0f48 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -873,6 +873,8 @@ static int ext4_ioc_getfsmap(struct super_block *sb,
 
 	if (copy_from_user(&head, arg, sizeof(struct fsmap_head)))
 		return -EFAULT;
+	if (head.fmh_iflags & ~FMH_IF_VALID)
+		return -EINVAL;
 	if (memchr_inv(head.fmh_reserved, 0, sizeof(head.fmh_reserved)) ||
 	    memchr_inv(head.fmh_keys[0].fmr_reserved, 0,
 		       sizeof(head.fmh_keys[0].fmr_reserved)) ||
-- 
2.40.0.rc1.284.g88254d51c5-goog

