Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD86738D9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjASMmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjASMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:41:59 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3B798CB;
        Thu, 19 Jan 2023 04:39:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so2728232wmq.1;
        Thu, 19 Jan 2023 04:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZGmJZiHO4zSg1lq+3nWY4u/vstveQj+Y4K63K64lAc=;
        b=fIkPSVW3pVRh4PvuaoGe4C12b1n3z0yflP1rqlHtDh+jJUJOA2wElr/gbM7PynBo4B
         g9WegrXt4AH7zUifF9abOSJx5IC0lOol1lCSnn9TtWeAp38eV35bJC5Zkt8MQOOtkX7g
         WrhGT8+705c740fDfk4giAvqzKRNDGbfs4SnDjLvC0JT3SGuw34zZIOKniR6/mhRyiti
         /kcmIBsEO9mlC+W7IFX6kpf8TS16DXziwWRu7iswYM1SwAqUP52iUKgEVGsVQ+KG96dT
         9iVQ1VG7Uo1tgklQaM6mys9J82LcWDvLdNsuMqb3UIrHldiAr93Vnu64RxQjH9NKOZie
         gwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZGmJZiHO4zSg1lq+3nWY4u/vstveQj+Y4K63K64lAc=;
        b=GutoEUVyJDxCf7cQDCWRbOppB8ZI7AlKG1/BNsHnupntss7zAIG/AoCH/Yy50H2n3H
         YycCPQurUuOk+ZOOk8dMSOKTmMk0Mf/8Oq2QnZ54JaXB/St4J2dTd9UidegQaEhsZ4g6
         8PGdyU0vrAV8aWyN/1+hP/GMtU3qGvB+poqqFZL15XKOIXLFcFps5RGjKisI2tgyDf+/
         KsBoG2jDEFanl4h3t8zAQLumBg8GqoOOm1IjyL19k9PdnOFWFjDUbNBLd+CaM1we/5My
         MCDjfzq3xCXYlbzmF/jlIkjtSfFZym8pEsbZuVWv9aeEqF44dqEMRqjhAR2jm/yddP+J
         VSbg==
X-Gm-Message-State: AFqh2kqtVZ67+Np02wIn+IT7h7uJ1EdPyey1enRT0cY3NbB/mbGeZ7jt
        5Fp8WntqkE53HJWqAP0RFN0=
X-Google-Smtp-Source: AMrXdXs3qps9TFsimlC0ZXZm9rFm+ANZ/7UMJBNHDcdqpzCUPYKOwemn+7BeQrCa76mPAy5viViNDA==
X-Received: by 2002:a05:600c:2052:b0:3da:f9e8:9809 with SMTP id p18-20020a05600c205200b003daf9e89809mr10036385wmg.35.1674131989597;
        Thu, 19 Jan 2023 04:39:49 -0800 (PST)
Received: from localhost.localdomain (host-82-55-106-56.retail.telecomitalia.it. [82.55.106.56])
        by smtp.gmail.com with ESMTPSA id q24-20020a05600c331800b003d1de805de5sm4509265wmp.16.2023.01.19.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 04:39:48 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3] mm/highmem: Add notes about conversions from kmap{,_atomic}()
Date:   Thu, 19 Jan 2023 13:39:45 +0100
Message-Id: <20230119123945.10471-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() and kmap_atomic() have been deprecated. kmap_local_page() should
always be used in new code and the call sites of the two deprecated
functions should be converted. This latter task can lead to errors if it
is not carried out with the necessary attention to the context around
and between the maps and unmaps.

Therefore, add further information to the Highmem's documentation for the
purpose to make it clearer that (1) kmap() and kmap_atomic() must not
any longer be called in new code and (2) developers doing conversions from
kmap() amd kmap_atomic() are expected to take care of the context around
and between the maps and unmaps, in order to not break the code.

Relevant parts of this patch have been taken from messages exchanged
privately with Ira Weiny (thanks!).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v2:
	Merge two sentences into one (thanks to bagas Sanjaya).

 Documentation/mm/highmem.rst | 41 +++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
index 0f731d9196b0..e691a06fb337 100644
--- a/Documentation/mm/highmem.rst
+++ b/Documentation/mm/highmem.rst
@@ -57,7 +57,8 @@ list shows them in order of preference of use.
   It can be invoked from any context (including interrupts) but the mappings
   can only be used in the context which acquired them.
 
-  This function should be preferred, where feasible, over all the others.
+  This function should always be used, whereas kmap_atomic() and kmap() have
+  been deprecated.
 
   These mappings are thread-local and CPU-local, meaning that the mapping
   can only be accessed from within this thread and the thread is bound to the
@@ -100,10 +101,21 @@ list shows them in order of preference of use.
   (included in the "Functions" section) for details on how to manage nested
   mappings.
 
-* kmap_atomic().  This permits a very short duration mapping of a single
-  page.  Since the mapping is restricted to the CPU that issued it, it
-  performs well, but the issuing task is therefore required to stay on that
-  CPU until it has finished, lest some other task displace its mappings.
+* kmap_atomic(). This function has been deprecated; use kmap_local_page().
+
+  NOTE: Conversions to kmap_local_page() must take care to follow the mapping
+  restrictions imposed on kmap_local_page(). Furthermore, the code between
+  calls to kmap_atomic() and kunmap_atomic() may implicitly depend on the side
+  effects of atomic mappings, i.e. disabling page faults or preemption, or both.
+  In that case, explicit calls to pagefault_disable() or preempt_disable() or
+  both must be made in conjunction with the use of kmap_local_page().
+
+  [Legacy documentation]
+
+  This permits a very short duration mapping of a single page.  Since the
+  mapping is restricted to the CPU that issued it, it performs well, but
+  the issuing task is therefore required to stay on that CPU until it has
+  finished, lest some other task displace its mappings.
 
   kmap_atomic() may also be used by interrupt contexts, since it does not
   sleep and the callers too may not sleep until after kunmap_atomic() is
@@ -115,11 +127,20 @@ list shows them in order of preference of use.
 
   It is assumed that k[un]map_atomic() won't fail.
 
-* kmap().  This should be used to make short duration mapping of a single
-  page with no restrictions on preemption or migration. It comes with an
-  overhead as mapping space is restricted and protected by a global lock
-  for synchronization. When mapping is no longer needed, the address that
-  the page was mapped to must be released with kunmap().
+* kmap(). This function has been deprecated; use kmap_local_page().
+
+  NOTE: Conversions to kmap_local_page() must take care to follow the mapping
+  restrictions imposed on kmap_local_page(). In particular, it is necessary to
+  make sure that the kernel virtual memory pointer is only valid in the thread
+  that obtained it.
+
+  [Legacy documentation]
+
+  This should be used to make short duration mapping of a single page with no
+  restrictions on preemption or migration. It comes with an overhead as mapping
+  space is restricted and protected by a global lock for synchronization. When
+  mapping is no longer needed, the address that the page was mapped to must be
+  released with kunmap().
 
   Mapping changes must be propagated across all the CPUs. kmap() also
   requires global TLB invalidation when the kmap's pool wraps and it might
-- 
2.39.0

