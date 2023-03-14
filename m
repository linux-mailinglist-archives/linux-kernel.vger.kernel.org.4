Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F316B942C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjCNMnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjCNMmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:42:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818C94F71
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:42:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c10so9590697pfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678797735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdc7UbNBneHho9oqmigekem1agGN/vBMBnNuJZM71Vw=;
        b=Lc4umaDTjOtkaLSsPc4M1IXUWPNZbqF5+yTINoM2IU/nhV4oARdpcU496yWvlohvRx
         rXsWb7j1wHmB2KIu6/AeKZAlEP3K4OwrVb0zmGG0ppXvUSzPgWkas1X5VSfaJTIqM1LR
         aPSlnmD5fkZT5PDs8UwHP4gLsNxpHotEjCj72aaJJeW41fmMZ7RtDgBo6XzThJC2U4za
         QwUlryeriPMTLlE28OTqxTeieaxWGojXBRjf/oH+kOg4l5PRXEIJFF744U6lOkEuqK6o
         NxabJczCwNOPnMXPHJ1KXGw+mFMQeaIw4ipNYBe75FDrl+KWubWCrFRXx7Z2yP3KcEVh
         uJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678797735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdc7UbNBneHho9oqmigekem1agGN/vBMBnNuJZM71Vw=;
        b=Q9WARMB5UfHM0v/8eiwQ7MhuBNK4oJ/MpldxCXqr8Y1cAeYe61GS461OMe8Pq2xnHf
         Zb4foW3e6xBDGVdit/hkGvAgcvQa9yPXw71a0jEQ/gyDelIqSveMaSFfHp8ncW5K2eFz
         JNhthnzs5/Fpo247PGD3HC+Fexlf/fohYWSija0T3VS0upeEwbb8WkGPLYkHxIccgpCG
         gbdAgmXWU35OddDr+F9tOZ73vBxUo+gcfllBm8b0CNSV+fs+VfZkGSMHP3PhHVL0QEQ7
         pWx04puUS+3lLI7YkCPBe0nv0vtHm2TN1ALMU3iQUsqA2erzGLiM2IlTFjciukGuSMfV
         jwzQ==
X-Gm-Message-State: AO0yUKX5wLZVo+te5+VNDuMAYbzzw5bdspW2cAqcqlyURuDvh47/Ix1f
        dme0Dna1XEL+FHFp132YMHLsptsWdbXuB376Ok4=
X-Google-Smtp-Source: AK7set9NbkFaKM3mIDwG+DR65lCy0qwYWOEvpNHAETvz3oGZOdr5D7ZbxTiZAQhaf7632ArGyBDNnQ==
X-Received: by 2002:aa7:968e:0:b0:5aa:72c6:4a7d with SMTP id f14-20020aa7968e000000b005aa72c64a7dmr15664029pfk.16.1678797735679;
        Tue, 14 Mar 2023 05:42:15 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7828b000000b005ded5d2d571sm1509385pfm.185.2023.03.14.05.42.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Mar 2023 05:42:15 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 0/3] Some fixes and cleanup for maple tree.
Date:   Tue, 14 Mar 2023 20:42:00 +0800
Message-Id: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fixes and clean up for maple tree.

The bug fixed by [PATCH v2 1/3] does not seem to be triggered due to some
coincidences, because now the implementation of mtree_lookup_walk() scans
pivots one by one and exits the loop early. The test cases for the bugs fixed by
[PATCH v2 3/3] are difficult to write. If I think of how to write them later,
I will send them out. So I send out the second edition first.

Changes since v1:
 - drop [PATCH 4/4]
 - update the commit message of [PATCH 2/4]
 - collect Reviewed-bys
 - add fixes tags

Peng Zhang (3):
  maple_tree: Fix get wrong data_end in mtree_lookup_walk()
  maple_tree: Simplify mas_wr_node_walk()
  maple_tree: Fix a potential concurrency bug in RCU mode

 lib/maple_tree.c | 52 ++++++++++--------------------------------------
 1 file changed, 11 insertions(+), 41 deletions(-)

-- 
2.20.1
