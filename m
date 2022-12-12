Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9508664AB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiLLXTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLLXTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:19:16 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC471C136
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:14 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y16so13934589wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2D3szGCb9Vg2ywxzAo8nNWdIMuiqqy33S8+OxWxWj8=;
        b=LCqSz2Y5qcjBfH7iD0GZiRb9FoHwH7kdToub9Er9PErtfhHz6XBINd7RRN1Iye6Yzb
         gYrqyS9JQwmC4uivOMIquAnjKxFP26ILfZP7sJSnTHkSpEcAhfnjQvBAL6p3l7eN6z/y
         PAPzYMGKDYsi+hb/RCRjYpk4anTFNvIjCwbxDIUQ3+K6RwjZaQa+S3uQYwnTnih7YbMj
         npd9wlmd4S7hXuLiGNTwtfZAARoKCTywEXTWYIGSudDWzDInhkhvr2NtyNuYGUTQprYl
         vbtqhPxPtBKjVeg+JTjgBBDur2iT2UtNf6FktLNQmWT/LjuON3ZVIG4/1UhZg/40GJSu
         n1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2D3szGCb9Vg2ywxzAo8nNWdIMuiqqy33S8+OxWxWj8=;
        b=hiX/7Kvub31PPT9YGOqNNVdrrn2encPJw0eq+16kVmA3hYlD2+37hrUt85njwShcUl
         F6Me6yrrLeqLWSwxqfMnY9ZXCpmv1YPHL4zmtCe/G3VnYoTcNZ50b9cGpph0E60jFM/7
         ZCs+nZvjXC9FpsteStqEd6JO1WvHKuWAs6QUOb3F81nrrh55IpmiGZz2c+1312wqXNdk
         FzKpVvFGkhMkVhsA/LOPZEX/yqis+xnw4PrV9HGtzJWJIq1h0a8MDMV4qtsp0wvvLKpU
         pyEs/uIGZT6Pj4V3xjXyuNiATcK4nayhE0cSUIjLYKT7NGPqB/Fwq5M5pDjXPdbRG7LP
         iKXA==
X-Gm-Message-State: ANoB5pmGYcYutN8kTusr/6njpZFdMYnaDVNtatXqPvkX8QEnfZrxWVPA
        /R5QhwXI65ujmKdR4llLY6M=
X-Google-Smtp-Source: AA0mqf6TWRW96K4JfS3kP6DgZ1YnpFTQD3ICFOQSZhHE+VTy1UOAIHJlDv/1Doz8EyNAP524sfNEZA==
X-Received: by 2002:a05:6000:50f:b0:236:c62f:eb70 with SMTP id a15-20020a056000050f00b00236c62feb70mr11424280wrf.13.1670887152833;
        Mon, 12 Dec 2022 15:19:12 -0800 (PST)
Received: from localhost.localdomain (host-79-41-27-125.retail.telecomitalia.it. [79.41.27.125])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6103000000b002423edd7e50sm9964304wrt.32.2022.12.12.15.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:19:11 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/3] fs/ufs: replace kmap() with kmap_local_page
Date:   Tue, 13 Dec 2022 00:19:03 +0100
Message-Id: <20221212231906.19424-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org>
References: <bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/ufs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
requires the mapping address, so return that address from ufs_get_page()
to be used in ufs_put_page().

This series could have not been ever made because nothing prevented the
previous patch from working properly but Al Viro made a long series of
very appreciated comments about how many unnecessary and redundant lines
of code I could have removed. He could see things I was entirely unable
to notice. Furthermore, he also provided solutions and details about how
I could decompose a single patch into a small series of three
independent units.[1][2][3]

I want to thank him so much for the patience, kindness and the time he
decided to spend to provide those analysis and write three messages full
of interesting insights.[1][2][3]

Changes from v1
	1/3: No changes.
	2/3: Restore the return of "err" that was mistakenly deleted
	     together with the removal of the "out" label in
	     ufs_add_link(). Thanks to Al Viro.[4]
	     Return the address of the kmap()'ed page instead of a
	     pointer to a pointer to the mapped page; a page_address()
	     had been overlooked in ufs_get_page(). Thanks to Al
	     Viro.[5]
	3/3: Return the kernel virtual address got from the call to
	     kmap_local_page() after conversion from kmap(). Again
	     thanks to Al Viro.[6]

[1] https://lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/
[2] https://lore.kernel.org/lkml/Y4FG0O7VWTTng5yh@ZenIV/
[3] https://lore.kernel.org/lkml/Y4ONIFJatIGsVNpf@ZenIV/
[4] https://lore.kernel.org/lkml/Y5Zc0qZ3+zsI74OZ@ZenIV/
[5] https://lore.kernel.org/lkml/Y5ZZy23FFAnQDR3C@ZenIV/
[6] https://lore.kernel.org/lkml/Y5ZcMPzPG9h6C9eh@ZenIV/

The cover letter of the v1 is at
https://lore.kernel.org/lkml/20221211213111.30085-1-fmdefrancesco@gmail.com/

Fabio M. De Francesco (3):
  fs/ufs: Use the offset_in_page() helper
  fs/ufs: Change the signature of ufs_get_page()
  fs/ufs: Replace kmap() with kmap_local_page()

 fs/ufs/dir.c | 138 +++++++++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 66 deletions(-)

-- 
2.38.1

