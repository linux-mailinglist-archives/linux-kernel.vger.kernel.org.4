Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF79D613555
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiJaMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJaMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:07:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F023A558F;
        Mon, 31 Oct 2022 05:07:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 4so10582429pli.0;
        Mon, 31 Oct 2022 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8KXzElrk7eZcMvhOMGLSocH1L3elk+opngelcioVZk=;
        b=iVH3xGKfWj//tRC8mM1EDHEmdHABtRA8Pk7XmKUNly4hgpoPYEh/S/T7cSVvmsVZ9V
         EZCIICLmWJQwpFAUZ4Hh1SULQNKji2cPYa3jzPzxndTJivwgpcRuH4zA8ovmgpGzZc9b
         Q4dSuejOClokJ1UkY6ntHGI29r4injlv6Jam6f0Lc5kgkMQRK3gG/Z1phb5GSU16uha7
         gpTXWLzMDB14ykOoPDZyiiYpnbkXnZDls+w8cewlMBjcK9c8Y5IhrvwDZl7wahO8PrUA
         GSLu7V+XPYwbxchdEm/1ZJf08sZwJKetrWbh9h4jrZdoGjdmv2Ez4HuQXWT1VYA55ISF
         GzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8KXzElrk7eZcMvhOMGLSocH1L3elk+opngelcioVZk=;
        b=YdVqil90czp7lNeYfMtyCq35bYj8Jo+HANGTvR4+5yAIHbFdbcZ/ckY0JciYNMDiRW
         KcfgSFvAaGqVhyNxNE9WiwLfWmSLIH9YRvHYyWH8ftYd83vuFIr5pQ7bUME43oP9C036
         ERrMFcF4Bzztz3c2KwAcI1SMoamScUw+JN/T7UdIIgQm3/v1RyMmcUsVLADcUdy0arOz
         0tHVZpkwsoiW49sH6UvS+LqPbb3Gg+HVSvd0w+Cq49B3iXkOjOvQKkq87Ja3rUxSMDnm
         Bf+0mJzIy3fMHfjVkK8P8iszE4/kWgezv6T/cCa7wtbZxhR7O6AxWlBoG2/rZydV4FiM
         KLmQ==
X-Gm-Message-State: ACrzQf1cBh20x2C68w1rQtioqBVbNdbpibtYcyuYP3GySYHVHK+iE54T
        1KcAFpS/p4SO2u4HGsXW6VLaKU+ZNXM=
X-Google-Smtp-Source: AMsMyM6MFVIN9ZCxpO8+Mlfo/DtTtXcUUJD5nQ8a+6f0AqXpe5QBHKUoFQkKe6J3rVoTNuJG6AvzXg==
X-Received: by 2002:a17:903:1c2:b0:187:feb:1f31 with SMTP id e2-20020a17090301c200b001870feb1f31mr10217779plh.92.1667218069206;
        Mon, 31 Oct 2022 05:07:49 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-106-251.tpgi.com.au. [193.116.106.251])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902e75100b0017e64da44c5sm1595134plf.203.2022.10.31.05.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 05:07:48 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-modules@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 1/2] module: add module_elf_check_arch for module-specific checks
Date:   Mon, 31 Oct 2022 22:07:32 +1000
Message-Id: <20221031120733.3956781-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221031120733.3956781-1-npiggin@gmail.com>
References: <20221031120733.3956781-1-npiggin@gmail.com>
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

The elf_check_arch() function is also used to test compatibility of
usermode binaries. Kernel modules may have more specific requirements,
for example powerpc would like to test for ABI version compatibility.

Add a weak module_elf_check_arch() that defaults to true, and call it
from elf_validity_check().

Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
[np: added changelog, adjust name, rebase]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/moduleloader.h |  3 +++
 kernel/module/main.c         | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 9e09d11ffe5b..7b4587a19189 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -13,6 +13,9 @@
  * must be implemented by each architecture.
  */
 
+/* arch may override to do additional checking of ELF header architecture */
+bool module_elf_check_arch(Elf_Ehdr *hdr);
+
 /* Adjust arch-specific sections.  Return 0 on success.  */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
 			      Elf_Shdr *sechdrs,
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d02d39c7174e..7b3f6fb0d428 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1674,6 +1674,11 @@ static int elf_validity_check(struct load_info *info)
 		       info->hdr->e_machine);
 		goto no_exec;
 	}
+	if (!module_elf_check_arch(info->hdr)) {
+		pr_err("Invalid module architecture in ELF header: %u\n",
+		       info->hdr->e_machine);
+		goto no_exec;
+	}
 	if (info->hdr->e_shentsize != sizeof(Elf_Shdr)) {
 		pr_err("Invalid ELF section header size\n");
 		goto no_exec;
@@ -2247,6 +2252,11 @@ static void flush_module_icache(const struct module *mod)
 			   (unsigned long)mod->core_layout.base + mod->core_layout.size);
 }
 
+bool __weak module_elf_check_arch(Elf_Ehdr *hdr)
+{
+	return true;
+}
+
 int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
 				     Elf_Shdr *sechdrs,
 				     char *secstrings,
-- 
2.37.2

