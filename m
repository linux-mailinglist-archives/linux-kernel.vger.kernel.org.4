Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8715E6420D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiLEAv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLEAvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:51:55 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904441147F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 16:51:53 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id cg5so10447990qtb.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 16:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pTY2l+gjqfB9RBAkMQhNeterlNdKjU202ghxsWo7JAA=;
        b=eWtMKpca6u53309Xb+1JRA0s3CGPDyUCyaLuDVcyQUosW1r9K/S2622XXUTZ9zf8B1
         b0Hw6qk3aAig0bEJUj3wtr9zx+TZ1ow3R5LR6LKkLR+12U7f+wDDX7YWhTJQW3r2Z0N4
         Y1ChWiyhdX24+WJT5RX86JXogacO6sIo/oXGmI2DyFx3z6OweYrHouWxmXrFOncExgyl
         v3XbOIcW0EZfplSS0PkE5/Nwgixv5qvJ330v0UNkt/Yy5HxJlfF/xkYoubvm+bn2qN1C
         FFqDNS+k5Wr3QRtqs5NWG3Lyfs8DTkDIAB/zzf6fLUT6eCtXsHepy02K47sxZ9j2JhMt
         FgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTY2l+gjqfB9RBAkMQhNeterlNdKjU202ghxsWo7JAA=;
        b=gq1ESows1HnpKmYYlOjTrVXYc1MAAs1rcTFikByihd68dOBQF3RmX1yBwxw0TuT9Kp
         VqZvxGYpX8Jc8qDGoPW+k7fXRSmcqaBCSWDh9BpQe5Cnb46k5oFqdGmoPG4WtC+nekea
         dLC/VJRR9xDdULqFRi5vyeQrIgiv6V2UU7ImMEpX3z+kcaqOPHgNntquLkXaWPIGkrQ4
         VT9DSYO2hVU0DrguZybROsDsfW5OJIHHnKuyOP76frZAzKK8OtAT3STo0YDw1hd6CqbF
         vryxoqxgdynDWno9DUskVU0GIZfQQlb7i+4pv4mxKqGH2y76t0L9Vsmwlr09dacyV8nG
         Cnkg==
X-Gm-Message-State: ANoB5pluYEaVEUyEUyW9WXn+HYt7YWkWpjlHAXylHl6Auq9IsRzsiyr5
        0q4iKI7vw9e0lpBt0l4dAvyIqA==
X-Google-Smtp-Source: AA0mqf7FH3twKpzV3XbhsCtS6L5iw9mLMcoJX/nFWX7DCzhg/0FdEF5ViLHrNlvHJ+DaihnUfi0QjA==
X-Received: by 2002:ac8:4995:0:b0:3a6:a35e:8256 with SMTP id f21-20020ac84995000000b003a6a35e8256mr7681681qtq.636.1670201512383;
        Sun, 04 Dec 2022 16:51:52 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d18-20020ac847d2000000b003a611cb2a95sm1329245qtr.9.2022.12.04.16.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 16:51:52 -0800 (PST)
Date:   Sun, 4 Dec 2022 16:51:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Rui Wang <kernel@hev.cc>, Matthew Wilcox <willy@infradead.org>,
        Guoqi Chen <chenguoqic@163.com>,
        Huacai Chen <chenhuacai@loongson.cn>, Rui Wang <r@hev.cc>,
        Vishal Moola <vishal.moola@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] tmpfs: fix data loss from failed fallocate
In-Reply-To: <5889e4e3-e054-7654-1436-8d2bcbefe3c6@google.com>
Message-ID: <a5dac112-cf4b-7af-a33-f386e347fd38@google.com>
References: <20221101032248.819360-1-kernel@hev.cc> <Y2KBovUHODJJ8ZnV@casper.infradead.org> <CAHirt9h2CrLhYML3XW=Vj4=BD5eVDoRAbULVGgNbEdYnAzwCzA@mail.gmail.com> <9984f58e-826-74c6-1cd4-65366cc01549@google.com>
 <5889e4e3-e054-7654-1436-8d2bcbefe3c6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix tmpfs data loss when the fallocate system call is interrupted by a
signal, or fails for some other reason.  The partial folio handling in
shmem_undo_range() forgot to consider this unfalloc case, and was liable
to erase or truncate out data which had already been committed earlier.

It turns out that none of the partial folio handling there is appropriate
for the unfalloc case, which just wants to proceed to removal of whole
folios: which find_get_entries() provides, even when partially covered.

Link: https://lore.kernel.org/linux-mm/33b85d82.7764.1842e9ab207.Coremail.chenguoqic@163.com/
Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
Reported-by: Guoqi Chen <chenguoqic@163.com>
Original-patch-by: Rui Wang <kernel@hev.cc>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: stable@vger.kernel.org # 5.17+
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- 6.1-rc8/mm/shmem.c
+++ linux/mm/shmem.c
@@ -948,6 +948,15 @@ static void shmem_undo_range(struct inod
 		index++;
 	}
 
+	/*
+	 * When undoing a failed fallocate, we want none of the partial folio
+	 * zeroing and splitting below, but shall want to truncate the whole
+	 * folio when !uptodate indicates that it was added by this fallocate,
+	 * even when [lstart, lend] covers only a part of the folio.
+	 */
+	if (unfalloc)
+		goto whole_folios;
+
 	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
 	folio = shmem_get_partial_folio(inode, lstart >> PAGE_SHIFT);
 	if (folio) {
@@ -973,6 +982,8 @@ static void shmem_undo_range(struct inod
 		folio_put(folio);
 	}
 
+whole_folios:
+
 	index = start;
 	while (index < end) {
 		cond_resched();
