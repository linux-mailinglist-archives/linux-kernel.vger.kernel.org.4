Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD470EBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbjEXDNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbjEXDNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:13:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA44A1A1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae875bf125so3278635ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684897993; x=1687489993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ehFVUCQoe0lDEMgZdM37gF761S3HqmSPrdoblvRhjJU=;
        b=eIFUsO9wpFreIAkMXyT7pbX4UOjLCQhiGOVJOMRUlgPjojng4L26qyTe3qUSI0q6Io
         z95OPvZKjKH+5ZbkJPEYlZFmhaj227n8JlUVOZc06PI9yius9E+mmIPuYMHKnUWaga2C
         FYpPmqSuPErzFcHG0Woh3y67TDPML4rptqWzDRvpRfFafo0Q3bY5RReikYsaAKvxpfU0
         ok3v4KMhHps1qm4nlZEtp5Tj93fU1pnI6xM4CYu5TNDlE2QIttg899UPwOF5N3Ea6ow3
         Z1ITHWbKU4AHfMFfozHoXBnJ5uxJWwidGbGQqoG5fFkcVfAipFxkrsY+IKdqaB5TbTUR
         sW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684897993; x=1687489993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehFVUCQoe0lDEMgZdM37gF761S3HqmSPrdoblvRhjJU=;
        b=Y+77H0VQubwiFb6RKvokBgUt1BGGnn4A+Nverx13Fs8NlJVTf9FqLK+TlOUqYrQrL+
         qaGk64KqC9RVU3TWEpjhKPmJ1/JFl5Vz6jmW2InEi5kgpnMUyvcAiQn0CUhal1k9SeZi
         NICuiVQoEMhYTIouEJNGHAOGG2nduT8YnCTs4koT3RqkzJYJPe9Sfpr0wg97hktUNbxd
         ZZhbA+lVxczKt7URqukED4K0qzSS7uEekuZScpOyfvTxLJc+WCjoqds+hgTTPsIJmLnX
         Urf9XEm1b3E19R7s9tlIleyViUJg4iRVhWW/f6BPV+E0pygKNWsyxklvudvdRGr5vbL3
         c1rQ==
X-Gm-Message-State: AC+VfDw19kBDb3E/nOiYhaKBnvDDisEc/zL/spD559GleFdNtjl0mSuc
        f4DMURXkwvR072aDsOAJPMuxQg==
X-Google-Smtp-Source: ACHHUZ6f1cTVv277UYDqaOEipnKI6G88giFIYNl8ZTh4J8+SEYLRXiOs95/jKog1hqBMQ9CQRwwysA==
X-Received: by 2002:a17:902:b705:b0:1ae:56ff:74a with SMTP id d5-20020a170902b70500b001ae56ff074amr13158950pls.58.1684897993191;
        Tue, 23 May 2023 20:13:13 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:12 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 00/10] Clean ups for maple tree
Date:   Wed, 24 May 2023 11:12:37 +0800
Message-Id: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clean ups, mainly to make the code of maple tree more concise.
This patchset has passed the self-test.

Thanks Liam for the review.

Changes since v3:
 - Modify the commit log [02/10] [08/10]
 - Remove some comments [04/10]

v1: https://lore.kernel.org/lkml/20230515131757.60035-1-zhangpeng.00@bytedance.com/
v2: https://lore.kernel.org/lkml/20230517085809.86522-1-zhangpeng.00@bytedance.com/
v3: https://lore.kernel.org/lkml/20230522050656.96215-1-zhangpeng.00@bytedance.com/

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
 lib/maple_tree.c           | 450 +++++++++++++------------------------
 2 files changed, 156 insertions(+), 306 deletions(-)

-- 
2.20.1

