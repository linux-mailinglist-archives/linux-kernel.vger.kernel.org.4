Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A78611B98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJ1Ufo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJ1Ufj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:35:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB77332D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:35:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 17so1474190pfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=l3r1fcKZOvpw95FaXr5T0U9suQOfZjsGtJyHVlRBBKs=;
        b=lBjxQws7ctF7zPPVhF0soNIAusC4rFEP1hXpRG1K0hIsoRVkiJYXWULefqFTr4o8oX
         rzydCpxqJv/ULMHDe4YM4Eay8ZadtLM2N4kC4r8dvmfVICmtiOzpkb/yGVei8RiSBK94
         gi3QKjftC5nLVdNo76OI7pu1xRY4x9OWzwvlISB9iZl9BpGl0IF1E9aCjRYPnuZeKK5k
         J2T3SHfqq5YqCIbSV6kbniDX9j34dFQFlZkTXJa+QvDz1ADwko8sWGZIjtY42s+XMLH0
         T33lqb+yPZQou0Qz5J7uRUoO7v2aPzfb8m7T+RyzEMC2QRZYCKJWGQNm7xEK0J4BJmd8
         cE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3r1fcKZOvpw95FaXr5T0U9suQOfZjsGtJyHVlRBBKs=;
        b=QbhcBKDv+AYAzmbe/eaEtJHo8go82bkz02yVtqhp24O8evCAF0HEkDlJB+IzxwdafZ
         xCj7gwMj2YDJ95TPMeFk77463fxX0dIhagBB/9xazyPKBslIcXf1a6B2fjkF2/XEzLjX
         fU6BAK6HGhazd20e5/YUzOPmJxB/14PoR9zu4fbl4vW5pX/GtcwokrWkT/wjTAJVd3Qc
         zcoTY+FKYMKS0UjH+Slwr1U70zSFcls2WqZhnyhhKmb2WZt4z70/tCn5iPNge+nksEko
         /tffAlwGSy4djwMBIjHjHXOxQOMB0J+v7TLb/0XUACr9QsyfhDd6HrZcB3tnyzaj1k9D
         IInw==
X-Gm-Message-State: ACrzQf2mBFeB0qseJCtWJw9SMDyH+WmH9W655z13A+PT6W0tTcoFzHRj
        dgEPAvdR69PTZl+E4Zhp9zMnvqbjmxk=
X-Google-Smtp-Source: AMsMyM5ePCGB9xGd2uEAQmOougCglNhMWBDva/2u3PLFD/bsjVcn8A8/zYi0UypCBHGssFlC0fM05w==
X-Received: by 2002:aa7:888e:0:b0:56c:f16d:2eb0 with SMTP id z14-20020aa7888e000000b0056cf16d2eb0mr1034539pfe.19.1666989330208;
        Fri, 28 Oct 2022 13:35:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:940b])
        by smtp.gmail.com with ESMTPSA id mv10-20020a17090b198a00b00212c27abcaesm4622085pjb.17.2022.10.28.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:35:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 28 Oct 2022 10:35:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-6.1-fixes] cgroup: Implement DEBUG_CGROUP_REF
Message-ID: <Y1w9EKH/CZhNGLJj@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's really difficult to debug when cgroup or css refs leak. Let's add a
debug option to force the refcnt function to not be inlined so that they can
be kprobed for debugging.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applying this to for-6.1-fixes. Holler for any objections.

Thanks.

 include/linux/cgroup.h        |   97 +++++-------------------------------------
 include/linux/cgroup_refcnt.h |   91 +++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c        |    5 ++
 lib/Kconfig.debug             |   10 ++++
 4 files changed, 118 insertions(+), 85 deletions(-)

