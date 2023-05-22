Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510DA70B451
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjEVFHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjEVFHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:07:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868FB8F
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d18d772bdso4779247b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732038; x=1687324038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l2QTyOP0QbQCu+WMHoE79eLdHJF0pmz10ZOb+Q1hT2Y=;
        b=fVNV61eydTd98Le4VONZty3UvmTb+OmGs1nl9+5tJYPuOTjZLSwu+2V4+JtQKxfeH+
         qyx26su7uAYlPs6+TT+HdbF7D8V3WkqdOxlmLXpzUAN1YcvA9VjdaeF4bAeoooyl8NXz
         aHVnkz9jByWwZ66rmNY7F088HLIXv1I1tAiDo/0C2DS5QR+zJQJSXPTiXmcvMWop2jam
         GMBGYAkpUEMmovLLjFAT1T0gu13agecDyWS11FmgX2tJSyNyPqKSJDsM8eosnOR6BJ/5
         J08iAIOfB7DYoPX89M3NcMXdKpG0gPqxECQ+bqcVkR60o3hzdSIxA3VZG1JD9KpYGGsn
         4BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732038; x=1687324038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2QTyOP0QbQCu+WMHoE79eLdHJF0pmz10ZOb+Q1hT2Y=;
        b=NDBDMjk6am/38+45xD06IN9ejRY0aD4sc6AeUwWDfce94l7IOxcSC32oDOYNZ4CKAq
         r56+d5WoWMrnNljb5U1YFAx6qtu8Co/zbh51vo6RYEGfI++Zm6Pfi9iPnHDov/2LrgNp
         89J7yzIUt0aiAnNGVcuUVDeIdSf9bLYxT3UgIWUG0EwO2f8wXRx9qKfloaYrzPWuFMey
         HNX0QC3PHzwcfF/h3cWlA/kDQ4BjVDfinOcZcx3NfM1Y2MhQA6NixyQ4Srl6imOYGqcZ
         fsEe94y3ZY5z8pNckbEUSKES1tRaoqRu38sGvxpuHfyAMkl5bdvYAd1gGa9tQTFK5FMr
         IkeQ==
X-Gm-Message-State: AC+VfDxWZF/hyOUrP5CSryCBJ/aRwLQ2MZG23SHQrEJglSnoQ1nZk6u7
        llHAbQXIzbYs1Sn+haeR0mCpqQ==
X-Google-Smtp-Source: ACHHUZ6O2qJ430fCUDN0i9410vv6naqgf3j6H6sAGdTabKFvB47G+n7TKJbjaxANv3bNwz1/FWGLaQ==
X-Received: by 2002:a05:6a00:1803:b0:63a:ea82:b7b7 with SMTP id y3-20020a056a00180300b0063aea82b7b7mr11513126pfa.28.1684732038020;
        Sun, 21 May 2023 22:07:18 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:17 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 00/10] Clean ups for maple tree
Date:   Mon, 22 May 2023 13:06:46 +0800
Message-Id: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
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

0006-0009 - Make mas_wr_modify() and its subfunctions clearer. Make the
            store operation of maple tree more efficient in some cases.

Changes since v2:
 - Change the error detection method. [01/10]
 - Add blank line after some if statement.
 - Fine tune the code of mas_is_span_wr() [04/10]
 - Remove unreachable blocks of code and make
   changes to the relevant code. [07/10] [08/10]

v1: https://lore.kernel.org/lkml/20230515131757.60035-1-zhangpeng.00@bytedance.com/
v2: https://lore.kernel.org/lkml/20230517085809.86522-1-zhangpeng.00@bytedance.com/

Peng Zhang (10):
  maple_tree: Rework mtree_alloc_{range,rrange}()
  maple_tree: Drop mas_{rev_}alloc() and mas_fill_gap()
  maple_tree: Fix the arguments to __must_hold()
  maple_tree: Simplify mas_is_span_wr()
  maple_tree: Make the code symmetrical in mas_wr_extend_null()
  maple_tree: Add mas_wr_new_end() to calculate new_end accurately
  maple_tree: Add comments and some minor cleanups to mas_wr_append()
  maple_tree: Rework mas_wr_slot_store() to be cleaner and more
    efficient.
  maple_tree: Simplify and clean up mas_wr_node_store()
  maple_tree: Relocate the declaration of mas_empty_area_rev().

 include/linux/maple_tree.h |  12 +-
 lib/maple_tree.c           | 451 +++++++++++++------------------------
 2 files changed, 157 insertions(+), 306 deletions(-)

-- 
2.20.1

