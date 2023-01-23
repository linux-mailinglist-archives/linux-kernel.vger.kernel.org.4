Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72467828B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjAWRF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjAWRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:22 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFAA23D9E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:16 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r9so10894944oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88a4EcsyoImPea13g+jXS6DiIw9vwnj7Q3nYiAaYWFo=;
        b=S1Qps+QWqSAgJqvVuhDhPBwLsxy8BoOsJSz/h0OhtVDBaooKT4fb8zDOwrF0VjUxZk
         ntDm0tto2zMPa/NYeadxggaX5k1JqfGiVRd5syWRqmWx0Ngs7KprGV3neIsYqBOXzLk4
         smxVyWxlA0zkX3om66NoDSmZfbqV0ICYZZj1dKjW1SasAQ4dHHEoH/g05vV4tizc7u7H
         xBBiJpdsDNJcuk92X+NMceSQUHZasUDAuCjsbdGpzIu3xK65przH/X7fVdtM3qGWNFy3
         g21a3V43cRiLYhbIFBI0N0GDROUsiZBqO4cApy4/Yav1LjzCk4H6o7H3ZIiR6gFiHrCj
         FcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88a4EcsyoImPea13g+jXS6DiIw9vwnj7Q3nYiAaYWFo=;
        b=hX0uiUZhGHSXFPkHW19tBZ0asJlbxiEPjb1EQGJojyselAgnlE+KJitCCKO/wOlOMO
         bgvwwRp1qtYqKot9LsftffN7KPZsFWh9hD/oHNh+MQmu8cslUpdZNKzFfpEGiI0BZnbw
         eY3HqfpBypJdhA/9a+wt6vn0msZHXVN6QaaTaM0xJoeJXZgtNMmVXkny9KO2SEE4FRWr
         g1ATdwS0DM5AE4Ytf2AD55kCDs3urBSkv1sQy0eV55F8hez4QSQnDSsabLwoZi2MAkwp
         6rLeJteKHnRBQsOZQtePGMNZB/6zn/nXHU/8uYNq9qncS1dv0HWQOb02uhBYZM90Z2BQ
         5syA==
X-Gm-Message-State: AFqh2krjT1LGRhB8oCuSgSAXAbhbqj1tclMGE4N/HWaMK6t0qc6Mp6Uf
        K9vB2NUyL+g4OE1p+TvQwYK58t4xrltKwuoUo2VBWhOBJNh5BSRfZsEbwwM/iFN2sERRuN/wtex
        DXzC2Gdo5WiKz9OU4ydlWKWCkf3vxRTgmTNepGgAaKDn0fJcOjQTD0pdlTTU7ElHg/Rzj0vHnJ4
        aXM6TmMp+pGIsz
X-Google-Smtp-Source: AMrXdXvrTP6NKOk9RnbyL+czq+G2DpbJC3hFN/EnFfOXtejW+ehF57bYGWslNLJhLEGzZzI+Fm5ytw==
X-Received: by 2002:a05:6808:120a:b0:364:cc8c:1870 with SMTP id a10-20020a056808120a00b00364cc8c1870mr14930314oil.41.1674493514028;
        Mon, 23 Jan 2023 09:05:14 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:05:13 -0800 (PST)
From:   George Prekas <george@enfabrica.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: [PATCH 4/9] mm: kmemleak: add kmemleak_noscan_phys function
Date:   Mon, 23 Jan 2023 11:04:14 -0600
Message-Id: <20230123170419.7292-5-george@enfabrica.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123170419.7292-1-george@enfabrica.net>
References: <20230123170419.7292-1-george@enfabrica.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function should be used instead of kmemleak_noscan when the object
has been registered with kmemleak_alloc_phys.

Signed-off-by: George Prekas <george@enfabrica.net>
---
 include/linux/kmemleak.h |  4 ++++
 mm/kmemleak.c            | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 1e2e8deac6dc..42069e0c1ac8 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -29,6 +29,7 @@ extern void kmemleak_not_leak(const void *ptr) __ref;
 extern void kmemleak_ignore(const void *ptr) __ref;
 extern void kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp) __ref;
 extern void kmemleak_no_scan(const void *ptr) __ref;
+extern void kmemleak_no_scan_phys(phys_addr_t phys) __ref;
 extern void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
 				gfp_t gfp) __ref;
 extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
@@ -106,6 +107,9 @@ static inline void kmemleak_erase(void **ptr)
 static inline void kmemleak_no_scan(const void *ptr)
 {
 }
+static inline void kmemleak_no_scan_phys(phys_addr_t phys)
+{
+}
 static inline void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
 				       gfp_t gfp)
 {
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5882f60d127c..6e037dcf322f 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -939,12 +939,12 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
  * pointer. Such object will not be scanned by kmemleak but references to it
  * are searched.
  */
-static void object_no_scan(unsigned long ptr)
+static void object_no_scan(unsigned long ptr, bool is_phys)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
 
-	object = find_and_get_object(ptr, 0);
+	object = __find_and_get_object(ptr, 0, is_phys);
 	if (!object) {
 		kmemleak_warn("Not scanning unknown object at 0x%08lx\n", ptr);
 		return;
@@ -1188,10 +1188,24 @@ void __ref kmemleak_no_scan(const void *ptr)
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		object_no_scan((unsigned long)ptr);
+		object_no_scan((unsigned long)ptr, false);
 }
 EXPORT_SYMBOL(kmemleak_no_scan);
 
+/**
+ * kmemleak_no_scan_phys - similar to kmemleak_no_scan but taking a physical
+ *			   address argument
+ * @phys:	physical address of the object
+ */
+void __ref kmemleak_no_scan_phys(phys_addr_t phys)
+{
+	pr_debug("%s(0x%pa)\n", __func__, &phys);
+
+	if (kmemleak_enabled && phys)
+		object_no_scan((unsigned long)phys, true);
+}
+EXPORT_SYMBOL(kmemleak_no_scan_phys);
+
 /**
  * kmemleak_alloc_phys - similar to kmemleak_alloc but taking a physical
  *			 address argument
-- 
2.37.1

