Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5E67A889
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjAYB6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjAYB6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:58:14 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE54BCD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:58:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id lk5-20020a17090b33c500b00228cb369d7aso280771pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fp9ccs/R/HqGAoRU6R/FJYwx892zglssKTnZXb6TNhs=;
        b=WAqnNhtiG8WjUY8O+bk3uMlpTRdXAO1398g06DJIjO5tpLENLCDEFEWfl5MKQQ2cS4
         FJmL4Hx1MgPkUvaWuxuEKoXfRmKWL2q9d5N75BjvVzLdMDt/6/LMiboSf2ZuostsQRoT
         5oOPTgTiEDS0FKff/+yrSTTKn/j66fTfrr+Er9d8jkJiPj/NjiPkpckv7Sfa8Z4H5BlN
         +qW9JTz3wAKujy3DdbdwCaEfka7lpLk/bYQvXMvMgNfLHIjIFV2LvQDDSZdYttuhSOO5
         tVfxl+1M1BxCZvN4M8o48BWAxGGoiHGmTA+PLRW0WNl344BBT0PzlqW+jQqTi6sTu+My
         HpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fp9ccs/R/HqGAoRU6R/FJYwx892zglssKTnZXb6TNhs=;
        b=3QujvQ+fz0XBqNSE0t9UJ34Y5Ss1ztLQY2PAjGKwJI6jtFKW0I5BE/QagwhSsqfuGI
         pp9Yx7Wy/83B2X36cleUechny506RuoSairPzGfjibCq4ljac2k7N4AHRr9CrTwDQ6zU
         mKCQOX9lToGXrmN9at0C+zESN3ypYFLdhdFNoCusVo+Lwg2uOlbduvIeu3UiP6ChYy//
         HaUV7/cMcLmAxPQG9669Z9Is7hfw9ObXw/yCYnbsgkWPpW80fM+iR4hUl1gU9/r2XCw1
         NGt2H30//at7etQlPdPbjqiGBmFROr/L/2O9gppYX963DKyOtMh4a8fd8fdFp25pr5is
         M9IQ==
X-Gm-Message-State: AFqh2koCf1bFjEHfofhtmGrQhLOp4WHLqAN8DgNBm6VHWIFHD75EcOj/
        8gztPSHDWMZRBNqyRikXXj0PnAjK5AeN
X-Google-Smtp-Source: AMrXdXumtB1amnGJ3IJUGIww8hnAuAjaZabzfhDhTWmrwPx4x/+DFmvmnBwEW8RCk35Au2yhMVxS0rtyDwrR
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:22ca:b0:58b:3d7f:746a with SMTP
 id f10-20020a056a0022ca00b0058b3d7f746amr3665212pfj.77.1674611891064; Tue, 24
 Jan 2023 17:58:11 -0800 (PST)
Date:   Tue, 24 Jan 2023 17:57:37 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125015738.912924-1-zokeefe@google.com>
Subject: [PATCH 1/2] mm/MADV_COLLAPSE: set EAGAIN on unexpected page refcount
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        "Zach O'Keefe" <zokeefe@google.com>
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

During collapse, in a few places we check to see if a given small page
has any unaccounted references.  If the refcount on the page doesn't
match our expectations, it must be there is an unknown user concurrently
interested in the page, and so it's not safe to move the contents
elsewhere. However, the unaccounted pins are likely an ephemeral state.

In such a situation, make MADV_COLLAPSE set EAGAIN errno, indicating that
collapse may succeed on retry.

Fixes: 7d8faaf15545 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Zach O'Keefe <zokeefe@google.com>

---
 mm/khugepaged.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e23619bfecc4..fa38cae240b9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2712,6 +2712,7 @@ static int madvise_collapse_errno(enum scan_result r)
 	case SCAN_CGROUP_CHARGE_FAIL:
 		return -EBUSY;
 	/* Resource temporary unavailable - trying again might succeed */
+	case SCAN_PAGE_COUNT:
 	case SCAN_PAGE_LOCK:
 	case SCAN_PAGE_LRU:
 	case SCAN_DEL_PAGE_LRU:
-- 
2.39.1.405.gd4c25cc71f-goog

