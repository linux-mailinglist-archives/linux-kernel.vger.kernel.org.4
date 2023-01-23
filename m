Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B075678289
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjAWRFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjAWRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:12 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEDE1E1F2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:09 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s124so10949357oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp4WYRpASf5CVsJFYjl+ZnZkRci2IQqrsIcj0lr85Wg=;
        b=So8Z6Rqf1NYD+bATgnx25yeR3ZEQYv6xfpev5aAJBoSfG0j6uNny0FS3K8CyhMwahK
         VxlTg7zggBSoEtqV9ZoZKkrhRfYhDRYT/aHS8hUc4S8IahBStPNwBWjYddsZaiduXtaL
         +fvHuVuUAVcrg4M+v9xOhd7Yw2REstoxg9WzPgGEpv3zo2QisRZzSno1G32LUG/6t38U
         xj//tnhcajOK+iOekBC+deLs5/CakXMUWxw03E3DsXu2vAktxqs1YMn840No/iWRsryS
         Ybkl28Qh0h3+YYcP23/lrgMYCIpGXi5x822cqBOqRVDkzSJhZOn54To1sN9Low5BrKq1
         ZwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp4WYRpASf5CVsJFYjl+ZnZkRci2IQqrsIcj0lr85Wg=;
        b=KzVVzpDov3RUJOBnLFuV2m7NrQ6Q4QhvUMEGs/ZzzU1jWrD33zwQouoPrQ2Jze72sI
         sMi1QHgNtckTSZR6VLZDGVQDk7Lss0E3IFgPe1rYU9BhxXAueEo+D3OUK0SObMnAH22o
         PJF/n79yWo0rXbZXqG4gNJb50zp2o3GFr4h+VvIZsUzAxpmWD7dRQ+EXNBkS5GybOOHD
         plMVRNmkDBaut0NGnY24at5Mu0W/yQulROyfLDok3SrrDbq17mkVjVT8GO85LhSsoWWn
         UuVCZ5pHdGhYxwSIyXeX8P0lJ0uBQjtBHlCmEMnZIMzmJCAEltAMqIvUpq36nwKnWvBf
         Ttmg==
X-Gm-Message-State: AFqh2krwjVLScUepZVX5+nhuieAKmMZYgjXeuxVbWw9RrVBCNDaSu7k1
        R/Tz8jpfq5ek/OrQNv6IhLFSgjlL19skPzhdyDBb7CNvKjaD4sUzCv2Ztw3ATzGfHidOLNtM9mA
        jlz57PVUhcygA12S8OdCvTPntarmimVALqGT19XZPJCk03N/hTZ9Rm5iTjzcUfoTgAiKR6nBy6v
        lw0u+phj/M9ZRR
X-Google-Smtp-Source: AMrXdXuN1RJ5ZNaZEPdtdf1wuP6Clsbzl7xIblCQ8qoK09KR8XE7O+qkKulzCI9CedZR0H4QTQwr8g==
X-Received: by 2002:aca:230f:0:b0:364:d7f0:3847 with SMTP id e15-20020aca230f000000b00364d7f03847mr10623413oie.38.1674493508937;
        Mon, 23 Jan 2023 09:05:08 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:05:08 -0800 (PST)
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
Subject: [PATCH 2/9] Revert "mm/kmemleak: make create_object return void"
Date:   Mon, 23 Jan 2023 11:04:12 -0600
Message-Id: <20230123170419.7292-3-george@enfabrica.net>
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

This reverts commit b955aa70a3ac9f1dd5e26d4c7673ec3c28a8c2af.

The function delete_object_part can use the return value of
create_object to propagate flags from the old object to the new objects.

Signed-off-by: George Prekas <george@enfabrica.net>
---
 mm/kmemleak.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index b40735539abd..2b9c9ad68806 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -616,8 +616,9 @@ static noinline depot_stack_handle_t set_track_prepare(void)
  * memory block and add it to the object_list and object_tree_root (or
  * object_phys_tree_root).
  */
-static void __create_object(unsigned long ptr, size_t size,
-			    int min_count, gfp_t gfp, bool is_phys)
+static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
+					     int min_count, gfp_t gfp,
+					     bool is_phys)
 {
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
@@ -629,7 +630,7 @@ static void __create_object(unsigned long ptr, size_t size,
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
-		return;
+		return NULL;
 	}
 
 	INIT_LIST_HEAD(&object->object_list);
@@ -698,6 +699,7 @@ static void __create_object(unsigned long ptr, size_t size,
 			 */
 			dump_object_info(parent);
 			kmem_cache_free(object_cache, object);
+			object = NULL;
 			goto out;
 		}
 	}
@@ -707,20 +709,21 @@ static void __create_object(unsigned long ptr, size_t size,
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+	return object;
 }
 
 /* Create kmemleak object which allocated with virtual address. */
-static void create_object(unsigned long ptr, size_t size,
-			  int min_count, gfp_t gfp)
+static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
+					     int min_count, gfp_t gfp)
 {
-	__create_object(ptr, size, min_count, gfp, false);
+	return __create_object(ptr, size, min_count, gfp, false);
 }
 
 /* Create kmemleak object which allocated with physical address. */
-static void create_object_phys(unsigned long ptr, size_t size,
-			       int min_count, gfp_t gfp)
+static struct kmemleak_object *create_object_phys(unsigned long ptr, size_t size,
+					     int min_count, gfp_t gfp)
 {
-	__create_object(ptr, size, min_count, gfp, true);
+	return __create_object(ptr, size, min_count, gfp, true);
 }
 
 /*
-- 
2.37.1

