Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6372ADF9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjFJR5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjFJR5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:57:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928BDF0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 10:57:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso2328364b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686419838; x=1689011838;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hPcol59mgRdncxA10mWzbwWyNDS1U6CMlrEINf4rH0=;
        b=M7lMDEeQjaeDMgP3mpOPFqOB8+g8oUwg/hct6MT0buYO507vwhbc0cGARA8g1+ZGdS
         c4w68BQO9rrpuXQdXWd3NEzZgKiqsImI1x+ATknwiicD29pKaN+LRmnnohwBOC2PPb6J
         JGiWckbPe1CCPgayOALmXxUdUNSYul7Ot6ksxzvwtKAwfOzuN6aGW4AbVO+c9q2wKJ/s
         HkS7L+Fnq6DXReht/nK5ONxOBycv9n+yQSVrwudylR5bvp6ezN4In5n5PViPVAE7tFAO
         QhI6rnXApwakWXOflGeYaranr62z92Rk2fsry2ZCn5OkP+4o/IjH9ufye7dB8XbfUrsL
         toyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686419838; x=1689011838;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hPcol59mgRdncxA10mWzbwWyNDS1U6CMlrEINf4rH0=;
        b=ACJgTV9aLL0j7GYn0V94q2DjSzaFMSjilXRt4sCbXFErgBnnGg0UniWNc5SXptM4xX
         IW0eEZO9oGvnyqnil0y5Bp3Wgn4fAk5F+83xNxvPfwIUUfQINofGRiRLMl4eWxQCPbC9
         kxk0MufYls2BLgeheTY5FV0GjpnoQR0ABFtvLnIRm7hes844tK1qR7VHzt4b5SqBfwiW
         xZjGwK53BrFEnvuhuvxhoDFwYEBHqTulvj/XB9CM52QOtxARzoGdfi4c6zQP0GjaaqPG
         60Jrgu5tcIsxbyzYGPfYfpUVWdXUEI8gstbXXtnak/a20Q7QrvHmB3W7QrE3BVSzbKqa
         V2/w==
X-Gm-Message-State: AC+VfDxHTjwFGDE4qrSVQng3Q89jwMlCWdy8M24LZw4R9tl6Gh65MJBg
        im5DbRktif8lQYqgnJzUIsAm96h1UX0L3GFN
X-Google-Smtp-Source: ACHHUZ6jEfXhhJNImqBBhqqU65fgDEkqcGUm+T2fCgxwUABlgXflTwWQDEjk2EgVDJQz5RpCqjWS3Q==
X-Received: by 2002:a05:6a20:a20d:b0:10d:5390:ea90 with SMTP id u13-20020a056a20a20d00b0010d5390ea90mr3771281pzk.59.1686419837863;
        Sat, 10 Jun 2023 10:57:17 -0700 (PDT)
Received: from sumitra.com ([59.95.149.54])
        by smtp.gmail.com with ESMTPSA id i21-20020aa78d95000000b0064d34ace753sm4438844pfr.114.2023.06.10.10.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 10:57:17 -0700 (PDT)
Date:   Sat, 10 Jun 2023 10:57:12 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v2] lib: Replace kmap() with kmap_local_page()
Message-ID: <20230610175712.GA348514@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() has been deprecated in favor of the kmap_local_page()
due to high cost, restricted mapping space, the overhead of
a global lock for synchronization, and making the process
sleep in the absence of free slots.

kmap_local_page() is faster than kmap() and offers thread-local
and CPU-local mappings, take pagefaults in a local kmap region
and preserves preemption by saving the mappings of outgoing
tasks and restoring those of the incoming one during a context
switch.

The mappings are kept thread local in the functions
“dmirror_do_read” and “dmirror_do_write” in test_hmm.c

Therefore, replace kmap() with kmap_local_page() and use
mempcy_from/to_page() to avoid open coding kmap_local_page()
+ memcpy() + kunmap_local().

Remove the unused variable “tmp”.


Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

Changes in v2: 
	- Change commit subject and description.
	- Remove unnecessary type casting (char *).


 lib/test_hmm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 67e6f83fe0f8..717dcb830127 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -368,16 +368,13 @@ static int dmirror_do_read(struct dmirror *dmirror, unsigned long start,
 	for (pfn = start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++) {
 		void *entry;
 		struct page *page;
-		void *tmp;
 
 		entry = xa_load(&dmirror->pt, pfn);
 		page = xa_untag_pointer(entry);
 		if (!page)
 			return -ENOENT;
 
-		tmp = kmap(page);
-		memcpy(ptr, tmp, PAGE_SIZE);
-		kunmap(page);
+		memcpy_from_page(ptr, page, 0, PAGE_SIZE);
 
 		ptr += PAGE_SIZE;
 		bounce->cpages++;
@@ -437,16 +434,13 @@ static int dmirror_do_write(struct dmirror *dmirror, unsigned long start,
 	for (pfn = start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++) {
 		void *entry;
 		struct page *page;
-		void *tmp;
 
 		entry = xa_load(&dmirror->pt, pfn);
 		page = xa_untag_pointer(entry);
 		if (!page || xa_pointer_tag(entry) != DPT_XA_TAG_WRITE)
 			return -ENOENT;
 
-		tmp = kmap(page);
-		memcpy(tmp, ptr, PAGE_SIZE);
-		kunmap(page);
+		memcpy_to_page(page, 0, ptr, PAGE_SIZE);
 
 		ptr += PAGE_SIZE;
 		bounce->cpages++;
-- 
2.25.1

