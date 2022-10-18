Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD7603108
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJRQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJRQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:50:20 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9205FAD4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666111802; bh=29EY3/OiWd3iMrUC+Z221n8xSKWT7a3/meFzR6wx6Rg=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=UPLnrygJi8azATBCFME5W5GsJbaeoA2OVblhpJfki8SQOcVKfFEWESmga62Ey2ytx
         LuNp1ndjOjtGbIj5A41is56guQzzBqdCOWoBbMeBkrb9M9pK4cT1kpMgWjFz47kJbf
         bD22xvPhZWZyxZQGG1TDLRFd6yBcpMi4VmN7pKMk=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Tue, 18 Oct 2022 18:50:02 +0200 (CEST)
X-EA-Auth: 5QBNPiTmqvSkx2+BFed9ahndmwwx34D1YnmITye6VjENxrhxM3zeqiAUbZ0O2WCA6GhZFj4dswD0e80vzqrdRU5pK1CpxAVg
Date:   Tue, 18 Oct 2022 22:19:58 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: most: dim2: correct misleading variable name
Message-ID: <b8550823920f40c4d02a3a691acca1af18998878.1666105876.git.drv@mailo.com>
References: <cover.1666105876.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666105876.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct misleading struct variable name dim_ch_state_t to dim_ch_state
since this not a typedef but a normal variable declaration.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
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



