Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C645670EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjARAmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjARAl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:28 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED23C2B1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:33 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id z11-20020a6b5c0b000000b0070492cb751aso7580234ioh.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5YP4NYX9S7zVrVLE6QdkyuYEvdTIcKXOFJ/pF/J7aoo=;
        b=DiMuuKDUaQOWmEy1UBMBwe/WEcDFFi7wMWK0S7xtZv31BW4UQFj11yCkucyrd4fBuV
         TByB3DM7eQS7zzwog8470VEv2k1JUWnPhS56LhMF5GWuymbNZCPe2SxySZhLq23W4S3I
         v33snliHSMPz0cEd/7Jgl2rSY5NjnvM1c/cppzfTixKO3oVbMXq1WfGZnnoaBBU1SVDn
         l3xP8irHPvWGr13JZm+erNTVTC2D78Wy4b6fGa4/pquQy60cOonorJytYVT0D/GCajk6
         xfjCKXpnj9Nqht/S9SYSjo9Eh1g18ghyPi5nb4MG7PMFMXSia27z71p8CBOgBe+R7aIX
         F5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YP4NYX9S7zVrVLE6QdkyuYEvdTIcKXOFJ/pF/J7aoo=;
        b=2/4kPm3gQIhiTkijGDlVMlJLqCQE7AUveF8DmeTIZcQ584faQFyV59tCPjbtwZEwZk
         A7n8twg7ntfYjsDKBclxnph4bEeYjwqUhU+hygiqARq/ZdyCHMHgsk2G6w34XpPBQca7
         E2LS+I2GyWdpa402YoGGrPOuU1MttDK7+raEB7GVeg8gyZKlNXLlNxadfmQgN8KVinaC
         AKUxP+5MLNN+QlGbE20aNxWenXAaVwfTAuIzb+45rTJebvXE6AhRLjnAus2j652qKAqg
         4hK9M3fCg84/0muMRjaTjadJxHkgzcXMn8rSj8g1nRZLIFuWpAYfUmIamIRaOjqwbQbC
         7znw==
X-Gm-Message-State: AFqh2kqf6VVQrqOWbWbClHlvvA/W59Ok1rnNTrbvyQda/W2f4GzMylcN
        vTZNUel9wYKYnfSkERu5NAlRg6omQVpwyg==
X-Google-Smtp-Source: AMrXdXsFqr8HDqlUNMxYGuAtJ7EfwL5fmDPmzLylZfggQzUqT0acRAJN8EnLNioKK3h4K7SNaTq4Z2soq78ZFw==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a05:6638:279b:b0:3a5:93e:989a with SMTP
 id dl27-20020a056638279b00b003a5093e989amr439248jab.319.1674001112913; Tue,
 17 Jan 2023 16:18:32 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:18:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230118001827.1040870-1-talumbau@google.com>
Subject: [PATCH mm-unstable v1 0/7] mm: multi-gen LRU: improve
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves a few MGLRU functions, collects related
functions, and adds additional documentation.

T.J. Alumbaugh (7):
  mm: multi-gen LRU: section for working set protection
  mm: multi-gen LRU: section for rmap/PT walk feedback
  mm: multi-gen LRU: section for Bloom filters
  mm: multi-gen LRU: section for memcg LRU
  mm: multi-gen LRU: improve lru_gen_exit_memcg()
  mm: multi-gen LRU: improve walk_pmd_range()
  mm: multi-gen LRU: simplify lru_gen_look_around()

 Documentation/mm/multigen_lru.rst |  78 ++++-
 include/linux/mm_inline.h         |  17 -
 include/linux/mmzone.h            |  13 +-
 mm/memcontrol.c                   |   8 +-
 mm/vmscan.c                       | 534 ++++++++++++++++--------------
 5 files changed, 360 insertions(+), 290 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

