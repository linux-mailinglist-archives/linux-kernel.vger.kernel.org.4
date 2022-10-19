Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDF6050E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiJST4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiJST4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:56:44 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F861C77D5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666209386; bh=T3f8Wh/SL8v/3/j9kA5MFUnw8WYI2ZeJHwNe8d+A6nY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=b5pPwo8kCguNHoG7iP4tFI1A0U7wSrBmBb77BV0RDrjFy16TIUzBBsVBXrZSO39xW
         bsXKIZsg+HTeqoXhd+JMKll4Oy0rw5flB75eRIKkNlUMAwxKV847/Yv0tSx0YlKX1O
         5U99LN5RvQchoUuUohCrywWvDbzd677IRx6fVlpA=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Wed, 19 Oct 2022 21:56:26 +0200 (CEST)
X-EA-Auth: 4xMhWhHPuopDUeHFk/sD5rYY7mMTCudS9R7qM7M/KAyHJoX2lkMGoxsmSQGPWaMy191iulbBmV7zXkhLlWCH2/TiKY8LI8Ve
Date:   Thu, 20 Oct 2022 01:26:21 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: [PATCH v4 2/2] staging: most: dim2: correct misleading struct type
 name
Message-ID: <6b772a1ac06ae3b0d63e198e7238c1590b14703a.1666208065.git.drv@mailo.com>
References: <cover.1666208065.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666208065.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct misleading struct type name dim_ch_state_t to dim_ch_state
since this not a typedef but a normal structure declaration.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v4:
   1. Correct patch subject and log message. Use struct type name instead of
      variable name for the change description. Feedback from julia.lawall@inria.fr

Changes in v3:
   1. Patch introduced in the patch set

 drivers/staging/most/dim2/dim2.c | 2 +-
 drivers/staging/most/dim2/hal.c  | 4 ++--
 drivers/staging/most/dim2/hal.h  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 4c1f27898a29..a69a61a69283 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -161,7 +161,7 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
 	struct list_head *head = &hdm_ch->pending_list;
 	struct mbo *mbo;
 	unsigned long flags;
-	struct dim_ch_state_t st;
+	struct dim_ch_state st;

 	BUG_ON(!hdm_ch);
 	BUG_ON(!hdm_ch->is_initialized);
diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
index 65282c276862..a5d40b5b138a 100644
--- a/drivers/staging/most/dim2/hal.c
+++ b/drivers/staging/most/dim2/hal.c
@@ -943,8 +943,8 @@ u8 dim_service_channel(struct dim_channel *ch)
 	return channel_service(ch);
 }

-struct dim_ch_state_t *dim_get_channel_state(struct dim_channel *ch,
-					     struct dim_ch_state_t *state_ptr)
+struct dim_ch_state *dim_get_channel_state(struct dim_channel *ch,
+					   struct dim_ch_state *state_ptr)
 {
 	if (!ch || !state_ptr)
 		return NULL;
diff --git a/drivers/staging/most/dim2/hal.h b/drivers/staging/most/dim2/hal.h
index 20531449acab..ef10a8741c10 100644
--- a/drivers/staging/most/dim2/hal.h
+++ b/drivers/staging/most/dim2/hal.h
@@ -27,7 +27,7 @@ enum mlb_clk_speed {
 	CLK_8192FS = 7,
 };

-struct dim_ch_state_t {
+struct dim_ch_state {
 	bool ready; /* Shows readiness to enqueue next buffer */
 	u16 done_buffers; /* Number of completed buffers */
 };
@@ -87,8 +87,8 @@ void dim_service_ahb_int_irq(struct dim_channel *const *channels);

 u8 dim_service_channel(struct dim_channel *ch);

-struct dim_ch_state_t *dim_get_channel_state(struct dim_channel *ch,
-					     struct dim_ch_state_t *state_ptr);
+struct dim_ch_state *dim_get_channel_state(struct dim_channel *ch,
+					   struct dim_ch_state *state_ptr);

 u16 dim_dbr_space(struct dim_channel *ch);

--
2.30.2



