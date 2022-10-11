Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380725FAA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJKCU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKCUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:20:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271F759248
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:20:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id i6so6866933pli.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eW7DNlS16RoYLT6uJ2WK221+Zbzraxz3CxrZYCkWg6s=;
        b=DClq4d3tRxArm/g8fpYhcSWamPmA1Jukadx3EurAVBGfxfRbUXs/RmyhFWErNs6pMW
         5Lm38IISQuDDp5MoY8VbFJ72OC0EULNkeI9mmbGMrSJjAuAS64vYFDc9bnBnbt92GMBH
         O7G2jVQPS2LzaJlZD3JGZr4pZrAQkNUtXynlUy3hHoUv4D+dbefZpiMQZ5aoM7hDdcgu
         nx9a6K3oNW4GnJg7oAmlOscNoQ6Jg8pEmEgALYqLIuEpUvkcgF9R7dv7xzrTDSo9HDs5
         r1A03KUIC/YFMQ/cHl8c6pQ2LJ35jW8ngd79jB2POGOKwPhZ+UcJMdBuVFeKlUhc2DwU
         6zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eW7DNlS16RoYLT6uJ2WK221+Zbzraxz3CxrZYCkWg6s=;
        b=VsWrFUQ+ZUR1uqelWpzzEYl5UNJSfLRUAkRmPsOSsmDwB5osrShQbxb7LLeSG00Pki
         DewlXbIMGbZHOiBAWP3Zv5xrriqvE9VbKNr+xH9Glm9PxYpMnN8bjmkJ/5go4ZVchVM9
         x4uFckEZ9QOS6o1mcOsaOWEdDro2RvWtJulq+FQ9pP8Igqx71nUlj9TQIXhdxATcfwUW
         9dhmsMgL2IxxTlQiNvS82ICK2V4/5QvNX8ZWQuYH7MtP2DXz4XIC0HAgf6kHwmM3ttl8
         Z8v8G/C4r8eVqB5OQ1aixSUYCpFaKX6MiOPMgvWJzghviq8z0xliCvz9LEwKM7/kzEK2
         UVBQ==
X-Gm-Message-State: ACrzQf2vs88iF0A3UvWcrluLp1yGHAG1LWGIIbxxoma2GU5lsrVS7gWF
        VJBbiu8ucSWtlQdeUYDccJel3vug0TA=
X-Google-Smtp-Source: AMsMyM4db7aeAn3whyejbDBpKCgk18j+dGFcSbcbo7dxg9AmV24f3yLdmA1e41g7X7HL5ofBeMQN5w==
X-Received: by 2002:a17:902:b945:b0:181:c6b6:abc with SMTP id h5-20020a170902b94500b00181c6b60abcmr11342027pls.75.1665454821504;
        Mon, 10 Oct 2022 19:20:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902c41100b0017f8094a52asm7471998plk.29.2022.10.10.19.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:20:20 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     ran.xiaokai@zte.com.cn, yang.yang29@zte.com.cn,
        jiang.xuexin@zte.com.cn, imbrenda@linux.ibm.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH v3 0/5] ksm: support tracking KSM-placed zero-pages
Date:   Tue, 11 Oct 2022 02:20:06 +0000
Message-Id: <20221011022006.322158-1-xu.xin16@zte.com.cn>
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

use_zero_pages is good, not just because of cache colouring as described
in doc, but also because use_zero_pages can accelerate merging empty pages
when there are plenty of empty pages (full of zeros) as the time of
page-by-page comparisons (unstable_tree_search_insert) is saved.

But there is something to improve, that is, when enabling use_zero_pages,
all empty pages will be merged with kernel zero pages instead of with each
other as use_zero_pages is disabled, and then these zero-pages are no longer
managed and monitor by KSM, which leads to two issues at least:

1) MADV_UNMERGEABLE and other ways to trigger unsharing will *not*
   unshare the shared zeropage as placed by KSM (which is against the 
   MADV_UNMERGEABLE documentation at least); see the link:
   https://lore.kernel.org/lkml/4a3daba6-18f9-d252-697c-197f65578c44@redhat.com/

2) we cannot know how many pages are zero pages placed by KSM when
   enabling use_zero_pages, which leads to KSM not being transparent
   with all actual merged pages by KSM.

Zero pages may be the most common merged pages in actual environment(not only VM but
also including other application like containers). Enabling use_zero_pages in the
environment with plenty of empty pages(full of zeros) will be very useful. Users and
app developer can also benefit from knowing the proportion of zero pages in all
merged pages to optimize applications.

With the patch series, we can both unshare zero-pages(KSM-placed) accurately
and count ksm zero pages with enabling use_zero_pages.

---
v2->v3:

1) Add more descriptive information in cover letter.

2) In [patch 2/5], add more commit log for explaining reasons.

3) In [patch 2/5], fix misuse of break_ksm() in unmerge_ksm_pages():
   break_ksm(vma, addr, NULL) -> break_ksm(vma, addr, false);

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

