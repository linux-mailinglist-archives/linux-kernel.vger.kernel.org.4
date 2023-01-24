Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E98678D42
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjAXBWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAXBWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:22:15 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E757E8A7A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g205so10209992pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWQ8Mjj9mQfWi0ryrLDjNixoF50ripWX9NE7HkrYwgw=;
        b=N3i6i0Vuczma+2Gn0uEL5nHllgVqqrAWzuiGB7kK3xdORDjFKaJCJMcAMN3aGpUmaS
         SSQ+DpK4rBCyPJR5gIpbPlQFYEjWfBZpetUcBOdyZ0KlKCZ1E3VUgHbreJvc9ff/4WzG
         MH3EwBRRe5rWAxQl8zeYmP2XXqSk0kP5/Dd6CfGRSiDUjVEFdzcXDbCgyb9DlQ4IPnqS
         Jo/7XBwf1QZZDLljs6d3us5HoTRXMFmnE3A3WRou0w56X6/dn3WgyNUj0lqnPKGIk8X+
         57yywZ2PKUMclTBb0LeW+oPqwSLwrpCZLA1V77/n3zsl1BYhI8r84E4TeWhcgaTbu9al
         NDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWQ8Mjj9mQfWi0ryrLDjNixoF50ripWX9NE7HkrYwgw=;
        b=h954Q8kZd/kAL+T7s7/yMmkw7VxM4QNyEwtu2pUPda7Hxxr28sGmUz4Y6LkNeLVa5F
         qtFAa6b5WYX8mEClaOtN4b1b+4bWxbJ4C2P+yyZLfM8psCks5fjvBxudoZQYPAfyYPTx
         /D1sKlSvI3s/J2OOxLLCLOh3nCvt4G1dbk4Sk1uyiiC+UqnCdXASrrTEjcs4L9Xewdhj
         A0bdfdrn0JQGZj6gB+kIXvwocTGzIB0pBEjRG8Q6M3i3bHXxhjpTD9nR2vfIVWtsFQXR
         +vmE5zxCf6X4Lm42gum/wiiMNTdyMa2NhL89s8/sdQ0GnG+SsGS5B2reoLmkMe9+Fqw+
         cBRQ==
X-Gm-Message-State: AFqh2kpel6DFIuIh2KXmN0LvH5ydf6Mi78leAAWtodX42Y61hRC2kvZR
        1y/W3VxUfGxItZFMSTv0zXI=
X-Google-Smtp-Source: AMrXdXveIW4sa9EzR+KjtYZlSkZWuB8Z1CdymxLOa/lst291reud+d7jy7P5+YyPDeqS2QysqKMBLA==
X-Received: by 2002:a05:6a00:2ba:b0:576:7fb9:85cc with SMTP id q26-20020a056a0002ba00b005767fb985ccmr24965590pfs.14.1674523334217;
        Mon, 23 Jan 2023 17:22:14 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id 68-20020a620547000000b005825b8e0540sm213335pff.204.2023.01.23.17.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:13 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 0/6] Convert various mempolicy.c functions
Date:   Mon, 23 Jan 2023 17:22:04 -0800
Message-Id: <20230124012210.13963-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This patch series converts migrate_page_add() and queue_pages_required()
to migrate_folio_add() and queue_page_required(). It also converts the
callers of the functions to use folios as well, and introduces a helper
function to estimate a folio's mapcount.

---
v2:
  - Introduce folio_estimated_mapcount() to replace page_mapcount() in
migrate_page_add() and queue_pages_hugetlb().
  - Elaborate on the comments to make it clear what the mapcount check is
for and why it is being done this way.

Vishal Moola (Oracle) (6):
  mm: Add folio_estimated_mapcount()
  mm/mempolicy: Convert queue_pages_pmd() to queue_folios_pmd()
  mm/mempolicy: Convert queue_pages_pte_range() to
    queue_folios_pte_range()
  mm/mempolicy: Convert queue_pages_hugetlb() to queue_folios_hugetlb()
  mm/mempolicy: Convert queue_pages_required() to queue_folio_required()
  mm/mempolicy: Convert migrate_page_add() to migrate_folio_add()

 include/linux/mm.h |   5 ++
 mm/mempolicy.c     | 122 ++++++++++++++++++++++++---------------------
 2 files changed, 70 insertions(+), 57 deletions(-)

-- 
2.38.1

