Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F07163E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjE3OYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjE3OYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667B21B7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685456520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IaNRJCmDjWU8/6DXmsxqc7rHWPn8lAenVzUVcNnxOjU=;
        b=aMLoIn32j7n8pdmxEGlww642cpApN6Bj8zvXxypsq+SOEgs1N4XZKlwjfNhrRl10iJWVZN
        c5w7eOpi9E4+8xuOWgyrYPCB3rYd2gybs/uGWpGIKoYlLahNAo5G5nbwJ3VqwGnJVx2o6q
        UEAP+Ed6rIYex8SuRK/+iVM/7+buvWw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-qlF2X_1-O2OrTXS9tQ8GXA-1; Tue, 30 May 2023 10:21:59 -0400
X-MC-Unique: qlF2X_1-O2OrTXS9tQ8GXA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f6c4674e3cso67769711cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456517; x=1688048517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaNRJCmDjWU8/6DXmsxqc7rHWPn8lAenVzUVcNnxOjU=;
        b=aJz1PumCaYFLwIL9Rkou6qdV++V7lZXUYQGE0HjHQtwlO7ZSaC1B0dXRDV6ca9Uo3M
         dfAcvAjcABdHbjtmiNBOWswJ17DSMTRiUF81J8XZnVgOP4XC74Coxs+q6FJJqq2qOxuW
         m8s+bkYYfMkm3YXDIXMaIipcAt2T2LTJHf6zWeyJTIBVPGvB7YSgjnwl4PEpvtExmVkw
         dE5bfkHvk2N5Y4tFnUQlyO9wrcxEPLOvzn/9magGj+yYdwluEvtGeiWIKNJN2eWiWc86
         EBGoZYW7DNJcD/N7nH0MfEEMZZn91KhRrlFQkAflyghHw/Kult2r65DnCxIZ40SXPcvp
         aQ8A==
X-Gm-Message-State: AC+VfDzhRQhsCsqBYqg7EteUOhTm1dPSHKddgTrMT3CMhuU7llGPhH4g
        teTNAGlcOj5MgKEK8MXBJgk/YBgRDak0ArvhaOBcSJcpsR1LUxvwD4l8p082Koo5kC/Bqqpcf46
        hsZ3sIzZbxqGXT1wccV/EXIBH
X-Received: by 2002:a05:622a:1787:b0:3f8:20a:1c6a with SMTP id s7-20020a05622a178700b003f8020a1c6amr1912805qtk.40.1685456517403;
        Tue, 30 May 2023 07:21:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yvPRFJ6QfVfk1/1OEdvl2Lu3bQMAfd0qtXiTSv1WBwMYtf1F4J8MySyj03BE8wXZx/eMRPw==
X-Received: by 2002:a05:622a:1787:b0:3f8:20a:1c6a with SMTP id s7-20020a05622a178700b003f8020a1c6amr1912788qtk.40.1685456517195;
        Tue, 30 May 2023 07:21:57 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i26-20020ac871da000000b003f394decd08sm4652992qtp.62.2023.05.30.07.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:21:56 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: remove unused variable pages_processed
Date:   Tue, 30 May 2023 10:21:54 -0400
Message-Id: <20230530142154.3341677-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
fs/btrfs/extent_io.c:230:16: error: variable
  'pages_processed' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned long pages_processed = 0;
                      ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/extent_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 89e093ae1c33..6919409c1183 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -227,7 +227,6 @@ static void __process_pages_contig(struct address_space *mapping,
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
-	unsigned long pages_processed = 0;
 	struct folio_batch fbatch;
 	int i;
 
@@ -242,7 +241,6 @@ static void __process_pages_contig(struct address_space *mapping,
 
 			process_one_page(fs_info, &folio->page, locked_page,
 					 page_ops, start, end);
-			pages_processed += folio_nr_pages(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.27.0

