Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1568B2BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 00:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBEXSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 18:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBEXR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 18:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119291968A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 15:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675639028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hczbFL+ar/tk/IYpzPCczVyi3teFQZrB1wxKh73TL0g=;
        b=gLAF8qii/iuEwBLmyjF0T1Y6jdTmzsBC9JuY0dGdh0wfaJT5S3EVu2dbG1NVRhRY5s3/qE
        N9oJQO4aR+tuSd4Tv5avZh18HY12a1KQrdBvMwzPxV/1bAT0qOGIqGET5XMhUQDeqVv7Qx
        TiHo+i9cLl60RIy6ikPdU2GrH0/l5dA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-xdLjNT1pPCu_S-B8s8B-Cg-1; Sun, 05 Feb 2023 18:17:06 -0500
X-MC-Unique: xdLjNT1pPCu_S-B8s8B-Cg-1
Received: by mail-qk1-f198.google.com with SMTP id u11-20020a05620a430b00b007052a66d201so6892546qko.23
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 15:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hczbFL+ar/tk/IYpzPCczVyi3teFQZrB1wxKh73TL0g=;
        b=CHZmEcz2SHCZZM4NVRrhkAtaSzJd1sNpQsldofPcL3/7CUiIAPWl8JjCuqLsV/dJTk
         GaHVrJl2rzK87F04wzbMueOQVIvmbLSeeec3q+S2xNaEp4lL6bIaVFxvhQ9qYl+Hkdp8
         aDtxcbaO8TiSKXiYGg1P9yQjI5bvFLJmq0ZSgRkmIakPvg8D9dFlN9Zixna02UIPRUTt
         TJQDSHEOLW85kgRSXGW44GRPzFV3BqxnpH8pikdHztylfDk+8x037f6mEI1106XCcdIK
         A431Kdk8r0q4A+YS2sR5lPkmW6flwh7ZmI0D91EKu0vs1Ed27Gw1GBfNWYscYWaPvHma
         M6Tw==
X-Gm-Message-State: AO0yUKU1n60eQnBoNk6+uEdCfBzeAAkFcAJpanvS6i5Uaqcp/AP+oji7
        mheKSDtR+XqPb7fF5Ty0z9ZzfpHgD75Hj3QOQct5EEFIvwfkpNVji9pI+oKTBSW6a5JEM08KSHL
        yJFRB80KftJ5ACemooIuTdK9p
X-Received: by 2002:a05:622a:a15:b0:3b8:695b:aad1 with SMTP id bv21-20020a05622a0a1500b003b8695baad1mr31166805qtb.1.1675639026387;
        Sun, 05 Feb 2023 15:17:06 -0800 (PST)
X-Google-Smtp-Source: AK7set/sbA75b0Czo2TaDI7H5+UellOBQzwBIsx8AnsLPSQNhM0IiyfwrSSGN0x0tfL39bKfeNgbnw==
X-Received: by 2002:a05:622a:a15:b0:3b8:695b:aad1 with SMTP id bv21-20020a05622a0a1500b003b8695baad1mr31166787qtb.1.1675639026141;
        Sun, 05 Feb 2023 15:17:06 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8515a000000b003b82cb8748dsm5986545qtn.96.2023.02.05.15.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:17:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/3] mm/arch: Fix a few collide definition on private use of VM_FAULT_*
Date:   Sun,  5 Feb 2023 18:17:01 -0500
Message-Id: <20230205231704.909536-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a few collision usage on VM_FAULT_* definition in the page fault
path on arm/arm64/s390 where the VM_FAULT_* can overlap with the generic
definition of vm_fault_reason.

The major overlapped part being VM_FAULT_HINDEX_MASK which is used only by
the hugetlb hwpoisoning.

I'm not sure whether any of them can have a real impact, but that does not
look like to be expected.  I didn't copy stable, if anyone thinks it should
please shoot.  Nor did I test them in any form - I just changed the
allocations from top bits and added a comment for each of them.

Please have a look, thanks.

Peter Xu (3):
  mm/arm: Define private VM_FAULT_* reasons from top bits
  mm/arm64: Define private VM_FAULT_* reasons from top bits
  mm/s390: Define private VM_FAULT_* reasons from top bits

 arch/arm/mm/fault.c   |  8 ++++++--
 arch/arm64/mm/fault.c |  8 ++++++--
 arch/s390/mm/fault.c  | 14 +++++++++-----
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.37.3

