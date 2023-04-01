Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE706D2E7B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjDAGFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDAGFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:05:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ACFD53A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:05:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso23542476ybu.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680329129;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ov8ZVCcYVVi0B1B0YBvfK4afztMi+B7sxRF04HC7IDs=;
        b=q2fTRFHRIwt+AQ6j6M4K9X6ntmh4WlvwQWgSowI6lWVlrqhm7LMxR7b4/xhfjeptUe
         o3KbzLjZM17F6aDOv0tJwF/1FEc3966AIUh0MO0LzSJDBT/TUl5kwIyyMxcx84NCtPAI
         febleBeBix28YtK4zdNcTnA7+IlYN9ELiEHKkfAtCIw0qjyxr32ZEYrcNHA75i6P5OZS
         oB4ur8xOk53eXmOcu9jT2FoW+/+37VQwGEXTw2rkokvezBLE9I+qjxrt8qbBvt+6nBgu
         YsVYrs8qL3bmbbfpJGwB0PKNOTxdznFUcIi/5QBz5OQd2XidTyVKPBgqMvLXEHvGSYMO
         p1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680329129;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ov8ZVCcYVVi0B1B0YBvfK4afztMi+B7sxRF04HC7IDs=;
        b=c0yjM8NuKWWNaW/uXgHOwx2chFFJ0+BtxeewVfJqvqVqGkAP+4Pw2qfxL9/AwqTzwI
         QE/HYpv4yLtLncKyzFlzBRso0hd8mELBcqGchvo91ndA480F3sSsJaC/X6rB5aTBs9sp
         Q1wqcoQxzvz8a9wxjS3kbkiY1DKaa5sm+/SOWNbdhsQwIUWPeNIs1gnJ1JR6NSDXnW7W
         SfpYsB00LqUXkHsUCFlUuj66pa4MmFVzcymM5B7jDIOe7MCjmIOKxijCMfBCMnKHEV0T
         jOml841QfA11TifOV2JKT7h9OK2J8qu/qVW/unVzwDjDSy3JO8Or85EtfS0XYbrD5n2+
         +25w==
X-Gm-Message-State: AAQBX9dIVbENHmZu31+TPBEPXtaQlpk4vj67BbLm4NnBjPiGAhvFkpDv
        dcEidgjwRTTHbNI/W43Zr3BKbqspwdyx
X-Google-Smtp-Source: AKy350agSXorhDBTmsfL20Uqv1LVviOhfcJIrE2QzRTQW1KIr7Uw08unfc385zC/+VbQJWHQG+TVksch1FDG
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a05:6902:70a:b0:b6e:361a:c86 with SMTP id
 k10-20020a056902070a00b00b6e361a0c86mr16079712ybt.3.1680329129660; Fri, 31
 Mar 2023 23:05:29 -0700 (PDT)
Date:   Sat,  1 Apr 2023 06:05:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230401060509.3608259-1-dhavale@google.com>
Subject: [PATCH v1 0/2] USB: Fixes for handling ITER_UBUF
From:   Sandeep Dhavale <dhavale@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Sandeep Dhavale <dhavale@google.com>, kernel-team@android.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 1e23db450cff ("io_uring: use iter_ubuf for single range
imports") .read_iter() can be called with iov type ITER_UBUF.
In such case dup_iter() will correctly dup but it will not allocate
any memory. But callers ffs_epfile_read_iter and ep_read_iter treat
this as a failure.

Following patches address this by checking if iter_is_ubuf().
Without the fix, async IOs from io_uring will be returned with -ENOMEM.

Sandeep Dhavale (2):
  usb: gadget: f_fs: Fix ffs_epfile_read_iter to handle ITER_UBUF
  usb: gadgetfs: Fix ep_read_iter to handle ITER_UBUF

 drivers/usb/gadget/function/f_fs.c | 2 +-
 drivers/usb/gadget/legacy/inode.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

