Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B98D662ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbjAIQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbjAIQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:08:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3156B392C2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:08:15 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 80-20020a621453000000b0058952aa1c39so893343pfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xyECd1rsW3exJndECu8q+ev3KdOyDWWEbigO77NqdCk=;
        b=kdlmONTLmbqdAZs/NBYP9jUdOxLAvA9jdwZbpjHZ3tHyjKxTjfuYCoDYum07dI89m+
         QA/38bTswLYyeXsN3mwxQyODhROjF+E9OSa+b5n97FSe7w+0ZmqtrE/RjlL9NqxaHuz3
         CRMS65fzgV2Qdurg0/02eiWhqj8bUG5iObMSWz+AFwR+TTc0yH30HL5Ygupu9JDCxzx7
         vXXo16GwV7Lw54C1yComnMOTMBkzkm3Uu8vjLepmcAGGJvEMaRhdqT3JvZAjXcLPbl3Q
         8V4xupbRgxh9G8haSYFa/ZQow09ZZYa7EG/tKB7LxTa5ns9ZKgc6nJ78eKvktKo/tRWO
         GrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyECd1rsW3exJndECu8q+ev3KdOyDWWEbigO77NqdCk=;
        b=ry+zPOppo9v+GZhaU6JRYLd0PSh/WwmoeaxOun9lUqxVqEjrLhCI6X6o5Sxcg9KwtZ
         vLuVMnGhZA9dH05WT5N3mBiWpkVCPfGTQoYSpFHg0pNCjQH6N3GEepx3gG4UW/ZL10w7
         /La5QeOn8CXomitX5+incad1W9ZEKq3ekSuW/YhSQ9haM7TqXC0NGfTBWUaLgLhNqfB9
         GxMc6SN+9b3fOcmKdBSH+5B8ZS0nCAlr/blexrC7GEXWm6epBXRWYdiC5VbdmUJdnA+I
         aJJW8GkEzbyHTINanvQSemo5UE4tJ4nD7DWjpk1ygjkuJr9/hvMv/GN9M57ArLNFmbgp
         7w+g==
X-Gm-Message-State: AFqh2koHn325FrwasnKGQ7j4CrRyacHdfX7XPAiDEXkzhPvn11075ANV
        l7dv6neT0F4XqZdph+1sF7KuDzfmX6Y=
X-Google-Smtp-Source: AMrXdXtfd2sfBIxNw+Rxy/KydCOZGP1eQYUZB45FYydRThzpSXrCW/RZvZm+D+uYBJzZ6R3Ukg06UrfuG1g=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:ca:b043:174:2b96])
 (user=pgonda job=sendgmr) by 2002:a17:902:8213:b0:192:a805:29d with SMTP id
 x19-20020a170902821300b00192a805029dmr2217114pln.31.1673280494640; Mon, 09
 Jan 2023 08:08:14 -0800 (PST)
Date:   Mon,  9 Jan 2023 08:08:08 -0800
Message-Id: <20230109160808.3618132-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH] KVM: sev: Fix int overflow in send|recieve_update_data ioctls
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>, Andy Nguyen <theflow@google.com>,
        Thomas Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM_SEV_SEND_UPDATE_DATA and KVM_SEV_RECEIVE_UPDATE_DATA have an integer
overflow issue. Params.guest_len and offset are both 32bite wide, with a
large params.guest_len the check to confirm a page boundary is not
crossed can falsely pass:

    /* Check if we are crossing the page boundary *
    offset = params.guest_uaddr & (PAGE_SIZE - 1);
    if ((params.guest_len + offset > PAGE_SIZE))

Add an additional check to this conditional to confirm that
params.guest_len itself is not greater than PAGE_SIZE.

The current code is can only overflow with a params.guest_len of greater
than 0xfffff000. And the FW spec says these commands fail with lengths
greater than 16KB. So this issue should not be a security concern

Fixes: 15fb7de1a7f5 ("KVM: SVM: Add KVM_SEV_RECEIVE_UPDATE_DATA command")
Fixes: d3d1af85e2c7 ("KVM: SVM: Add KVM_SEND_UPDATE_DATA command")
Reported-by: Andy Nguyen <theflow@google.com>
Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/svm/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 273cba809328..9451de72f917 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1294,7 +1294,7 @@ static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	/* Check if we are crossing the page boundary */
 	offset = params.guest_uaddr & (PAGE_SIZE - 1);
-	if ((params.guest_len + offset > PAGE_SIZE))
+	if (params.guest_len > PAGE_SIZE || (params.guest_len + offset > PAGE_SIZE))
 		return -EINVAL;
 
 	/* Pin guest memory */
@@ -1474,7 +1474,7 @@ static int sev_receive_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	/* Check if we are crossing the page boundary */
 	offset = params.guest_uaddr & (PAGE_SIZE - 1);
-	if ((params.guest_len + offset > PAGE_SIZE))
+	if (params.guest_len > PAGE_SIZE || (params.guest_len + offset > PAGE_SIZE))
 		return -EINVAL;
 
 	hdr = psp_copy_user_blob(params.hdr_uaddr, params.hdr_len);
-- 
2.39.0.314.g84b9a713c41-goog

