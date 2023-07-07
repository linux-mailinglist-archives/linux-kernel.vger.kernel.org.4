Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE3974AE8B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGGKLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGGKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:11:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA8990
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:11:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666edfc50deso1192147b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688724672; x=1691316672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXvs5CAjk5TQfpxZcN1SVUwEQr5thYQQkIy4eu1cKz0=;
        b=PqZrukRkPbofvCLqz24T770w20wVKpkEsIWTbhQDDqOjHUGtBYQDjPP6xk2HOnHZVd
         LMKNzLx9MNB26CX95gIivk7G/zRK8A0pl4oKcLdXviu3xBkcMe1UnU78fxX5w3X/07rv
         XOcIGC2ti+Y8iZLEtOKZMDlNqdvxe6z2vpcNszwBqmhKTLb2nIeMUGtkBw2hFsiFSHEa
         72KpTKCLDplSFRQmhK7CIdz3v81tIu2l4yMuvs244q6BAnty+HpHubpry3yU01YjCeTJ
         Zn3wWWlTnKjjes0796atLGv9mWQalUSZOuEZ7BNXeFEhaIOTOrO0oJFOtV68ZkXEmz/R
         XRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724672; x=1691316672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXvs5CAjk5TQfpxZcN1SVUwEQr5thYQQkIy4eu1cKz0=;
        b=IRvt23VenNF2PlhzROsvdFQHGtdwelO/k72wsHaH1Rqnv8XNe2fS6UY8QldJV10JPk
         5KtY8MpoOhLRuaUHfzr03wlTw36FurYdWiznhvf0yyiQgWcjqtZi5g/wBuYBcx6DhodD
         WAwtXLBpS2KD36b1fZO9258m3NhywkNQKUqsmsNNxlUytV1EdOkQdJd0oQl4+XDrtV7h
         WVpJykt0BQ+DR6seml3roT4C77Ml7AhtJlxDEs8p6SORHTryEgnTqbkBRGMmuKsepbPm
         X0z6Dl0ETCxHs6I47EoePLIHzE1t5wejJuuv/c1Das0XkA1hfIqC1jkgf0RCG8Rh2w8Y
         3fPw==
X-Gm-Message-State: ABy/qLZOga9CZ8M6nWKacq2vyqBqxT3QbsFiCg7QMPQZD7svv9/8+5HX
        pPg0W27kFig4lJtVeDOBmVyfwjB6/ENFCnqUb3o=
X-Google-Smtp-Source: APBJJlFwvn/4qAItZTGRM9Qc3BBujHONUIgbUd101BIiX6OZKDSDwGauz88Csn7AW0g3PZxaEDM/5Q==
X-Received: by 2002:a05:6a00:39a9:b0:67b:77e7:f467 with SMTP id fi41-20020a056a0039a900b0067b77e7f467mr13447624pfb.16.1688724671876;
        Fri, 07 Jul 2023 03:11:11 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b0068288aaf23esm2602549pfv.100.2023.07.07.03.11.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jul 2023 03:11:11 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH 0/8] Improve the validation for maple tree and some cleanup
Date:   Fri,  7 Jul 2023 18:10:49 +0800
Message-Id: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
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

