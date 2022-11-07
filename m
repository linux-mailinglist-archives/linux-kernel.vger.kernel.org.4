Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25162012D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiKGVbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiKGVbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:31:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D27E240B6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:31:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k5so11838157pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/a6s9FkrKvGz+jO1XUHUIKBmi/KNPRg8Hd8bDVTOKU=;
        b=jQVsyLbWNjAzBZlS5rCfJIEyzdnve7P7JHlITuQuT+Zf4knoTONtZrHuJgIHgzNi2j
         NMucZwWaLj6eeKX/EL/EWlmV5N4x62tCGA6FLUmWdfVbDn4Exv1axUTiVX6lRoedbWNM
         L+MXoxuyvMsHW6jrZGhIbz5f8K/dt2XVtR7BsPgahMsxmM/xSBg7qvjuDoFaySSd/VY+
         TiIxgKPhZxMBYYlgucteiXLfK/NwTxTuFY6Fjkz7ImIrxYpIxj1wY3Js/7qjWFW5IAw5
         YCkwEZP4PYGMJXHQMsgSN4MVzV35fP0/wYCoRO01oEi2bCSsTjZqJDb7s+sIpisCwTWW
         aGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/a6s9FkrKvGz+jO1XUHUIKBmi/KNPRg8Hd8bDVTOKU=;
        b=G7/UEGqfc9stCXPBUJ5kh6gtGLKn/iUPbsMfiyB1b9//Zlxp1PluGFRsrteZ10ko3y
         0Br9R+QhzKOkWwCXdKGywFpT/nUD4JMMcuHM7QXqQMUSd3SLp+WCU8X+YUMMCJRjbIRZ
         0Fywuuo++lM3pfxc43vD4i8wBAmEmLXdGe8Bl8dktFGcxvT5QqVMsD0kBkQVq5FLS5oC
         Gqq2KZdSh9X2przNCMDE4IhY3aJ4a1yJZDKHz2RVKQpnmjI2q1YUN/G7aZ0pnhSnFPPx
         sMBr1LQefKh2XuNNsLpChi0go+x1VARBUiBchap3WM9vYVYe35gq+NHZKjKYrhcAB/28
         Giqw==
X-Gm-Message-State: ACrzQf0qiLRdA7sOmOYCJjtq1/pTJA9254y9kPBQ82QCIOL8T4bhsUv7
        us64kbqMt9mfAU7ujOy1Z4E=
X-Google-Smtp-Source: AMsMyM6Lz2ApkCWLspkosq/SKhMG9Jxo9FRcsEiZhwlK0OjNypS59ubHiR5L26fr0AYPUysxJWRaoQ==
X-Received: by 2002:a17:902:b089:b0:178:54cf:d692 with SMTP id p9-20020a170902b08900b0017854cfd692mr52085120plr.1.1667856676054;
        Mon, 07 Nov 2022 13:31:16 -0800 (PST)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id n126-20020a622784000000b0056b4c5dde61sm5083356pfn.98.2022.11.07.13.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:31:15 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     senozhatsky@chromium.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, akpm@linux-foundation.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and size_class's locks
Date:   Mon,  7 Nov 2022 13:31:14 -0800
Message-Id: <20221107213114.916231-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y2SN5tMH8CqYHsYK@google.com>
References: <Y2SN5tMH8CqYHsYK@google.com>
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

We have benchmarked the lock consolidation to see the performance effect of
this change on zram. First, we ran a synthetic FS workload on a server machine
with 36 cores (same machine for all runs), using this benchmark script:

https://github.com/josefbacik/fs_mark

using 32 threads, and cranking the pressure up to > 80% FS usage.

Here is the result (unit is file/second):

With lock consolidation (btrfs):
Average: 13520.2, Median: 13531.0, Stddev: 137.5961482019028

Without lock consolidation (btrfs):
Average: 13487.2, Median: 13575.0, Stddev: 309.08283679298665

With lock consolidation (ext4):
Average: 16824.4, Median: 16839.0, Stddev: 89.97388510006668

Without lock consolidation (ext4)
Average: 16958.0, Median: 16986.0, Stddev: 194.7370021336469

As you can see, we observe a 0.3% regression for btrfs, and a 0.9% regression
for ext4. This is a small, barely measurable difference in my opinion.

For a more realistic scenario, we also tries building the kernel on zram.
Here is the time it takes (in seconds):

With lock consolidation (btrfs):
real
Average: 319.6, Median: 320.0, Stddev: 0.8944271909999159
user
Average: 6894.2, Median: 6895.0, Stddev: 25.528415540334656
sys
Average: 521.4, Median: 522.0, Stddev: 1.51657508881031

Without lock consolidation (btrfs):
real
Average: 319.8, Median: 320.0, Stddev: 0.8366600265340756
user
Average: 6896.6, Median: 6899.0, Stddev: 16.04057355583023
sys
Average: 520.6, Median: 521.0, Stddev: 1.140175425099138

With lock consolidation (ext4):
real
Average: 320.0, Median: 319.0, Stddev: 1.4142135623730951
user
Average: 6896.8, Median: 6878.0, Stddev: 28.621670111997307
sys
Average: 521.2, Median: 521.0, Stddev: 1.7888543819998317

Without lock consolidation (ext4)
real
Average: 319.6, Median: 319.0, Stddev: 0.8944271909999159
user
Average: 6886.2, Median: 6887.0, Stddev: 16.93221781102523
sys
Average: 520.4, Median: 520.0, Stddev: 1.140175425099138

The difference is entirely within the noise of a typical run on zram. This
hardly justifies the complexity of maintaining both the pool lock and the class
lock. In fact, for writeback, we would need to introduce yet another lock to
prevent data races on the pool's LRU, further complicating the lock handling
logic. IMHO, it is just better to collapse all of these into a single
pool-level lock.
