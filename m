Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08106619561
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKDLcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiKDLbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2936F25C77
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667561450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RevsFdiPw/fb8SaWA4i0OScuHjqawmx3PhXyedjj5ck=;
        b=PasuLHhZ5wWoFvZd9dKacp8HT+tQgmNnTf0JDe0kzzJgP9XVvRss8a/jZZK3qf0/i24j+Z
        F0eu7RVcS1K/73k2xTgWFot6tS8F6XqieGfNv4Xos7OZov2ktTBi59LNG9xWSvyXby7EuB
        UW3IQYDXRuc3xxq7FuzEp39bWdgbOMA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-vfqosuPYM1ih1a8_K5f1BQ-1; Fri, 04 Nov 2022 07:30:46 -0400
X-MC-Unique: vfqosuPYM1ih1a8_K5f1BQ-1
Received: by mail-pl1-f197.google.com with SMTP id a6-20020a170902ecc600b00186f035ed74so3409701plh.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 04:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RevsFdiPw/fb8SaWA4i0OScuHjqawmx3PhXyedjj5ck=;
        b=X5LljYiUcY/Ybg8r62sn9hUfBgVbdYb//La/+oA0XF70ibJtJAmzXaRHWJee8fvpeA
         BJ1asoh/uQ7ZhvaT2OsdWmi7dYHrANHV3FEpLRw44QtQBjczO5ZVMCSRiSrgFpce4Grg
         qKoNFMs+B6M4bbmXRvxCHONR+FZPJjEcAmyTsqTdwTx5j/chrsLHbFGOE0Rs3L/RJOjO
         6qD41DJRwhfzGDzuzwznDeui/NEOVccpUGqVm7NJi050sJ9FS4rNEsZYTb+hojJP8Xst
         mD3qQow4+g30G0fmAHJjJ6VIALxLZCctLBUuIXQKc7xHuYxhpw+bgjX/yFQKCsMDUui8
         qw8g==
X-Gm-Message-State: ACrzQf0jGaMq1JPbntgWzUWhHv8vAG43WPT1biIzdwPJthdWh+80kTwD
        AxMoxKAO/EBzQ1m5qHPiLRuFfa1fvozDY2pFVZBmQqPbq1GGAntQVzS7L+Fg2cCDiE+4n9qolS3
        OvmkTTQLrvvL0aYTPBYh0Rajy
X-Received: by 2002:a17:90a:6d22:b0:213:7e1e:9be0 with SMTP id z31-20020a17090a6d2200b002137e1e9be0mr35804895pjj.17.1667561445708;
        Fri, 04 Nov 2022 04:30:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51CDYLEqWginckV/rN0elEiAXD4s8pR8U6DdMP+NZPO37JWjN6xDUyvoO9upVjiEVTkeoywQ==
X-Received: by 2002:a17:90a:6d22:b0:213:7e1e:9be0 with SMTP id z31-20020a17090a6d2200b002137e1e9be0mr35804871pjj.17.1667561445499;
        Fri, 04 Nov 2022 04:30:45 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00008500b005629b6a8b53sm2609597pfj.15.2022.11.04.04.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:45 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC v2 4/5] x86/crash: make the page that stores the LUKS volume key inaccessible
Date:   Fri,  4 Nov 2022 19:29:59 +0800
Message-Id: <20221104113000.487098-5-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104113000.487098-1-coxu@redhat.com>
References: <20221104113000.487098-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an addition layer of protection for the saved copy of LUKS
volume key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 0611fd83858e..f3d51c38a1c9 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -557,9 +557,25 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+static void kexec_mark_luks_volume_key_inaccessible(void)
+{
+	unsigned long start, end;
+	struct page *page;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->luks_volume_key_addr) {
+		start = kexec_crash_image->luks_volume_key_addr;
+		end = start + kexec_crash_image->luks_volume_key_sz - 1;
+		page = pfn_to_page(start >> PAGE_SHIFT);
+		nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
+		set_memory_np((unsigned long)page_address(page), nr_pages);
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_luks_volume_key_inaccessible();
 }
 
 void arch_kexec_unprotect_crashkres(void)
-- 
2.37.3

