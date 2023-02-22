Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BF969F525
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjBVNMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjBVNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:12:34 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6F38B7C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:12:24 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m7so9876907lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BsSDzTf9SbFwUJeyYQyh3jBbWhIKnNTZMpy1sOIMAw=;
        b=sMofeJd9iLw2kOEDQpMnMPpzHOysXOgdR3wH4VnBjWBwy+EK8cm8O0J7jxhjyn7Dt7
         77CbVAGYMKonjt7Ex4Tfa19sv8Z2W/OL2Cq7kLub6LZlVWPWFnv19aGhCLMsltXN8tEp
         /vyczCYN6k0wDiA2SvO9B5tb+A0Zk8RCzXbGykG8oBHLFbKMN2qi4kuf8YY0Ohm6HtHE
         VHQLjNhtgkTqUrmf1i00BV9Yg91tR1T2/QLVcFp54jGGYNSFTx6KFqaGmVBXJt3D7DFm
         hTQf0Ge+cb2GDYnf8aC0sGLEo5D7oRucspojLAyHzfa7SQIN8WZv2URm2ee/tNQjFxOK
         GeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BsSDzTf9SbFwUJeyYQyh3jBbWhIKnNTZMpy1sOIMAw=;
        b=hHK58/vzCrLvR15BMYoKUIm43zkp2LbRpFi5OcAVkhsz/SbtE6rW1CVMqgyoGkQuUl
         FJ1Uvzft2NTGpXGMh1N8Pr0RA+QhoTkP5dIctz5oIWGDYM5igMv8ZQ1wVZDPPys7szj9
         f5GHZ3V51XtlRocmvLToKnGfTzkWQ1GCx/veqMzSxMesQBYUIIlhFShszEBIt+AXK8bT
         H3dt3rVKTj30C3mnv3sagIa4bEOowiaLNn8Gi1kcNlogMRXf6tYBUC0pb/O6Wjgu+pRs
         zkW3RD+5m6dcAwJFDhuuZyuLMp29DIM7ZafbmlMQys2m4ycPIeVD6C+ZfeqZBZLCGvgX
         gEbA==
X-Gm-Message-State: AO0yUKWb8hmlEMEgdgeosKISklQK/HRrfBa5JuubYGmAZbgmn4NxuVcB
        D93Ja4Fuo9/4raugTf6rSoqCGg==
X-Google-Smtp-Source: AK7set97icoH4gneBTQnKTzfwX04sUGPV+HUluAuLzHIsOe8ud64Si92qBqUkXq6r4BQiI7iXKy2oA==
X-Received: by 2002:ac2:544c:0:b0:4b5:3505:d7f9 with SMTP id d12-20020ac2544c000000b004b53505d7f9mr2621363lfn.35.1677071543295;
        Wed, 22 Feb 2023 05:12:23 -0800 (PST)
Received: from ta1.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id y25-20020a2e7d19000000b0029335c12997sm564383ljc.58.2023.02.22.05.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:12:22 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, darrick.wong@oracle.com, djwong@kernel.org,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 3/3] ext4: fsmap: Remove duplicated initialization
Date:   Wed, 22 Feb 2023 13:12:11 +0000
Message-Id: <20230222131211.3898066-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230222131211.3898066-1-tudor.ambarus@linaro.org>
References: <20230222131211.3898066-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All members of struct ext4_fsmap_head were already initialized with zero
in the caller, ext4_ioc_getfsmap(), remove duplicated initialization.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/fsmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index a27d9f0967b7..348eaffaa4d8 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -668,8 +668,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	int i;
 	int error = 0;
 
-	head->fmh_entries = 0;
-
 	/* Set up our device handlers. */
 	memset(handlers, 0, sizeof(handlers));
 	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
-- 
2.39.2.637.g21b0678d19-goog

