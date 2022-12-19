Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F116651252
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiLSTA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLSTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:00:00 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5032AE7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:10 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so9776156pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZhRIzBqxXMa6fseg6CkSAdY583EaojUpyztij/imbw=;
        b=L5GgSLXnzhMaLVMaVYqX/Ybe1XCcGXDDtaD3Zsecc+djwJkvd4W7SFk3kXZI9VL8GG
         fLZ0Pm7qkspJmgcSfzSP0P9e/RtiEm9XcEirRerUb632pq75N9YtQlnv7VUfmw/vSA4w
         bkOyL+aAJAbGH65LZ+yY4IOissL4Kj3TUlqPFJToWB/s5oFZ3JlqTnIr4VzWlPdxm4+C
         FFa33NoXBmU+GaOg7SWFs7lbolkJK51YJghVomJjdxmPEHEYq0TSBdSGww7r3GjCtvxi
         bn1/7bsHhU12L5sxiMng/lr+TToZIefy0EimnCxUelw3Makg3diT2w9IaXPb/+fmcrfU
         s17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZhRIzBqxXMa6fseg6CkSAdY583EaojUpyztij/imbw=;
        b=EyJ22ZsFwAQcKR28E4DbfSO/wLD/JoRTwShzNZAyK9cDRJ1AAFgbNuH/FljTMN2tKB
         ywzEUJ/4YGdN2IUyuJQbsVAYO+ys1fCKqgaw0TTCUa+RU5l5IRzBZnfXTBnpAVaZwbY7
         51NPEqtOCjg3iPAXHsYg3ddrRxGx/1T5nMVCDiwfFM3IuTxeopxzvVpeqGXkuna62Ua/
         CB7E52tdDthnIQq4FRGVQxxRktfFSXBgXHJVRAUIyyjkVQMCHDuvcHZSXocHIbSCNzJf
         /yu8DAu25nmzhb3SPhQyC++2ezdPKivWbXf6aAsiR3XPVLQPjdomZbHDJSHj+XOi+ack
         inzA==
X-Gm-Message-State: ANoB5pnCaTR7fmyGVcLZ+nTlMhEfWfugozKTxxVwFbCe1ZR4qx9D574m
        NRcmiI7El13SO6gkS74duhBxKdGouBC69Q==
X-Google-Smtp-Source: AA0mqf7cG+2pSZEZzrZjF7usvC+PtSqvx/z18btb9yJDbRy4HTdlmHkv8p/lgdx0ebdSgmUp/msLpw==
X-Received: by 2002:a17:902:f64d:b0:189:603d:ea71 with SMTP id m13-20020a170902f64d00b00189603dea71mr44135292plg.58.1671476350218;
        Mon, 19 Dec 2022 10:59:10 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189847cd4acsm7480790pla.237.2022.12.19.10.59.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Dec 2022 10:59:09 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 0/4] Clean up and fixes for swap
Date:   Tue, 20 Dec 2022 02:58:36 +0800
Message-Id: <20221219185840.25441-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

This series cleanup some code path, saves a few cycles and reduce the
object size by a bit, also fixes some rare race issue of statistics.

Update from V1:
- Collect Huang, Ying's Reviewd-by.
- Use bloat-o-meter to show size change info in commit message as
  suggested by Matthew Wilcox.
- Rework patch 4/4 as suggested by Huang, Ying.
- Drop a previouly invalid clean up patch.

Kairui Song (4):
  swapfile: get rid of volatile and avoid redundant read
  swap: avoid a redundant pte map if ra window is 1
  swap: fold swap_ra_clamp_pfn into swap_ra_info
  swap: avoid holding swap reference in swap_cache_get_folio

 mm/shmem.c      | 11 +++++++++
 mm/swap_state.c | 59 +++++++++++++++++++------------------------------
 mm/swapfile.c   |  7 +++---
 3 files changed, 38 insertions(+), 39 deletions(-)

-- 
2.35.2

