Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0D63CE23
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiK3D6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiK3D6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:58:25 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C5069DD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:24 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d2-20020a170902cec200b001899479b1d8so6435676plg.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbgjxXco2ICYz4eUnp8sVnVcMsNs7Pg8hjijnkTmMjU=;
        b=UHy4vNcQIx9t/WwFNmy5jfp9/nM/BZmdBFjznHBzmbCuI5CcfSueXovUoveXMtM7DO
         NJ7ycoBF1WcHSkotHoiF0M+1tKeXPLXYfGFmnOamSkfT/TNHOQuwjZfqkhKUArePyvKu
         g6JWXT6/7LlHK3Z9bsIvcMs9xS23QZCmxsC/LzEmVoApbfgIT2su6wySuvwQKRmoNtIh
         HgkNnXnqM9nL79zkPMENXD75mI85RZ+LqRxcwOEqBY6jmIr5/OxOibyR8fqdm+1AjonR
         gGIanVj4M65jME3iVwyk84QuXDGDpnNo4ZeM1e8btTLHftEQEJLxlEGRExrlL73AFyif
         1MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbgjxXco2ICYz4eUnp8sVnVcMsNs7Pg8hjijnkTmMjU=;
        b=lf/sQdaiUXpZHt1W5jmSzolLCBWnbYhn/g7dNWqLfbNGSCBbfuwLtok36dB1mtJM6F
         hzxCbhrHarW5xKhn+xmHlK85EwfH+jKadOCWMTDbwSxaLqtEudMZxE9xtaeb9AIcS7YX
         ca57d1trjwHXCYQr+gv7zOcnGnOkp7dlrNODJc2U+LR4A7y0U5gYaArUqZ6WDiPOGcZ5
         rJcAWllHgA6RrcHi0DNdEa5z+DRrePOe/mQJj0Kjfu1W8LoDv06+1JS646yPQ3mpbCht
         ee+AfWF5mYeJP/ojgMzjb5qWF/Vp7kwF7Yw9GaKJpo5mEZ2A04egRPLGUmEnKcwlwtIC
         wR8g==
X-Gm-Message-State: ANoB5pmD/go3WvlI/xliTHYC/VaA86PtXXGMyGrZGehQ/eFy2dgrEXhy
        See/ZLD+oLIsaDaE3y5i8gX6qXM16nJosA==
X-Google-Smtp-Source: AA0mqf5yCfLxL4ypzda97sRkLV0YY9kHvf0KdarnDWdpPS1Ecz4mtuceRBqUWTyuWwSkAqvBbl9dVRN51ZZhUg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:aa7:9045:0:b0:56c:a321:eecb with SMTP id
 n5-20020aa79045000000b0056ca321eecbmr61328481pfo.19.1669780703628; Tue, 29
 Nov 2022 19:58:23 -0800 (PST)
Date:   Wed, 30 Nov 2022 03:58:01 +0000
In-Reply-To: <20221130035805.1823970-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20221130035805.1823970-1-cmllamas@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130035805.1823970-3-cmllamas@google.com>
Subject: [PATCH 5.10 2/6] binder: read pre-translated fds from sender buffer
From:   Carlos Llamas <cmllamas@google.com>
To:     stable@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Kjos <tkjos@google.com>

commit 656e01f3ab54afe71bed066996fc2640881e1220 upstream.

This patch is to prepare for an up coming patch where we read
pre-translated fds from the sender buffer and translate them before
copying them to the target.  It does not change run time.

The patch adds two new parameters to binder_translate_fd_array() to
hold the sender buffer and sender buffer parent.  These parameters let
us call copy_from_user() directly from the sender instead of using
binder_alloc_copy_from_buffer() to copy from the target.  Also the patch
adds some new alignment checks.  Previously the alignment checks would
have been done in a different place, but this lets us print more
useful error messages.

Reviewed-by: Martijn Coenen <maco@android.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
Link: https://lore.kernel.org/r/20211130185152.437403-4-tkjos@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 58ab76b7a787..4abb621300ec 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2634,15 +2634,17 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 }
 
 static int binder_translate_fd_array(struct binder_fd_array_object *fda,
+				     const void __user *sender_ubuffer,
 				     struct binder_buffer_object *parent,
+				     struct binder_buffer_object *sender_uparent,
 				     struct binder_transaction *t,
 				     struct binder_thread *thread,
 				     struct binder_transaction *in_reply_to)
 {
 	binder_size_t fdi, fd_buf_size;
 	binder_size_t fda_offset;
+	const void __user *sender_ufda_base;
 	struct binder_proc *proc = thread->proc;
-	struct binder_proc *target_proc = t->to_proc;
 
 	fd_buf_size = sizeof(u32) * fda->num_fds;
 	if (fda->num_fds >= SIZE_MAX / sizeof(u32)) {
@@ -2666,7 +2668,10 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 	 */
 	fda_offset = (parent->buffer - (uintptr_t)t->buffer->user_data) +
 		fda->parent_offset;
-	if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32))) {
+	sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
+
+	if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32)) ||
+	    !IS_ALIGNED((unsigned long)sender_ufda_base, sizeof(u32))) {
 		binder_user_error("%d:%d parent offset not aligned correctly.\n",
 				  proc->pid, thread->pid);
 		return -EINVAL;
@@ -2675,10 +2680,9 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 		u32 fd;
 		int ret;
 		binder_size_t offset = fda_offset + fdi * sizeof(fd);
+		binder_size_t sender_uoffset = fdi * sizeof(fd);
 
-		ret = binder_alloc_copy_from_buffer(&target_proc->alloc,
-						    &fd, t->buffer,
-						    offset, sizeof(fd));
+		ret = copy_from_user(&fd, sender_ufda_base + sender_uoffset, sizeof(fd));
 		if (!ret)
 			ret = binder_translate_fd(fd, offset, t, thread,
 						  in_reply_to);
@@ -3344,6 +3348,8 @@ static void binder_transaction(struct binder_proc *proc,
 		case BINDER_TYPE_FDA: {
 			struct binder_object ptr_object;
 			binder_size_t parent_offset;
+			struct binder_object user_object;
+			size_t user_parent_size;
 			struct binder_fd_array_object *fda =
 				to_binder_fd_array_object(hdr);
 			size_t num_valid = (buffer_offset - off_start_offset) /
@@ -3375,8 +3381,27 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_bad_parent;
 			}
-			ret = binder_translate_fd_array(fda, parent, t, thread,
-							in_reply_to);
+			/*
+			 * We need to read the user version of the parent
+			 * object to get the original user offset
+			 */
+			user_parent_size =
+				binder_get_object(proc, user_buffer, t->buffer,
+						  parent_offset, &user_object);
+			if (user_parent_size != sizeof(user_object.bbo)) {
+				binder_user_error("%d:%d invalid ptr object size: %zd vs %zd\n",
+						  proc->pid, thread->pid,
+						  user_parent_size,
+						  sizeof(user_object.bbo));
+				return_error = BR_FAILED_REPLY;
+				return_error_param = -EINVAL;
+				return_error_line = __LINE__;
+				goto err_bad_parent;
+			}
+			ret = binder_translate_fd_array(fda, user_buffer,
+							parent,
+							&user_object.bbo, t,
+							thread, in_reply_to);
 			if (!ret)
 				ret = binder_alloc_copy_to_buffer(&target_proc->alloc,
 								  t->buffer,
-- 
2.38.1.584.g0f3c55d4c2-goog

