Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F35681D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjA3VoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjA3Vn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:43:58 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEEDFF28
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 5so13099910plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Be0GbNSETxdWEgUWa43nheEU4+7u32RSWDZM1/WkMvo=;
        b=kA1XRdzq2oK/p0tfLkb68/ufyYI4rmOuaA1vGgSbyEtbSfRxMtUBaHPiweOmIuDR5n
         PPOr4B5wi34D1If6pjrmr6MZ7CndRDlNTgPrQXZ3P60OEX0l2nWkOnivXtg7EydEekOa
         7uWlYxE5ZP9sc7O8c/8INej7egnKPfBuVV2d6mZsIkIEGhBSpNe71xaiqm6ZHPxwW0Yn
         YNlwi1fNbKzlJE9IT/qHPZD2eC3/uG9mWrzsyAEBD37ZOq1sqNDjbPoQMzRZ90TsUlDQ
         ZCqehH9QwRNZN2sUu38VVeD+DG8+m9Qxm6bqfMr6EHh4VHh/lwjpnJIMyLuZ3c+IQ11i
         IkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be0GbNSETxdWEgUWa43nheEU4+7u32RSWDZM1/WkMvo=;
        b=D0SwJHzmR8SpEUg1I3ibuoZvIoJCq92ZUzlrBCleyWng+ovkIBVnJuy+JmBm2tXzs9
         Ml+7qx95Wsre4dAWKoOF9hoBAQe4jUBn7spgZ2mUQNgm72dqLuAnp6MA4+JL/eARd5Nh
         6GlbvyjqbjYFQHyZgGIFc3VcKlwfwfCdPh1i8D+FaZ0K4H6N4qN2p+ZT7+EXPGq4lbko
         U0/OPkmJdyQSEl6DDTWdWqfefGP4WGN3CGeFVZdQnQd/KLj17fTB/Tn5YsJbaueGeBks
         //nG+ptI9YgjG6IKoyTAXVmterXUUvXSehm5G6wERxTObA8Q+t38My9HWECz9u4gYAqC
         NYHw==
X-Gm-Message-State: AO0yUKWetfFn3QSFgGHKv5Dm/vmufcyQ0pkDgt6moDrXxES/sTJdLTzo
        XoU3Ctn2uf8ol63WkhKmeQ6Rc2JKsEM=
X-Google-Smtp-Source: AK7set8u0PBItb9cLRV8J43xO789vl4yztg8rE75ilakZk2IYRzUxQn80HqS9U8H7Mf4PTsIEsBZUw==
X-Received: by 2002:a17:90b:3905:b0:22c:94f6:cf39 with SMTP id ob5-20020a17090b390500b0022c94f6cf39mr6594013pjb.38.1675115035362;
        Mon, 30 Jan 2023 13:43:55 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id d5-20020a17090a628500b0022bbad75af6sm25156403pjj.1.2023.01.30.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:43:54 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 0/4] Convert a couple migrate functions to use folios
Date:   Mon, 30 Jan 2023 13:43:48 -0800
Message-Id: <20230130214352.40538-1-vishal.moola@gmail.com>
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

This patch set introduces folio_movable_ops() and converts 3 functions
in mm/migrate.c to use folios. It also introduces
folio_get_nontail_page() for folio conversions which may want to
distinguish between head and tail pages.

---
v2:
  - Add folio_get_nontail_page() to fix behavior in isolate_movable_page()
  - Rebase on latest mm-unstable

Vishal Moola (Oracle) (4):
  mm: Add folio_get_nontail_page()
  mm/migrate: Add folio_movable_ops()
  mm/migrate: Convert isolate_movable_page() to use folios
  mm/migrate: Convert putback_movable_pages() to use folios

 include/linux/migrate.h |  9 +++++
 include/linux/mm.h      |  7 ++++
 mm/migrate.c            | 87 +++++++++++++++++++++--------------------
 3 files changed, 60 insertions(+), 43 deletions(-)

-- 
2.38.1

