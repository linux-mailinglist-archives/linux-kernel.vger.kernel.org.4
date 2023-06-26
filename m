Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1203073DABA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjFZJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFZJDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:03:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2742720;
        Mon, 26 Jun 2023 01:58:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-311367a3e12so4213471f8f.2;
        Mon, 26 Jun 2023 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687769893; x=1690361893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXoqBJ5SjwaazwPupYLAmCHlcx6sG+m6SwqgWeDfHJg=;
        b=g4dDFsuLrP/kq6wjidgxCVSZBWexLlLfzozRLHF4rlKHxPrUkNxO67SrjoZCrESpdQ
         aJ2Cmd5YUbLlw8pzUsKV6d7mq6F1Ezl61pbT7nLBjfXhrL7kiOO05uDTYYlz5VKc6TKz
         MIjAcqUe2Qlu1VdxLUEhJ2h7eT1qJwLnfYQoUR00XBFUGz6TMBWsQ88/JJWSYusRGkB4
         +nFCOiA2zsix3xJzeq14eqep7tG8m21EwDS4MGMT272sTncmfoSbKv6FAjcrd9TK2hYB
         cU+gfQIrPje7lhB+A4xggWp9smrQ992zaJaUmEBTjsCfRhJayX+epU8BfX6jsLbdC2VW
         LPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687769893; x=1690361893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXoqBJ5SjwaazwPupYLAmCHlcx6sG+m6SwqgWeDfHJg=;
        b=Pq0gZeFyUY01vZnul3B/+kqlL2Wh5giRE0zOYIDTGRECD7ln4T6GhpmOSU6+5GMDj5
         c4mDkzuP0owIrUqYpW7aereLXnEr2XtmSaw594gxyhaEcsHJxPfzYzy1i8SZWkO+Cxir
         ZfECj7R+i6voezIuLW44qxA+bWW8Hw9QT5Vmt/ZBLAetGEaWr4A7o/A7NzrFoFzfXrvj
         kD3oWr7DNrCOLFJMibWOUyadn5d2xnxS4LxWrNM+dHcPjfKFYjjUJ41Mc/qHm/cpUV8n
         icdikSrt2cxPNmcupsAQeN7SL0EimkMeRDwAjo4OEw4/KiLF1tsxWZqH5qIQ3IxRLBJw
         2hDA==
X-Gm-Message-State: AC+VfDxxo4fZJCRgJN7JdEacDNpZG4VKByvMYiswYQGNQIaZWsGBPFJH
        avvj30hI5NwR/H2sssbxGpc=
X-Google-Smtp-Source: ACHHUZ5Amc/Osho99Kkutqafky4CNCXZK+MTntk6OuGOjVXPalxm7R230LqvZchQ4XpX7VlwKr3csQ==
X-Received: by 2002:a5d:480c:0:b0:309:3e77:6cac with SMTP id l12-20020a5d480c000000b003093e776cacmr24739369wrq.0.1687769893315;
        Mon, 26 Jun 2023 01:58:13 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-242-96-229.eu-west-1.compute.amazonaws.com. [34.242.96.229])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b00313e8dc7facsm4883533wrt.116.2023.06.26.01.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 01:58:13 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: [PATCH bpf-next v4 1/3] bpf: make bpf_prog_pack allocator portable
Date:   Mon, 26 Jun 2023 08:58:09 +0000
Message-Id: <20230626085811.3192402-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626085811.3192402-1-puranjay12@gmail.com>
References: <20230626085811.3192402-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpf_prog_pack allocator currently uses module_alloc() and
module_memfree() to allocate and free memory. This is not portable
because different architectures use different methods for allocating
memory for BPF programs. Like ARM64 uses vmalloc()/vfree().

Use bpf_jit_alloc_exec() and bpf_jit_free_exec() for memory management
in bpf_prog_pack allocator. Other architectures can override these with
their implementation and will be able to use bpf_prog_pack directly.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
Changes in V3 => v4
- No changes

Changes in V2 => V3:
- No changes

Changes in v1 => v2:
- No code changes.
- Added Acked-by: Song Liu <song@kernel.org>

 kernel/bpf/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dc85240a0134..599136cb5096 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -860,7 +860,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 		       GFP_KERNEL);
 	if (!pack)
 		return NULL;
-	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
+	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
 	if (!pack->ptr) {
 		kfree(pack);
 		return NULL;
@@ -884,7 +884,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
 		size = round_up(size, PAGE_SIZE);
-		ptr = module_alloc(size);
+		ptr = bpf_jit_alloc_exec(size);
 		if (ptr) {
 			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
@@ -922,7 +922,7 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 
 	mutex_lock(&pack_mutex);
 	if (hdr->size > BPF_PROG_PACK_SIZE) {
-		module_memfree(hdr);
+		bpf_jit_free_exec(hdr);
 		goto out;
 	}
 
@@ -946,7 +946,7 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
 		list_del(&pack->list);
-		module_memfree(pack->ptr);
+		bpf_jit_free_exec(pack->ptr);
 		kfree(pack);
 	}
 out:
-- 
2.40.1

