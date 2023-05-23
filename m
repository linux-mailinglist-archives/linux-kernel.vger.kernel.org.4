Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BDE70D86E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjEWJHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjEWJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:06:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B612B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:06:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso3671598b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684832798; x=1687424798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SJFbfEPz5BQtxDDqrX/ZF8BK3JtwWXLb1EJuZcx8oE=;
        b=XwLwLwB2jponEkWGP473zgJPfzhkn77x1qcHDEatQ66MKB6iAvL9jghXxAoT8kUhl6
         SG/GcmW1lEop8zbgSK+GJBx0b993/BdKCtkoXrgq7Mt90frVLuCstN2Ro4xZl+ZAPzmL
         EgVSO3MXXkRuimyDL6nUyEEMMlGtDGBawoPKKX83UdZNLWuAiTS9RASQes0feYPFnje0
         LfanlHYFx6lIEA79qyPx0I0zU8UO5bliTq3HkY74qGDujcqqIRXLvUj8IdBVS3C+DCtq
         h2BjxmuMDLp6ZShobQR7apYeueGBLQF7ea+hNSqomv6qpbDtMEq5TMjlYh9bc1dywUBb
         BQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684832798; x=1687424798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SJFbfEPz5BQtxDDqrX/ZF8BK3JtwWXLb1EJuZcx8oE=;
        b=Vnb/kWQQT4PwiT2GVvjsfZplne+wrOrOPRGpGDimvQBr5WtsIOcZfUZleN0gkg2GS3
         UrR0quBzbl1stbbyulufkPc0SQJf2mo+pVvDOxsqJQ/xFl3gp/EODOGfOFM5fsUchX6z
         HdLqNaudXytROkasPYi2G1UH0kJmgl3sJGqECDNZM36H+hKJdMX/29a7iSlLRPjupzK2
         5yIyLP9R382YPPGw2tIqR2wU09Jx5h423RGQig4/QnWJyrvgT1E11zl8LJXF6H9fLDgW
         fOE1us8FLdsuyYcIRwAAHC+QPoAzRg0GNOkBssZNR1XZ7eRMTd6dJ2q6uM3hb6mmpM0y
         HnJA==
X-Gm-Message-State: AC+VfDz2Tdopp++53Egus6h0TB//h82GMuJZ1szLGgpKScht13uVePYh
        OlPNgFcQkYRALpamtCTtExcPeA==
X-Google-Smtp-Source: ACHHUZ6p+NdheMFiw1yQhFh9ivBjOc4HgsNQ7FXcE0F595oDop/nrDsp2w/+OsN3D9ov9cfQYz8h/Q==
X-Received: by 2002:a05:6a00:b4e:b0:64d:6a78:1575 with SMTP id p14-20020a056a000b4e00b0064d6a781575mr7267633pfo.30.1684832798558;
        Tue, 23 May 2023 02:06:38 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78113000000b006410f4f3ecdsm5338195pfi.83.2023.05.23.02.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:06:38 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v4 1/3] efi: expose efivar generic ops register function
Date:   Tue, 23 May 2023 18:06:04 +0900
Message-Id: <20230523090607.1433-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523090607.1433-1-masahisa.kojima@linaro.org>
References: <20230523090607.1433-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index abeff7dc0b58..56fcced48544 100644
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
index 7aa62c92185f..6d6c5e384345 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1338,4 +1338,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

