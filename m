Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBE964FE67
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 11:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiLRKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 05:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiLRKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 05:19:26 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D5DEE6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 02:19:25 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id a9so6393741pld.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 02:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERe/r2sSrZoK/GY0S6LEuDdiHuaRQ2o4UfuW7lVdOJA=;
        b=NzidgMsUv/PXs06KQ1wiEISb3hVNDjxnjvZ03vdtNPZ+wQrwGZ+beCSj1jS5UCnrOm
         EcwJOQxR5C24LhdzxFXchQ3CjlIgeflvZ9Ffd5od6T7TJMiVhGo3QhVoLKYNIUcqKFrc
         SB9H7hMqHpwSqMCjPqlardUQjGuslebXpsCBHDuUQ0VFGHomt8PW1+87G9HhJVZBBRvI
         NJl9sZk1LqboH0x+TGGRD/fl6yVEbou1laIZ8ytEtOJKUVYtqtm2ntB5Ju2PMrpvPtCF
         w5O0ZWeTaady6ZWy4F7dZIS9qzLSAGmfkTDp4WQWVo9CsE0pOsYLcS3PtTly57hWQwcq
         zDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERe/r2sSrZoK/GY0S6LEuDdiHuaRQ2o4UfuW7lVdOJA=;
        b=o0OzLldEYxpXWj1haUy9xXw8AxDZVv2TIJzOGbmVvm2RoPo199qgQtcTc9Yc9MG13I
         eBfqfBqnjT5UPu1YE0CgtC4/F9reglFRxY2kpJrmfXdzpsLyK1DJ6VRxVx5m1et3le60
         EWsj+0UscljhxgMgluDxBX84xpFxs/Xnix12ZqBkaIDjYe5mFoP65+3WdjgpObL5Z/Hm
         e5wWBKAryx5jfqh011+lc1+blrinP6jlF1RBwE3XAKGUUZvUvknAyx15WdpyYZRnIiYV
         peAFvxNCXCJQuKl6zcfyvFl0zg/U6azaeAUpkdvqrQpZgKH72cJZUgM7x80bCBjYbtzO
         /8nQ==
X-Gm-Message-State: AFqh2kpmIUnDAIajBuCD5O3or7de4PhQ3y+iXnKciRRRw0zh46iGwpfg
        WFNABNh1HGC1ntXaOoye0h8=
X-Google-Smtp-Source: AMrXdXt3Qc6Z+OskCRLL2iIYYRcpfIiOSjKvwM/qlDjcbNGQ72fpb+5p9Oct7I9A1nW4i/QOOzW8xg==
X-Received: by 2002:a17:902:e80c:b0:189:985c:849d with SMTP id u12-20020a170902e80c00b00189985c849dmr7076606plg.1.1671358765219;
        Sun, 18 Dec 2022 02:19:25 -0800 (PST)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm4789791plb.53.2022.12.18.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:19:24 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        =?UTF-8?q?HORIGUCHI=20NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 0/4] move PG_slab flag to page_type
Date:   Sun, 18 Dec 2022 19:18:57 +0900
Message-Id: <20221218101901.373450-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC v2:
https://lore.kernel.org/linux-mm/20221106140355.294845-1-42.hyeyoo@gmail.com/

This patch series moves PG_slab page flag to page_type,
freeing one bit in page->flags and introduces %pGt format
that prints human-readable page_type like %pGp for printing page flags.

See changelog of patch 2 for more implementation details.

Thanks everyone that gave valuable comments.

v2 -> v3:
- dropped show_page_types() in a thought that it is not interesting
  to track refcount of non-usermapped pages.
- added patch 1 that cleans up MF_MSG_SLAB in hwpoison
- split implementation and application of %pGt to separate patches.
- instead of printing "no page_type for ..." in %pGt, just print 
  '0x<value>()' for a page that does not use page_type field.

Hyeonggon Yoo (4):
  mm/hwpoison: remove MF_MSG_SLAB from action_page_types
  mm: move PG_slab flag to page_type
  mm, printk: introduce new format %pGt for page_type
  mm/debug: use %pGt to print page_type in dump_page()

 Documentation/core-api/printk-formats.rst |  3 +-
 fs/proc/page.c                            | 13 ++--
 include/linux/mm_types.h                  | 11 ++--
 include/linux/page-flags.h                | 77 ++++++++++++++++-------
 include/trace/events/mmflags.h            |  8 ++-
 kernel/crash_core.c                       |  3 +-
 lib/test_printf.c                         | 26 ++++++++
 lib/vsprintf.c                            | 21 +++++++
 mm/debug.c                                |  7 +++
 mm/internal.h                             |  1 +
 mm/memory-failure.c                       | 10 ---
 mm/slab.c                                 | 44 ++++++++-----
 mm/slab.h                                 |  3 +-
 13 files changed, 162 insertions(+), 65 deletions(-)

-- 
2.32.0

