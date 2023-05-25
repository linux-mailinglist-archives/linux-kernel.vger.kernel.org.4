Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28CB71107B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjEYQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEYQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:09:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30441E59
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:08:33 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so1569631a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030901; x=1687622901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USQa14bxm9/gfk0iTFn1mMIzz0dadrwCcKOKR8DDgzQ=;
        b=nwOl8DG2BBTjeCysT0zw1xSgZWdheR/RWsAuvcg1DdEjdV7B2fYOPNPm8x0tlNmE/j
         hnfZGo7TBiqISYdVhCnYremv5C6rfiQdCVrkrWDJ2SCv4k8p4lZf6cDSNxRpC/0e6ydM
         oJFPM1oZ1Oz6UN5lERgMzfDltBLvgFnDYXyHDHepKLi5qCbSQGiWYcWvVapAbkVDVZM7
         kkKMbwzQ+y9m3LXYiu/H5cTpU7Vt+mJm5uk1ow6Rb6h889EPpJZq8nRl+c0T4ejNoyt0
         VBprecfmG7TsMhgxy8WhSbUVjg2yQx2bkgVgOv0BPZ8Bb8CMQraD72x7kL5+9TFscMhg
         15Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030901; x=1687622901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USQa14bxm9/gfk0iTFn1mMIzz0dadrwCcKOKR8DDgzQ=;
        b=BhGHuJefVLJboJ8rgmRG68LRFy/R5nk4pCDUAOWAzIL89bGtV+gUlAwKWuCJCS+nK9
         QQPP857QJBUYrM/ZU8xQ0oQCdw+a4CMZtVOdr7Bi7lgmRJmsSiL2TQ1iSUIpoRcLeHU/
         elZgQu/2o1KgWYg0udLdGJJn4eZA5sV6MSvOXXWSwUpzy1vIiLbBoxEYm4p8ZS0wNU+g
         bw0AeEIA4+OVaix2cO+/feEAUqS+EgIOUfjcr6qRNv8Vn/6JQYFOqkZWMQwK84umdGWx
         rG3uTzh7fJLX11+0OHwxO0TIMgMf1DYaGDdr4iUuruqF79uO7xOz04wKQ9MEOjUu8aUn
         Bevw==
X-Gm-Message-State: AC+VfDy4iIYvCkEY34F0XIVFuS0Z8v5n4FqSxvsmAyjKAa/eMBfwDgOb
        kiwHpbp4+jRVP0R0eOQyNSE=
X-Google-Smtp-Source: ACHHUZ6hqDma7sqnvdnFTlwYvxCGOVKRH/UBaY12+lVWEC1CRJshhvo5HN45DYQ5qq2WPMdx85JqBg==
X-Received: by 2002:a17:902:e5c3:b0:1a6:8ed5:428a with SMTP id u3-20020a170902e5c300b001a68ed5428amr2528473plf.22.1685030900944;
        Thu, 25 May 2023 09:08:20 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-81-153.dynamic-ip.hinet.net. [36.228.81.153])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902a50300b001ab12ccc2a7sm1611450plq.98.2023.05.25.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:08:20 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [RESEND PATCH 1/2] ARC: fix incorrect THREAD_SHIFT definition
Date:   Fri, 26 May 2023 00:08:11 +0800
Message-Id: <20230525160813.39408-2-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525160813.39408-1-minhuadotchen@gmail.com>
References: <20230525160813.39408-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current definition of THREAD_SHIFT is (PAGE_SHIFT << THREAD_SIZE_ORDER)
It should be (PAGE_SHIFT + THREAD_SIZE_ORDER) because the following
equation should hold:

Say PAGE_SHIFT == 13 (as the default value in ARC)
THREAD_SIZE_ORDER == 1 (as CONFIG_16KSTACKS=y)

THREAD_SIZE == (1 << THREAD_SHIFT)
            == (1 << (PAGE_SHIFT + THREAD_SIZE_ORDER))
	    == (1 << 14)
	    == 16KB

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 arch/arc/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index 6ba7fe417095..9f9dd021501c 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -22,7 +22,7 @@
 #endif
 
 #define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
-#define THREAD_SHIFT	(PAGE_SHIFT << THREAD_SIZE_ORDER)
+#define THREAD_SHIFT	(PAGE_SHIFT + THREAD_SIZE_ORDER)
 
 #ifndef __ASSEMBLY__
 
-- 
2.34.1

