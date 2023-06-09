Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF407298FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbjFIMFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbjFIME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:04:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5D730FB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:04:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-662f0feafb2so1317702b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686312272; x=1688904272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lp6OV13Bt/hNYfWu+dUWpmpBFuOi+D6XcFIiA8tjOKg=;
        b=PRc3ZLG9xumYTe3iNTpYxXmSIfnSJd3hDh7S5Kbt9/Im5mvIeUsyviNVibu6klxK4i
         A2qhQgXsIsD4vx5O6T/e9xkVtT6XySDs3rp6HVIU+P2iyuE/6ugFVGT+GJQTll5OkUnD
         nrc65hI+bajJDfpIq0Yfm8XovTN0AiqZnU7deGI0gtJ8C8lqDPzdxBx47MVXwRmtj1OF
         T3g2sr5SU8kShraGEVEpWfve2NHe5Q/eje488uWjHo2du6l4xBVDNYChX2pON9axAJd8
         i96aK6DqlBqd7CvDHL8aMoabvlhd5FYQDMh6jDiaTfH9EPUe9ZzmC0CXSqgV1hYezvPc
         JXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312272; x=1688904272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lp6OV13Bt/hNYfWu+dUWpmpBFuOi+D6XcFIiA8tjOKg=;
        b=ZVbHZkMA5pOovsXD6M1BEGS6d23iK+bQWXJzrVeFFrzQZvCtkRXJCf1j5WzBKZ0nq1
         9gKxvptu0JDo+YnZRPjSOc7Wq+ucjLJhUcYlYQZv3AXYfBvy965yilpGfAgqCZ4q15Bd
         P3q9zFj/040JN1jyyhXFXR8AtRpNvUhk/EtRWbq7AyaMnq7PCSGrlwfo4bC/mRT5O3bc
         qOLmWTO7HljwUEjvC43c2YkHjDVArz8jBKEa+JTQQU8YOlEG/cHM/i9I59wsiUN50w4T
         pm0BlbaKJ/1m0YtNMOvC7RgRbSY2lpd2nrJf6BT6lTGp+Hj+GMD3WcB+2GPxg9Vzol/q
         OCrw==
X-Gm-Message-State: AC+VfDxUKPA7351v3Zo9hXZsyXwHZblhlWJ9IWN5F2c4Naf7tVeuhAm3
        6X7mdcwhSQPhTHarxo+o2JmnSQ==
X-Google-Smtp-Source: ACHHUZ4OD6GZXbvCpliG4gL749ujSXX9biD9kK3KxajdWPsOXlBfI8UPCGzSFWI56XgAwmROj6qpJg==
X-Received: by 2002:a05:6a20:3947:b0:10c:2c30:4765 with SMTP id r7-20020a056a20394700b0010c2c304765mr2091168pzg.1.1686312271708;
        Fri, 09 Jun 2023 05:04:31 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id v12-20020a65568c000000b00514256c05c2sm2619168pgs.7.2023.06.09.05.04.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jun 2023 05:04:31 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 0/3] Optimize the fast path of mas_store()
Date:   Fri,  9 Jun 2023 20:03:44 +0800
Message-Id: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
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

Add fast paths for mas_wr_append() and mas_wr_slot_store() respectively.
The newly added fast path of mas_wr_append() is used in fork() and how
much it benefits fork() depends on how many VMAs are duplicated.

Changes since v1:
 - Revise comment and commit log. [3/3]
 - Add test for mas_wr_modify() fast path. [1/3]

v1: https://lore.kernel.org/lkml/20230602075353.5917-1-zhangpeng.00@bytedance.com/

Peng Zhang (3):
  maple_tree: add test for mas_wr_modify() fast path
  maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
  maple_tree: add a fast path case in mas_wr_slot_store()

 lib/maple_tree.c      | 69 ++++++++++++++++++++++++++++---------------
 lib/test_maple_tree.c | 65 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 23 deletions(-)

-- 
2.20.1

