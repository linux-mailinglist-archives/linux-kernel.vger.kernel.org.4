Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680676647BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjAJRvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjAJRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:51:17 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAD654D81
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:51:15 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z3-20020a170903018300b0018fb8ca1688so8819729plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd8IRDcm/I+X4nIj9mIHk75KksnNCPDW6vKldjVyscc=;
        b=b6KSQFqc5bLezor0zmWctfaPJ+f7KyxQdr3D/WxZuD9X/46Ab/0ny+3J5uSKG+8BMd
         uOQtNt3qd0SKGSJDc48X0DejhNnMOMN1KqX1H6Y2pq4012FFY+jsK2wdmkihUd8VYDJi
         lcm7hjV5n3lyYiVTAfWEbyj6PuU3nPZAPMuLFBK1dNwVn8VthonXMN8aFsG2D7/FUimc
         nqJ2g6PZpyu46JOs2r3mstW5uLQxFnf0GAqB1S1db+9ovE4akeJlXlcXxOEh+z4XxCNp
         YjtPFDZ7tPeI1jg+M4oKf7aIqOJxeUYsspIuXjhlF97sGbW0rAl1a7vOZq86idj7GWYl
         GBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd8IRDcm/I+X4nIj9mIHk75KksnNCPDW6vKldjVyscc=;
        b=w8TbfMpq9TWSi5uKDs9iQ8EbvT9XMAP+JXduAFM3eei7/XA91ehDojbNQfjPdRJCKX
         rNO+VAtFPiCJepuvxk4CW8fPwfPUmSwF0bf4AqJh0X2iibZcpO959zFAHUSgPrx/GnHn
         LA5mgKxNksXr9R158oYTD/hhENiWdpGUUhilamdO10acE44o/dX2bQ+flOiRnoI/u26L
         4k5OxDrp+DSuE8Ay2rTSAKyqEYCT3qfe1G9/lA0+v+KEXKAEuiKaIdNhhf3CdPhzA5ba
         S+zP8fO2cOcwnweRW/Xb1GTz2deFPTeNWu2h9uy7pBFhwaPHjolZwnffyoWCi2QTJAKM
         xjXA==
X-Gm-Message-State: AFqh2krUa3pra0aT9mNMcBVQ14fd87mk7LbdPptgnjfMGLfENTC/3q6q
        cGfwhYiYfrbC6ZpYzvGVlqhiqSNgFSE=
X-Google-Smtp-Source: AMrXdXtgUqdh/8WMm6DEuvZ030LJA1xX0uMeQAB19fs4xWBZgfTRe3FK8MNQ9gfkgaQtgyE4OlBoTZ6JP8U=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:8358:4c2a:eae1:4752])
 (user=pgonda job=sendgmr) by 2002:a63:1a0a:0:b0:478:ba6c:3879 with SMTP id
 a10-20020a631a0a000000b00478ba6c3879mr5162985pga.440.1673373075316; Tue, 10
 Jan 2023 09:51:15 -0800 (PST)
Date:   Tue, 10 Jan 2023 09:50:56 -0800
In-Reply-To: <20230110175057.715453-1-pgonda@google.com>
Message-Id: <20230110175057.715453-7-pgonda@google.com>
Mime-Version: 1.0
References: <20230110175057.715453-1-pgonda@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH V6 6/7] KVM: selftests: Update ucall pool to allocate from
 shared memory
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerly Tng <ackerleytng@google.com>,
        Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the per VM ucall_header allocation from vm_vaddr_alloc() to
vm_vaddr_alloc_shared(). This allows encrypted guests to use ucall pools
by placing their shared ucall structures in unencrypted (shared) memory.
No behavior change for non encrypted guests.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerly Tng <ackerleytng@google.com>
cc: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 tools/testing/selftests/kvm/lib/ucall_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 2f0e2ea941cc..99ef4866a001 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -24,7 +24,7 @@ void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 	vm_vaddr_t vaddr;
 	int i;
 
-	vaddr = __vm_vaddr_alloc(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR, MEM_REGION_DATA);
+	vaddr = vm_vaddr_alloc_shared(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR);
 	hdr = (struct ucall_header *)addr_gva2hva(vm, vaddr);
 	memset(hdr, 0, sizeof(*hdr));
 
-- 
2.39.0.314.g84b9a713c41-goog

