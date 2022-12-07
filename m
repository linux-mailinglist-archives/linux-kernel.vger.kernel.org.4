Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EEF6464AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLGXCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiLGXB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:01:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180093D900
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:01:57 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 4so18508864pli.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/M7aDOH/qGCjs9lVwYHlVEwpsAApNAGVOZKD3ahzUuQ=;
        b=NOZ9lRCAQZP8wewc5DewcyWHlye7Pd1FmMImEx2GCbB+gZkla2ba5JURxFy6LaQnj9
         QRy1Jh6VQHRInet+vF3UptPq7mT6aCspNbCfXqtFiEWpgTk/jyYUoUF09jz9cOdOu/KG
         ql72FNYp+LJy97RhxhvASR5P1cNDr2aw3JDkb98OT0QZmQ6uKSA3H4v1PpsmOB2zcMBi
         FkwoYUb64Viv6SHIZFiwSI9YSuCiKOvK9Z1Z3HnAI59cqcWdGBd26gRi6Ssr8XUukIwC
         Qs+k0N/LMU9+OSMQBrj0o9AxDbRoy8fMqfIFYF2uQPPKZ5llIqtCyw8rw073UUQjAPPE
         ABJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/M7aDOH/qGCjs9lVwYHlVEwpsAApNAGVOZKD3ahzUuQ=;
        b=Q1fZ3kpTUIGF97l8KKO2AYtIAccm/7LY/oEiaq0GgA6tXwJax59k4zC0kjmJUkarnW
         9RU4nRQkm8/+pmScATvKuYIC3nl4yzOzXhs863As/YVQTVr+eppsITdYgEVt1kn41B69
         +Ut+565lU1k5meingsak+aGHsiKjdkuM5Qeq6U0OTL5SqHpWUgaiDkJ+39peAZRNNxbX
         AVmXJ1Kg65Gu9wGMMLTsmAIGzUHjVWD1KmU+B1JiPe9vmdQv80TqFP7CFnyEXfq9olGR
         u3aGPmzehbrwlbl4CWQS5AKsdcWB1VkIOWBd1O+IhqxOA3SjOxJOA76PWXmTdLQarql6
         E7bg==
X-Gm-Message-State: ANoB5pkeaUX1/l5hJmpfmG0M7KjBIDr3yUjy4eu19ximG9kCknRw/HVE
        TNkHUZVOPFe0qeFTgRtnpXg=
X-Google-Smtp-Source: AA0mqf5ru8h/nOgdCusmzUFw+sibQbgtP6oabpN5X1rY40fSPo9N9qSdlT1MBbf08uscyvrLaGGM1A==
X-Received: by 2002:a17:90a:5184:b0:219:b79d:c2f4 with SMTP id u4-20020a17090a518400b00219b79dc2f4mr1145859pjh.18.1670454116513;
        Wed, 07 Dec 2022 15:01:56 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm5411033pjb.1.2022.12.07.15.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:01:56 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/3] Convert deactivate_page() to deactivate_folio()
Date:   Wed,  7 Dec 2022 15:01:49 -0800
Message-Id: <20221207230152.22938-1-vishal.moola@gmail.com>
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
converts deactivate_page() to folio_deactivate() which takes in a folio.

---
v2:
  Fix a compilation issue
  Some minor rewording of comments/descriptions

Vishal Moola (Oracle) (3):
  madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
  mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
  mm/swap: Convert deactivate_page() to folio_deactivate()

 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     | 11 ++++--
 mm/madvise.c         | 88 ++++++++++++++++++++++----------------------
 mm/swap.c            | 14 +++----
 4 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.38.1

