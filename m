Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6C6872F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBBBYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBBBYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:24:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC2577FB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 17:24:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x8-20020a25e008000000b007cb4f1e3e57so325449ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 17:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qi6CRUcIqoMhsE8Npcv6LrLCHd/yXBQ/syl5x+jj8cQ=;
        b=LgCsIqGey4Gm2+BQOHTuOVwiZ0FTCQSQnUhHJpyjgyOweCwR4O/LlMPxHQXUmd9Fok
         7+xZ1Emlqau8iDgmO7exVFw9yRRpAFhpCmwHn9v3/Ehf5qfkFJ8odjd1XtW5DLfW5bNq
         5LPhzC+tReHAxdM7k6/TE7xQQqY5D5htBxO7efrqMtBNp1yOwHb6h9kiMgTLWMsOX4yx
         vcskunW0KwQbSg25azzNrTWoZMm6GnjzZqDwu+BHclJ9YkhYmX/11v+FRYXDuq3Wml4V
         5rYwmwRJFMhTlWbg+OzsdeEjxX8GsZRTqtOXhFRZrQt7T3SuW5ZfRDa1SlHu7qCCPC5r
         GrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qi6CRUcIqoMhsE8Npcv6LrLCHd/yXBQ/syl5x+jj8cQ=;
        b=PeZ+0r3lVN4xrJhxl15VCstAcUILO18STANzgNOSWHcESK/JiH1yyGmClzjeONiaDd
         FVkbN3wwewYlvE/+T6UCp39aVEY8s5bdmW0SU6pmMyiEz7m67KFxA3qtxULecU4BXQaT
         t40UkdoC5zi5E3fRs9P6RtU+GD2By0RfE6cmgzTgmIvSRUMcDOUe4A2xbZE2shzm4jIp
         M92iA5Tl0eytJ43OKvQsjzC+Ex3ufUqK/+1VUZjzzykkvTw3Cy2yXMPcJBfLya9Tv5DR
         kRc+6oeR82WEVFBRqbYxmt2DKZmZ+w5KKfs+ZcZog9KZagu9OqKCL4VcqQzTkJYm/EhU
         Lr9w==
X-Gm-Message-State: AO0yUKWV+W94eWBiq/96/qDRwPqDPGvVfnRs0fDmpxRCKKA3bkObgIRR
        zGeaocqgVdP3/6qS/4Hlq+mXKhLN3g==
X-Google-Smtp-Source: AK7set8RhiyeXAE+GXAwyzjDa8iVaPFqHfOlnWvgUjqh4AUtSCVY1X5GDAfnNtzuqKjOavRKMvxPYg8kKg==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6902:1815:b0:855:fafc:7424 with SMTP id
 cf21-20020a056902181500b00855fafc7424mr10ybb.11.1675301043864; Wed, 01 Feb
 2023 17:24:03 -0800 (PST)
Date:   Wed,  1 Feb 2023 17:23:48 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230202012348.885402-1-nhuck@google.com>
Subject: [PATCH] dm-verity: Remove WQ_UNBOUND.
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting WQ_UNBOUND increases scheduler latency on ARM64.  This is likely
due to the asymmetric architecture of ARM64 processors.

I've been unable to reproduce the results that claim WQ_UNBOUND gives a
performance boost on x86-64.

This flag is causing performance issues for multiple subsystems within
Android.  Notably, the same slowdown exists for decompression with
EROFS.

| open-prebuilt-camera  | WQ_UNBOUND | ~WQ_UNBOUND   |
|-----------------------|------------|---------------|
| verity wait time (us) | 11746      | 119 (-98%)    |
| erofs wait time (us)  | 357805     | 174205 (-51%) |

| sha256 ramdisk random read | WQ_UNBOUND    | ~WQ_UNBOUND |
|----------------------------|-----------=---|-------------|
| arm64 (accelerated)        | bw=42.4MiB/s  | bw=212MiB/s |
| arm64 (generic)            | bw=16.5MiB/s  | bw=48MiB/s  |
| x86_64 (generic)           | bw=233MiB/s   | bw=230MiB/s |

Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/md/dm-verity-target.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index ccf5b852fbf7..020fd2341025 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1399,8 +1399,8 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		goto bad;
 	}
 
-	/* WQ_UNBOUND greatly improves performance when running on ramdisk */
-	wq_flags = WQ_MEM_RECLAIM | WQ_UNBOUND;
+	wq_flags = WQ_MEM_RECLAIM;
+
 	/*
 	 * Using WQ_HIGHPRI improves throughput and completion latency by
 	 * reducing wait times when reading from a dm-verity device.
-- 
2.39.1.456.gfc5497dd1b-goog

