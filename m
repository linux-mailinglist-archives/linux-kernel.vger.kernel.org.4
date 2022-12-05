Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13A64397F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiLEXbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLEXbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:31:40 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C17918387
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:31:39 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a14so8891391pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PGxZk7EEUvOnO5sx9rLILLBhk3hndjY3IkHigHnSNk=;
        b=VM9pcVhYNAPJGZ3AgbVI68+hqY5fuov7xv6MTKm+IbaqxEGKCAMYynql8YsNxhN5ll
         AKh8+YHGuNtYR6TquFYAn/Nq3PCKhNizj+V0PKc1kDQ6cr9QUExm1x/MLBu3ZDNeHww6
         97oahN/0ax9u8B79bZbZM0oroWFY1LlTi5IiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PGxZk7EEUvOnO5sx9rLILLBhk3hndjY3IkHigHnSNk=;
        b=cY+RXguU/thgn1gIQPGj7zlAjC5BzfBX0cZmikZi2cqArkvV5uE/t/3rzYdT8muhTt
         maZXBhOijpvuMuCaDEAbhR49BWrWGCJPfep9stMKgbquTdyYatzQII8U5WbNfQMQ05R2
         KCxn89uM4IrworUU0OMxmdp3qmKjg7/w5Z6kL7ULdw3wQjOu4K77xHPn+quPmZERBo2y
         YolmCfVT8lweQ3M38tjQGR8XK7gLBGQaa+Dbvlgog/yjI75TIIz8F/swwiI/aA9KjEKV
         88xXlKYb/kDK68tTGP3dq4N/BUdOjZCnILRV8mdU2mkVILcn5KUsiyFR1+AhkYWyIFyQ
         D9ig==
X-Gm-Message-State: ANoB5pnSi2EL3d+irBFD+seLPJvcs1urXjiQIA7qKm2xla5slnE5RN/d
        xJOvMdiwvcQmrLUwLqNejm/Pvw==
X-Google-Smtp-Source: AA0mqf6+ELziPed8juoC6rlcujfAK7ChfnChJFMKw4zNC96g+vRUSY17tgqUG4y2gleflRL8tX+xgg==
X-Received: by 2002:a63:5d63:0:b0:462:85d6:6276 with SMTP id o35-20020a635d63000000b0046285d66276mr59370450pgm.293.1670283098959;
        Mon, 05 Dec 2022 15:31:38 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:306e:2b04:2f47:46cc])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b00188ea79fae0sm11232250plb.48.2022.12.05.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:31:38 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-mm@kvack.org, Brian Geffon <bgeffon@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] pstore: Avoid kcore oops by vmap()ing with VM_IOREMAP
Date:   Mon,  5 Dec 2022 15:31:36 -0800
Message-Id: <20221205233136.3420802-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An oops can be induced by running 'cat /proc/kcore > /dev/null' on
devices using pstore with the ram backend because kmap_atomic() assumes
lowmem pages are accessible with __va().

 Unable to handle kernel paging request at virtual address ffffff807ff2b000
 Mem abort info:
 ESR = 0x96000006
 EC = 0x25: DABT (current EL), IL = 32 bits
 SET = 0, FnV = 0
 EA = 0, S1PTW = 0
 FSC = 0x06: level 2 translation fault
 Data abort info:
 ISV = 0, ISS = 0x00000006
 CM = 0, WnR = 0
 swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000081d87000
 [ffffff807ff2b000] pgd=180000017fe18003, p4d=180000017fe18003, pud=180000017fe18003, pmd=0000000000000000
 Internal error: Oops: 96000006 [#1] PREEMPT SMP
 Modules linked in: dm_integrity
 CPU: 7 PID: 21179 Comm: perf Not tainted 5.15.67-10882-ge4eb2eb988cd #1 baa443fb8e8477896a370b31a821eb2009f9bfba
 Hardware name: Google Lazor (rev3 - 8) (DT)
 pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __memcpy+0x110/0x260
 lr : vread+0x194/0x294
 sp : ffffffc013ee39d0
 x29: ffffffc013ee39f0 x28: 0000000000001000 x27: ffffff807ff2b000
 x26: 0000000000001000 x25: ffffffc0085a2000 x24: ffffff802d4b3000
 x23: ffffff80f8a60000 x22: ffffff802d4b3000 x21: ffffffc0085a2000
 x20: ffffff8080b7bc68 x19: 0000000000001000 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000 x15: ffffffd3073f2e60
 x14: ffffffffad588000 x13: 0000000000000000 x12: 0000000000000001
 x11: 00000000000001a2 x10: 00680000fff2bf0b x9 : 03fffffff807ff2b
 x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000000
 x5 : ffffff802d4b4000 x4 : ffffff807ff2c000 x3 : ffffffc013ee3a78
 x2 : 0000000000001000 x1 : ffffff807ff2b000 x0 : ffffff802d4b3000
 Call trace:
 __memcpy+0x110/0x260
 read_kcore+0x584/0x778
 proc_reg_read+0xb4/0xe4

During early boot, memblock reserves the pages for the ramoops reserved
memory node in DT that would otherwise be part of the direct lowmem
mapping. Pstore's ram backend reuses those reserved pages to change the
memory type (writeback or non-cached) by passing the pages to vmap()
(see pfn_to_page() usage in persistent_ram_vmap() for more details) with
specific flags. When read_kcore() starts iterating over the vmalloc
region, it runs over the virtual address that vmap() returned for
ramoops. In aligned_vread() the virtual address is passed to
vmalloc_to_page() which returns the page struct for the reserved lowmem
area. That lowmem page is passed to kmap_atomic(), which effectively
calls page_to_virt() that assumes a lowmem page struct must be directly
accessible with __va() and friends. These pages are mapped via vmap()
though, and the lowmem mapping was never made, so accessing them via the
lowmem virtual address oopses like above.

Let's side-step this problem by passing VM_IOREMAP to vmap(). This will
tell vread() to not include the ramoops region in the kcore. Instead the
area will look like a bunch of zeros. The alternative is to teach kmap()
about vmalloc areas that intersect with lowmem. Presumably such a change
isn't a one-liner, and there isn't much interest in inspecting the
ramoops region in kcore files anyway, so the most expedient route is
taken for now.

Cc: Brian Geffon <bgeffon@google.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 404a6043385d ("staging: android: persistent_ram: handle reserving and mapping memory")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index a89e33719fcf..3a2a041b023d 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -439,7 +439,7 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
 		phys_addr_t addr = page_start + i * PAGE_SIZE;
 		pages[i] = pfn_to_page(addr >> PAGE_SHIFT);
 	}
-	vaddr = vmap(pages, page_count, VM_MAP, prot);
+	vaddr = vmap(pages, page_count, VM_MAP | VM_IOREMAP, prot);
 	kfree(pages);
 
 	/*

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
https://chromeos.dev

