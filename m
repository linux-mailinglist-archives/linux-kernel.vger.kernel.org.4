Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC9607C65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJUQhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJUQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30AA27B560
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-367dc159c2fso33838717b3.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUxkfzPpYKN6asWxOUK5hNSN6fMNkS8/sAXTNszQZDU=;
        b=KyHaYNZ4pYGCB/ViwdCe6ocu1GDgb5YvODnNgAb9mCc41is/HzCKWGlBYl+zSC2M7R
         wDxY0MPGeDl4H+0C+mB6AFFSBWs3XZbwRg6SRGwAx5hUQbyU0q2y7YE3x3g1mN6R7kOL
         mmsmmdI260xt2gPS3NqKTeMLpZZsslNcjBFK0FPPuqtHMPONuhEMnH8tH2tsucIOb/sf
         djUB2qYtnGhphrore61r1cmnFMRrRh4uh4EhSpubCR4MBBVW+CoIXhmSmouk+6a8lUUx
         XMYWqrbERhGrTAQJzZPB/mpCFUGWWYrvH6mlo2sZFv3G70Q1lmcsgtXbK8JdDbqteunh
         HYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUxkfzPpYKN6asWxOUK5hNSN6fMNkS8/sAXTNszQZDU=;
        b=gMkWMVwBAMjeZmC5mjvOl02uJNZTZLJ6Tfy5rg0H+wCm2MjZmSoL7j3Ixuu54he+Ol
         qnwcavChW1oXU0eFkUP0WvRCA7KMUWyYQ4d3fNlBYiqBgfXA+EoZpYLSWbb1EsYOjwO0
         9wVCXua1XPTJPfNRxuhXAUcPTYvb7rvDSO8QSsr8MgvA+ZJ53rgkJNyVMCQcwhG/V6OX
         +cmWESx1E/Wl826M5vnQ1cx0bvoRHADYIWw32V15pIQWezj0l9sljOdxK2m69l9m3/7n
         JeZc6uKbvU51c3n7Mi93dboiiAiAwKMpl20MOB+KgbbDN1CgCaSfKIj4uuFk6qAOqZ8X
         /raw==
X-Gm-Message-State: ACrzQf0KWd5sI6zwHhRvJ+ehCqlJxI62xQ/EqLcOnEnxvSAEdzGGnD6z
        nZOEDWsu+3ErMEFnYzg41EdnP+tp9jvdcWoc
X-Google-Smtp-Source: AMsMyM4vp8fYTq3qDzC4UTof6qxcqVOi/s+AdXdyXBlWQIteH9csXgDzlKMfMAxWzbToL+1hNLKr/pzgUDQtkmZ8
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:790d:0:b0:670:6032:b1df with SMTP
 id u13-20020a25790d000000b006706032b1dfmr16600775ybc.629.1666370243225; Fri,
 21 Oct 2022 09:37:23 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:23 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-8-jthoughton@google.com>
Subject: [RFC PATCH v2 07/47] hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
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

This adds the Kconfig to enable or disable high-granularity mapping.
Each architecture must explicitly opt-in to it (via
ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING), but when opted in, HGM will
be enabled by default if HUGETLB_PAGE is enabled.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 2685a4d0d353..ce2567946016 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -267,6 +267,13 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
 	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
 	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
 
+config ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING
+	bool
+
+config HUGETLB_HIGH_GRANULARITY_MAPPING
+	def_bool HUGETLB_PAGE
+	depends on ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.38.0.135.g90850a2211-goog

