Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131106A6576
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCAC1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCAC11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:27:27 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14407136DE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:27:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a5a0b6e3so256328677b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677637646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cn5FYVeC2KQFYRWBJMiQUgkU1g+DHIoWLNV16kMAX8=;
        b=nEKJGBxVMi4BEnUPRf0A+X+O4cmdoIfmLz4mW0W7FAAdyzE+55RofUSqDm1Oc8j5HW
         s1kTQu8Va0CaEqyTIW/ytdCVmiVSAcL55TeGUQBZ59DCB+JKZYO06jESJpBOq9zHC2Ve
         BFLqAqFjGXGEaw6a2XEiZp/v9rL6janNV4eXvoeLzGpw+GAUNeE9/AYpJAhViMLNUcMj
         M9FU382AfH+XW6iH4w1WuYFyzsFbmH3+tD0ZrvREQ3+QePPpECTKuQVBwosyAERKmI53
         sgKsNHDtefpjWD8aYJb4eUnl3c/A4mbpNnImsVMVoqxw1yHBqUVX7C2Lb9lK+/YiXOny
         bAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677637646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cn5FYVeC2KQFYRWBJMiQUgkU1g+DHIoWLNV16kMAX8=;
        b=t41RrGRcmA6e72HQjE/jNRBVfZF1DTNFELVJvYpfyPDJvTrycaSytinnCIfFF7TNoi
         dwiPlGe5ogSG4W/rLsKW1jpMN+6Lu3zGlKN1tq+rDI8TkmZYnOzy+Bo/NDmCUKnvSEpB
         0d770JDvhTX/U1osjEiY+73Pk7vPG5YwmUpPYAYji/6evIFOIy6h54uhH8+NYH6FR+5P
         BJ8TrCjEPODDn6pfn9U02V+0vumOCsEZETYMjBBC11oZvD9xL4gsuzhDI6TR+jaby3i7
         rCJwUJjaNR+l8mFkJWaQr1I3tqYnX7KOTzx+7bXw4Tv9ehyAnwpNCKF5lwqnz7MDIurl
         KeIw==
X-Gm-Message-State: AO0yUKWPWgfSv6qwZEQpnQrx/TunjZoHdIUV26JcjRef/GD+XLTCiPPk
        XB7xaA/252AyLL6BHYKWiu2CxVNSZBg=
X-Google-Smtp-Source: AK7set+bQp/cRKpaxZTq9IwTlkx2ibMJdRWhkaok19KZrfs1SDda57vKLaSk5U2QaFcJDDsrJULwQTMPDek=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:612b:820a:2225:ad82])
 (user=surenb job=sendgmr) by 2002:a05:6902:10d:b0:a4b:a813:46de with SMTP id
 o13-20020a056902010d00b00a4ba81346demr2167842ybh.4.1677637646292; Tue, 28 Feb
 2023 18:27:26 -0800 (PST)
Date:   Tue, 28 Feb 2023 18:27:20 -0800
In-Reply-To: <20230301022720.1380780-1-surenb@google.com>
Mime-Version: 1.0
References: <20230301022720.1380780-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230301022720.1380780-2-surenb@google.com>
Subject: [PATCH 2/2] mm: document FAULT_FLAG_VMA_LOCK flag
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, error27@gmail.com, willy@infradead.org,
        david@redhat.com, Liam.Howlett@oracle.com, jgg@ziepe.ca,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        mathieu.desnoyers@efficios.com, pasha.tatashin@soleen.com,
        laurent.dufour@fr.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, surenb@google.com
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

FAULT_FLAG_VMA_LOCK flag was introduced without proper description. Fix
this by documenting it.

Fixes: 863be34fc093 ("mm: add FAULT_FLAG_VMA_LOCK flag")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/all/20230301113648.7c279865@canb.auug.org.au/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Fix cleanly apply over mm-unstable, SHA in "Fixes" is from that tree.

 include/linux/mm_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 89bbf7d8a312..ef74ea892c5b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1064,6 +1064,7 @@ typedef struct {
  *                      mapped after the fault.
  * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
  *                        We should only access orig_pte if this flag set.
+ * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
-- 
2.39.2.722.g9855ee24e9-goog

