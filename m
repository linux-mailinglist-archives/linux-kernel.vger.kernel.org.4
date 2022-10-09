Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AD75F88D1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJICSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJICSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:18:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE56357FB
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:18:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 10so7749786pli.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 19:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5a/DovPCD12eZJTVKdniqOPRiNNYGTTOdUFZS0hw8WI=;
        b=iAVupyDZOWfN+dPvM/5OKfpMjx92BJ53/PhY5wJaaqL/cPKG7czwPdubp/uV/hQPH1
         ZmeIH1XI/gX6y/M0aXE/h6gQrsNH9yHEIX+xwLVEcXEZmWkeZ3p3F2rIzSKpoNSh2LDF
         Jz4xwn/yJG8UHDRgf9Db80aSfy19GDU4kcRuno1grEos/JRZ3JGsDOPI4qXO6kvyeAHo
         gp6fGfKr5i2Y5Y0LF1K7JAOrB3dWP9M3Nz6CTjGlo0E+U4BQfQQX8Xc0nEo+ZbiYcNb5
         blLJ+BfhKtr/66vQ7IAnyvd0ZYJ+wFo9W5IGApFoumqjESaVQ2By2BprhlURH96WUBvO
         vi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5a/DovPCD12eZJTVKdniqOPRiNNYGTTOdUFZS0hw8WI=;
        b=JzZB/3yEetbAH5LJF3G4UPpIaPhGhFi3Egl4MaD9UazUnTgerfGPeXOt4YMStakas4
         2tlpcfja75hpXex4DkRsQ3Sc85jJ2JZjtFccqdSDlvf9lOATB8eBr/wKcp9dMmwBhF99
         vtDk+N3Px2CzJHw4lwbnNroDIEnq+WXL68hmsx7lnjTrRF2+EDtiSzfiF2j6Cln31/bR
         aGEPlqhqsgDrFrKiUZ5Eh7TDERBKSA6L2gmuQjCZSqtQp70SOa0l3SkQV+t0pzDZimbc
         j/WcwFjMHSA5hhFu8vcGot/ss4prXfE83O8i4e2wreVIHNm843m+l9AnreLo3McLlvtW
         aiIA==
X-Gm-Message-State: ACrzQf3pNkiefsqbM7mJZIy+D69V40Q/TsKLPqUq3Uci2a7Cg5X6NY13
        mVrs7gdMQvrF6TeYytDCB8A=
X-Google-Smtp-Source: AMsMyM7lqrOf8pZtc3CkeRa6rrH75Q2UE5YymHX6vWFwtpN52RnxJsbKP1beXYpak+vSGKRU0nMQSQ==
X-Received: by 2002:a17:903:2445:b0:17c:f033:92f5 with SMTP id l5-20020a170903244500b0017cf03392f5mr12371293pls.31.1665281910753;
        Sat, 08 Oct 2022 19:18:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709029a0800b001708c4ebbaesm3823607plp.309.2022.10.08.19.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 19:18:30 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     ran.xiaokai@zte.com.cn, yang.yang29@zte.com.cn,
        jiang.xuexin@zte.com.cn, imbrenda@linux.ibm.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH v2 0/5] ksm: support tracking KSM-placed zero-pages
Date:   Sun,  9 Oct 2022 02:18:16 +0000
Message-Id: <20221009021816.315205-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
when enabling use_zero_pages, all empty pages that are merged with
kernel zero page are not counted in pages_sharing or pages_shared.
That is because these empty pages are merged with zero-pages then no
longer managed by KSM, which leads to two issues at least:

1) MADV_UNMERGEABLE and other ways to trigger unsharing will *not*
   unshare the shared zeropage as placed by KSM (which is against the 
   MADV_UNMERGEABLE documentation at least); see the link:
   https://lore.kernel.org/lkml/4a3daba6-18f9-d252-697c-197f65578c44@redhat.com/

2) we cannot know how many pages are zero pages placed by KSM when
   enabling use_zero_pages, which leads to KSM not being transparent
   with all actual merged pages by KSM.

With the patch series, we can unshare zero-pages(KSM-placed) accurately
and count ksm zero pages.

---
v1->v2:

[patch 4/5] fix build warning, mm/ksm.c:550, misleading indentation; statement 
'rmap_item->mm->ksm_zero_pages_sharing--;' is not part of the previous 'if'.



*** BLURB HERE ***

xu xin (5):
  ksm: abstract the function try_to_get_old_rmap_item
  ksm: support unsharing zero pages placed by KSM
  ksm: count all zero pages placed by KSM
  ksm: count zero pages for each process
  ksm: add zero_pages_sharing documentation

 Documentation/admin-guide/mm/ksm.rst |  10 +-
 fs/proc/base.c                       |   1 +
 include/linux/mm_types.h             |   7 +-
 mm/ksm.c                             | 177 +++++++++++++++++++++------
 4 files changed, 157 insertions(+), 38 deletions(-)

-- 
2.25.1

