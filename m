Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C246760B3BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiJXROr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiJXRNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:13:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BE3EE081;
        Mon, 24 Oct 2022 08:49:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso3601535wmq.1;
        Mon, 24 Oct 2022 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox3NT4sRh3PO3jRJO5A/eUaL5QHz/K5YDeTmJQezQYg=;
        b=A6ALW2gSnQz5ctwrGGBb43+A8L9eqSGELjLcrR+vSbiP1J7PsxpCVyUwnggecwGGxB
         FoQf7b2c2P4D5OHW9CgvwXspQyt4OJfzhVlR+oyH8ifRK6XhGwIRdkxBbA+k674T8Sei
         jjV1Js5/AE0AAVdIjkDx2XflBe/FT4LhqJzgRaNXbg5Qv44EcxSdNBLLPsUxOhiRRCAA
         S7daIKGusCqHPlogxehNqcyA8/CTEP7AszhxzolT9aRLqDwT93AqdO93Tx3x2S7y0yCJ
         WmSbFHHN2VYh3225iUU52XWvCaJ9iAZSXAVlXt1mMpnC59gA8e4jJ7pBHwfcIfksS8Bf
         8p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ox3NT4sRh3PO3jRJO5A/eUaL5QHz/K5YDeTmJQezQYg=;
        b=KuC79cJuI1xKinCY20ll2JH9JhCnInPmoTQSQXU4GkPv2v69c+G/q8Pdh4843+/U3u
         9VtZa990NwEpWBmI3WfQ1WLmMJ2ti5mO5bFsGRtxT4wct6dK/6nlTPwVYdIBGyaQ/25v
         jwNy6GcWsC9yr0cgoX6qc3fCPP4AQjCg4kPa/IkTEHfmMG90ZjPa767hBSqCgFdo/20P
         VMZt/zR6HbziWJXex2y3TQXIUTSOJT5xoy6kNEWF+dRcXD6KyZRqfULzHKk4dT22LRTZ
         WDqynCHrLIc4SmKXd/r8lr+qTnG6HyusA5RChdwGY9AN1yigX1DCk3av5U3kn1T4UVZb
         Ae4g==
X-Gm-Message-State: ACrzQf1iqDgCQ161e4KnKsbXqM8as0Wik+KpDYdEOEJbFiYuiZjb0Q/+
        aFcargWN5qs/0KR0SNzbdFASlYgDIqpUu5TS
X-Google-Smtp-Source: AMsMyM4J8Vmm+xY0Kv0RrQjrv7s8nj0ZZwoe43nagROBzOgWMr9GPGYXOWd762abhi0dCSaI9MO4jw==
X-Received: by 2002:a05:600c:4f55:b0:3ce:ec0c:2a60 with SMTP id m21-20020a05600c4f5500b003ceec0c2a60mr3225555wmq.159.1666618677072;
        Mon, 24 Oct 2022 06:37:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003b4cba4ef71sm8458353wmo.41.2022.10.24.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:37:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: remove variable i
Date:   Mon, 24 Oct 2022 14:37:56 +0100
Message-Id: <20221024133756.2158497-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable i is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/vdpa/mlx5/core/mr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index a639b9208d41..60e0f51d9c92 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -311,7 +311,6 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
 	u64 st;
 	u64 sz;
 	int err;
-	int i = 0;
 
 	st = start;
 	while (size) {
@@ -336,7 +335,6 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
 		mr->num_directs++;
 		mr->num_klms++;
 		st += sz;
-		i++;
 	}
 	list_splice_tail(&tmp, &mr->head);
 	return 0;
-- 
2.37.3