--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -309,72 +309,24 @@ void css_task_iter_end(struct css_task_i
  * Inline functions.
  */
 
+#ifdef CONFIG_DEBUG_CGROUP_REF
+void css_get(struct cgroup_subsys_state *css);
+void css_get_many(struct cgroup_subsys_state *css, unsigned int n);
+bool css_tryget(struct cgroup_subsys_state *css);
+bool css_tryget_online(struct cgroup_subsys_state *css);
+void css_put(struct cgroup_subsys_state *css);
+void css_put_many(struct cgroup_subsys_state *css, unsigned int n);
+#else
+#define CGROUP_REF_FN_ATTRS	static inline
+#include <linux/cgroup_refcnt.h>
+#endif
+
 static inline u64 cgroup_id(const struct cgroup *cgrp)
 {
 	return cgrp->kn->id;
 }
 
 /**
- * css_get - obtain a reference on the specified css
- * @css: target css
- *
- * The caller must already have a reference.
- */
-static inline void css_get(struct cgroup_subsys_state *css)
-{
-	if (!(css->flags & CSS_NO_REF))
-		percpu_ref_get(&css->refcnt);
-}
-
-/**
- * css_get_many - obtain references on the specified css
- * @css: target css
- * @n: number of references to get
- *
- * The caller must already have a reference.
- */
-static inline void css_get_many(struct cgroup_subsys_state *css, unsigned int n)
-{
-	if (!(css->flags & CSS_NO_REF))
-		percpu_ref_get_many(&css->refcnt, n);
-}
-
-/**
- * css_tryget - try to obtain a reference on the specified css
- * @css: target css
- *
- * Obtain a reference on @css unless it already has reached zero and is
- * being released.  This function doesn't care whether @css is on or
- * offline.  The caller naturally needs to ensure that @css is accessible
- * but doesn't have to be holding a reference on it - IOW, RCU protected
- * access is good enough for this function.  Returns %true if a reference
- * count was successfully obtained; %false otherwise.
- */
-static inline bool css_tryget(struct cgroup_subsys_state *css)
-{
-	if (!(css->flags & CSS_NO_REF))
-		return percpu_ref_tryget(&css->refcnt);
-	return true;
-}
-
-/**
- * css_tryget_online - try to obtain a reference on the specified css if online
- * @css: target css
- *
- * Obtain a reference on @css if it's online.  The caller naturally needs
- * to ensure that @css is accessible but doesn't have to be holding a
- * reference on it - IOW, RCU protected access is good enough for this
- * function.  Returns %true if a reference count was successfully obtained;
- * %false otherwise.
- */
-static inline bool css_tryget_online(struct cgroup_subsys_state *css)
-{
-	if (!(css->flags & CSS_NO_REF))
-		return percpu_ref_tryget_live(&css->refcnt);
-	return true;
-}
-
-/**
  * css_is_dying - test whether the specified css is dying
  * @css: target css
  *
@@ -394,31 +346,6 @@ static inline bool css_is_dying(struct c
 	return !(css->flags & CSS_NO_REF) && percpu_ref_is_dying(&css->refcnt);
 }
 
-/**
- * css_put - put a css reference
- * @css: target css
- *
- * Put a reference obtained via css_get() and css_tryget_online().
- */
-static inline void css_put(struct cgroup_subsys_state *css)
-{
-	if (!(css->flags & CSS_NO_REF))
-		percpu_ref_put(&css->refcnt);
-}
-
-/**
- * css_put_many - put css references
- * @css: target css
- * @n: number of references to put
- *
- * Put references obtained via css_get() and css_tryget_online().
- */
-static inline void css_put_many(struct cgroup_subsys_state *css, unsigned int n)
-{
-	if (!(css->flags & CSS_NO_REF))
-		percpu_ref_put_many(&css->refcnt, n);
-}
-
 static inline void cgroup_get(struct cgroup *cgrp)
 {
 	css_get(&cgrp->self);
--- /dev/null
+++ b/include/linux/cgroup_refcnt.h
@@ -0,0 +1,91 @@
+/**
+ * css_get - obtain a reference on the specified css
+ * @css: target css
+ *
+ * The caller must already have a reference.
+ */
+CGROUP_REF_FN_ATTRS
+void css_get(struct cgroup_subsys_state *css)
+{
+	if (!(css->flags & CSS_NO_REF))
+		percpu_ref_get(&css->refcnt);
+}
+
+/**
+ * css_get_many - obtain references on the specified css
+ * @css: target css
+ * @n: number of references to get
+ *
+ * The caller must already have a reference.
+ */
+CGROUP_REF_FN_ATTRS
+void css_get_many(struct cgroup_subsys_state *css, unsigned int n)
+{
+	if (!(css->flags & CSS_NO_REF))
+		percpu_ref_get_many(&css->refcnt, n);
+}
+
+/**
+ * css_tryget - try to obtain a reference on the specified css
+ * @css: target css
+ *
+ * Obtain a reference on @css unless it already has reached zero and is
+ * being released.  This function doesn't care whether @css is on or
+ * offline.  The caller naturally needs to ensure that @css is accessible
+ * but doesn't have to be holding a reference on it - IOW, RCU protected
+ * access is good enough for this function.  Returns %true if a reference
+ * count was successfully obtained; %false otherwise.
+ */
+CGROUP_REF_FN_ATTRS
+bool css_tryget(struct cgroup_subsys_state *css)
+{
+	if (!(css->flags & CSS_NO_REF))
+		return percpu_ref_tryget(&css->refcnt);
+	return true;
+}
+
+/**
+ * css_tryget_online - try to obtain a reference on the specified css if online
+ * @css: target css
+ *
+ * Obtain a reference on @css if it's online.  The caller naturally needs
+ * to ensure that @css is accessible but doesn't have to be holding a
+ * reference on it - IOW, RCU protected access is good enough for this
+ * function.  Returns %true if a reference count was successfully obtained;
+ * %false otherwise.
+ */
+CGROUP_REF_FN_ATTRS
+bool css_tryget_online(struct cgroup_subsys_state *css)
+{
+	if (!(css->flags & CSS_NO_REF))
+		return percpu_ref_tryget_live(&css->refcnt);
+	return true;
+}
+
+/**
+ * css_put - put a css reference
+ * @css: target css
+ *
+ * Put a reference obtained via css_get() and css_tryget_online().
+ */
+CGROUP_REF_FN_ATTRS
+void css_put(struct cgroup_subsys_state *css)
+{
+	if (!(css->flags & CSS_NO_REF))
+		percpu_ref_put(&css->refcnt);
+}
+
+/**
+ * css_put_many - put css references
+ * @css: target css
+ * @n: number of references to put
+ *
+ * Put references obtained via css_get() and css_tryget_online().
+ */
+CGROUP_REF_FN_ATTRS
+void css_put_many(struct cgroup_subsys_state *css, unsigned int n)
+{
+	if (!(css->flags & CSS_NO_REF))
+		percpu_ref_put_many(&css->refcnt, n);
+}
+
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -248,6 +248,11 @@ static int cgroup_addrm_files(struct cgr
 			      struct cgroup *cgrp, struct cftype cfts[],
 			      bool is_add);
 
+#ifdef CONFIG_DEBUG_CGROUP_REF
+#define CGROUP_REF_FN_ATTRS	noinline
+#include <linux/cgroup_refcnt.h>
+#endif
+
 /**
  * cgroup_ssid_enabled - cgroup subsys enabled test by subsys ID
  * @ssid: subsys ID of interest
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1715,6 +1715,16 @@ config LATENCYTOP
 	  Enable this option if you want to use the LatencyTOP tool
 	  to find out which userspace is blocking on what kernel operations.
 
+config DEBUG_CGROUP_REF
+	bool "Disable inlining of cgroup css reference count functions"
+	depends on DEBUG_KERNEL
+	depends on CGROUPS
+	depends on KPROBES
+	default n
+	help
+	  Force cgroup css reference count functions to not be inlined so
+	  that they can be kprobed for debugging.
+
 source "kernel/trace/Kconfig"
 
 config PROVIDE_OHCI1394_DMA_INIT
