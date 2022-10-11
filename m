Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3445FBBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJKT6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJKT6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A098CA5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665518301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAlECgJKwNknwoioVUeF/uXHuNVkO1eljRPrSr7m9O4=;
        b=fo08+YB45cnpbux1+hEFkSz9J6CLtFH1MUK9znQJX3YTOdL3Jh5uH9LJ93w/5UQRlGW36N
        lZOfkI17AhbSBm8BawgTJz14nqaaUHF4hfY4A2d4yJi4fG9pDWrWjeUkk1sziyXvtXKzwH
        eocd8xRRP6+/ga/S0QqaW3Ya1ByAz98=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-YCRiPx4NOwy7AgDO5Mp_2g-1; Tue, 11 Oct 2022 15:58:15 -0400
X-MC-Unique: YCRiPx4NOwy7AgDO5Mp_2g-1
Received: by mail-qk1-f197.google.com with SMTP id k2-20020a05620a414200b006ceec443c8bso12577513qko.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAlECgJKwNknwoioVUeF/uXHuNVkO1eljRPrSr7m9O4=;
        b=GgkZIDD1L9l/y72N93qDa6+0GLeur7mmOlWEFBaUCWC5lydCWTpW2C+wwmGYN1rSCd
         MRgTtkHdhI0NvpdSxRwm3AzuZlzJz7Jh6U+DJn6rLgQWRkWa0MJBa/n7G2x/nPVfIigd
         gae+eDCfXFvaiNvHITYl0iQkOLezwE5QF6annboS7oCO5VuVA4d56vpwJhTwHeIbzeTD
         6oLs8inplEJvTX+pvw+2ME6xNsLMP0sbLOfRbZxA1OQi7Aq9AHo+FEvko5a1pnhl1TlI
         fWf+tJtvVkKIMMbMIpuJaOCN8YIyrGrRSysVRgg5DozBJ3DowF/qh4jmi2Tkmcv7j3KQ
         jvqQ==
X-Gm-Message-State: ACrzQf3BIY1pSR1H7O6Ie0p4IRIgzcYi6IsQdzlpOrDfJJYynXm0j129
        eqMcrl6o0r/56jA3wCmrETsgQO5zxZdJlGAi/uY7eR+xal506orJ0XbT9B326Ak2kKLDE7udbVr
        C+phK02yjZEEn5MZxpAjtNP9U
X-Received: by 2002:ac8:574a:0:b0:394:3388:9fc3 with SMTP id 10-20020ac8574a000000b0039433889fc3mr20682007qtx.292.1665518294789;
        Tue, 11 Oct 2022 12:58:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5lzV/hWT/COel7yjUmDe/h42rtZvKalYrmBS4qOaAdmcwzGvcmWe1PC252299lW5tk7hr3pg==
X-Received: by 2002:ac8:574a:0:b0:394:3388:9fc3 with SMTP id 10-20020ac8574a000000b0039433889fc3mr20681987qtx.292.1665518294584;
        Tue, 11 Oct 2022 12:58:14 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006ce9e880c6fsm13648837qkb.111.2022.10.11.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:58:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 2/4] kvm: Add KVM_PFN_ERR_SIGPENDING
Date:   Tue, 11 Oct 2022 15:58:07 -0400
Message-Id: <20221011195809.557016-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011195809.557016-1-peterx@redhat.com>
References: <20221011195809.557016-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new pfn error to show that we've got a pending signal to handle
during hva_to_pfn_slow() procedure (of -EINTR retval).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 10 ++++++++++
 virt/kvm/kvm_main.c      |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 32f259fa5801..92baa930b891 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -96,6 +96,7 @@
 #define KVM_PFN_ERR_FAULT	(KVM_PFN_ERR_MASK)
 #define KVM_PFN_ERR_HWPOISON	(KVM_PFN_ERR_MASK + 1)
 #define KVM_PFN_ERR_RO_FAULT	(KVM_PFN_ERR_MASK + 2)
+#define KVM_PFN_ERR_SIGPENDING	(KVM_PFN_ERR_MASK + 3)
 
 /*
  * error pfns indicate that the gfn is in slot but faild to
@@ -106,6 +107,15 @@ static inline bool is_error_pfn(kvm_pfn_t pfn)
 	return !!(pfn & KVM_PFN_ERR_MASK);
 }
 
+/*
+ * KVM_PFN_ERR_SIGPENDING indicates that fetching the PFN was interrupted
+ * by a pending signal.  Note, the signal may or may not be fatal.
+ */
+static inline bool is_sigpending_pfn(kvm_pfn_t pfn)
+{
+	return pfn == KVM_PFN_ERR_SIGPENDING;
+}
+
 /*
  * error_noslot pfns indicate that the gfn can not be
  * translated to pfn - it is not in slot or failed to
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e30f1b4ecfa5..e20a59dcda32 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2667,6 +2667,8 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
 	npages = hva_to_pfn_slow(addr, async, write_fault, writable, &pfn);
 	if (npages == 1)
 		return pfn;
+	if (npages == -EINTR)
+		return KVM_PFN_ERR_SIGPENDING;
 
 	mmap_read_lock(current->mm);
 	if (npages == -EHWPOISON ||
-- 
2.37.3

