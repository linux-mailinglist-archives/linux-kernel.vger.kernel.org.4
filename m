Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C315C6804F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjA3EZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3EZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:25:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73741BFB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:25:38 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so10302133plw.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhPJEWpOfk1ykeQU4U3ngSaMOT4Kg+4FPcVKFWkho0s=;
        b=eZ17fd6e3UlSZGtxd55lTgEig1YRMVdMcln2sRtnEr34qVlahjw+yrtUdNbJ3NuctB
         elSELCKoof0FFDSVPi0Du+oVUH1NX655Z93RdeeuvPy+Twi2n5TzjGTTqdFZJF354slD
         Yn6m8+PxZuDeyNNmGNQD4gzwtrTsGP3TevhoUMNcBg8LodXmt8ezZel4++1uK9oDQCq/
         UgCPxT0Ru8zWd6Ow+ge2UOB4ugZQtnbfqtvxDImWnttF3z4H1Gokb7kIHi7jcy4Cb9X9
         03WXef9zNIH3UKub22yx0woGdBYf+xOmMWwpjWAlDdKvzUY//N91ApbCdM8qhOtDlD2n
         OTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhPJEWpOfk1ykeQU4U3ngSaMOT4Kg+4FPcVKFWkho0s=;
        b=sf8PXnP3JkmJhLbfn8IssX8/9ZN3JmLmEp17bvGl9QrnVTYW1u/XtmcugHMt3yXxjS
         SqMxLCkZlhYOHreZcZDLOFllTEJziLag7lbzHHu4YWFV+Bqvm6K46E13rm1LmkytBK7b
         wKk1AIRrkGOD2s06SmhnhPSHFwldNadVCVbpB2GT55uT1C80ujHOFYdnxHbHuZpgRnSx
         cYTLFHq6m8SbiqH1vnAsCiYzfqV1aVKD7MOhvLW0lBnvIXMNN2NmBKIG/JVoT/Payvxp
         edZSSAr3HQOD4GfSwhlKWKW59Efvl2MjIG6vh7Jrjh/9KOZ7w+8tA5d9yPD/rVnnJyA+
         MEUw==
X-Gm-Message-State: AO0yUKWxsWI0Ta46LYxK7v71oDbX41zdFR5XNBynw/IrzJIyC5Iv/KyW
        UgLSvF4kW3zrAN3jOMOSOG4=
X-Google-Smtp-Source: AK7set/PKXPnYT8fiYnv7DlanYGwDupypUZWbD4XKw3xmaSADOZs4RDLu+OTJnqIAeMmZ0UYIn2Uqg==
X-Received: by 2002:a05:6a20:441f:b0:bc:8aba:4fa0 with SMTP id ce31-20020a056a20441f00b000bc8aba4fa0mr9246743pzb.31.1675052738014;
        Sun, 29 Jan 2023 20:25:38 -0800 (PST)
Received: from localhost.localdomain ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 138-20020a621790000000b0059312530b54sm4275969pfx.180.2023.01.29.20.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:25:37 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable v4 0/3] mm, printk: introduce new format for page_type
Date:   Mon, 30 Jan 2023 13:25:11 +0900
Message-Id: <20230130042514.2418-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC v3:
   https://lore.kernel.org/lkml/20221218101901.373450-1-42.hyeyoo@gmail.com

This series was originally part of "move PG_slab to page_type" series,
but printk format implementation for page_type is separated to this series.

RFC v3 -> v4:
  - dropped patch 1 ("mm/hwpoison: remove MF_MSG_SLAB from action_page_types")
    and patch 2 ("mm: move PG_slab flag to page_type") from previous
    spin as they are planned as separate series

  - adjusted comments from Andy Shevchenko [1] and Petr Mladek [2]

  - added patch 1 ("mmflags.h: use less error prone method to define pageflag_names")
    for consistency with patch 2 ("mm, printk: introduce new format %pGt for page_type"),
    as suggested by Andy Shevchenko [1]

[1] https://lore.kernel.org/lkml/Y6AycLbpjVzXM5I9@smile.fi.intel.com/
[2] https://lore.kernel.org/lkml/Y6HSutM8pmoKxQWp@alley/

Based on mm-unstable (ede43f2956cc "kasan: fix Oops due to missing calls
to kasan_arch_is_rea()") as there are recent changes in mmflags.h.

Hyeonggon Yoo (3):
  mmflags.h: use less error prone method to define pageflag_names
  mm, printk: introduce new format %pGt for page_type
  mm/debug: use %pGt to display page_type in dump_page()

 Documentation/core-api/printk-formats.rst | 16 ++--
 include/linux/page-flags.h                |  7 +-
 include/trace/events/mmflags.h            | 93 +++++++++++++----------
 lib/test_printf.c                         | 26 +++++++
 lib/vsprintf.c                            | 21 +++++
 mm/debug.c                                |  7 ++
 mm/internal.h                             |  1 +
 7 files changed, 124 insertions(+), 47 deletions(-)

-- 
2.39.1

