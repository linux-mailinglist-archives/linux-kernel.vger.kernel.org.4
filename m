Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D26050EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiJST6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJST6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:58:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849CB1D79A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:58:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c10-20020a170902d48a00b001825736b382so12545485plg.15
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dkeuj2JEjMdaDkWKpIRh1Qeplaf/0fGmD/fPQgm8zGI=;
        b=IJhpJfOhoGUoA0QwTgEDY7rZLC0hLsmivrkcFmq+vhvGf09EWyL9ERoeZzdYgo5og3
         iY9YUk/drwmMfkXKEEbUXZPGHhCnIWPg0DXL7B5h/7WuQqBkZfnQ9TH6oVSXnvXHXL5E
         LEgLcO4iEKV5JFYuuVIuXynU0yvSZPUUB5eFGoPe+inStlQWSDZDMgO0YonTrctYj+Ba
         lVQK1PE2W2CAUZ9VYzshQheg26HOLysqgnQfeaPiA2dtOLsM1BD3ZTvFyZ3ITYUr0CId
         N1MpHMUMceby9zovEGJSjFudluwWIYKs3akXDDcB9/VWJumjFy5oOjaH/8lkFtixjQmH
         5LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dkeuj2JEjMdaDkWKpIRh1Qeplaf/0fGmD/fPQgm8zGI=;
        b=B3iydu+TOlYYA1zNpXVCsDNgMchLSxN9r17a1wWjN4Ugio9n4dtbdE+mfaqvgQlHNW
         OgZ59sSCznugTAUdrwqOmoOn58+5pBcaOjh7dFA8Xvy4BRjlUeU7Gbz9efnrPCHojILw
         FsNVZblcD/fGS2oc6U0G4Iuj2DAz95JnKVo2RCG6HVqJwd9zTs7ug8dUiW8CzIXGMQ4q
         QZPjAFI8VN0VCHayGShweBIxdsolEeVsAnoIQXLrn8D+gJsdOtGfk+qS7ZPlsOLQ+1H1
         zsACs84vC5KLck0ASzuqLkdrkT72JHssi3nMFES5SYbX4J5Ncg87ZnG7ikVFvicaozts
         AtAA==
X-Gm-Message-State: ACrzQf1fw0xqbCGuwbET/V/HKtce2tgGmt2S5d/gK33GlnmmIU81iPkU
        p2es0EQpSzlyA1rtHd136F4VpaDIl+kiHGorQA==
X-Google-Smtp-Source: AMsMyM4N+OlC1AYRnyBX6XJONm6qWUHbYHHjHt6Boqz4PSPHJLPd4X1VFNUvsSCXxpdVLGWvze3tEEmlvsUY0edlkQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:13a1:b0:563:4c5:c3dd with
 SMTP id t33-20020a056a0013a100b0056304c5c3ddmr10413871pfg.5.1666209499042;
 Wed, 19 Oct 2022 12:58:19 -0700 (PDT)
Date:   Wed, 19 Oct 2022 19:58:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221019195815.1298915-1-dionnaglaze@google.com>
Subject: [PATCH v2] virt/coco/sev-guest: Remove err in handle_guest_request
From:   Dionna Glaze <dionnaglaze@google.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

The err variable may not be set in the call to snp_issue_guest_request,
yet it is unconditionally written back to fw_err if fw_err is non-null.
This is undefined behavior, and currently returns uninitialized kernel
stack memory to user space.

The fw_err argument is better to just pass through to
snp_issue_guest_request, so we do that.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c58ba7..00708b4491e0 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -305,7 +305,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
 {
-	unsigned long err;
 	u64 seqno;
 	int rc;
 
@@ -322,9 +321,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		return rc;
 
 	/* Call firmware to process the request */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
-	if (fw_err)
-		*fw_err = err;
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, fw_err);
 
 	if (rc)
 		return rc;
-- 
2.38.0.413.g74048e4d9e-goog

