Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF06DFB94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjDLQnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjDLQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3886B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AASukmt80WChuLSYpdLGBsnHxG2u2zyP4JySsjm2BSA=;
        b=h2mFIRwLiqzTr6Assw4NHoKNZdg75KbmVR0dNpR4v9CLe+aCl/aBtEy9dNHjBOqJnJGMlx
        +YzSMh/9gKOpVRu3SI68li1dCflA2hsXLdKowcEZ2CS6Ya9DyHjLSVtOIcsHr0xdGThGvb
        3iGbshuatxn3OuI8utfbre2evNN+kcg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-tV8pNClaNmqE7G1MjxxbIA-1; Wed, 12 Apr 2023 12:42:25 -0400
X-MC-Unique: tV8pNClaNmqE7G1MjxxbIA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ef3c877a1aso1539336d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317743; x=1683909743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AASukmt80WChuLSYpdLGBsnHxG2u2zyP4JySsjm2BSA=;
        b=j8w2evCAgyb3Z0pYvg3fSYGt/omznK4k9/+TRvPDpQxxI2I9kqeqNXZIxIzKBn3w+Z
         MR7qECKtb50cFPshzGRUUiKZTopjBnctTyX0HR6LQs7NmSwqqDLcr4icmPCeiTxOz45A
         lt7+lB0y4XzWbLemNWx09LDY+I1HT2+QiucLcXe6rWV3WCybneq27GtHKeFz+gMRW5jA
         KYBDnjp5PdeB8TYzf8se5a9AuErbYUEM4XsPNVCW+N99BkUm23SwupjhQB0LIUuWNWYu
         MNabIQ24QimDtKj3aowW16ZEilpJtnkZlMyIHrXRi6SqEOnCbvUPCZ7B4TxR1ZFUmK4C
         0/tA==
X-Gm-Message-State: AAQBX9f8f7sAKYO3amYcfiBMCt74QTQYc63e1dPyzwKbX8ioGfNzx7XK
        w7r4mNsV4IHZmANn47yctHD72hf7E4LeLH0VkbEhWYLxZAusiKt4y9Y6pI/hyWHLRzQXphV+8cT
        Xi0RVhbmsNrb7WkI2/p9BEeUUf2ltaABERGW61hKiJzCrc94vipjCbr2t3hAgFELXfXNSy5JRVN
        byDL3QtA==
X-Received: by 2002:a05:6214:5192:b0:5e8:e6ac:591a with SMTP id kl18-20020a056214519200b005e8e6ac591amr4456994qvb.2.1681317743690;
        Wed, 12 Apr 2023 09:42:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZUkH+8udPYM+p0M1Q9rt2RFeDUODTp4Lvra9E3t4UecH3AAez7Vq5YIMTGGOhtqw2IhIGH8Q==
X-Received: by 2002:a05:6214:5192:b0:5e8:e6ac:591a with SMTP id kl18-20020a056214519200b005e8e6ac591amr4456960qvb.2.1681317743372;
        Wed, 12 Apr 2023 09:42:23 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id ei20-20020ad45a14000000b005e90a67a687sm3577922qvb.65.2023.04.12.09.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 06/31] selftests/mm: Link vm_util.c always
Date:   Wed, 12 Apr 2023 12:42:20 -0400
Message-Id: <20230412164220.328123-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do have plenty of files that want to link against vm_util.c.  Just make
it simple by linking it always.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 74988f5adc5f..5f7626550e5f 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -106,18 +106,7 @@ TEST_FILES += va_128TBswitch.sh
 
 include ../lib.mk
 
-$(OUTPUT)/cow: vm_util.c
-$(OUTPUT)/khugepaged: vm_util.c
-$(OUTPUT)/ksm_functional_tests: vm_util.c
-$(OUTPUT)/madv_populate: vm_util.c
-$(OUTPUT)/mkdirty: vm_util.c
-$(OUTPUT)/soft-dirty: vm_util.c
-$(OUTPUT)/split_huge_page_test: vm_util.c
-$(OUTPUT)/userfaultfd: vm_util.c
-$(OUTPUT)/gup_test: vm_util.c
-$(OUTPUT)/mrelease_test: vm_util.c
-$(OUTPUT)/transhuge-stress: vm_util.c
-$(OUTPUT)/ksm_tests: vm_util.c
+$(TEST_GEN_PROGS): vm_util.c
 
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
-- 
2.39.1

