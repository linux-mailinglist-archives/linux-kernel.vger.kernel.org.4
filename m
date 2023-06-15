Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFAE731998
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbjFONKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245176AbjFONKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:10:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39DA26B8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b3d44e3d1cso35395675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834624; x=1689426624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXvs5CAjk5TQfpxZcN1SVUwEQr5thYQQkIy4eu1cKz0=;
        b=RV2h43lCBIpd+JQ1QBvekx843b3WvoIJr6wHrq0JI5wMyDj2jBKrdigEYL5VNDwCTV
         4j/Hj92gFiOTX7NhmtbTsbpaWHdE/hUVm8EEkGUvHNfvjMV7HJPVfaTQGqE5YdMNsrOB
         sVh5ZGjUpQumjYbpPid6yuWGcL2GCVIl+shrOHIxckYbyvz9UJCMsTjTrlwq52X1P/df
         vyQsAxNjMGELNj9tofppoB7fdC/Q+RWJfnEolevbToS7tloeDnqCpui7/uabiIRFFReh
         G7puS9ssua7Bku1hQxOq8rnqrDCGy+acN9WBzdnucgFsx07+duZQ5+0zlKNc3BOTgBMV
         NmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834624; x=1689426624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXvs5CAjk5TQfpxZcN1SVUwEQr5thYQQkIy4eu1cKz0=;
        b=FJdyZWXuSbn2vSwYED9SnP3eBCiOsnlDPWmcKClYlhYzVqwJ6BHAwLhxusy4m/qycD
         l4fB9NbhvfzolOfs7hT5lZ3XLmUhhlCFp7wQtAHkIwSSIrubrfxEvFl5We+f7GVIWJvB
         pRZDvSygX3e3PJZYePrcAxdDY/B8ntRha6Zl66XwSENbe+AsgShcZW8mn30WaUQmrtEf
         lpCqh55i7YDeYvJJSG+I1uOUSbbrL8HdHJMuk+CgTWaBKgYEQs7n7swMzqMkHSi63hST
         UwgStvPOAx9Y1NWxKdxyoY65bCW9xQSE5MgC9969qpXgQbep0BX7IuyyRMzlJLvee3nv
         M7gA==
X-Gm-Message-State: AC+VfDzO/IcQWv01yW5X+YcUdlBdENAjFuuLLGH98fwyhWx6/81NNlTI
        Kw1s8P+TkAfIXXuA1vWcXqbY8g==
X-Google-Smtp-Source: ACHHUZ716R0pYefPRHce92V7xY4eImzci9R43HqbMWSfEN1fhNfPWRD59M43fLCZSsnUdFxlMoxg8w==
X-Received: by 2002:a17:903:120c:b0:1a5:150f:8558 with SMTP id l12-20020a170903120c00b001a5150f8558mr17037997plh.17.1686834624156;
        Thu, 15 Jun 2023 06:10:24 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001a804b16e38sm14036019plr.150.2023.06.15.06.10.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 06:10:12 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 0/8] Improve the validation for maple tree and some cleanup
Date:   Thu, 15 Jun 2023 21:08:51 +0800
Message-Id: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches do the following:
001 - 002: Small cleanup to maple tree.
003 - 006: Improve the validation for maple tree.
007 - 008: Drop some functions that will no longer be used.

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
 lib/maple_tree.c           | 246 +++++++++++--------------------------
 2 files changed, 69 insertions(+), 179 deletions(-)

-- 
2.20.1

