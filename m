Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF867C106
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjAYXlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjAYXlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:41:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865AD3ABB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso211539pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Bh5gd1PcSeNJQ0JyKgJbQZHssUzNPHOpST5xNeedBo=;
        b=AapQh2g0RdJjDmYLkQLAlA70USXDgHo8iRz2XMCmnZnmlbEiIYiSHwy+cAMbnkH8Cw
         kPGCk5LdT6H112lE4Q/PgGq0/5WsCoNhMGtzN2NHXwUg4IIFiOaC08lGOM5rNUrrr3pe
         x+c8iDOl0j/MV4v69WZOhRqTrO373lICoOF8PE1HG0pCdYt8XsRHhUY5QePjbeV5NoVJ
         UxH6Ajj6QZdgxVK1pOqT033VH5qLUV2ZTXb5+mGxPX4xeCUT6mXufoTK+Nf1nnNTUyGq
         HaulRtkpg96AxLkmhDZOkvwSKh7WwzazZvNKp2VB38JBHnI4qOp5GfScPSdMSoQJ3TU6
         +qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Bh5gd1PcSeNJQ0JyKgJbQZHssUzNPHOpST5xNeedBo=;
        b=jeK6WQMeSCEhT9A2byEw06LX1CLd6OXJqjbi3BmZj5pSpDgv8UB3zzFfkB8s7WzOrB
         nFg1c9Q24Rj8uR24loxxug71O3pwp1IOEjCbxzMN49b/FUD2lvxtXNly5+EHUeePlHO8
         rDsEdEa6+xAS0Mek45tUvmI7wKaqhr2pqYu0tY8z6/QAr6LsFF3hYhISF70ywhrr2L7S
         +W/7cHZF1tcYoJI6nCeqTEvwZJN9OoBYqCwKi2yVgiFQLThsbsVKy/IDe1W4x3QwQP9p
         BRgz7tk/WUsUw/thqNdXKalbL5BPgxN2GLyZPf5ZNIZuntLw9dYFb6aO4z3FbEpwAH3E
         q8+w==
X-Gm-Message-State: AO0yUKU+tvuAxUPVYqCF0pyipvZBbGVz5iBQ4HelNnj9nIEAswiJOKjm
        t74uVf5TFoffJSKWYm6G/AQ=
X-Google-Smtp-Source: AK7set9vSt7fdV6sIrXUp4EGLrS68FPdTF8zZ30x5x3kab7oXSDvZmmIWv90DBawZuXkValGa1HDuA==
X-Received: by 2002:a17:90b:164f:b0:22b:e749:5c8d with SMTP id il15-20020a17090b164f00b0022be7495c8dmr9072947pjb.3.1674690104709;
        Wed, 25 Jan 2023 15:41:44 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id e8-20020a17090a630800b00219752c8ea5sm2226806pjj.37.2023.01.25.15.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 15:41:44 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v3 0/6] Convert various mempolicy.c functions to use folios
Date:   Wed, 25 Jan 2023 15:41:28 -0800
Message-Id: <20230125234134.227244-1-vishal.moola@gmail.com>
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
v3:
  - Move folio_estimated_mapcount() to fix build warnings
  - Add comments to folio_estimated_mapcount() to make its function and
purpose clear

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

 include/linux/mm.h |  17 +++++++
 mm/mempolicy.c     | 122 ++++++++++++++++++++++++---------------------
 2 files changed, 82 insertions(+), 57 deletions(-)

-- 
2.38.1

