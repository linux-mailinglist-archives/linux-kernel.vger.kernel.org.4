Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58468B2BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 00:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBEXSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 18:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBEXSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 18:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DB819691
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 15:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675639032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5/Ww/5/bhqPqutkGRybIHLtU9jqdfakTNy4g0j2iQk=;
        b=Q2IrcXKinh5UW/cS5BHwRhE7QHpgFMfdia8drwNkRJuUqGLqoLQQzK49ao6JT8ezXocSWb
        Hv4VmnzirRr62mNFcdLgodGI1TncMhPQD7PgO3l+Mf9K94soxq6F/ba/SVdIv2aEBVK0Dn
        r2FQzJ8RiQLk8vF9Gpr+RSqCJ65YGb8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-A9tmxP4xPr2FrXKLQM24WA-1; Sun, 05 Feb 2023 18:17:10 -0500
X-MC-Unique: A9tmxP4xPr2FrXKLQM24WA-1
Received: by mail-qk1-f200.google.com with SMTP id j10-20020a05620a288a00b0070630ecfd9bso6927732qkp.20
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 15:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5/Ww/5/bhqPqutkGRybIHLtU9jqdfakTNy4g0j2iQk=;
        b=bN/QYlW4VzVYFxaT6mtk5oAMxdxZ62g4M9xCdtWJU2+DFlTdy3LOifb4f8MWyZzKer
         mVV1vVXSyVBrHmMZKnlv8lP2SHMhUsrchaa99W9fM0ZLZ8xUFB1fTAN8v2NOst4NtvhG
         tBDxcTB0YQyHYFz7nUERwINpoFAIy0OfN1rvChvpISSx8ka4F5ZayV0nk4+z9qHHhEWe
         kuckKfM2JqSPcwwIgyA/8MqB856SdpKKjUIPoxmCA62LLYDKqRrUFjiO1enLiT8JJjoz
         nHvCkbRiPvia4KbEeEg6qlKvg1HukXD7+zxd6TeiTAcK/Xa/EoGX67PuOcoM1tsix69D
         9Siw==
X-Gm-Message-State: AO0yUKWBZ6M9vVSZDnnLX5BI9tU3CiXICNfVbW+8HS1i/ogsp8rz72Js
        O2o6WxfP6Px1cdN0mSmCHnMhowlTviMlCmHugxjQYofXujo927o8VecXFf7xLQxiM53kefg3Qe2
        IZlwB+9rg6Wz2rXW0LUmrj7eO
X-Received: by 2002:ac8:5813:0:b0:3b9:a4d4:7f37 with SMTP id g19-20020ac85813000000b003b9a4d47f37mr37363479qtg.3.1675639030437;
        Sun, 05 Feb 2023 15:17:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8mrnK+ikirixTmDtvR78/fRtminiJLSrpX/G80o7vhvBjyiJhn1+xWU/af4TGpWMpz/q/ScQ==
X-Received: by 2002:ac8:5813:0:b0:3b9:a4d4:7f37 with SMTP id g19-20020ac85813000000b003b9a4d47f37mr37363454qtg.3.1675639030152;
        Sun, 05 Feb 2023 15:17:10 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8515a000000b003b82cb8748dsm5986545qtn.96.2023.02.05.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:17:09 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/3] mm/arm64: Define private VM_FAULT_* reasons from top bits
Date:   Sun,  5 Feb 2023 18:17:03 -0500
Message-Id: <20230205231704.909536-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230205231704.909536-1-peterx@redhat.com>
References: <20230205231704.909536-1-peterx@redhat.com>
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

The current definition already collapse with the generic definition of
vm_fault_reason.  Move the private definitions to allocate bits from the
top of uint so they won't collapse anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 596f46dabe4e..44fd16f58f94 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -480,8 +480,12 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 	}
 }
 
-#define VM_FAULT_BADMAP		0x010000
-#define VM_FAULT_BADACCESS	0x020000
+/*
+ * Allocate private vm_fault_reason from top.  Please make sure it won't
+ * collide with vm_fault_reason.
+ */
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x80000000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x40000000)
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
-- 
2.37.3

