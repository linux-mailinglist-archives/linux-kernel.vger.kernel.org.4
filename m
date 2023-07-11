Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D236574E58D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjGKDzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjGKDzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:55:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B91A2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:54:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8b318c5a7so38828545ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689047698; x=1691639698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZOGU4heI4nfKEgQzYHYG+CvttaFlbdv5Wyw3YDD8vk=;
        b=VFodhLlAppvFUDByEsIICPzpQnUF4Pl3ZPr1W5KpYkgn/rmm2y2bG3/q7O2b7VV1m5
         KPRnBjlJPUXOkOC5Hs2bgXGdyoAC7REerJGkK6MW08fPQqzI6WFgshtOJkrqF6rXbRdN
         kS1P+Su0k/hLhdl3vsLtS8T846Hwit1m57c+9sng+yX1DMaBsNjLnIPjAFS0Fz4iEYvs
         QdK+EKD00+LzFQ7OXw+H9oXvWLY7lbcBGvpNpQofXq717Y6pX3DiERnJLEuqXmnYfFeY
         oZ4+o9tyN3QWi6COzjazDZ0lKHvZFSex2CGFtHe29yxy2b4cyEjcC93ETuuTJGz2IUod
         FSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047698; x=1691639698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZOGU4heI4nfKEgQzYHYG+CvttaFlbdv5Wyw3YDD8vk=;
        b=C5h/hz2wpgEvNQ0I2BtaV1wcmPLzOuPxHzp3jvnseMlQHo3LaiONjEFTjTKjOSholD
         naPIPmZTWg1FRB8B7RqqSZebPWhTCqD6M20EMI9csy3JAvqABtfPxR+I5srSZESyJrsr
         CkUyMUw3j1ZqO+3O9/K+hAPp30tBgwatbywS/apl1KoUrUpvfZJ6irV7wWYsqgUCYmH1
         x9WWJNwEsfJfM2ozVbpFGDK9bOK/vZmxaP2DaZBszn0JWUAvYwYJuPRBeWUUEJNCP2qn
         KDWn9I1whEjaCJM1117b9d+a2IFzdxEFDko13hSlRLRMu5OYJG9qwDOOIJIKE6hwHdyh
         O+Pg==
X-Gm-Message-State: ABy/qLYuLsyUzlNem1krNqdGsVZDZi5+MC63XLoZpZe3EnvyGnd9dyJQ
        uB3zxw2ml6oM2+DDQ2eKBIXEww==
X-Google-Smtp-Source: APBJJlHOL8iqoglMNLGSn7jzQVMv0P3Opsf08qBzte06HqvSmggKQKrbgDun7HTR0SV8WvCoor3b+A==
X-Received: by 2002:a17:902:d3c6:b0:1b8:90bd:d157 with SMTP id w6-20020a170902d3c600b001b890bdd157mr13620566plb.26.1689047698539;
        Mon, 10 Jul 2023 20:54:58 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001b872c17535sm688329plh.13.2023.07.10.20.54.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jul 2023 20:54:58 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 0/8] Improve the validation for maple tree and some cleanup
Date:   Tue, 11 Jul 2023 11:54:36 +0800
Message-Id: <20230711035444.526-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches do the following:
001 - 002: Small cleanup to maple tree.
003 - 006: Improve the validation for maple tree.
007 - 008: Drop some functions that will no longer be used.

Thanks Liam for the review.

Changes since v1:
 - Add fixes tag and the necessary Cc. [1/8]
 - Add the verification that gaps beyond the node limit are zero. [3/8]
 - Revise comment. [5/8]
 - Reformat the code. [6/8]

Peng Zhang (8):
  maple_tree: set the node limit when creating a new root node
  maple_tree: don't use MAPLE_ARANGE64_META_MAX to indicate no gap
  maple_tree: make mas_validate_gaps() to check metadata
  maple_tree: fix mas_validate_child_slot() to check last missed slot
  maple_tree: make mas_validate_limits() check root node and node limit
  maple_tree: update mt_validate()
  maple_tree: replace mas_logical_pivot() with mas_safe_pivot()
  maple_tree: drop mas_first_entry()

 include/linux/maple_tree.h |   2 -
 lib/maple_tree.c           | 258 ++++++++++++-------------------------
 2 files changed, 79 insertions(+), 181 deletions(-)

-- 
2.20.1

