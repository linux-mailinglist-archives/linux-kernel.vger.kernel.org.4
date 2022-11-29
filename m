Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515EB63BF67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiK2LxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiK2LxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D213631FA4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669722744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2Gux2/Som03hICgU5yOVV/Q1V+JmfiX5qRK+2wvl878=;
        b=R5XSuUSSnCx6HXNwXx6qZK9vzo/hV79H7IDWvZkimVs8gBF08bfYUZe2k0bhaLCHbMlVYK
        OjIErbruTn2U3ulneOexZ5WoFPaUPXP30YheNzMiK28CwwK9Uws0CZ8Uk62wRyJ4/XCKFb
        dGMAeD0jgdCmRlhfDCDuTr8cV2xXlhk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-mFCE1HO7OuyfFb-YNVMzmA-1; Tue, 29 Nov 2022 06:52:22 -0500
X-MC-Unique: mFCE1HO7OuyfFb-YNVMzmA-1
Received: by mail-wm1-f70.google.com with SMTP id e8-20020a05600c218800b003cf634f5280so4635353wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Gux2/Som03hICgU5yOVV/Q1V+JmfiX5qRK+2wvl878=;
        b=VhOgEQqZh2Z1eiToqdDDj4D93N2YuWS7x4UBIoWTMjhk+nF7fg+RcdEY6a1GnV2gkV
         kQdX1+GxNJQ4RBA7eRYmcPN5/aNtn7aDgl2sfw+UOsOk30lDYrLjHLpdmBXH0qhLarWs
         72oTdkuv97JmeqscEx9r+FLIxwKUuxt++1QYzsH9jOueAFKdkaFwP2mJKDczc5Apk32O
         1xxMODfDvFu4q/BR7zU0cO45Pd91nz6pwXuISH6T11h2jf2sP+SEpQyT3jBTxJLEgYYc
         NF7o3YPH+7yRL17r0pxXbPqzdj3UYVk/43dV4ArR0c+cm+k8tqRfRt5bm4ortIl7nF0i
         4cew==
X-Gm-Message-State: ANoB5pmXmqmTS5snhDmJHHqsbH2Q3x+TDg4LQKVwGJVMg/lgwiR/xRWt
        tGfML7rVXHAxXGXEfRP1dyCQANl+J3xuIeeSHhngQN80DDItyh4nDbyFnv6wVwfY0GdbndzzMtB
        sJmnTmOowikcQrvEA51SmdX0=
X-Received: by 2002:a1c:4b12:0:b0:3cf:90de:7724 with SMTP id y18-20020a1c4b12000000b003cf90de7724mr44534257wma.18.1669722741538;
        Tue, 29 Nov 2022 03:52:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jWVYrfMlBCQFeHwziy5QCyzfD2FjXU0pt9cHOO8RRJpocET7EWtBePXu5o9xbIk8wvf++pw==
X-Received: by 2002:a1c:4b12:0:b0:3cf:90de:7724 with SMTP id y18-20020a1c4b12000000b003cf90de7724mr44534239wma.18.1669722741311;
        Tue, 29 Nov 2022 03:52:21 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-144.cust.vodafonedsl.it. [2.34.28.144])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002365b759b65sm13232124wrt.86.2022.11.29.03.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:52:20 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] habanalabs: fix double assignment in MMU V1
Date:   Tue, 29 Nov 2022 12:52:17 +0100
Message-Id: <20221129115217.129290-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

Removing double assignment of the hop2_pte_addr
variable in dram_default_mapping_fini().

Dead store reported by clang-analyzer.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/misc/habanalabs/common/mmu/mmu_v1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index 8a40de4a4761..d925dc4dd097 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -344,7 +344,6 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
 		}
 	}
 
-	hop2_pte_addr = hop2_addr;
 	hop2_pte_addr = hop2_addr;
 	for (i = 0 ; i < num_of_hop3 ; i++) {
 		clear_pte(ctx, hop2_pte_addr);
-- 
2.38.1

