Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FBB6B2FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCIViF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCIViD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:38:03 -0500
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6361ABD1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 13:38:02 -0800 (PST)
Received: by mail-vs1-xe49.google.com with SMTP id df27-20020a056102441b00b004216a8c8b91so1206178vsb.17
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 13:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678397881;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CjVCnK2+PbOEo6iotAw4ZlEJBJGbRLCsJRiwiC573nQ=;
        b=iDcGqwWXeOsrMo3PN2YChvdaLFVn6SiHlk8xRG5mOVvc/jBmkFrCIToFxSQkpuoTlb
         4zw6bqgh0sJ3WMiMxFTsjoVrB3KafRWn7wOlEkVbTaNV7mMEClflIEE6i5VrFtbvYLtb
         oshsajQGUkkfRDx4ynUr9lz5lwkiXFh6xK+TJI0VLKx9QgIAuQp74oyqPoQ7KwCKREZ+
         +DVqswVM1NBcGpDdnHFQydNnRZpgVwA/6f9V3iq8RmcoVGzk/Kpf5o68tDFWT1fuV+tl
         sWvq0dnI/r/uHI0N7IixYAy4mO/NhrUQGLHY3YLe8Vi7TliNmBxZoW8tP7DPDv8nCN2/
         aq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678397881;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjVCnK2+PbOEo6iotAw4ZlEJBJGbRLCsJRiwiC573nQ=;
        b=8RI7cCyj6EdmPJgQh7lMFdjYVXR5QjxPscLjnbfa3uLyPx/z3ZvFawZgbduiAVuTza
         wZ1N9ZZZRYtH9wTu4TAQ6ccbf9OOKsZOo+XUN+7TO6vgMS1ucF0lj/zhi41JtcsmJKN8
         CAyrPcUIgMQYBB3mN1I1k7G/PS8Jq/cJaTuZlLMn7sA7G6aJKD9EwgAtkyfoYTfVSeS5
         7BrqSwHcgA1hOYySjDAOFRH1zh5Ed0c2n24/kPGfDGAyZqWyeKw2+rGiIg5BE0M6bVFB
         m5scDhyvwWN6FybID33+l4lUQzUTk6OyOQ3lyMpt51XUMEuQ6tpa1iiPS182ValNEbnk
         rsGQ==
X-Gm-Message-State: AO0yUKW50AzxAHRo8E7iADIP2MLiZ6xsVZAaojnCQ2LB0lbBFIEzHY0F
        zgje2FfUbaR1Bvvr11RE/5Zej3G8wQ==
X-Google-Smtp-Source: AK7set/3xwbqPZOVKcj1jnhlEuaFuyYb20cAVkbFpCLioY4Jn4WxHw12DhUrdl/Zy4Ont1x5IyWefzt/QQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a67:e94c:0:b0:421:c4a7:872b with SMTP id
 p12-20020a67e94c000000b00421c4a7872bmr13271594vso.6.1678397880952; Thu, 09
 Mar 2023 13:38:00 -0800 (PST)
Date:   Thu,  9 Mar 2023 13:37:41 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230309213742.572091-1-nhuck@google.com>
Subject: [PATCH] fsverity: Remove WQ_UNBOUND from fsverity read workqueue
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, fsverity@lists.linux.dev,
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

WQ_UNBOUND causes significant scheduler latency on ARM64/Android.  This
is problematic for latency sensitive workloads like I/O post-processing.

Removing WQ_UNBOUND gives a 96% reduction in fsverity workqueue related
scheduler latency and improves app cold startup times by ~30ms.

This code was tested by running Android app startup benchmarks and
measuring how long the fsverity workqueue spent in the ready queue.

Before
Total workqueue scheduler latency: 553800us
After
Total workqueue scheduler latency: 18962us

Change-Id: I693efee541757851ed6d229430111cd763d39067
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 fs/verity/verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index f50e3b5b52c9..e8ec37774d63 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -395,7 +395,7 @@ int __init fsverity_init_workqueue(void)
 	 * which blocks reads from completing, over regular application tasks.
 	 */
 	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
-						  WQ_UNBOUND | WQ_HIGHPRI,
+						  WQ_HIGHPRI,
 						  num_online_cpus());
 	if (!fsverity_read_workqueue)
 		return -ENOMEM;
-- 
2.40.0.rc1.284.g88254d51c5-goog

