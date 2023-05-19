Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0565370947C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjESKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjESKJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:09:24 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FF4E5C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:09:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d341bdedcso302180b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684490962; x=1687082962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=mN/KYSkjwe4oBUPBj056lpeRHMayZYGNPkMtc0EGvqsj46UqpJPSFQCnHHYK7th6a5
         jK7/CP+NV3QVLIiGceugKCiKPlNIEOYWwNgmIlsfr/AKYvOG//Tf1tmkdqcaxE3Shk8y
         gEnLyIXD2EE/mQ5GBd8M50YOOVrWYrd+2+VMwbjIDO/PktxR/3X8vX0gtmJB9kGps8t9
         4ENar8i0NKaPVkorRtNj+nC/fgJwVtNxGa54QdCQeVwlbrNQ/8Xpv6WSYpia4XniT+TZ
         fEgTcsOzQg+sn1AVTXW4k2p2uxopwB/8CcJxyZmXbOR+etMHNebL6eYQTlaTE2OUXA6C
         P5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490962; x=1687082962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=kaTLoLHlv3A3v5uYY4JIX6VaIncW3ThOJlx2Cuw9+ybp1qKYVJBxQGoty90hEugv9G
         zKT80z2mpU+7DOikB9laAMjpe0yrkcPmQEAngS6ZEPnpEsvDbnTFTsirnUNbLzHeOkX/
         gZh2txq4SsrUm9b3+OciEuwr9AVBKsAq6iyolUVU9B8zDissHDYC/ztv4WzbImIyaFUG
         qoTFNzSKXzG41Q1JN0pYD/kwEGhX2Pqz1qo4z0iujkYhPqQWe0/FjjOe1XuErIdLUo/B
         Btp31y/7qjLJAFaKO3d38djBF/iz89xO+MIbXCA8q6KaP6IiT3WP0qLv0KB5srrbXtJZ
         U5zg==
X-Gm-Message-State: AC+VfDw6HRQF93fVH5TFDmue+KiM9jAZ8lz6c9Qw+AxN4nULQTcEn5cg
        cDyR7iGzB4syNfxd5ZRRuCA0h4yl9NM=
X-Google-Smtp-Source: ACHHUZ5ftD6QXjy0PpqJoH+opC2XVe0mXm7OhPMOt5ELaq+FalOSQQeCpHWEzyQDp8RxlxMD4P0paA==
X-Received: by 2002:a05:6a00:1145:b0:648:ebb2:3d6 with SMTP id b5-20020a056a00114500b00648ebb203d6mr2410811pfm.26.1684490961768;
        Fri, 19 May 2023 03:09:21 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:92bc:26c4:ce02:816b])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7874a000000b006439ad979cbsm2687554pfo.152.2023.05.19.03.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:09:21 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH v2] Staging: rts5208: rtsx: Moved else statement to same line with else if
Date:   Fri, 19 May 2023 15:38:58 +0530
Message-Id: <20230519100858.26508-2-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519100858.26508-1-kartikey406@gmail.com>
References: <20230519100858.26508-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved else statement to same line with else if,
this warning was given by checkpatch.pl

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

...
Changes in V2:
	- Moved else to the same line with else if
        - Moved comment on else statement to inside of it
---
 drivers/staging/rts5208/rtsx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 2284a96abcff..47dacef0aaf8 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -399,10 +399,8 @@ static int rtsx_control_thread(void *__dev)
 				chip->srb->device->id,
 				(u8)chip->srb->device->lun);
 			chip->srb->result = DID_BAD_TARGET << 16;
-		}
-
-		/* we've got a command, let's do it! */
-		else {
+		} else {
+			/* we've got a command, let's do it! */
 			scsi_show_command(chip);
 			rtsx_invoke_transport(chip->srb, chip);
 		}
-- 
2.25.1

