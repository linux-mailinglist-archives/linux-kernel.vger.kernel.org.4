Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2806C2A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCUGpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCUGpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:45:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3263724BF9;
        Mon, 20 Mar 2023 23:45:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j13so14680998pjd.1;
        Mon, 20 Mar 2023 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679381127;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBlI+oJSvB7F5CTf18vIbj2UkTaU+FCvh8P2NMwv3gQ=;
        b=Kn04m2cMujcd/1X7I/qQ+Z2L028Rke8VOWJhLt5koVK0fM+PvKiWkZfvU645FT9WCh
         /jpvAQG3RJ9uSveqkB5UTeM6SgMrjP/viPnW63ZOLv3E8m9/uQllFCMZH6eBMOjbpCr8
         I2LhtvmIzWVLq4zsYBQMNqpC2Y7+VHVveL4r99cBJBntBafGOnJdKDDgtsrzLbipR3LR
         lCDixDgkWDymUq6ifCzeE+b3qUb3Gy/7PCFKnNbWejDXeXqwfusgZFSyMTYYNK24Sbzb
         RvNdOh7ClJl2MwdLisvPoVrSwmJ2ftcd4rd3piSJ0R/asYwofvdHyq7riYuvbDUVulsy
         vEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679381127;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBlI+oJSvB7F5CTf18vIbj2UkTaU+FCvh8P2NMwv3gQ=;
        b=DzTURiSBZocRwrp+q5savYSUMFxmk7Nu/Jo3rhA+5cbROkiS5Lf8ZgKkGvuytV5MkZ
         E8RALyRlpmtxKSsVxobcJ65PNNuA6W0AbekTtkEGNmlOzoZ/JZ+Z5QlK4keSxdMTy/GH
         tPuIN0YIlNPt9+1DEqbONYTwgr7TjogExhssGrsv/PnxGZwhT2VlZ6YGoJlDTxKgCOb5
         M1xK3SUDrM55IEuVrAsUTqqAZTY2lbgzopwQS2N3CWYKok2efBmPGt/7Hr5hN5Xu44N4
         z+g08fSp7pTqfL2QGC2aib+aGKg6nQw3ul7CTHl9grJg9A368B65Uw2v2FNBTCJGPBPz
         A8rQ==
X-Gm-Message-State: AO0yUKU/fCf1DZhIM5zBFsbii2nmAbvOipq0TnR6pdgwB/k7jgyXr4td
        4jeLC684LNG+oNPs7LTTioR1lnqbAo4=
X-Google-Smtp-Source: AK7set9Zqsp2EHKO3BKgI2Rc3F7SqxGfJ3+HyrFqA/Qq1gQgwPg2C0jgfZXkuqX2tUJp14J9CM4SWw==
X-Received: by 2002:a17:903:124e:b0:19e:8076:9bd2 with SMTP id u14-20020a170903124e00b0019e80769bd2mr1509171plh.17.1679381127711;
        Mon, 20 Mar 2023 23:45:27 -0700 (PDT)
Received: from trent-reznor ([2601:641:4000:81:109e:9b0c:f18f:7fa1])
        by smtp.gmail.com with ESMTPSA id jm18-20020a17090304d200b001888cadf8f6sm7796388plb.49.2023.03.20.23.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:45:26 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:45:24 -0700
From:   Daniel Watson <ozzloy@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: av7110: put spaces around operators
Message-ID: <ZBlShLl4PYlNIpGN@trent-reznor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put spaces around '=' and '<=' to match style from checkpatch

Signed-off-by: Daniel Watson <ozzloy@gmail.com>
---
 drivers/staging/media/av7110/av7110_hw.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_hw.h b/drivers/staging/media/av7110/av7110_hw.h
index 6380d8950c695..3274146c401f1 100644
--- a/drivers/staging/media/av7110/av7110_hw.h
+++ b/drivers/staging/media/av7110/av7110_hw.h
@@ -402,8 +402,8 @@ static inline u32 irdebi(struct av7110 *av7110, u32 config, int addr, u32 val, u
 {
 	u32 res;
 
-	res=av7110_debiread(av7110, config, addr, count);
-	if (count<=4)
+	res = av7110_debiread(av7110, config, addr, count);
+	if (count <= 4)
 		memcpy(av7110->debi_virt, (char *) &res, count);
 	return res;
 }
@@ -424,7 +424,7 @@ static inline u32 rdebi(struct av7110 *av7110, u32 config, int addr, u32 val, un
 	u32 res;
 
 	spin_lock_irqsave(&av7110->debilock, flags);
-	res=av7110_debiread(av7110, config, addr, count);
+	res = av7110_debiread(av7110, config, addr, count);
 	spin_unlock_irqrestore(&av7110->debilock, flags);
 	return res;
 }
-- 
2.34.1

