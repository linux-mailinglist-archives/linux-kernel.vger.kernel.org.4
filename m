Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E9624BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiKJUck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiKJUcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864021E701
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668112300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQpC1KJZxfuI3Xd3ROAIVllQOpnyDtGxdSkS8bhzCN0=;
        b=VrC1zLewUg/xJCLnssyU+XO5/3ytsetbqE9mKtFNQsd2Ax1rdZNl3xZyPxQCTzA/s+55zf
        aOixlonX9Qw1/Mj4AES5TtpGtO0+Gf+dIwq0x3R65Tu+9MAYcjq9l3l0L/e86yvg31iO4r
        k4Wh+k96gAbYKycmlcMTOBhGoDVp/P0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-318-PH6j4e1qN1uRaPbYNWd1Og-1; Thu, 10 Nov 2022 15:31:39 -0500
X-MC-Unique: PH6j4e1qN1uRaPbYNWd1Og-1
Received: by mail-qt1-f199.google.com with SMTP id u31-20020a05622a199f00b003a51fa90654so2228453qtc.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQpC1KJZxfuI3Xd3ROAIVllQOpnyDtGxdSkS8bhzCN0=;
        b=aZs2E5TrDJUEls8dZyMJCn3RjhpaDhYra/Ml6QopASQwZA0PgvRko2Ky1U6tWob0ZZ
         f+uH9U0r5ZJ9CUQe8ONTZRbUGEU1wHIp9SC0VsA8LfRKTMvEj7tHl8DPPByOZab72ClR
         2w869TzAihMSK/We4btw9cGbJAe8/rvk0WGie1T+wmQ8g13RmCDZFf4rnoauPev/XY3z
         K3b89hS5D35EKcbOekHh4xcW28XNYMKUQDynM8OQetIRSMhHtuGpJfxGrLRLHCMuiWGT
         W0B/R0vD7C0JSx3+Wr4pB/tnGH8jql1dAFO307u6aYttnqPq7fiqlGojooZqFWxnGbXO
         wBAw==
X-Gm-Message-State: ACrzQf35iIpovYgn3ZTl5+jZ83QDdArFjaOykOXg/jVQmI0s4neyhUbp
        rKKYPntUq7dlGdFIbFL2LVq0rfBqEZIQHey1fTIPmubddBqeTuoLNZggbbSgswnzji2LQW+EYI/
        ZCbVJ5rBmhtPo+OLvkivuqJKP5yc867DaxV521cPekqf0y6DvLgOAEQesW64jEvDx1GcTOQoE5g
        ==
X-Received: by 2002:a05:6214:c47:b0:4bb:85b4:fd8e with SMTP id r7-20020a0562140c4700b004bb85b4fd8emr60020951qvj.25.1668112298131;
        Thu, 10 Nov 2022 12:31:38 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6a4bYEEfrparCjbxn+5nTpkS1ttlH0u8PymDLSxp/42P4cYuyUmwamqmx1eFIRs1TCSmTebg==
X-Received: by 2002:a05:6214:c47:b0:4bb:85b4:fd8e with SMTP id r7-20020a0562140c4700b004bb85b4fd8emr60020935qvj.25.1668112297792;
        Thu, 10 Nov 2022 12:31:37 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i1-20020ac860c1000000b00399edda03dfsm123588qtm.67.2022.11.10.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:31:37 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] mm/uffd: Sanity check write bit for uffd-wp protected ptes
Date:   Thu, 10 Nov 2022 15:31:32 -0500
Message-Id: <20221110203132.1498183-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110203132.1498183-1-peterx@redhat.com>
References: <20221110203132.1498183-1-peterx@redhat.com>
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

Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5059799bebe3..64141acf70c8 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -291,7 +291,21 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_UFFD_WP;
+	bool wp = pte_flags(pte) & _PAGE_UFFD_WP;
+
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
+	VM_WARN_ON_ONCE(wp && pte_write(pte));
+
+	return wp;
 }
 
 static inline pte_t pte_mkuffd_wp(pte_t pte)
-- 
2.37.3

