Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AEA62456F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiKJPSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiKJPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:18:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD6F12615
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668093433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CDOnJYMZah4WeGmtiqmew/mMyquYuFWazZX9Q40Hac=;
        b=B7GCCQbmfuiRx2auHOnSL2kx6j7HIxHBNq/lKMblO7KLiwm19yilMjnJJM5t7nrYEI+NF+
        zCcC9n/kdj5k01Creb0rFpI8LtgpcyTzG+3SJBHE6ZPQmzDTTvhc7PCM/mpHNyiir4tRbO
        IeNUZhx9m5gtTV391vPRf1Hea4ZW6Nk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-9_rZmloSNcWu0PtaFgKW6g-1; Thu, 10 Nov 2022 10:17:10 -0500
X-MC-Unique: 9_rZmloSNcWu0PtaFgKW6g-1
Received: by mail-qv1-f69.google.com with SMTP id b2-20020a0cfe62000000b004bbfb15297dso1651173qvv.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CDOnJYMZah4WeGmtiqmew/mMyquYuFWazZX9Q40Hac=;
        b=WWjwY9B6hgwdt1PXiLSdaoLbMqjmSHjGoDw0HwoNrz85ykKq6toNfRu/ECRN9As9Y9
         FZmzRt98VsRiDz3WBIzCdV+Vbpczu8krCPjfaqj3Tdf/lzJJ8kmRfVRVPK8zT4Z6avcu
         rs54MdWYI4FIEX/BGd6Lgdd1Pj5t4p7oNWJtHynsn1HhVQL0psHuWoHQQnruQGhpd76k
         wLPw92ldxorRD/rNlGg+KU8Ag/qpe+5+StmyQe/RIpcJ9Ebr/prXBPRTtxJJBlX9TFza
         yVlLSO3iltsBcn7SP0/emBXa/p9GKsV+hT5YWMgITnLmbuJ7HkXIst78Br/mKOJoKV4N
         lwLQ==
X-Gm-Message-State: ACrzQf2vynabYt7Xr3WCz9diXoX+wRPoi9b6z1pIQvPgebOy8oP4HQE5
        nJ7Itasmh/i8AH6LuLp/TDTdQNGj+xj79OBwYhzWUoIU5cQI93swlyr7vZX7+mP7Ir94i3CmhIQ
        ceA3S/NH5H7BNodQYOKFo3PyQ
X-Received: by 2002:a05:620a:cc2:b0:6fa:2175:5fa7 with SMTP id b2-20020a05620a0cc200b006fa21755fa7mr44267847qkj.0.1668093427831;
        Thu, 10 Nov 2022 07:17:07 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5sZc0MPXl3k0/8piyAMxvk9MkH6fZqGYMI8ObhnZ5YYr0EEA2u8MpiOMTdbYs26mM5B7/hMg==
X-Received: by 2002:a05:620a:cc2:b0:6fa:2175:5fa7 with SMTP id b2-20020a05620a0cc200b006fa21755fa7mr44267821qkj.0.1668093427556;
        Thu, 10 Nov 2022 07:17:07 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a28d300b006ec771d8f89sm13621596qkp.112.2022.11.10.07.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:17:07 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ives van Hoorne <ives@codesandbox.io>
Subject: [PATCH 2/2] mm/uffd: Sanity check write bit for uffd-wp protected ptes
Date:   Thu, 10 Nov 2022 10:17:02 -0500
Message-Id: <20221110151702.1478763-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110151702.1478763-1-peterx@redhat.com>
References: <20221110151702.1478763-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add one sanity check for CONFIG_DEBUG_VM on the write bit in whatever
chance we have when walking through the pgtables.  It can bring the error
earlier even before the app notices the data was corrupted on the snapshot.
Also it helps us to identify this is a wrong pgtable setup, so hopefully a
great information to have for debugging too.

Wrapping with CONFIG_DEBUG_VM is not that useful considering we have that
in many distros already, but still do that just in case some custom build
doesn't want anything like it.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5059799bebe3..27fff6b14929 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -291,7 +291,21 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_UFFD_WP;
+	bool wp = pte_flags(pte) & _PAGE_UFFD_WP;
+#ifdef CONFIG_DEBUG_VM
+	/*
+	 * Having write bit for wr-protect-marked present ptes is fatal,
+	 * because it means the uffd-wp bit will be ignored and write will
+	 * just go through.
+	 *
+	 * Use any chance of pgtable walking to verify this (e.g., when
+	 * page swapped out or being migrated for all purposes). It means
+	 * something is already wrong.  Tell the admin even before the
+	 * process crashes. We also nail it with wrong pgtable setup.
+	 */
+	WARN_ON_ONCE(wp && pte_write(pte));
+#endif
+	return wp;
 }
 
 static inline pte_t pte_mkuffd_wp(pte_t pte)
-- 
2.37.3

