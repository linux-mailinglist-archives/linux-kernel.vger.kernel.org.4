Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC36F0CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbjD0UMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbjD0UMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8059230FC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682626279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LCJpqufoYvIBJBVywTzcH9xoKv2yJbkOGxjs6oW1og=;
        b=frim5pWnd+2z8UxBHjrHc38u+ZxufmR0mUDk+VsUtXOuOHOgNolu1twM4FdZIHo5P+I7hQ
        sWuouwi1tG9Cuoy9eBIqN7C2ho5HeqvatZVUk1Tetpa11v4QiNOsTE686ULrnnZ51hY8OL
        LBcsI+n7f5xx0CbjI38XFyDbFf5uaNw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-1qOMglX4MwKeXmGUye39QA-1; Thu, 27 Apr 2023 16:11:18 -0400
X-MC-Unique: 1qOMglX4MwKeXmGUye39QA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ecc0c4b867so24848921cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682626277; x=1685218277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LCJpqufoYvIBJBVywTzcH9xoKv2yJbkOGxjs6oW1og=;
        b=UJNWEhgB+ZW+zdaBH9hvn/9eI4vL+TcFfW96HTGyFXGGseTHqCfDJ5ZBuA5WYs3Rnr
         z8uA+a8qkQZaXAKEvWb4V4nF/VPqwaO5yZN+KFSR5HTVfpTqCm35pyvRUxDLJ/VOL6m/
         9CASZbgEIzTXo5pySyzF6iv6bC5OzsFHmLfzugeHJOwNK/RPXYgcYXwFYqpoAbSXSjbi
         l3NRETZlrrUQUhEopriTIo8e8FgHQOVqxsL9OmvHkEC5BZbAUHwHoHlSGbVhkQuIpg5t
         81uYNcZZWMniEQaNHUAgJRFlNZ0ElVwVbDaKztKCb6vSoSoNrlZIfA5mbaYxG8CAP//z
         b4pg==
X-Gm-Message-State: AC+VfDxzxw+ZfUo97aFUzCiNkpF06KuvAxDhNa38H7ViUeziHPNuXZdx
        eNW3w8tRan9TouNsUBWhTZxnPDi9QmIkTesq18Dbk1QrR7ZsXy/PaLfMTybFCiNBwmflx3re9cO
        txcLQc949c7AML47drr+ixKU+JKxz3RYaKDXvue6MObsReAeBlCnvbDd5Z10uwm9ycsqALgR34y
        u2lyyRvA==
X-Received: by 2002:a05:622a:1443:b0:3ef:5587:723b with SMTP id v3-20020a05622a144300b003ef5587723bmr135308qtx.3.1682626277174;
        Thu, 27 Apr 2023 13:11:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4g0ZcRZj3rzs9wGbSgr4+c+5fTEoqjr/5FCJ6CLpr8UpBSKLjqTwP4eEwGJ6qVDiS0YbA3PQ==
X-Received: by 2002:a05:622a:1443:b0:3ef:5587:723b with SMTP id v3-20020a05622a144300b003ef5587723bmr135257qtx.3.1682626276859;
        Thu, 27 Apr 2023 13:11:16 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b0074fb065bde4sm3444283qkn.18.2023.04.27.13.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:11:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Houghton <jthoughton@google.com>, peterx@redhat.com,
        Anish Moorthy <amoorthy@google.com>
Subject: [PATCH 1/2] selftests/kvm: Setup vcpu_alias only for minor mode test
Date:   Thu, 27 Apr 2023 16:11:11 -0400
Message-Id: <20230427201112.2164776-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230427201112.2164776-1-peterx@redhat.com>
References: <20230427201112.2164776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes two things:

- Unbreaks MISSING mode test on anonymous memory type

- Prefault alias mem before uffd thread creations, otherwise the uffd
  thread timing will be inaccurate when guest mem size is large, because
  it'll take prefault time into total time.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .../testing/selftests/kvm/demand_paging_test.c  | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 2439c4043fed..9c18686b4f63 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -128,6 +128,7 @@ static void prefault_mem(void *alias, uint64_t len)
 
 static void run_test(enum vm_guest_mode mode, void *arg)
 {
+	struct memstress_vcpu_args *vcpu_args;
 	struct test_params *p = arg;
 	struct uffd_desc **uffd_descs = NULL;
 	struct timespec start;
@@ -145,24 +146,24 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		    "Failed to allocate buffer for guest data pattern");
 	memset(guest_data_prototype, 0xAB, demand_paging_size);
 
+	if (p->uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
+		for (i = 0; i < nr_vcpus; i++) {
+			vcpu_args = &memstress_args.vcpu_args[i];
+			prefault_mem(addr_gpa2alias(vm, vcpu_args->gpa),
+				     vcpu_args->pages * memstress_args.guest_page_size);
+		}
+	}
+
 	if (p->uffd_mode) {
 		uffd_descs = malloc(nr_vcpus * sizeof(struct uffd_desc *));
 		TEST_ASSERT(uffd_descs, "Memory allocation failed");
-
 		for (i = 0; i < nr_vcpus; i++) {
-			struct memstress_vcpu_args *vcpu_args;
 			void *vcpu_hva;
-			void *vcpu_alias;
 
 			vcpu_args = &memstress_args.vcpu_args[i];
 
 			/* Cache the host addresses of the region */
 			vcpu_hva = addr_gpa2hva(vm, vcpu_args->gpa);
-			vcpu_alias = addr_gpa2alias(vm, vcpu_args->gpa);
-
-			prefault_mem(vcpu_alias,
-				vcpu_args->pages * memstress_args.guest_page_size);
-
 			/*
 			 * Set up user fault fd to handle demand paging
 			 * requests.
-- 
2.39.1

