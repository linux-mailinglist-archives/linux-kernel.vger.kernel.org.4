Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD2E70DE7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbjEWOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbjEWOGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:06:50 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C3130
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:06:47 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f4bd608cf4so1001117e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850746; x=1687442746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYHNj4xOB3A9+sRrGGyA+CHl8mr8r8wePJEdzxz75NA=;
        b=yi3hcBL/sMAfGA15PDa1P8NdEmww4HzJP2F/sUwI9IpWl8FAr9D8nzxcXs3kk9VZLg
         gqW+uTf0Quu6EKOMoBtewB5My0WXhMod0GC8z1ZbYL4s/yewGksiSDol/qQUkOAwxxUP
         tWgq8rOI0YG+2kzNAd6LFlZQnU/w/sUVfPTphub78KgJsbXLOjbr0epF5+oc5rNWTcLT
         4z9nAmfx1uJBTtHPDaWVenyL8i5pZQeTVRUJb52fjzXC6jarDxR7o0xXXXnUa9XVKQra
         c4l8ZCAV1hnrQiBJbDsUuYXenW29rw/An0d2CKxpWMKMbNQerNNefqEtiX0g0tIAPTZn
         73Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850746; x=1687442746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYHNj4xOB3A9+sRrGGyA+CHl8mr8r8wePJEdzxz75NA=;
        b=CH2B8OsYnVQ+umNHKS9gP1lp6dAdILmi4qhdYTeg6PtWPdZilcn5f1CaaW8fUo/C2L
         zeqiM2MX5lsKTMtmhauCAJqpijtaIGTumiG6b/vFqn+aj/zSsfg1IKJ6plNoSrzuBXXU
         wNUihkst+FTah36A/BPPCdUmVW7gTMCJ5T2ILvK+MwZJ9017f6XiNUwolHLpEq3rv8aX
         2ZhRJJZ2z9naWAocZdkFhit5DIDNq7Jp6K4UqSDbiKq3U3y8+sV3h8eUb1H+TUMgk/dk
         bK+WtSW18NfN11FWjINSeT079O6UZ0wmfmfUUW7m96ZZ4FsQhLCWDOZmEtc/Za5wxkQf
         W3WA==
X-Gm-Message-State: AC+VfDw2OKx2wvl/QZMrWOpnkigP16VuEM9tdsXdASbUMHrutmnChoB9
        redry9Z+GHLjK7gSh1Q/6viFEw==
X-Google-Smtp-Source: ACHHUZ7rLgS3uJwWiogUeDYb0+CYWWtRVMpUMIrByqwxVk0kXBZ79wUE4ySYqYt+Mam8+eVWY8llcQ==
X-Received: by 2002:ac2:43a2:0:b0:4f3:a1db:ad4 with SMTP id t2-20020ac243a2000000b004f3a1db0ad4mr4313623lfl.66.1684850745735;
        Tue, 23 May 2023 07:05:45 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:25 +0200
Subject: [PATCH v3 01/12] fs/proc/kcore.c: Pass a pointer to
 virt_addr_valid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-1-a16c19c03583@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virt_addr_valid() should be passed a pointer, the current
code passing a long unsigned int is just exploiting the
unintentional polymorphism of these calls being implemented
as preprocessor macros.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/proc/kcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 25b44b303b35..75708c66527f 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -199,7 +199,7 @@ kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
 	ent->addr = (unsigned long)page_to_virt(p);
 	ent->size = nr_pages << PAGE_SHIFT;
 
-	if (!virt_addr_valid(ent->addr))
+	if (!virt_addr_valid((void *)ent->addr))
 		goto free_out;
 
 	/* cut not-mapped area. ....from ppc-32 code. */

-- 
2.34.1

