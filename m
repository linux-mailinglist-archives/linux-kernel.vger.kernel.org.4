Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD19A5EF439
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiI2LXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiI2LXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:23:30 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC814B874
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:23:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 78so1151466pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=r/PBU5z71sX2zMZDTYPxe8Ov6/ObpI5wnc7fTRzYGJI=;
        b=nlAR3UGxJw8mM7U3ZP49KQZwp09SWSS7FhW6dBf4HidEuZsgQ/Qe95WCto0YTVWbHQ
         dh1g4q76lhuUSj/AwWyDqQXV1amXnFPSrR+FtGamyDYNbcxTeYHOW/wPfeFmAZ1MmFrL
         eUJjxWKYo2hCWHd6pATT+pHMHcgk4m6lexrZwqlsM1exSExC9K3yByiAPu2ec8swX0w1
         PS8NM1/BOUWB+5JOs8U6LsLtgmjm7F1yxrr4DT11ZB0ZxXv5mAbKHyZMSsGquEUR1XEe
         YGvDxd/6vct0eSWdw4BlaP0Kji/fn5FoRlFuO/6coi0aq6S5eEmhXvlCNyWb+HdY0xi1
         f1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=r/PBU5z71sX2zMZDTYPxe8Ov6/ObpI5wnc7fTRzYGJI=;
        b=oqQX8Johdt9+BIoZ1/L/Z/hLbuSQd1mPqyBzzn2CQGGvm7FtgHzR89ZYB5GQYbpYIT
         MLSYOzcqf8pVhhRexwKEH30MBrp7XdOs9mLNbUE5NojWasC1q2z8bba8mVsi/r5N/MEu
         02zFJBUwMADtM0Xw6btnMqB4RLeOm6C+lkJTUO+Co1FznWr69Yf5tBoYzd9lenkcJ52F
         kNCK1v6Y/83fcjdk8GMCvuMUzBxTSq3GC6rFhCDOVRFG9iLprn99rbntRNvfwpv5D5Za
         24A5n+LOE5xpYpxA1gA6r3+4T2P6Uj2Dhzz7AH1xYQUZt5DPMGInLpfPsCmJDW9g14BI
         z7dA==
X-Gm-Message-State: ACrzQf1SEQvaQER34vSXpk2eYuS/nkLjDYr9PMcCmlxWikFMnaCj43ub
        j7xBI7RtdfJMTL6JKYa0niIRZQ==
X-Google-Smtp-Source: AMsMyM4RKSiRyMbM0mV2FWs/Ku8dZ2NIcUEldNW0Z34ls1vE3MwhIWVSxdglMPZl2347wi/OIzIbBw==
X-Received: by 2002:a63:fc5b:0:b0:43c:3f90:ca07 with SMTP id r27-20020a63fc5b000000b0043c3f90ca07mr2576383pgk.110.1664450608825;
        Thu, 29 Sep 2022 04:23:28 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id i8-20020a655b88000000b00434651f9a96sm5225401pgr.15.2022.09.29.04.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 04:23:28 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, maobibo@loongson.cn,
        chenhuacai@loongson.cn, songmuchun@bytedance.com, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, chris@zankel.net, jcmvbkbc@gmail.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 0/2] use update_mmu_tlb() on the second thread
Date:   Thu, 29 Sep 2022 19:23:16 +0800
Message-Id: <20220929112318.32393-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://lore.kernel.org/lkml/20220924053239.91661-1-zhengqi.arch@bytedance.com/
v2: https://lore.kernel.org/linux-mm/20220926115621.13849-1-zhengqi.arch@bytedance.com/

Changelog in v2 -> v3:
 - implement update_mmu_tlb() for LoongArch (suggested by Bibo)

Changelog in v1 -> v2:
 - change the subject and commit message (David)

Qi Zheng (2):
  mm: use update_mmu_tlb() on the second thread
  LoongArch: update local TLB if PTE entry exists

 arch/loongarch/include/asm/pgtable.h | 3 +++
 mm/memory.c                          | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.20.1

