Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A525EC975
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiI0Q1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiI0Q1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:27:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C262048EA6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i6so5962959pfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mZ0ic9EB4+tzuNdj/CFplry2nB0UlL8aeOFVdviEjyk=;
        b=dDhu03HoHqtx2WXjQchPedVhAxIJsNBfEaj5pSXtu5I6p2ogdvS8/URft5lKjPQVMX
         KO2ExjK8I0Dm2RvEBkTFabGtZ99ppt1NVmR9oeGojcXuTHuqmRiPZqb6FhrlEAbqdGXp
         qFxAVD70FqY7faBtqWPlEhnQBwhQGwIlRUPp7dAK290DLDU9KutrOOrZJbBIzOx+c43r
         aDjhclGS/L8ou4YGOuZZ9xkjd8Xnvaz7FOCmMWAaRB5mH8OPnnkg+m1lypQ4UmcxQXzW
         Y40EGz3RwZiUhx8TtxjdK5G+FSyaixZ82mEzDnOZWRRbjxbos7BXQOeUNhTw6IY+9Zoo
         4lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mZ0ic9EB4+tzuNdj/CFplry2nB0UlL8aeOFVdviEjyk=;
        b=6jG+p5mZfFLQnCm/pYgYUk9xg+g+GQ9Zfb7WBHIHKc2xxrSWkLFlsBAobg3rRG7zMA
         jQuAPqlPM+L2mmeFLbIE41YJkZ0/LWjXR+ShnvuYqmMtSWqfOkH03zTzVDuuRMe55K7M
         OgPOCmemFmmiRZtuidzYuJqtAsy3i/X8UiMdf2W4+az6WqIhcs7jrT9m6UKQhlHhPN8v
         SxdTEAot41FlZnejlZ3kE2xiJhJpUM2PqPJ5lWdYoSiFd9Y+6rhOQ2xE/EaeuFaJVNdh
         zF65paprR8QwfYb58l9+d5FZT6Mvxwxe1Rg35Ss1ZVt4pGTuxVbxXrd9CUyvp//CQyr5
         kb5w==
X-Gm-Message-State: ACrzQf2ztt+a6GSiCbfqBIUA7CbAFBnx3fNHVorfN47IvL2PJQTVvH3h
        fAfPylZ8VRcNozZYTtdhyWE=
X-Google-Smtp-Source: AMsMyM4X8q5DLOnenuOpkczDjluEL+5YCxAl4GIpEEy9RDAAZfHYJA96bX3p3JTHiMYDraXh1AoL8A==
X-Received: by 2002:a65:6ccd:0:b0:439:2033:6ee with SMTP id g13-20020a656ccd000000b00439203306eemr25656463pgw.271.1664296061307;
        Tue, 27 Sep 2022 09:27:41 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:27:40 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [RFC PATCH v2 1/9] mm: Add new mm flags for Copy-On-Write PTE table
Date:   Wed, 28 Sep 2022 00:29:49 +0800
Message-Id: <20220927162957.270460-2-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927162957.270460-1-shiyn.lin@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
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

Add MMF_COW_PTE{, _READY} flags to prepare the subsequent
implementation of Copy-On-Write for the page table.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/sched/coredump.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 4d0a5be28b70f..f03ff69c90c8c 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -84,7 +84,13 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
+#define MMF_COW_PTE_READY	29
+#define MMF_COW_PTE_READY_MASK	(1 << MMF_COW_PTE_READY)
+
+#define MMF_COW_PTE		30
+#define MMF_COW_PTE_MASK	(1 << MMF_COW_PTE)
+
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_COW_PTE_MASK)
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
-- 
2.37.3

