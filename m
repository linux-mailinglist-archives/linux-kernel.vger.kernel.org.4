Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2150647757
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiLHUfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLHUfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:35:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC848566C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:35:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2733962pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pxoZSb+LSg2Sr/OdadIfRMcj1fpcuMZctN0ht3p2zD4=;
        b=VwCLLnMeB3k+m93uzv1eq29GbH6lHGER8I1wurF0B4Ax5fHnR3DiQNpHMpGfvnQfDu
         nZmLmXIyRUnA3l2X/+56gt3ZWzqD9PYZjPg1KXKw6WQma7pTMKUxQinuq+mdDLgBkGkC
         WXAqILax3018nRSDwH4AurHrjYoJUmirxagXs3LOXrnSe8Oh81i+WL8IELBXBUnBxyVB
         qABu4Lt3o4Izbyi/FqvcONlR5+wY2gSQiveHWVQHRZIfAHROSQ/kr3nHXUL8/bR+TjxD
         Sy0Kv5Vt3kDsNE4EIrEzNiQWYtTJ8i+k8vZzt/6gKS5hCKt6zCJ338IdAS7JR2e1PjWH
         sRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxoZSb+LSg2Sr/OdadIfRMcj1fpcuMZctN0ht3p2zD4=;
        b=h3i/QOLdocF7f/egTAU3Sxaj7ToTUQKFg/hoB8Q2EOfhFQ49Wk8GnKW7fP8P/wVR7v
         SOlaKGuTn0PxDWvhSB4aMmDG37ueA9JOhm3tTCblcxCz1UdCe+lpTL8nFb4FBQOZUrTw
         ABPDdRp2MslHCGczcJna1BP6YHgSDbMCxdymUPhfPskaUFpGLdwOCTaGTibIRmAUCUGC
         lDL6fZBNymOhlKnNTJMIH2FBynbX6mUM9taa+BRpw0ocifvPvfDMFRmBVHoesF+iECU3
         hcPkEAZPVZswco0VwSa2kfnSNSluFm/21IK9yslpHTJhgS9Vr038iX7U8FmCFEXZ3JCD
         2sgA==
X-Gm-Message-State: ANoB5pn+HId2pFE4COyhcqzspLXDjZdU3itVW9kGfU/UP+4M+pkxT140
        mlV/z0+k4TiyX75clVoFWYHZxu7zEJs=
X-Google-Smtp-Source: AA0mqf4k72/AHpv1DnErQTrKu22mRMb4TU2PdaN2wkHpDZPOhQPVGlP8yF/zfmzlkzsnX00BTjSjMg==
X-Received: by 2002:a17:902:c94d:b0:189:b36a:5448 with SMTP id i13-20020a170902c94d00b00189b36a5448mr4682294pla.44.1670531706836;
        Thu, 08 Dec 2022 12:35:06 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020a170902860500b00189951514c4sm16954349plo.206.2022.12.08.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:35:06 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 0/4] Convert deactivate_page() to folio_deactivate()
Date:   Thu,  8 Dec 2022 12:34:59 -0800
Message-Id: <20221208203503.20665-1-vishal.moola@gmail.com>
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
 mm/damon/paddr.c     | 11 ++++--
 mm/madvise.c         | 92 ++++++++++++++++++++++----------------------
 mm/memory.c          | 10 +++++
 mm/swap.c            | 14 +++----
 6 files changed, 72 insertions(+), 59 deletions(-)

-- 
2.38.1

