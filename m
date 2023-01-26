Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6467CBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbjAZNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbjAZNWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:22:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A756951B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:22:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so1730908pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb1TjdSBROKgpzfUeVaUTyHesAuYGunU6yuolHrwpSc=;
        b=IG25tEZgrlag046v1zrPHOE/87wEkDPEUGw7LgsuqaxIi9eznt61ned3E0VT6UR2yl
         8ENDLo/NNu0gtwL2QpcGj/fLYJ62gfWGfmdON2jnAIKvfu6Cko7X35bfteF90Zina7rm
         0gcl4sPN8lJqWAuipMtcMT0OtQZw2GMOaLT8PxA38Cwa/m+ZgtjbMedwalJo9VkwR1tU
         Wew6HiKrawGpNcfRzdql2OX9Q8vfnumb4jcVAwhJqKlz6Wk0KqVfZoTmLX6IFADpakJm
         oDYsdArI1rUkEO+O/tzRg7QI2f/jJZdhAN+atkFVPFVMpNdlHF3G6Bp84bC1ofgTwHRl
         630w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb1TjdSBROKgpzfUeVaUTyHesAuYGunU6yuolHrwpSc=;
        b=cnxDRPVmQO37hslfgYXcGMd1ywls1aAk2Gr/6mqWuuWDcdzbxnTZ4k3cCrtQhQyOWb
         rEAiUIZ9PuzECrRDVgDEAfArJuc3PI5s/I8ob5tkrqKzw5hjStoycNv25oMcm0I0u4P6
         Emx+O9BZdFeiIcL0xlFrmE0wLVMno8x0E4q12T217CWVUFsjTxBeMG42sAMjRQKKNu6A
         VWChjbM6qlF79L3aOUjTzDYyd9OP9PJqmHB0j6zkYfy5VlD1gQ59K6TctXP2b9elRJh/
         LN1hrM5VlJQ4M8ejQ5ANuhWJRp4NmiIjhOP8S/E5n65Gx73vMrRaVEyykDpMJC7yE0KL
         w7YQ==
X-Gm-Message-State: AO0yUKWbEg+/5Rb4scpKOgUNK4eodJGkuhCszAiLDp97WAhGxSPwyLvd
        pop1dRwwwZ3Fq6OLa68kAPFyNA==
X-Google-Smtp-Source: AK7set9LCkZZzzPRiJxmpocQsfdZqzBDZZ18FSGyY5me355QHzO2xZyiU9Ele7W4ZLpYWzdnELgXTQ==
X-Received: by 2002:a05:6a20:3f93:b0:b9:5fc6:9ed6 with SMTP id ay19-20020a056a203f9300b000b95fc69ed6mr1557169pzb.37.1674739355870;
        Thu, 26 Jan 2023 05:22:35 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id l6-20020a656806000000b00478dad38eacsm736047pgt.38.2023.01.26.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:22:35 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [RFC PATCH 1/2] efi: expose efivar generic ops register function
Date:   Thu, 26 Jan 2023 22:21:18 +0900
Message-Id: <20230126132120.1661-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126132120.1661-1-masahisa.kojima@linaro.org>
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation for supporting efivar operations
provided by other than efi subsystem.
Both register and unregister functions are exposed
so that non-efi subsystem can revert the efi generic
operation.

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++++++++
 include/linux/efi.h        |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 52146f95d58e..4e576b62c170 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -227,6 +227,18 @@ static void generic_ops_unregister(void)
 	efivars_unregister(&generic_efivars);
 }
 
+void efivars_generic_ops_register(void)
+{
+	generic_ops_register();
+}
+EXPORT_SYMBOL_GPL(efivars_generic_ops_register);
+
+void efivars_generic_ops_unregister(void)
+{
+	generic_ops_unregister();
+}
+EXPORT_SYMBOL_GPL(efivars_generic_ops_unregister);
+
 #ifdef CONFIG_EFI_CUSTOM_SSDT_OVERLAYS
 #define EFIVAR_SSDT_NAME_MAX	16UL
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 1a1adc8d3ba3..5e301c00e9b0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1332,4 +1332,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

