Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D35681B37
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjA3USw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjA3USn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:18:43 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697E470B2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:41 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 78so8497228pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/lmYSHdaKEx9MQhNyRl2WaJ9sSWoq4RbCP4Yw6Q004=;
        b=aD2Z3rDUk8kajuPDXgp7/UsNHh+KbL2+0N4OHa+EcE5IJz03CyTH5UyYgG4kzNQovy
         Bboeukhtc25FaavbCL4dyiupfFgV0CQyn59INuhP8WiQvskZPEBFot9ALWzDtSfBUqyb
         yeWLnjjWtg25pkFdnutXSSLovx3GtRyNxxeBNgtdfwei/v4cus229Jf1GjzwfHkoqlre
         FP786TTk3CGUSm/dfpYGWUDESADqZLiUZgpMg9mT8VHIN/NwxviS+cy3rUnfxjOUIu+J
         NVeP5i4E3ER1I70aRsW3TZ/e6dchPbpCtUw+8+hCohT6vo3LZXHrTGLds3f/zU72wfYr
         m+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/lmYSHdaKEx9MQhNyRl2WaJ9sSWoq4RbCP4Yw6Q004=;
        b=3/pHEniVdoFoH4gJlL6841+02kRjwFmoC6efhdhAhMiWkO3PDAIuyEWvDhgqBe9MHB
         oGJ61npmEX3ESRK3whXnhFtA5ekej1IZ8W8jlfnJnfOp6OU4rGWu2pR+n5NWHnSFnphD
         RiGlrf6Pb+3gy4mjYjal7cy1dGHESI37v5NHnBeAlSz+GtrYzoJYxPzYbs2hBLPR8n7R
         nbF6a/wyDc8fj9tYDqonUQ0jLJ2VhJ7YxakFzr560ccQN3l86/vxGMAFDsH3iEdYXZwc
         hiiVaMXkjfSFIAytWcPv1hnrq9t6y14oJOyasPGlNZnnvPYOpkNSmTCKN3heJEWbuWFq
         iR9A==
X-Gm-Message-State: AFqh2kqFJaMB/R+9eWvFi0WNjAb6/D25m3M8+OLh3moL1x1glAbszeH5
        md2Ad8rq9HxxA2nJhPSLah8=
X-Google-Smtp-Source: AMrXdXtz7nOVP6S+JD1RUfXiLMp0GGP6GNeQ127WGljVNwdv47dAvvK3+ldwKonlaQGE4qxgmj2cXw==
X-Received: by 2002:a62:4e8d:0:b0:58d:b8f8:5e2f with SMTP id c135-20020a624e8d000000b0058db8f85e2fmr46962908pfb.10.1675109920707;
        Mon, 30 Jan 2023 12:18:40 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id g9-20020a056a000b8900b0058d9730ede0sm113262pfj.210.2023.01.30.12.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:18:40 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v4 0/6] Convert various mempolicy.c functions to use folios
Date:   Mon, 30 Jan 2023 12:18:27 -0800
Message-Id: <20230130201833.27042-1-vishal.moola@gmail.com>
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
function to estimate the number of sharers of a folio.

---
v4:
  - Rebase on latest mm-unstable
  - Rename folio_estimated_mapcount() to folio_estimated_sharers()

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
  mm: add folio_estimated_sharers()
  mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()
  mm/mempolicy: convert queue_pages_pte_range() to
    queue_folios_pte_range()
  mm/mempolicy: convert queue_pages_hugetlb() to queue_folios_hugetlb()
  mm/mempolicy: convert queue_pages_required() to queue_folio_required()
  mm/mempolicy: convert migrate_page_add() to migrate_folio_add()

 include/linux/mm.h |  18 +++++++
 mm/mempolicy.c     | 122 ++++++++++++++++++++++++---------------------
 2 files changed, 83 insertions(+), 57 deletions(-)

-- 
2.38.1

