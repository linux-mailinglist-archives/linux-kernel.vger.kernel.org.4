Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D676535E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiLUSKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLUSKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:10:00 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84D252AF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:09:58 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m4so16309313pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yca21srt3jfSdwv9cmVTSEKRbmKmeVKwhiy24VVJrgk=;
        b=DSJOlh0H6jO1fPraClFL4H/mt/WnSL5eSOkqRML/zohANW9YASclvvRuLArC7LygE3
         69S5K4eBQ++zsHnSyQ2gSimwzS8WGl+A2n4pxh15QxZkW7QoqX1n7ZPNCn73roGCVPLY
         CQHjdyeuniToYJ8i0ndIZVvqJ8GQo8YNHba6+zrTEQTmv1n0sSdekDXmzlYzAFZFqhZ0
         SaZxNuSh3D7Ez4dVAorCB3m4HmUxUJKkB9U9AZ/n9a3GIktg1oHRi2rsKDRyyp+US4Kp
         oZWAgjNMowWJn4ge84VDkrM0ANapRf08CxpHxldzmZQz0b5OGD7KSc70oXXX688ZWPRt
         4uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yca21srt3jfSdwv9cmVTSEKRbmKmeVKwhiy24VVJrgk=;
        b=Xzgxv9anigNtilPSICIFw4tg2nxNieP9hEbGw3qXkNH8nzTxXxctG4PY5347ICjQVG
         Fiq/MxnpCF3aPOz1xxNKLponrZ5yMWnqX+kqOjJQPmo75RtaVZm9c4PwfZMZg7I2Mw3Y
         g3AwDRZKs3JdJFvIhSRY5ufO0h4RTqjad8Wt96x9MbS4YQ4MP9Pl27LuN8FW80g/Td1a
         +Z/Ax8cvAPIvDq5da8XxxTyKKMT2anoQXGUpvpgA652q14dkifbLN4gExCDiSDGIkCZ2
         EcS33GnB0DNVm5zN/WT9srltksMmH5ZFNqb2ONuzG/gJ3JeuxhZoTFpNfcTSr3cU6u47
         LKLg==
X-Gm-Message-State: AFqh2kogcNOd5jjOwrFml6bZiD03zbhEEurFXSRYLWnHyUVsneretn/C
        +jFCAKCrd4eWkjNw/WJffWSjse0rz9gAQQ==
X-Google-Smtp-Source: AMrXdXt+oepsNuWyWeOO7XR/0jnSM5UBICF9yESwu6cJLSH7Rdfzc7qbutGMcctI/PrXlnxwykdglg==
X-Received: by 2002:a05:6a21:1709:b0:ac:5671:adfa with SMTP id nv9-20020a056a21170900b000ac5671adfamr20123978pzb.18.1671646197796;
        Wed, 21 Dec 2022 10:09:57 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id e26-20020a63745a000000b00477bfac06b7sm10110732pgn.34.2022.12.21.10.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 10:09:57 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org, willy@infradead.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 0/4] Convert deactivate_page() to folio_deactivate()
Date:   Wed, 21 Dec 2022 10:08:44 -0800
Message-Id: <20221221180848.20774-1-vishal.moola@gmail.com>
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

Deactivate_page() has already been converted to use folios. This patch
series modifies the callers of deactivate_page() to use folios. It also
introduces vm_normal_folio() to assist with folio conversions, and
converts deactivate_page() to folio_deactivate() which takes in a folio.

---
v4:
  Rebased onto latest mm-unstable - fixes madvise and damon conflicts

v3:
  Introduce vm_normal_folio() wrapper function to return a folio
  Fix madvise missing folio_mapcount()

v2:
  Fix a compilation issue
  Some minor rewording of comments/descriptions

Vishal Moola (Oracle) (4):
  mm/memory: Add vm_normal_folio()
  madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
  mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
  mm/swap: Convert deactivate_page() to folio_deactivate()

 include/linux/mm.h   |  2 +
 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     | 14 ++++---
 mm/madvise.c         | 98 ++++++++++++++++++++++----------------------
 mm/memory.c          | 10 +++++
 mm/swap.c            | 14 +++----
 6 files changed, 76 insertions(+), 64 deletions(-)

-- 
2.38.1

