Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1C731285
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbjFOIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241049AbjFOIne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:43:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF17C2695
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6664e4d8fb4so1212581b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686818589; x=1689410589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+bDN9iklFF/86ce+oPNSVCYPYiJrmlJzMuqyt9nX5o=;
        b=K3VbDUKxfW83+DEvn4rsfcapW299oJpQAsgELcRCXsTVFxhXlekAGxdg83EmeXXzNw
         qqsfXFUj1GmlYY2dc7xyZb5uXz847X+gbNTMhOsyiUXr6yZDTNEKQJ64f7UBA/TYZn+b
         xMzpD1oZiSVZxVYdMiD0IoiKzLM8z3ESEo/Tg4at3HQjP8JqWIQuQ8guU+RnPhTpWnQC
         x2zNuBMvhuNj3Ifvhi5qwGO8FcrH6u4HFP9/KNeqhnRfR6b4MUnMS4vkqNVjGwBJYXld
         T6Igf9QqXnDao+MCpFWs1wbfxJZI96d3w8mVgLcPj1yhjnQLU0ejgUfClYHIxZuYFcFL
         YrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818589; x=1689410589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+bDN9iklFF/86ce+oPNSVCYPYiJrmlJzMuqyt9nX5o=;
        b=DK/K1ZDESp7l7vRt6flkMF8sKnnxUiLVoce9Gp1ZxsimS2jIM9Se4QX1ZI1Zn04hQP
         odC5C81Z4htupCpd+9M0nrVe+NMH+fzvqLPaGu9lcIn+Oxa1Sm8m8/u4ANJjmSFY5HmY
         xcAlVBBVmq7qMbO4YmuegCHcd/70cJWz884VrpXYSPcgd3LCYTI1QfDvNcKkkCyASlP3
         WrrbAt+Y4h5uWrkOt6YlRcfCC8ynWAdHGHTLuCaGjJrefGPVEbIR8d05Q15FDkr9XrEs
         onJ/lRJqc0IdV1GSf0VZnNSoJbaryuXBAYeZ6Ni9iBDNeSdzGgdgec7h6u2Vm4bzBMhx
         /qbw==
X-Gm-Message-State: AC+VfDznpq0nVTy6waK+EF2ljzznI944eb7lWyro/M9Ss6GYQbHaVKOZ
        LezSic73l+vlEpbqt52P1jxV7g==
X-Google-Smtp-Source: ACHHUZ5swGm0ZAv9wRJ//osArlRAwIoHqPkH/Wvsjjf16/jySAnIU5Oywv6OhF9QARwwQeWCm6Z69g==
X-Received: by 2002:a05:6a00:881:b0:64d:1451:8224 with SMTP id q1-20020a056a00088100b0064d14518224mr4643699pfj.22.1686818589299;
        Thu, 15 Jun 2023 01:43:09 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i21-20020aa78b55000000b0064fe06fe712sm11139783pfd.129.2023.06.15.01.43.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 01:43:08 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 0/4] Optimize the fast path of mas_store()
Date:   Thu, 15 Jun 2023 16:42:57 +0800
Message-Id: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
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

Add fast paths for mas_wr_append() and mas_wr_slot_store() respectively.
The newly added fast path of mas_wr_append() is used in fork() and how
much it benefits fork() depends on how many VMAs are duplicated.

Changes since v2:
 - Add test for expanding range in RCU mode. [2/4]

v1: https://lore.kernel.org/lkml/20230602075353.5917-1-zhangpeng.00@bytedance.com/
v2: https://lore.kernel.org/lkml/20230609120347.63936-1-zhangpeng.00@bytedance.com/

Peng Zhang (4):
  maple_tree: add test for mas_wr_modify() fast path
  maple_tree: add test for expanding range in RCU mode
  maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
  maple_tree: add a fast path case in mas_wr_slot_store()

 lib/maple_tree.c                 | 69 +++++++++++++++++++----------
 lib/test_maple_tree.c            | 65 +++++++++++++++++++++++++++
 tools/testing/radix-tree/maple.c | 75 ++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 23 deletions(-)

-- 
2.20.1

