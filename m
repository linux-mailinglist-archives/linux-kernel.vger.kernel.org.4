Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA063CE27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiK3D7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiK3D6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:58:42 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34ED74630
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:32 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x16-20020a63b210000000b0045f5c1e18d0so10828936pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wINQ5STM8fgnJ+k0v7AW6rztvA+U+PodJ0UkvqzDm9U=;
        b=ICqmrKSfyvKNqYSL017ULXFBdPJlBp+v3kahuoV3hqFc0hvHR8ZtKmg/keYdPL4Q+/
         jf8QU/Vb3tjdpiQBZH39c1SObLKGIQrDeRLyCLqHrJr12yeLkAQSRaKAnXU3UXokG/y+
         L6au2yUNUXZzeBTiQF/GzgRtDsMlhEqkVIIRtsqNfWAa+YOy7lPN9uD/ppow8eXgGRQn
         zQdDJIqFIC8IUwN/md3/3/Gx4B1CPiIITD93QPvBDENIo5uSSCJkPL0jQ4pQRowljS6T
         JtkWb6+BDxl3XTrmuKx+h9H5QEDoGNcvQTwd7JmrhT5SRy+4TfCrgFpKjnjFKJ9w17Lm
         SITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wINQ5STM8fgnJ+k0v7AW6rztvA+U+PodJ0UkvqzDm9U=;
        b=z5+vSyzEU0aY0YOG0+s5yrLRnDU3To+K+m6OgUTNXWJ9pNNWuOSyVdr4SNy48tasg8
         59nDrgMVrIu2RNO2joujRN94REZWn8//cTh3PstLs2IdB6oACjSs+67fJERSWo1Tpt79
         mLi6uCztq6WJv7plDUmRdbxWu3JZtPdih3rh03auh6qks3ZytUglSN/LHO8rkKFW/LC5
         Sct9mKnRGB5M74Ytf7f9fJzVkUdVVM45pNNC9jRW0vTNKN7+OXCYWUTTLgmpwlgWBgzG
         +cLJpnpw+0nK9q/gOetJHjxbBUPcWFIoo1HoOMLewzFDqvfWOm0NRZUkSjFHQKrYCp2W
         /yHw==
X-Gm-Message-State: ANoB5pn/7dFWAWr5iqjF7bxliQwHzO9UzDGcdu/AdDMUrB5dTKiPpQLB
        h+Sq3mLFHnDBKIWaldzvyXG4+O8P+xcM8g==
X-Google-Smtp-Source: AA0mqf46VOSPVyV8gpFA1NdY3rdJLYYeVdc/9MzUk4PZPVcYJm4qOZVHAiCwCdinTlUp7WknzNnEXaosXFboQg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:aa7:9534:0:b0:575:c857:edc0 with SMTP id
 c20-20020aa79534000000b00575c857edc0mr3112444pfp.22.1669780711857; Tue, 29
 Nov 2022 19:58:31 -0800 (PST)
Date:   Wed, 30 Nov 2022 03:58:05 +0000
In-Reply-To: <20221130035805.1823970-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20221130035805.1823970-1-cmllamas@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130035805.1823970-7-cmllamas@google.com>
Subject: [PATCH 5.10 6/6] binder: Gracefully handle BINDER_TYPE_FDA objects
 with num_fds=0
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
        Alessandro Astone <ales.astone@gmail.com>,
        Todd Kjos <tkjos@google.com>,
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

From: Alessandro Astone <ales.astone@gmail.com>

commit ef38de9217a04c9077629a24652689d8fdb4c6c6 upstream.

Some android userspace is sending BINDER_TYPE_FDA objects with
num_fds=0. Like the previous patch, this is reproducible when
playing a video.

Before commit 09184ae9b575 BINDER_TYPE_FDA objects with num_fds=0
were 'correctly handled', as in no fixup was performed.

After commit 09184ae9b575 we aggregate fixup and skip regions in
binder_ptr_fixup structs and distinguish between the two by using
the skip_size field: if it's 0, then it's a fixup, otherwise skip.
When processing BINDER_TYPE_FDA objects with num_fds=0 we add a
skip region of skip_size=0, and this causes issues because now
binder_do_deferred_txn_copies will think this was a fixup region.

To address that, return early from binder_translate_fd_array to
avoid adding an empty skip region.

Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
Acked-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Alessandro Astone <ales.astone@gmail.com>
Link: https://lore.kernel.org/r/20220415120015.52684-1-ales.astone@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 1ba8a98094b4..4473adef2f5a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2891,6 +2891,9 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 	struct binder_proc *proc = thread->proc;
 	int ret;
 
+	if (fda->num_fds == 0)
+		return 0;
+
 	fd_buf_size = sizeof(u32) * fda->num_fds;
 	if (fda->num_fds >= SIZE_MAX / sizeof(u32)) {
 		binder_user_error("%d:%d got transaction with invalid number of fds (%lld)\n",
-- 
2.38.1.584.g0f3c55d4c2-goog

