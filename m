Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72A6482B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiLINLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLINLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:11:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40272C105
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:11:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bj12so11322478ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 05:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U901euThR5untsgYtFHZfHgDIGt0xE8cuFMyPlg2kds=;
        b=WgeyFirOBzBp8wF9QFLi9BH5avruBvdwcR/yXqYZtzFBdz5IOP2xTrro2UrOM43EmZ
         o9M4NoukF5N7khWoLSzOCevOm15Qc7OwLhz9SlfBE7X8m4kvunrP7MJbaB7+ykMbQhrG
         AngniuLsrg/77AovobEP4dTy4O/GDT8Jx+9omsuHHQzRG0SXQoanMq7iqBKJZfsiI64U
         5Rsd+UM0DQYyS120lUwXJfX8r/EtN6Z3npqyCKBQFRRtR1ziqms1lFCXhXnVXWcyzoAa
         HHVi0pwDqZsXyoE7kG2JLjpCXWCO8up5OmKuQpe/y4QJBD9C4bDv41GgSeqfsH4FF0N1
         Nicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U901euThR5untsgYtFHZfHgDIGt0xE8cuFMyPlg2kds=;
        b=FCKz3dU2jPSSxbXjut4rOHbWc51hKfZv5/1f3XUtTV6Yhh799rWZA+TngIdVDHKwPp
         xXYLzP/bYLcJa2VtX4IUCe00da0xHk/Bts4cMQXSpJY25dGO/oO25ljwhZPnUEaOFj47
         JNjd8pbZqPOzPhLIJg4yneT5SY7A84r/qB7bSMnKN2Br4sWBB/OLsY3pmoMvfRjb8tTe
         Jn3jKkRENoZpz7Icq+rmZOTpDCzy7iSn4+p4uTK4V8Uyvfp6UzSpcSePH3TzcjU4NOTp
         xJa0AdeqiSPSgyLANPSjfIRdX0Cx/mWq9rO8j32GXVikjw+lMZjn6Uc2ubEe/kA2X/5d
         cbBQ==
X-Gm-Message-State: ANoB5pnghW/fvEr5fMol60G/BpvHKk2l5r/Try3zRlKpZke9IcjFshRn
        0lm4xfTtvGXQn33Ofhm/F5WmGpKP8F1okA==
X-Google-Smtp-Source: AA0mqf6COmty50XK6Vx8fIPwXwxIg8jO2cDSmzUEk2chTzX8e4k2nPgvb/yh1dsdgusCMjlWwijoDw==
X-Received: by 2002:a17:907:8746:b0:7bc:1e7e:6b8e with SMTP id qo6-20020a170907874600b007bc1e7e6b8emr5411751ejc.43.1670591462028;
        Fri, 09 Dec 2022 05:11:02 -0800 (PST)
Received: from omron.. (86-94-137-163.fixed.kpn.net. [86.94.137.163])
        by smtp.gmail.com with ESMTPSA id gq22-20020a170906e25600b007c10ad73927sm550855ejb.28.2022.12.09.05.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:11:01 -0800 (PST)
From:   Xander Moerkerken <xandermoerkerken@gmail.com>
X-Google-Original-From: Xander Moerkerken <xander.moerkerken@omron.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xander Moerkerken <xander.moerkerken@gmail.com>,
        Xander Moerkerken <xander.moerkerken@omron.com>
Subject: [PATCH] Added ability to vmalloc executable memory
Date:   Fri,  9 Dec 2022 14:10:52 +0100
Message-Id: <20221209131052.64235-1-xander.moerkerken@omron.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xander Moerkerken <xander.moerkerken@gmail.com>

Since release 5.8-rc1 the pgprot got removed from __vmalloc
because the only usage was PAGE_KERNEL as argument.
However, this removes the ability to input other arguments
such as 'PAGE_KERNEL_EXEC', which can be used to allocate
memory in which you can execute. For this reason a new
function is introduced called '__vmalloc_exec'.

Signed-off-by: Xander Moerkerken <xander.moerkerken@omron.com>
---
 include/linux/vmalloc.h | 1 +
 mm/vmalloc.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..10c46513b6b2 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -147,6 +147,7 @@ extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vmalloc_32(unsigned long size) __alloc_size(1);
 extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
 extern void *__vmalloc(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
+extern void *__vmalloc_exec(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
 extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccaa461998f3..8fd01ed7082b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3294,6 +3294,14 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc);
 
+
+void *__vmalloc_exec(unsigned long size, gfp_t gfp_mask)
+{
+	return __vmalloc_node_prot(size, 1, gfp_mask, PAGE_KERNEL_EXEC,
+	                          NUMA_NO_NODE, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(__vmalloc_exec);
+
 /**
  * vmalloc - allocate virtually contiguous memory
  * @size:    allocation size
-- 
2.37.2

