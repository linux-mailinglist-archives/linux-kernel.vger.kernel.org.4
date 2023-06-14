Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4695972F27B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbjFNCO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFNCOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:14:25 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52F19B9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:24 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56ff9cc91b4so2731977b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686708863; x=1689300863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BSFsBdfqKwJDeNmN034wMHi+SHlUrK9ElViK5A6C6IE=;
        b=Yrbn5QNKzbT2Vwjm5vqXOM8712t0dxIGO0HybDip9UlCaGnNwzntmA4pkKt7lPE+Da
         Y6lVhkhW9i9vlceYGFX20ODuhNR4GfkngnCa5kFYQuvTvLd5O7PaFY2FeL8SC26r665m
         Raw8LvqBk741Yofkgttjy8hfqmUzu7TKwAhstEP0G79QMdcDmypMgy30kYNd0QDnEEzk
         bEkmE76dQjoL8nNEhJ8D2Kyo3S0IJWe/8VfxFyJTdhdWAuE0qi8O/kxQtwsny0zZ9TF9
         R8fJT4zB3IlDS8l2LpFCOgtBoClumDiHnvVCLS9v9k7rY3sZzhrp56/YGsndm83LbmnI
         dnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686708863; x=1689300863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSFsBdfqKwJDeNmN034wMHi+SHlUrK9ElViK5A6C6IE=;
        b=AXzgoP/PqLs91Si0yPkWbSvekFzd8Jos/LGF+lTjdYeUHpm+yuWehE16Ef8Av7D/52
         7qU/kI7s1ghYb9j9fMy9p3Chjn7Jr6uvrpJCLUTYNmqT9NOJ0bWRzJ8PrTlvAxx4BLlq
         X9fK3KgCWPxwfnU1KMb15WPS9S4AK57Z5kJ3qB/xEu0hUIYShfZn/3A4SqasCM9B5OjM
         DZGgrTU26XFTCnya2ckNpzCkgiLnOTJpDbYXuxZcijbwkmvOQwWmxaHHIUKdr6uds+oM
         H+oEjNPvgs8G/rW9kHhGfM8fdlvcLUimzHsDm/0L0LQ1qdmIplPZpV/0lx+tb31B/tHq
         LmCA==
X-Gm-Message-State: AC+VfDzrOipA7iuTF2zcK30+RJv6Owpk0xFzUdezGljYFzRmjYo4/VU3
        915sq78XQC2Jt7th/EhRzzOUdE2v56E=
X-Google-Smtp-Source: ACHHUZ74QYigS0/7JConY7iOfmsiWekybmlTLrerY2KTcEH8th3enrZKX5zSFlnh/uwD4hTIZEhWsw==
X-Received: by 2002:a0d:ebc4:0:b0:56c:e54b:b4b8 with SMTP id u187-20020a0debc4000000b0056ce54bb4b8mr4610778ywe.28.1686708863245;
        Tue, 13 Jun 2023 19:14:23 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id p3-20020a817403000000b0056d30f1b508sm1463931ywc.107.2023.06.13.19.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:14:22 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/5] Replace is_longterm_pinnable_page()
Date:   Tue, 13 Jun 2023 19:13:07 -0700
Message-Id: <20230614021312.34085-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces some more helper functions for the folio
conversions, and converts all callers of is_longterm_pinnable_page() to
use folios.

--
v2:
  Fix a syntax issue
  Move flags check to top of try_grab_folio

Vishal Moola (Oracle) (5):
  mmzone: Introduce folio_is_zone_movable()
  mmzone: Introduce folio_migratetype()
  mm/gup_test.c: Convert verify_dma_pinned() to us folios
  mm/gup.c: Reorganize try_get_folio()
  mm: Remove is_longterm_pinnable_page() and Reimplement
    folio_is_longterm_pinnable()

 include/linux/mm.h     | 22 +++++------
 include/linux/mmzone.h |  8 ++++
 mm/gup.c               | 86 +++++++++++++++++++++---------------------
 mm/gup_test.c          | 13 ++++---
 4 files changed, 67 insertions(+), 62 deletions(-)

-- 
2.40.1

