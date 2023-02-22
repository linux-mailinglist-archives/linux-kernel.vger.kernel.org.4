Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1AD69EE70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjBVFjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBVFjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:39:19 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8963608D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:39:17 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b20so4532647pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sLDMeC85ViUoFkMg7Sog4nZA2hj3556Fo2Z4Pqw9Sk=;
        b=BHjb8C4cHgLz1HzRO4VRGO4k2QJsmCcNyEiNkq5lTCjvUq4Di7IseU1UwO7tNyTVdj
         bNEEKDEY0Aw2GKO6qxiKJKBRbvt/AfOjMdlcHCZzBNPecKAgK66/x/gS1gCDLo0gdd2m
         e2vUnqYhNa90mSxJwFLv/n7qZmAxRemoxMO/Pl0FzRAEcuStnKQPzJAaYmZjDBAYEEst
         NpUW0QCDOwGJVOLdDZqQaTFGy7xMhLj2XcUq9rOCqTjYbiQDIKGRNMnWwjnIni0ytVSf
         TLU+DBGdE1UdYcMyeq+X65AhUJ1LHkRdhexcoI7y4hDd5vx/xiRKEBu9LUbZwQYp89eh
         fgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sLDMeC85ViUoFkMg7Sog4nZA2hj3556Fo2Z4Pqw9Sk=;
        b=ETbFbLC3wAM5XfwYntlj5jbIUlJ7/iK1dzal5UykjqMecy0q/1z5FcU7Sh8V/vVzXQ
         3Vvd83HxOnESZ17kw3ynlGqyOb5C/0h0GOblMv/2guRrpIH/MxrF++NTe7+miu8lIToK
         7P9aiNKG6If9BkHXuhhFrN4GPYFvAxgEMS0UJxC3ropo2okH4QAhSOoQxMbQgtLSUVg3
         wQbuMSD4QovV0+gQihM2eMC40Eo+mWWPBQQ/1ohLsp+2YQXIE+/fidkbI0KFamRDbdC3
         zqtSdEekbaInXhQJNReSgk5kWGnVEFFVG7ZzmIHKqG0olEFK10IT/V2IwH8099G89d/6
         SRlw==
X-Gm-Message-State: AO0yUKVb8uOs4gLDgPDiCY/yFWsrbtgga1uQUcMREc3ZVoYNVyz+RaWx
        ybRwxKvtYCpduXvbFRn5dk3clg==
X-Google-Smtp-Source: AK7set8Is8WfXxn4KLyxy71JFEQc6uUnlBzTLEDzAxwg1ERJzQ9z/z1GHMb0j65/shf8yNvouxYAwQ==
X-Received: by 2002:a62:52d7:0:b0:5a9:d4fa:d3c7 with SMTP id g206-20020a6252d7000000b005a9d4fad3c7mr6353164pfb.7.1677044357377;
        Tue, 21 Feb 2023 21:39:17 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79203000000b005931a44a239sm1107130pfo.112.2023.02.21.21.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:39:16 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v3 1/3] efi: expose efivar generic ops register function
Date:   Wed, 22 Feb 2023 14:38:22 +0900
Message-Id: <20230222053825.992-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230222053825.992-1-masahisa.kojima@linaro.org>
References: <20230222053825.992-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 4bb30434ee4a..abaf77773bdd 100644
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
index df88786b5947..7e5239da87bf 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1336,4 +1336,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

